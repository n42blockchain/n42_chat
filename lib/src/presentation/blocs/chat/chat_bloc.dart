import 'dart:async';
import 'dart:io';
import 'dart:math' show min;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart' show SyncStatus, SyncStatusUpdate;

import '../../../core/services/speech_to_text_service.dart';
import '../../../core/services/translation_service.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../../domain/repositories/message_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

/// 聊天BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IMessageRepository _messageRepository;
  final PreferencesDataSource _secureStorage;
  final IGroupRepository? _groupRepository;
  final ITranslationService? _translationService;
  final MatrixClientManager? _clientManager;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  StreamSubscription<Map<String, dynamic>>? _pollResponsesSubscription;
  String? _currentRoomId;

  // 阅后即焚定时器
  Timer? _destructionTimer;

  // 定时发送检查定时器
  Timer? _scheduledMessageTimer;

  // 已本地删除的消息ID集合（防止被消息订阅恢复）
  final Set<String> _locallyDeletedMessageIds = {};

  // ============================================
  // 离线消息自动重试
  // ============================================

  /// 待重试的消息ID及其重试次数
  final Map<String, int> _pendingRetryMessages = {};

  /// 已耗尽自动重试次数的消息ID集合
  ///
  /// 防止 _scanFailedMessages 在 _pendingRetryMessages 移除 key 后
  /// 将同一消息重新以计数 0 加入队列，导致无限死循环。
  final Set<String> _permanentlyFailedMessages = {};

  /// 最大重试次数
  static const int _maxRetryCount = 3;

  /// 基础重试间隔（毫秒）
  static const int _baseRetryDelayMs = 2000;

  /// 同步状态订阅
  StreamSubscription<SyncStatusUpdate>? _syncStatusSubscription;

  /// 重试定时器
  Timer? _retryTimer;

  /// 当前是否处于连接状态
  bool _isConnected = true;

  ChatBloc({
    required IMessageRepository messageRepository,
    required PreferencesDataSource secureStorage,
    IGroupRepository? groupRepository,
    ITranslationService? translationService,
    MatrixClientManager? clientManager,
  })  : _messageRepository = messageRepository,
        _secureStorage = secureStorage,
        _groupRepository = groupRepository,
        _translationService = translationService,
        _clientManager = clientManager,
        super(ChatState.initial()) {
    on<InitializeChat>(_onInitializeChat);
    on<LoadMessages>(_onLoadMessages);
    on<LoadMoreMessages>(_onLoadMoreMessages);
    on<SubscribeMessages>(_onSubscribeMessages);
    on<UnsubscribeMessages>(_onUnsubscribeMessages);
    on<SendTextMessage>(_onSendTextMessage);
    on<SendImageMessage>(_onSendImageMessage);
    on<SendVoiceMessage>(_onSendVoiceMessage);
    on<SendFileMessage>(_onSendFileMessage);
    on<SendVideoMessage>(_onSendVideoMessage);
    on<SendLocationMessage>(_onSendLocationMessage);
    on<ResendMessage>(_onResendMessage);
    on<RedactMessage>(_onRedactMessage);
    on<DeleteMessagesLocally>(_onDeleteMessagesLocally);
    on<DeleteFailedMessage>(_onDeleteFailedMessage);
    on<ReplyToMessage>(_onReplyToMessage);
    on<SetReplyTarget>(_onSetReplyTarget);
    on<SetEditTarget>(_onSetEditTarget);
    on<AddReaction>(_onAddReaction);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
    on<SendTypingNotification>(_onSendTypingNotification);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<DisposeChat>(_onDisposeChat);
    on<SendSystemNotice>(_onSendSystemNotice);
    on<SendPokeMessage>(_onSendPokeMessage);
    on<SendPollMessage>(_onSendPollMessage);
    on<VoteOnPoll>(_onVoteOnPoll);
    on<PollResponseReceived>(_onPollResponseReceived);
    on<EndPoll>(_onEndPoll);
    on<PollEnded>(_onPollEnded);
    on<SendCustomMessage>(_onSendCustomMessage);
    on<ClearChatHistory>(_onClearChatHistory);
    on<StartMessageDestruction>(_onStartMessageDestruction);
    on<DestroyExpiredMessages>(_onDestroyExpiredMessages);
    on<UpdateDestructionCountdown>(_onUpdateDestructionCountdown);
    on<SendScheduledMessage>(_onSendScheduledMessage);
    on<CancelScheduledMessage>(_onCancelScheduledMessage);
    on<SendDueScheduledMessages>(_onSendDueScheduledMessages);
    on<TranscribeVoiceMessage>(_onTranscribeVoiceMessage);
    on<VoiceTranscriptionCompleted>(_onVoiceTranscriptionCompleted);
    on<SendGifMessage>(_onSendGifMessage);
    on<SendStickerMessage>(_onSendStickerMessage);
    on<LoadPinnedMessages>(_onLoadPinnedMessages);
    on<PinMessage>(_onPinMessage);
    on<UnpinMessage>(_onUnpinMessage);
    on<NavigatePinnedMessage>(_onNavigatePinnedMessage);
    on<TranslateMessage>(_onTranslateMessage);
    on<TranslationCompleted>(_onTranslationCompleted);
    on<ClearTranslation>(_onClearTranslation);
    on<RetryPendingMessages>(_onRetryPendingMessages);
    on<ConnectionStatusChanged>(_onConnectionStatusChanged);
    on<SendContactCardMessage>(_onSendContactCardMessage);
    on<DestructionTimesLoaded>(_onDestructionTimesLoaded);
  }

  /// 处理销毁时间加载完成事件
  Future<void> _onDestructionTimesLoaded(
    DestructionTimesLoaded event,
    Emitter<ChatState> emit,
  ) async {
    final updatedMessages = state.messages.map((msg) {
      final destroyedAt = event.destructionTimes[msg.id];
      if (destroyedAt != null && msg.isSelfDestructing && !msg.isDestructionStarted) {
        return msg.copyWith(destroyedAt: destroyedAt);
      }
      return msg;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _pollResponsesSubscription?.cancel();
    _destructionTimer?.cancel();
    _scheduledMessageTimer?.cancel();
    _syncStatusSubscription?.cancel();
    _retryTimer?.cancel();
    return super.close();
  }

  /// 初始化聊天室
  ///
  /// 采用本地优先策略：先显示缓存数据，后台静默同步
  /// 将首屏时间从 2s 降至约 100ms
  Future<void> _onInitializeChat(
    InitializeChat event,
    Emitter<ChatState> emit,
  ) async {
    _currentRoomId = event.roomId;
    _locallyDeletedMessageIds.clear();

    // 从持久化存储加载已删除的消息ID（异步，不阻塞）
    _loadDeletedMessageIds(event.roomId);

    // 立即显示界面，不等待网络
    emit(state.copyWith(roomId: event.roomId, isLoading: false, clearError: true));

    // 先尝试快速加载本地缓存消息
    try {
      final cachedMessages = await _messageRepository.getMessages(
        event.roomId,
        limit: 30, // 首屏只需要 30 条
      );

      if (cachedMessages.isNotEmpty && !isClosed) {
        // 过滤已删除的消息
        final filteredMessages = cachedMessages
            .where((m) => !_locallyDeletedMessageIds.contains(m.id))
            .toList();

        emit(state.copyWith(
          messages: filteredMessages,
          isLoading: false,
          hasMore: true,
        ));
        debugPrint('ChatBloc: Displayed ${filteredMessages.length} cached messages instantly');
      }
    } catch (e) {
      debugPrint('ChatBloc: Failed to load cached messages: $e');
    }

    // 订阅消息更新（后台同步）
    add(const SubscribeMessages());

    // 订阅投票响应事件
    _subscribeToPollResponses(event.roomId);

    // 后台静默加载完整数据（不阻塞 UI）
    _loadFullMessagesInBackground(event.roomId);

    // 启动阅后即焚定时器
    _startDestructionTimer();

    // 启动定时消息检查定时器
    _startScheduledMessageTimer();

    // 加载已保存的销毁时间
    _loadSavedDestructionTimes(event.roomId);

    // 加载定时消息
    _loadScheduledMessages(event.roomId);

    // 加载置顶消息
    add(const LoadPinnedMessages());

    // 启动离线消息自动重试监听
    _setupAutoRetry();
  }

  /// 启动阅后即焚销毁定时器
  void _startDestructionTimer() {
    _destructionTimer?.cancel();
    // 每秒检查一次是否有消息需要销毁
    _destructionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed && _currentRoomId != null) {
        add(const DestroyExpiredMessages());
      }
    });
  }

  /// 加载已保存的销毁时间
  void _loadSavedDestructionTimes(String roomId) {
    Future.microtask(() async {
      try {
        final destructionTimes = await _secureStorage.getMessageDestructionTimes(roomId);
        if (destructionTimes.isEmpty || isClosed) return;
        add(DestructionTimesLoaded(destructionTimes));
      } catch (e) {
        debugPrint('ChatBloc: Failed to load saved destruction times: $e');
      }
    });
  }

  /// 后台加载完整消息数据
  void _loadFullMessagesInBackground(String roomId) {
    Future.microtask(() async {
      if (isClosed || _currentRoomId != roomId) return;

      try {
        // 延迟加载 reactions 和 polls，避免阻塞首屏
        await Future<void>.delayed(const Duration(milliseconds: 100));

        if (isClosed || _currentRoomId != roomId) return;

        // 触发完整消息加载（包含 reactions 和 polls）
        add(LoadMessages(roomId));
      } catch (e) {
        debugPrint('ChatBloc: Background load failed: $e');
      }
    });
  }

  /// 异步加载已删除消息ID
  void _loadDeletedMessageIds(String roomId) {
    Future.microtask(() async {
      try {
        final persistedDeletedIds = await _messageRepository.getLocallyDeletedMessageIds(roomId);
        _locallyDeletedMessageIds.addAll(persistedDeletedIds);
        debugPrint('ChatBloc: Loaded ${persistedDeletedIds.length} locally deleted message IDs from storage');
      } catch (e) {
        debugPrint('ChatBloc: Failed to load locally deleted message IDs: $e');
      }
    });
  }

  /// 订阅投票响应事件
  void _subscribeToPollResponses(String roomId) {
    _pollResponsesSubscription?.cancel();
    final stream = _messageRepository.watchPollResponses(roomId);
    if (stream == null) return;

    _pollResponsesSubscription = stream.listen(
      (response) {
        // 防止在 BLoC 关闭后添加事件
        if (isClosed) return;

        final type = response['type'] as String?;
        final pollEventId = response['pollEventId'] as String?;

        if (pollEventId == null) return;

        if (type == 'vote') {
          final answers = (response['answers'] as List<dynamic>?)
              ?.cast<String>() ?? [];
          final senderId = response['senderId'] as String? ?? '';
          final isCurrentUser = response['isCurrentUser'] as bool? ?? false;

          add(PollResponseReceived(
            pollEventId: pollEventId,
            selectedOptionIds: answers,
            senderId: senderId,
            isCurrentUser: isCurrentUser,
          ));
        } else if (type == 'end') {
          add(PollEnded(pollEventId: pollEventId));
        }
      },
      onError: (Object error) {
        debugPrint('ChatBloc: Poll responses stream error: $error');
      },
    );
  }

  /// 加载消息
  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final messages = await _messageRepository.getMessages(
        event.roomId,
        limit: event.limit,
      );

      // 构建当前消息的索引 Map (O(n) 而不是 O(n²))
      final currentMessagesMap = <String, MessageEntity>{};
      for (final msg in state.messages) {
        currentMessagesMap[msg.id] = msg;
      }

      // 保留之前的 reactions（服务器聚合可能需要时间）
      var mergedMessages = messages.map((newMsg) {
        final currentMsg = currentMessagesMap[newMsg.id];
        if (currentMsg == null) return newMsg;

        // 如果当前消息有 reactions 但新消息没有，保留当前的 reactions
        if (currentMsg.reactions.isNotEmpty && newMsg.reactions.isEmpty) {
          return newMsg.copyWith(reactions: currentMsg.reactions);
        }
        // 合并 reactions（服务器可能有其他用户的 reactions）
        if (currentMsg.reactions.isNotEmpty && newMsg.reactions.isNotEmpty) {
          // 使用新消息的 reactions，但保留本地添加的
          final mergedReactions = <String, MessageReaction>{};
          // 先添加服务器的 reactions
          for (final r in newMsg.reactions) {
            mergedReactions[r.key] = r;
          }
          // 再添加本地的 reactions（如果服务器没有）
          for (final r in currentMsg.reactions) {
            if (!mergedReactions.containsKey(r.key)) {
              mergedReactions[r.key] = r;
            }
          }
          return newMsg.copyWith(reactions: mergedReactions.values.toList());
        }
        return newMsg;
      }).toList();

      // 获取投票消息的聚合结果
      mergedMessages = await _loadPollAggregations(event.roomId, mergedMessages);

      // 获取消息的反应聚合结果
      mergedMessages = await _loadReactionAggregations(event.roomId, mergedMessages);

      emit(state.copyWith(
        messages: mergedMessages,
        isLoading: false,
        hasMore: messages.length >= event.limit,
      ));

      // 标记最新消息已读
      if (messages.isNotEmpty) {
        await _messageRepository.markAsRead(event.roomId, messages.first.id);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load messages: ${e.toString()}',
      ));
    }
  }

  /// 加载投票消息的聚合结果
  Future<List<MessageEntity>> _loadPollAggregations(
    String roomId,
    List<MessageEntity> messages,
  ) async {
    final pollMessages = messages.where((m) => m.type == MessageType.poll).toList();
    if (pollMessages.isEmpty) return messages;

    final updatedMessages = List<MessageEntity>.from(messages);

    for (final pollMsg in pollMessages) {
      try {
        final aggregations = await _messageRepository.getPollAggregations(
          roomId,
          pollMsg.id,
        );

        if (aggregations != null) {
          final voteCounts = (aggregations['voteCounts'] as Map<String, dynamic>?)
              ?.cast<String, int>() ?? {};
          final totalVoters = aggregations['totalVoters'] as int? ?? 0;
          final myVotes = (aggregations['myVotes'] as List<dynamic>?)
              ?.cast<String>() ?? [];
          final pollEnded = aggregations['pollEnded'] as bool? ?? false;

          final index = updatedMessages.indexWhere((m) => m.id == pollMsg.id);
          if (index != -1 && pollMsg.metadata != null) {
            updatedMessages[index] = pollMsg.copyWith(
              metadata: pollMsg.metadata!.copyWithPoll(
                pollEnded: pollEnded,
                voteCounts: voteCounts,
                totalVoters: totalVoters,
                myVotes: myVotes,
              ),
            );
          }
        }
      } catch (e) {
        debugPrint('ChatBloc: Failed to load poll aggregations for ${pollMsg.id}: $e');
      }
    }

    return updatedMessages;
  }

  /// 加载消息的反应聚合结果
  ///
  /// 优化：使用 Future.wait() 并行请求，将加载时间从 5s 降至约 500ms
  Future<List<MessageEntity>> _loadReactionAggregations(
    String roomId,
    List<MessageEntity> messages,
  ) async {
    // 只检查最近的一些消息，因为旧消息可能没有反应
    final messagesToCheck = messages.take(50).toList();
    if (messagesToCheck.isEmpty) return messages;

    final updatedMessages = List<MessageEntity>.from(messages);

    // 并行请求所有消息的 reactions（最多 10 个并发）
    const batchSize = 10;
    for (var i = 0; i < messagesToCheck.length; i += batchSize) {
      final batch = messagesToCheck.skip(i).take(batchSize).toList();

      final futures = batch.map((msg) async {
        try {
          final aggregations = await _messageRepository.getReactionAggregations(
            roomId,
            msg.id,
          );
          return (msg.id, aggregations);
        } catch (e) {
          debugPrint('ChatBloc: Failed to load reaction aggregations for ${msg.id}: $e');
          return (msg.id, null);
        }
      });

      final results = await Future.wait(futures);

      for (final (msgId, aggregations) in results) {
        if (aggregations == null) continue;

        final reactionsData = aggregations['reactions'] as Map<String, dynamic>?;
        if (reactionsData == null || reactionsData.isEmpty) continue;

        final reactions = <MessageReaction>[];
        for (final entry in reactionsData.entries) {
          final emoji = entry.key;
          final data = entry.value as Map<String, dynamic>;
          final userIds = (data['userIds'] as List<String>?) ?? [];
          final isMe = data['isMe'] as bool? ?? false;

          reactions.add(MessageReaction(
            key: emoji,
            userIds: userIds,
            isMe: isMe,
          ));
        }

        if (reactions.isNotEmpty) {
          final index = updatedMessages.indexWhere((m) => m.id == msgId);
          if (index != -1) {
            final originalMsg = updatedMessages[index];
            updatedMessages[index] = originalMsg.copyWith(reactions: reactions);
          }
        }
      }
    }

    return updatedMessages;
  }

  /// 加载更多历史消息
  Future<void> _onLoadMoreMessages(
    LoadMoreMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || _currentRoomId == null) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final moreMessages = await _messageRepository.loadMoreMessages(
        _currentRoomId!,
        limit: 50,
      );

      emit(state.copyWith(
        messages: moreMessages,
        isLoadingMore: false,
        hasMore: moreMessages.length > state.messages.length,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: 'Failed to load more messages',
      ));
    }
  }

  /// 订阅消息更新
  Future<void> _onSubscribeMessages(
    SubscribeMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    await _messagesSubscription?.cancel();

    _messagesSubscription = _messageRepository
        .watchMessages(_currentRoomId!)
        .listen(
      (messages) {
        // 防止在 BLoC 关闭后添加事件
        if (!isClosed) {
          add(MessagesUpdated(messages));
        }
      },
      onError: (Object error) {
        debugPrint('ChatBloc: Messages stream error: $error');
      },
    );
  }

  /// 取消订阅
  Future<void> _onUnsubscribeMessages(
    UnsubscribeMessages event,
    Emitter<ChatState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;
  }

  /// 消息列表更新
  void _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<ChatState> emit,
  ) {
    // 过滤掉已本地删除的消息和线程内回复消息（线程回复只在线程详情页显示）
    final filteredMessages = event.messages
        .where((m) => !_locallyDeletedMessageIds.contains(m.id))
        .where((m) => !m.isInThread)
        .toList();

    // 构建当前消息的索引 Map (O(n) 而不是 O(n²))
    final currentMessagesMap = <String, MessageEntity>{};
    for (final msg in state.messages) {
      currentMessagesMap[msg.id] = msg;
    }

    // 保留本地添加的 reactions 和投票状态（服务器聚合可能需要时间）
    final mergedMessages = filteredMessages.map((newMsg) {
      // 查找当前状态中的同一消息
      final currentMsg = currentMessagesMap[newMsg.id];
      if (currentMsg == null) return newMsg;

      // 防止已撤回的消息被 sync 事件"恢复"成原始内容。
      // Matrix 协议保证消息一旦被 redact 就永远是 redacted，但本地乐观更新时
      // 可能 sync 先带来旧事件（历史分页等），需在此兜底。
      if (currentMsg.type == MessageType.redacted &&
          newMsg.type != MessageType.redacted) {
        return currentMsg;
      }

      // 如果当前消息有 reactions 但新消息没有，保留当前的 reactions
      if (currentMsg.reactions.isNotEmpty && newMsg.reactions.isEmpty) {
        newMsg = newMsg.copyWith(reactions: currentMsg.reactions);
      }

      // 保留投票消息的本地状态（服务器聚合需要时间）
      if (newMsg.type == MessageType.poll &&
          currentMsg.type == MessageType.poll &&
          currentMsg.metadata != null) {
        final currentMeta = currentMsg.metadata!;
        final newMeta = newMsg.metadata;

        // 如果本地有投票数据但服务器返回的没有，保留本地数据
        if ((currentMeta.totalVoters ?? 0) > 0 &&
            (newMeta?.totalVoters ?? 0) == 0) {
          newMsg = newMsg.copyWith(metadata: currentMeta);
        }
        // 如果本地有我的投票但服务器返回的没有，保留本地数据
        else if ((currentMeta.myVotes?.isNotEmpty ?? false) &&
                 (newMeta?.myVotes?.isEmpty ?? true)) {
          newMsg = newMsg.copyWith(
            metadata: MessageMetadata(
              pollQuestion: newMeta?.pollQuestion ?? currentMeta.pollQuestion,
              pollOptions: newMeta?.pollOptions ?? currentMeta.pollOptions,
              pollOptionIds: newMeta?.pollOptionIds ?? currentMeta.pollOptionIds,
              maxSelections: newMeta?.maxSelections ?? currentMeta.maxSelections,
              pollEnded: newMeta?.pollEnded ?? currentMeta.pollEnded,
              voteCounts: currentMeta.voteCounts,
              totalVoters: currentMeta.totalVoters,
              myVotes: currentMeta.myVotes,
              // 保留其他元数据
              mediaUrl: newMeta?.mediaUrl,
              httpUrl: newMeta?.httpUrl,
              thumbnailUrl: newMeta?.thumbnailUrl,
              mimeType: newMeta?.mimeType,
              size: newMeta?.size,
              width: newMeta?.width,
              height: newMeta?.height,
              duration: newMeta?.duration,
              fileName: newMeta?.fileName,
              isPlayed: newMeta?.isPlayed,
              waveform: newMeta?.waveform,
              latitude: newMeta?.latitude,
              longitude: newMeta?.longitude,
              locationName: newMeta?.locationName,
              amount: newMeta?.amount,
              token: newMeta?.token,
              transferStatus: newMeta?.transferStatus,
              txHash: newMeta?.txHash,
            ),
          );
        }
      }

      return newMsg;
    }).toList();

    if (!isClosed) {
      emit(state.copyWith(messages: mergedMessages));

      // 扫描失败消息加入自动重试队列
      _scanFailedMessages();
    }
  }

  /// 发送文本消息
  Future<void> _onSendTextMessage(
    SendTextMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || event.text.trim().isEmpty) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      // 如果有回复目标，使用回复功能
      if (state.replyTarget != null) {
        await _messageRepository.replyToMessage(
          _currentRoomId!,
          state.replyTarget!.id,
          event.text,
        );
        emit(state.copyWith(isSending: false, clearReplyTarget: true));
      } else {
        await _messageRepository.sendTextMessage(
          _currentRoomId!,
          event.text,
          selfDestructAfter: event.selfDestructAfter,
          mentionedUserIds: event.mentionedUserIds,
          mentionsRoom: event.mentionsRoom,
        );
        emit(state.copyWith(isSending: false));
      }
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send',
      ));
    }
  }

  /// 发送图片消息
  Future<void> _onSendImageMessage(
    SendImageMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) {
      debugPrint('ChatBloc: Cannot send image - no room ID');
      return;
    }

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      debugPrint('ChatBloc: Sending image ${event.filename}, size: ${event.imageBytes.length}');
      await _messageRepository.sendImageMessage(
        _currentRoomId!,
        imageBytes: event.imageBytes,
        filename: event.filename,
        mimeType: event.mimeType,
        selfDestructAfter: event.selfDestructAfter,
      );
      debugPrint('ChatBloc: Image sent successfully');
      emit(state.copyWith(isSending: false));
    } catch (e, stackTrace) {
      debugPrint('ChatBloc: Send image error - $e');
      debugPrint('ChatBloc: Stack trace - $stackTrace');
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send image: $e',
      ));
    }
  }

  /// 发送语音消息
  Future<void> _onSendVoiceMessage(
    SendVoiceMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) {
      debugPrint('ChatBloc: Cannot send voice - no room ID');
      return;
    }

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      debugPrint('ChatBloc: Sending voice ${event.filename}, size: ${event.audioBytes.length}, duration: ${event.duration}ms');
      await _messageRepository.sendVoiceMessage(
        _currentRoomId!,
        audioBytes: event.audioBytes,
        filename: event.filename,
        duration: event.duration,
        mimeType: event.mimeType,
      );
      debugPrint('ChatBloc: Voice sent successfully');
      emit(state.copyWith(isSending: false));
    } catch (e, stackTrace) {
      debugPrint('ChatBloc: Send voice error - $e');
      debugPrint('ChatBloc: Stack trace - $stackTrace');
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send voice: $e',
      ));
    }
  }

  /// 发送文件消息
  Future<void> _onSendFileMessage(
    SendFileMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      await _messageRepository.sendFileMessage(
        _currentRoomId!,
        fileBytes: event.fileBytes,
        filename: event.filename,
        mimeType: event.mimeType,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send file',
      ));
    }
  }

  /// 发送视频消息（带缩略图）
  Future<void> _onSendVideoMessage(
    SendVideoMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      debugPrint('ChatBloc: Sending video with thumbnail: ${event.thumbnailBytes?.length ?? 0} bytes');
      await _messageRepository.sendVideoMessage(
        _currentRoomId!,
        videoBytes: event.videoBytes,
        filename: event.filename,
        mimeType: event.mimeType,
        thumbnailBytes: event.thumbnailBytes,
        selfDestructAfter: event.selfDestructAfter,
      );
      debugPrint('ChatBloc: Video sent successfully');
      emit(state.copyWith(isSending: false));
    } catch (e, stackTrace) {
      debugPrint('ChatBloc: Send video error - $e');
      debugPrint('ChatBloc: Stack trace - $stackTrace');
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send video: $e',
      ));
    }
  }

  /// 发送位置消息
  Future<void> _onSendLocationMessage(
    SendLocationMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      await _messageRepository.sendLocationMessage(
        _currentRoomId!,
        latitude: event.latitude,
        longitude: event.longitude,
        description: event.description,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send location',
      ));
    }
  }

  /// 重发消息
  Future<void> _onResendMessage(
    ResendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _messageRepository.resendMessage(_currentRoomId!, event.messageId);
      // 旧的 EventStatus.error 事件仍在 SDK 时间线中，将其 ID 加入本地删除集合
      // 防止 _scanFailedMessages 将旧事件重新入队形成死循环。
      _locallyDeletedMessageIds.add(event.messageId);
      // 允许新事件（由 resendMessage 创建）被自动重试系统处理
      _permanentlyFailedMessages.remove(event.messageId);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to resend'));
    }
  }

  /// 撤回消息
  ///
  /// 遵循 Matrix 规范与微信行为：撤回不删除消息条目，而是将其原地更新为
  /// [MessageType.redacted]，保持消息在列表中的位置，仅内容替换为"已撤回"提示。
  ///
  /// 旧逻辑（直接删除）会导致：
  ///   撤回 → 消息消失 → 服务器确认后 BLoC 删除 → sync 到来 → 消息重新出现
  /// 新逻辑（原地标记）：
  ///   撤回 → 消息立即标记为 redacted（UI 持续显示"已撤回"）→ sync 到来不变
  Future<void> _onRedactMessage(
    RedactMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    // 保存原始消息列表，用于失败时回滚
    final originalMessages = List<MessageEntity>.unmodifiable(state.messages);

    // 立即在本地将消息标记为已撤回（乐观更新）
    // 使消息立即显示为"已撤回"提示，而不是消失
    final optimisticMessages = state.messages.map((m) {
      if (m.id == event.messageId) {
        return m.copyWith(type: MessageType.redacted, content: '');
      }
      return m;
    }).toList();
    emit(state.copyWith(messages: optimisticMessages));

    try {
      await _messageRepository.redactMessage(
        _currentRoomId!,
        event.messageId,
        reason: event.reason,
      );
      // 服务器确认后无需额外操作：
      // Matrix sync 会将该事件重新推回，_onMessagesUpdated 中会以
      // MessageType.redacted 合并，与当前状态一致，不会产生闪烁。
    } catch (e) {
      // 服务器撤回失败：回滚乐观更新，恢复原始消息列表
      debugPrint('ChatBloc: Failed to redact message ${event.messageId}: $e');
      emit(state.copyWith(
        messages: originalMessages,
        error: 'Failed to recall',
      ));
    }
  }
  
  /// 本地删除消息（不发送到服务器）
  Future<void> _onDeleteMessagesLocally(
    DeleteMessagesLocally event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    final idsToDelete = event.messageIds.toSet();

    // 将删除的消息ID添加到内存集合中，防止被消息订阅恢复
    _locallyDeletedMessageIds.addAll(idsToDelete);
    debugPrint('ChatBloc: Locally deleted message IDs: $idsToDelete');

    // 立即更新 UI
    final updatedMessages = state.messages
        .where((m) => !idsToDelete.contains(m.id))
        .toList();
    emit(state.copyWith(messages: updatedMessages));

    // 持久化到存储（异步，不阻塞 UI）
    try {
      await _messageRepository.markMessagesAsLocallyDeleted(
        _currentRoomId!,
        event.messageIds,
      );
      debugPrint('ChatBloc: Persisted ${event.messageIds.length} deleted message IDs to storage');
    } catch (e) {
      debugPrint('ChatBloc: Failed to persist deleted message IDs: $e');
    }
  }
  
  /// 删除发送失败的消息（从本地和服务器）
  Future<void> _onDeleteFailedMessage(
    DeleteFailedMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    final roomId = _currentRoomId!;
    final messageId = event.messageId;
    
    debugPrint('ChatBloc: Deleting failed message: $messageId');
    
    // 先从 UI 中移除
    _locallyDeletedMessageIds.add(messageId);
    final updatedMessages = state.messages
        .where((m) => m.id != messageId)
        .toList();
    
    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages));
    }
    
    // 然后尝试从服务器/本地数据库中删除（不需要 emit，所以可以在 bloc 关闭后继续）
    try {
      await _messageRepository.deleteFailedMessage(roomId, messageId);
      debugPrint('ChatBloc: Successfully deleted failed message from server/local');
    } catch (e) {
      debugPrint('ChatBloc: Error deleting failed message: $e');
    }
  }

  /// 回复消息
  Future<void> _onReplyToMessage(
    ReplyToMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      await _messageRepository.replyToMessage(
        _currentRoomId!,
        event.replyToMessageId,
        event.text,
      );
      emit(state.copyWith(isSending: false, clearReplyTarget: true));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to reply',
      ));
    }
  }

  /// 设置回复目标
  void _onSetReplyTarget(
    SetReplyTarget event,
    Emitter<ChatState> emit,
  ) {
    if (event.message == null) {
      emit(state.copyWith(clearReplyTarget: true));
    } else {
      // 进入回复模式时清除编辑模式
      emit(state.copyWith(replyTarget: event.message, clearEditingMessage: true));
    }
  }

  /// 设置编辑目标（进入/退出编辑模式）
  void _onSetEditTarget(
    SetEditTarget event,
    Emitter<ChatState> emit,
  ) {
    if (event.message == null) {
      emit(state.copyWith(clearEditingMessage: true));
    } else {
      // 进入编辑模式时清除回复目标
      emit(state.copyWith(editingMessage: event.message, clearReplyTarget: true));
    }
  }

  /// 添加表情回应
  Future<void> _onAddReaction(
    AddReaction event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 先立即更新本地UI，显示表情回应
      final currentUserId = await _messageRepository.getCurrentUserId();
      final updatedMessages = state.messages.map((msg) {
        if (msg.id == event.messageId) {
          // 查找是否已有该表情的回应
          final existingReactionIndex = msg.reactions.indexWhere(
            (r) => r.key == event.emoji,
          );
          
          List<MessageReaction> newReactions;
          if (existingReactionIndex >= 0) {
            // 已有该表情，增加计数
            final existingReaction = msg.reactions[existingReactionIndex];
            if (existingReaction.userIds.contains(currentUserId)) {
              // 用户已经回应过，移除回应
              final newUserIds = existingReaction.userIds
                  .where((id) => id != currentUserId)
                  .toList();
              if (newUserIds.isEmpty) {
                // 没有人回应了，移除整个表情
                newReactions = [...msg.reactions]..removeAt(existingReactionIndex);
              } else {
                newReactions = [...msg.reactions];
                newReactions[existingReactionIndex] = MessageReaction(
                  key: existingReaction.key,
                  userIds: newUserIds,
                  isMe: false,
                );
              }
            } else {
              // 用户没有回应过，添加回应
              newReactions = [...msg.reactions];
              newReactions[existingReactionIndex] = MessageReaction(
                key: existingReaction.key,
                userIds: [...existingReaction.userIds, currentUserId ?? 'me'],
                isMe: true,
              );
            }
          } else {
            // 新的表情回应
            newReactions = [
              ...msg.reactions,
              MessageReaction(
                key: event.emoji,
                userIds: [currentUserId ?? 'me'],
                isMe: true,
              ),
            ];
          }
          
          return msg.copyWith(reactions: newReactions);
        }
        return msg;
      }).toList();
      
      emit(state.copyWith(messages: updatedMessages));
      
      // 发送到服务器
      await _messageRepository.addReaction(
        _currentRoomId!,
        event.messageId,
        event.emoji,
      );
      debugPrint('ChatBloc: Reaction $event.emoji added to message ${event.messageId}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to add reaction: $e');
      emit(state.copyWith(error: 'Failed to add reaction'));
    }
  }

  /// 标记消息已读
  ///
  /// 根据用户隐私设置决定是否发送已读回执
  Future<void> _onMarkMessageAsRead(
    MarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 检查隐私设置：是否允许发送已读回执
      final shouldSendReadReceipts = await _secureStorage.shouldShowReadReceipts();
      if (!shouldSendReadReceipts) {
        debugPrint('ChatBloc: Skipping read receipt due to privacy settings');
        return;
      }

      await _messageRepository.markAsRead(_currentRoomId!, event.messageId);
    } catch (e) {
      // 静默失败
      debugPrint('Error: $e');
    }
  }

  /// 发送正在输入状态
  ///
  /// 根据用户隐私设置决定是否发送输入状态
  Future<void> _onSendTypingNotification(
    SendTypingNotification event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 检查隐私设置：是否允许发送输入状态
      final shouldSendTypingIndicator = await _secureStorage.shouldShowTypingIndicator();
      if (!shouldSendTypingIndicator) {
        debugPrint('ChatBloc: Skipping typing notification due to privacy settings');
        return;
      }

      await _messageRepository.sendTypingNotification(
        _currentRoomId!,
        event.isTyping,
      );
    } catch (e) {
      // 静默失败
      debugPrint('Error: $e');
    }
  }

  /// 清理聊天室
  Future<void> _onDisposeChat(
    DisposeChat event,
    Emitter<ChatState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;
    await _syncStatusSubscription?.cancel();
    _syncStatusSubscription = null;
    _retryTimer?.cancel();
    _retryTimer = null;
    _pendingRetryMessages.clear();
    _permanentlyFailedMessages.clear();
    _currentRoomId = null;
    _locallyDeletedMessageIds.clear();
    if (!isClosed) {
      emit(ChatState.initial());
    }
  }
  
  /// 发送系统通知/拍一拍消息
  Future<void> _onSendSystemNotice(
    SendSystemNotice event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    try {
      await _messageRepository.sendNoticeMessage(
        roomId: _currentRoomId!,
        notice: event.notice,
      );
      debugPrint('ChatBloc: System notice sent: ${event.notice}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to send system notice: $e');
    }
  }
  
  /// 发送拍一拍消息
  Future<void> _onSendPokeMessage(
    SendPokeMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    try {
      // 微信拍一拍逻辑：统一使用"拍人者"设置的后缀
      // 例如：拍人者设置后缀"的头"，则无论拍谁都显示"XXX 拍了拍 YYY 的头"
      final String? pokeText = event.pokerPokeText;
      
      debugPrint('ChatBloc: Using poker\'s pokeText: $pokeText');
      
      // 构造拍一拍消息
      String pokeMessage;
      if (pokeText != null && pokeText.isNotEmpty) {
        pokeMessage = '「${event.pokerName}」拍了拍「${event.targetName}」$pokeText';
      } else {
        pokeMessage = '「${event.pokerName}」拍了拍「${event.targetName}」';
      }
      
      debugPrint('ChatBloc: Sending poke message: $pokeMessage');
      
      // 发送系统消息
      await _messageRepository.sendNoticeMessage(
        roomId: _currentRoomId!,
        notice: pokeMessage,
      );
      
      debugPrint('ChatBloc: Poke message sent successfully');
    } catch (e) {
      debugPrint('ChatBloc: Failed to send poke message: $e');
    }
  }
  
  /// 发送投票消息
  Future<void> _onSendPollMessage(
    SendPollMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    try {
      debugPrint('ChatBloc: Sending poll - question: ${event.question}, options: ${event.options}');
      
      final message = await _messageRepository.sendPollMessage(
        _currentRoomId!,
        question: event.question,
        options: event.options,
        maxSelections: event.maxSelections,
      );
      
      if (message != null) {
        debugPrint('ChatBloc: Poll sent successfully - eventId: ${message.id}');
        // 消息会通过订阅自动更新
      }
    } catch (e) {
      debugPrint('ChatBloc: Failed to send poll: $e');
      if (!isClosed) {
        emit(state.copyWith(error: 'Failed to send poll'));
      }
    }
  }
  
  /// 投票响应
  Future<void> _onVoteOnPoll(
    VoteOnPoll event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    try {
      debugPrint('ChatBloc: Voting on poll - pollEventId: ${event.pollEventId}, options: ${event.selectedOptionIds}');
      
      final success = await _messageRepository.voteOnPoll(
        _currentRoomId!,
        pollEventId: event.pollEventId,
        selectedOptionIds: event.selectedOptionIds,
      );
      
      if (success && !isClosed) {
        debugPrint('ChatBloc: Vote submitted successfully, fetching fresh poll data');

        // 从服务器获取最新的投票聚合数据
        final freshAggregations = await _messageRepository.getPollAggregations(
          _currentRoomId!,
          event.pollEventId,
        );

        // 使用服务器数据更新UI
        final updatedMessages = state.messages.map((msg) {
          if (msg.id == event.pollEventId && msg.metadata != null) {
            final oldMetadata = msg.metadata!;

            // 优先使用服务器返回的数据
            Map<String, int> newVoteCounts;
            int totalVoters;
            List<String> newMyVotes;

            if (freshAggregations != null) {
              newVoteCounts = (freshAggregations['voteCounts'] as Map<String, dynamic>?)
                  ?.cast<String, int>() ?? {};
              totalVoters = freshAggregations['totalVoters'] as int? ?? 0;
              newMyVotes = (freshAggregations['myVotes'] as List<dynamic>?)
                  ?.cast<String>() ?? event.selectedOptionIds;
              debugPrint('ChatBloc: Using fresh poll data - voteCounts: $newVoteCounts, totalVoters: $totalVoters, myVotes: $newMyVotes');
            } else {
              // 如果获取失败，使用本地计算的数据
              debugPrint('ChatBloc: Fresh poll data unavailable, using local calculation');
              newVoteCounts = Map<String, int>.from(oldMetadata.voteCounts ?? {});
              final oldMyVotes = List<String>.from(oldMetadata.myVotes ?? []);
              newMyVotes = List<String>.from(event.selectedOptionIds);

              debugPrint('ChatBloc: oldMyVotes: $oldMyVotes, newMyVotes: $newMyVotes');

              // 减少之前投票但现在取消的选项的票数
              for (final optionId in oldMyVotes) {
                if (!newMyVotes.contains(optionId)) {
                  final currentCount = newVoteCounts[optionId] ?? 0;
                  if (currentCount > 0) {
                    newVoteCounts[optionId] = currentCount - 1;
                    debugPrint('ChatBloc: Decreased vote count for $optionId to ${newVoteCounts[optionId]}');
                  }
                }
              }

              // 增加新投票选项的票数
              for (final optionId in newMyVotes) {
                if (!oldMyVotes.contains(optionId)) {
                  newVoteCounts[optionId] = (newVoteCounts[optionId] ?? 0) + 1;
                  debugPrint('ChatBloc: Increased vote count for $optionId to ${newVoteCounts[optionId]}');
                }
              }

              // 计算新的总投票人数
              totalVoters = oldMetadata.totalVoters ?? 0;
              if (oldMyVotes.isEmpty && newMyVotes.isNotEmpty) {
                totalVoters += 1;
              } else if (oldMyVotes.isNotEmpty && newMyVotes.isEmpty) {
                totalVoters = totalVoters > 0 ? totalVoters - 1 : 0;
              }
            }
            
            return msg.copyWith(
              metadata: oldMetadata.copyWithPoll(
                voteCounts: newVoteCounts,
                totalVoters: totalVoters,
                myVotes: newMyVotes,
              ),
            );
          }
          return msg;
        }).toList();
        
        emit(state.copyWith(messages: updatedMessages));
      }
    } catch (e) {
      debugPrint('ChatBloc: Failed to vote: $e');
      if (!isClosed) {
        emit(state.copyWith(error: 'Failed to vote'));
      }
    }
  }

  /// 处理投票响应接收事件（来自其他用户的投票）
  Future<void> _onPollResponseReceived(
    PollResponseReceived event,
    Emitter<ChatState> emit,
  ) async {
    if (isClosed) return;

    // 如果是当前用户的投票，已在 _onVoteOnPoll 中处理
    if (event.isCurrentUser) return;

    debugPrint('ChatBloc: Poll response received - poll: ${event.pollEventId}, from: ${event.senderId}');

    final updatedMessages = state.messages.map((msg) {
      if (msg.id == event.pollEventId && msg.metadata != null) {
        final oldMetadata = msg.metadata!;
        final newVoteCounts = Map<String, int>.from(oldMetadata.voteCounts ?? {});

        // 更新选中选项的票数
        for (final optionId in event.selectedOptionIds) {
          newVoteCounts[optionId] = (newVoteCounts[optionId] ?? 0) + 1;
        }

        // 计算新的总投票人数
        final totalVoters = (oldMetadata.totalVoters ?? 0) + 1;

        return msg.copyWith(
          metadata: oldMetadata.copyWithPoll(
            voteCounts: newVoteCounts,
            totalVoters: totalVoters,
          ),
        );
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages));
  }

  /// 主动结束投票
  Future<void> _onEndPoll(
    EndPoll event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      debugPrint('ChatBloc: Ending poll - poll: ${event.pollEventId}');

      // 调用 API 结束投票
      final success = await _messageRepository.endPoll(
        _currentRoomId!,
        event.pollEventId,
      );

      if (success) {
        // 立即更新本地状态
        final updatedMessages = state.messages.map((msg) {
          if (msg.id == event.pollEventId && msg.metadata != null) {
            return msg.copyWith(
              metadata: msg.metadata!.copyWithPoll(pollEnded: true),
            );
          }
          return msg;
        }).toList();

        emit(state.copyWith(messages: updatedMessages));
        debugPrint('ChatBloc: Poll ended successfully');
      } else {
        debugPrint('ChatBloc: Failed to end poll');
        emit(state.copyWith(error: 'Failed to end poll'));
      }
    } catch (e) {
      debugPrint('ChatBloc: Error ending poll: $e');
      emit(state.copyWith(error: 'Error ending poll: $e'));
    }
  }

  /// 处理投票已结束事件（从服务器接收）
  Future<void> _onPollEnded(
    PollEnded event,
    Emitter<ChatState> emit,
  ) async {
    if (isClosed) return;

    debugPrint('ChatBloc: Poll ended - poll: ${event.pollEventId}');

    final updatedMessages = state.messages.map((msg) {
      if (msg.id == event.pollEventId && msg.metadata != null) {
        return msg.copyWith(
          metadata: msg.metadata!.copyWithPoll(pollEnded: true),
        );
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages));
  }

  /// 发送自定义消息（红包、转账等）
  Future<void> _onSendCustomMessage(
    SendCustomMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;
    
    try {
      debugPrint('ChatBloc: Sending custom message - type: ${event.type}, content: ${event.content}');
      
      // 获取当前用户ID
      final currentUserId = await _messageRepository.getCurrentUserId() ?? '';
      
      // 创建临时消息（用于乐观更新）
      final tempMessage = MessageEntity(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        roomId: _currentRoomId!,
        senderId: currentUserId,
        senderName: 'Me',
        content: event.content,
        type: event.type,
        timestamp: DateTime.now(),
        status: MessageStatus.sending,
        isFromMe: true,
        metadata: event.metadata,
      );
      
      // 乐观更新 UI
      if (!isClosed) {
        emit(state.copyWith(
          messages: [tempMessage, ...state.messages],
        ));
      }
      
      // 根据消息类型发送
      String? eventId;
      
      if (event.type == MessageType.redPacket) {
        // 发送红包消息（使用自定义消息类型）
        eventId = await _messageRepository.sendCustomMessage(
          _currentRoomId!,
          msgType: 'n42.red_packet',
          content: event.content,
          additionalData: {
            'amount': event.metadata?.amount ?? '0',
            'token': event.metadata?.token ?? 'ETH',
            'status': 'pending',
          },
        );
      } else if (event.type == MessageType.transfer) {
        // 发送转账消息
        eventId = await _messageRepository.sendCustomMessage(
          _currentRoomId!,
          msgType: 'n42.transfer',
          content: event.content,
          additionalData: {
            'amount': event.metadata?.amount ?? '0',
            'token': event.metadata?.token ?? 'ETH',
            'status': 'pending',
          },
        );
      } else if (event.type == MessageType.music) {
        // 发送音乐分享消息
        eventId = await _messageRepository.sendCustomMessage(
          _currentRoomId!,
          msgType: 'n42.music',
          content: event.content,
          additionalData: {
            'title': event.metadata?.musicTitle ?? '',
            'artist': event.metadata?.musicArtist ?? '',
            'url': event.metadata?.musicUrl ?? '',
            'cover': event.metadata?.musicCover ?? '',
          },
        );
      }

      if (eventId != null) {
        debugPrint('ChatBloc: Custom message sent - eventId: $eventId');
        
        // 更新消息状态为已发送
        if (!isClosed) {
          final updatedMessages = state.messages.map((msg) {
            if (msg.id == tempMessage.id) {
              return msg.copyWith(
                id: eventId,
                status: MessageStatus.sent,
              );
            }
            return msg;
          }).toList();
          
          emit(state.copyWith(messages: updatedMessages));
        }
      } else {
        // 发送失败，更新状态
        if (!isClosed) {
          final updatedMessages = state.messages.map((msg) {
            if (msg.id == tempMessage.id) {
              return msg.copyWith(status: MessageStatus.failed);
            }
            return msg;
          }).toList();
          
          emit(state.copyWith(
            messages: updatedMessages,
            error: 'Failed to send',
          ));
        }
      }
    } catch (e) {
      debugPrint('ChatBloc: Failed to send custom message: $e');
      if (!isClosed) {
        emit(state.copyWith(error: 'Failed to send: $e'));
      }
    }
  }

  /// 清空聊天记录（本地）
  Future<void> _onClearChatHistory(
    ClearChatHistory event,
    Emitter<ChatState> emit,
  ) async {
    debugPrint('ChatBloc: Clearing chat history for room $_currentRoomId');

    // 清空本地消息列表
    _locallyDeletedMessageIds.addAll(state.messages.map((m) => m.id));

    if (!isClosed) {
      emit(state.copyWith(
        messages: [],
        clearError: true,
      ));
    }
  }

  /// 开始消息的自毁倒计时
  Future<void> _onStartMessageDestruction(
    StartMessageDestruction event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 查找消息
      final messageIndex = state.messages.indexWhere((m) => m.id == event.messageId);
      if (messageIndex == -1) return;

      final message = state.messages[messageIndex];

      // 检查是否是阅后即焚消息且倒计时未开始
      if (!message.isSelfDestructing || message.isDestructionStarted) return;

      // 计算销毁时间
      final destroyedAt = DateTime.now().add(
        Duration(seconds: message.selfDestructAfter!),
      );

      // 保存到本地存储
      await _secureStorage.setMessageDestroyedAt(
        _currentRoomId!,
        event.messageId,
        destroyedAt,
      );

      // 更新消息状态
      final updatedMessages = List<MessageEntity>.from(state.messages);
      updatedMessages[messageIndex] = message.copyWith(destroyedAt: destroyedAt);

      if (!isClosed) {
        emit(state.copyWith(messages: updatedMessages));
      }

      debugPrint('ChatBloc: Started destruction countdown for message ${event.messageId}, will destroy at $destroyedAt');
    } catch (e) {
      debugPrint('ChatBloc: Failed to start message destruction: $e');
    }
  }

  /// 销毁已过期的阅后即焚消息
  Future<void> _onDestroyExpiredMessages(
    DestroyExpiredMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    final now = DateTime.now();
    final expiredMessageIds = <String>[];

    // 找出所有已过期的消息
    for (final message in state.messages) {
      if (message.isSelfDestructing &&
          message.isDestructionStarted &&
          message.destroyedAt!.isBefore(now)) {
        expiredMessageIds.add(message.id);
      }
    }

    if (expiredMessageIds.isEmpty) return;

    debugPrint('ChatBloc: Destroying ${expiredMessageIds.length} expired messages');

    // 从本地列表中移除
    _locallyDeletedMessageIds.addAll(expiredMessageIds);
    final updatedMessages = state.messages
        .where((m) => !expiredMessageIds.contains(m.id))
        .toList();

    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages));
    }

    // 异步撤回消息（不阻塞 UI）
    for (final messageId in expiredMessageIds) {
      try {
        await _messageRepository.redactMessage(
          _currentRoomId!,
          messageId,
          reason: 'Self-destructed',
        );
      } catch (e) {
        debugPrint('ChatBloc: Failed to redact expired message $messageId: $e');
      }
    }

    // 清除销毁时间记录
    await _secureStorage.clearMessageDestructionTimes(
      _currentRoomId!,
      expiredMessageIds,
    );
  }

  /// 更新阅后即焚消息的倒计时状态
  void _onUpdateDestructionCountdown(
    UpdateDestructionCountdown event,
    Emitter<ChatState> emit,
  ) {
    final messageIndex = state.messages.indexWhere((m) => m.id == event.messageId);
    if (messageIndex == -1) return;

    final message = state.messages[messageIndex];
    if (!message.isSelfDestructing) return;

    final updatedMessages = List<MessageEntity>.from(state.messages);
    updatedMessages[messageIndex] = message.copyWith(destroyedAt: event.destroyedAt);

    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages));
    }
  }

  // ============================================
  // 定时发送消息
  // ============================================

  /// 启动定时消息检查定时器
  void _startScheduledMessageTimer() {
    _scheduledMessageTimer?.cancel();
    // 每分钟检查一次是否有到期的定时消息
    _scheduledMessageTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!isClosed) {
        add(const SendDueScheduledMessages());
      }
    });
  }

  /// 加载定时消息
  void _loadScheduledMessages(String roomId) {
    Future.microtask(() async {
      try {
        final scheduledMessages = await _secureStorage.getScheduledMessages(roomId);
        if (scheduledMessages.isEmpty || isClosed) return;

        // 获取当前用户ID
        final currentUserId = await _messageRepository.getCurrentUserId() ?? '';

        // 为每个定时消息创建临时消息实体显示在UI中
        final tempMessages = <MessageEntity>[];
        for (final msg in scheduledMessages) {
          final scheduledAt = DateTime.parse(msg['scheduledAt'] as String);

          tempMessages.add(MessageEntity(
            id: msg['messageId'] as String,
            roomId: roomId,
            senderId: currentUserId,
            senderName: 'Me',
            content: msg['text'] as String,
            type: MessageType.text,
            timestamp: DateTime.parse(msg['createdAt'] as String),
            status: MessageStatus.sending,
            isFromMe: true,
            scheduledAt: scheduledAt,
            selfDestructAfter: msg['selfDestructAfter'] as int?,
            mentionedUserIds: (msg['mentionedUserIds'] as List<dynamic>?)?.cast<String>() ?? [],
            mentionsRoom: msg['mentionsRoom'] as bool? ?? false,
          ));
        }

        if (tempMessages.isNotEmpty && !isClosed) {
          // 将定时消息添加到消息列表末尾（按时间排序）
          final allMessages = [...state.messages, ...tempMessages];
          allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(messages: allMessages));
        }
      } catch (e) {
        debugPrint('ChatBloc: Failed to load scheduled messages: $e');
      }
    });
  }

  /// 发送定时消息
  Future<void> _onSendScheduledMessage(
    SendScheduledMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || event.text.trim().isEmpty) return;

    try {
      // 生成临时消息ID
      final tempId = 'scheduled_${DateTime.now().millisecondsSinceEpoch}';

      // 获取当前用户ID
      final currentUserId = await _messageRepository.getCurrentUserId() ?? '';

      // 保存定时消息到本地存储
      await _secureStorage.saveScheduledMessage(
        roomId: _currentRoomId!,
        messageId: tempId,
        text: event.text,
        scheduledAt: event.scheduledAt,
        selfDestructAfter: event.selfDestructAfter,
        mentionedUserIds: event.mentionedUserIds,
        mentionsRoom: event.mentionsRoom,
      );

      // 创建临时消息显示在UI中
      final tempMessage = MessageEntity(
        id: tempId,
        roomId: _currentRoomId!,
        senderId: currentUserId,
        senderName: 'Me',
        content: event.text,
        type: MessageType.text,
        timestamp: DateTime.now(),
        status: MessageStatus.sending,
        isFromMe: true,
        scheduledAt: event.scheduledAt,
        selfDestructAfter: event.selfDestructAfter,
        mentionedUserIds: event.mentionedUserIds ?? [],
        mentionsRoom: event.mentionsRoom,
      );

      // 添加到消息列表
      if (!isClosed) {
        emit(state.copyWith(messages: [tempMessage, ...state.messages]));
      }

      debugPrint('ChatBloc: Scheduled message saved - $tempId for ${event.scheduledAt}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to schedule message: $e');
      if (!isClosed) {
        emit(state.copyWith(error: 'Failed to schedule message'));
      }
    }
  }

  /// 取消定时消息
  Future<void> _onCancelScheduledMessage(
    CancelScheduledMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 从存储中删除
      await _secureStorage.removeScheduledMessage(_currentRoomId!, event.messageId);

      // 从UI中移除
      final updatedMessages = state.messages
          .where((m) => m.id != event.messageId)
          .toList();

      if (!isClosed) {
        emit(state.copyWith(messages: updatedMessages));
      }

      debugPrint('ChatBloc: Scheduled message cancelled - ${event.messageId}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to cancel scheduled message: $e');
    }
  }

  /// 发送到期的定时消息
  Future<void> _onSendDueScheduledMessages(
    SendDueScheduledMessages event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // 获取所有到期的定时消息
      final dueMessages = await _secureStorage.getDueScheduledMessages();
      if (dueMessages.isEmpty) return;

      debugPrint('ChatBloc: Found ${dueMessages.length} due scheduled messages');

      for (final msg in dueMessages) {
        final roomId = msg['roomId'] as String;
        final messageId = msg['messageId'] as String;
        final text = msg['text'] as String;
        final selfDestructAfter = msg['selfDestructAfter'] as int?;
        final mentionedUserIds = (msg['mentionedUserIds'] as List<dynamic>?)?.cast<String>();
        final mentionsRoom = msg['mentionsRoom'] as bool? ?? false;

        try {
          // 发送消息
          await _messageRepository.sendTextMessage(
            roomId,
            text,
            selfDestructAfter: selfDestructAfter,
            mentionedUserIds: mentionedUserIds,
            mentionsRoom: mentionsRoom,
          );

          // 从存储中删除
          await _secureStorage.removeScheduledMessage(roomId, messageId);

          // 如果是当前房间，更新UI
          if (roomId == _currentRoomId && !isClosed) {
            final updatedMessages = state.messages
                .where((m) => m.id != messageId)
                .toList();
            emit(state.copyWith(messages: updatedMessages));
          }

          debugPrint('ChatBloc: Sent scheduled message - $messageId');
        } catch (e) {
          debugPrint('ChatBloc: Failed to send scheduled message $messageId: $e');
        }
      }
    } catch (e) {
      debugPrint('ChatBloc: Failed to process due scheduled messages: $e');
    }
  }

  // ============================================
  // 语音转文字
  // ============================================

  /// 语音消息转文字
  Future<void> _onTranscribeVoiceMessage(
    TranscribeVoiceMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      // 查找消息
      final messageIndex = state.messages.indexWhere((m) => m.id == event.messageId);
      if (messageIndex == -1) {
        debugPrint('ChatBloc: Message not found for transcription: ${event.messageId}');
        return;
      }

      final message = state.messages[messageIndex];

      // 检查是否是语音消息
      if (message.type != MessageType.voice && message.type != MessageType.audio) {
        debugPrint('ChatBloc: Message is not a voice message: ${message.type}');
        return;
      }

      // 检查是否已经有转录结果
      if (message.metadata?.hasTranscription == true) {
        debugPrint('ChatBloc: Message already has transcription');
        return;
      }

      // 更新状态为正在转录
      final updatedMessages = List<MessageEntity>.from(state.messages);
      updatedMessages[messageIndex] = message.copyWith(
        metadata: (message.metadata ?? const MessageMetadata()).copyWithTranscription(
          transcriptionStatus: TranscriptionStatus.transcribing,
        ),
      );

      if (!isClosed) {
        emit(state.copyWith(messages: updatedMessages));
      }

      // 获取语音文件路径
      String? audioPath = event.audioPath;
      if (audioPath == null && message.metadata?.mediaUrl != null) {
        // 如果没有提供路径，尝试下载音频
        final mxcUrl = message.metadata!.mediaUrl!;
        try {
          final bytes = await _messageRepository.downloadMedia(mxcUrl);
          if (bytes != null) {
            // 保存到临时文件
            final tempDir = Directory.systemTemp;
            final tempFile = File('${tempDir.path}/voice_${event.messageId}.m4a');
            await tempFile.writeAsBytes(bytes);
            audioPath = tempFile.path;
          }
        } catch (e) {
          debugPrint('ChatBloc: Failed to download voice message: $e');
        }
      }

      if (audioPath == null) {
        debugPrint('ChatBloc: No audio path available for transcription');
        add(VoiceTranscriptionCompleted(
          messageId: event.messageId,
          success: false,
        ));
        return;
      }

      // 调用语音转文字服务
      final speechService = SpeechToTextService();
      if (!speechService.isConfigured) {
        debugPrint('ChatBloc: Speech-to-text service not configured');
        add(VoiceTranscriptionCompleted(
          messageId: event.messageId,
          success: false,
        ));
        return;
      }

      final transcription = await speechService.transcribe(
        audioPath,
        language: event.language,
      );

      // 发送完成事件
      add(VoiceTranscriptionCompleted(
        messageId: event.messageId,
        transcription: transcription,
        success: transcription != null,
      ));

    } catch (e) {
      debugPrint('ChatBloc: Failed to transcribe voice message: $e');
      add(VoiceTranscriptionCompleted(
        messageId: event.messageId,
        success: false,
      ));
    }
  }

  /// 语音转文字完成
  void _onVoiceTranscriptionCompleted(
    VoiceTranscriptionCompleted event,
    Emitter<ChatState> emit,
  ) {
    final messageIndex = state.messages.indexWhere((m) => m.id == event.messageId);
    if (messageIndex == -1) return;

    final message = state.messages[messageIndex];
    final updatedMessages = List<MessageEntity>.from(state.messages);

    updatedMessages[messageIndex] = message.copyWith(
      metadata: (message.metadata ?? const MessageMetadata()).copyWithTranscription(
        transcription: event.transcription,
        transcriptionStatus: event.success
            ? TranscriptionStatus.success
            : TranscriptionStatus.failed,
      ),
    );

    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages));
    }

    if (event.success) {
      debugPrint('ChatBloc: Voice transcription completed: ${event.transcription}');
    } else {
      debugPrint('ChatBloc: Voice transcription failed for message ${event.messageId}');
    }
  }

  /// 发送 GIF 消息
  Future<void> _onSendGifMessage(
    SendGifMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) {
      debugPrint('ChatBloc: Cannot send GIF - no room ID');
      return;
    }

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      debugPrint('ChatBloc: Sending GIF from ${event.gifUrl}');
      await _messageRepository.sendGifMessage(
        _currentRoomId!,
        gifUrl: event.gifUrl,
        previewUrl: event.previewUrl,
        width: event.width,
        height: event.height,
        title: event.title,
      );
      debugPrint('ChatBloc: GIF sent successfully');
      emit(state.copyWith(isSending: false));
    } catch (e, stackTrace) {
      debugPrint('ChatBloc: Send GIF error - $e');
      debugPrint('ChatBloc: Stack trace - $stackTrace');
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send GIF: $e',
      ));
    }
  }

  /// 发送贴纸消息
  Future<void> _onSendStickerMessage(
    SendStickerMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) {
      debugPrint('ChatBloc: Cannot send sticker - no room ID');
      return;
    }

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      debugPrint('ChatBloc: Sending sticker ${event.stickerId} from pack ${event.packId}');
      await _messageRepository.sendStickerMessage(
        _currentRoomId!,
        stickerId: event.stickerId,
        packId: event.packId,
        url: event.url,
        httpUrl: event.httpUrl,
        name: event.name,
        emoji: event.emoji,
        width: event.width,
        height: event.height,
        mimeType: event.mimeType,
        size: event.size,
      );
      debugPrint('ChatBloc: Sticker sent successfully');
      emit(state.copyWith(isSending: false));
    } catch (e, stackTrace) {
      debugPrint('ChatBloc: Send sticker error - $e');
      debugPrint('ChatBloc: Stack trace - $stackTrace');
      emit(state.copyWith(
        isSending: false,
        error: 'Failed to send sticker: $e',
      ));
    }
  }

  // ============================================
  // 置顶消息处理
  // ============================================

  /// 加载置顶消息
  Future<void> _onLoadPinnedMessages(
    LoadPinnedMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || _groupRepository == null) return;

    try {
      final pinnedEventIds = await _groupRepository.getPinnedEventIds(_currentRoomId!);
      final canPin = _groupRepository.canPinMessages(_currentRoomId!);

      // 从当前消息列表中查找置顶消息（优先内存缓存，fallback 远程拉取）
      final pinnedMessages = <MessageEntity>[];
      for (final eventId in pinnedEventIds) {
        // 快速路径：已在内存中
        final cached = state.messages.where((m) => m.id == eventId).firstOrNull;
        if (cached != null) {
          pinnedMessages.add(cached);
          continue;
        }
        // 慢速路径：从服务器/本地 DB 获取（历史置顶消息尚未分页到内存）
        final fetched = await _groupRepository.getMessageById(_currentRoomId!, eventId);
        if (fetched != null) {
          pinnedMessages.add(fetched);
        }
      }

      emit(state.copyWith(
        pinnedMessages: pinnedMessages,
        canPinMessages: canPin,
        currentPinnedIndex: 0,
      ));

      debugPrint('ChatBloc: Loaded ${pinnedMessages.length} pinned messages, canPin=$canPin');
    } catch (e) {
      debugPrint('ChatBloc: Failed to load pinned messages: $e');
    }
  }

  /// 置顶消息
  Future<void> _onPinMessage(
    PinMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || _groupRepository == null) return;

    try {
      await _groupRepository.pinMessage(_currentRoomId!, event.messageId);
      // 重新加载置顶消息
      add(const LoadPinnedMessages());
      debugPrint('ChatBloc: Pinned message ${event.messageId}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to pin message: $e');
      emit(state.copyWith(error: 'Failed to pin message: $e'));
    }
  }

  /// 取消置顶消息
  Future<void> _onUnpinMessage(
    UnpinMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || _groupRepository == null) return;

    try {
      await _groupRepository.unpinMessage(_currentRoomId!, event.messageId);
      // 重新加载置顶消息
      add(const LoadPinnedMessages());
      debugPrint('ChatBloc: Unpinned message ${event.messageId}');
    } catch (e) {
      debugPrint('ChatBloc: Failed to unpin message: $e');
      emit(state.copyWith(error: 'Failed to unpin message: $e'));
    }
  }

  /// 切换显示的置顶消息
  void _onNavigatePinnedMessage(
    NavigatePinnedMessage event,
    Emitter<ChatState> emit,
  ) {
    if (state.pinnedMessages.isEmpty) return;

    var newIndex = state.currentPinnedIndex + event.delta;
    // 循环显示
    if (newIndex < 0) {
      newIndex = state.pinnedMessages.length - 1;
    } else if (newIndex >= state.pinnedMessages.length) {
      newIndex = 0;
    }

    emit(state.copyWith(currentPinnedIndex: newIndex));
  }

  // ============================================
  // 消息翻译处理
  // ============================================

  /// 翻译消息
  Future<void> _onTranslateMessage(
    TranslateMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_translationService == null) {
      debugPrint('ChatBloc: Translation service not available');
      add(TranslationCompleted(
        messageId: event.messageId,
        success: false,
        error: 'Translation service not configured',
      ));
      return;
    }

    // 检查是否已经在翻译中
    if (state.isTranslating(event.messageId)) {
      debugPrint('ChatBloc: Message ${event.messageId} is already being translated');
      return;
    }

    // 检查是否已有翻译结果
    final existingTranslation = state.getTranslation(event.messageId);
    if (existingTranslation != null) {
      debugPrint('ChatBloc: Message ${event.messageId} already has translation');
      return;
    }

    // 查找消息
    final message = state.messages.firstWhere(
      (m) => m.id == event.messageId,
      orElse: () => MessageEntity(
        id: '',
        roomId: '',
        senderId: '',
        senderName: '',
        content: '',
        timestamp: DateTime.now(),
        type: MessageType.text,
        status: MessageStatus.sent,
        isFromMe: false,
      ),
    );

    if (message.id.isEmpty || message.type != MessageType.text) {
      debugPrint('ChatBloc: Cannot translate message - not a text message');
      return;
    }

    // 更新状态为正在翻译
    final newTranslatingIds = Set<String>.from(state.translatingMessageIds)
      ..add(event.messageId);
    emit(state.copyWith(translatingMessageIds: newTranslatingIds));

    try {
      debugPrint('ChatBloc: Translating message ${event.messageId} to ${event.targetLanguage}');

      final result = await _translationService.translate(
        text: message.content,
        targetLanguage: event.targetLanguage,
      );

      add(TranslationCompleted(
        messageId: event.messageId,
        translatedText: result.translatedText,
        detectedSourceLanguage: result.detectedSourceLanguage,
        success: result.success,
        error: result.error,
      ));
    } catch (e) {
      debugPrint('ChatBloc: Translation error: $e');
      add(TranslationCompleted(
        messageId: event.messageId,
        success: false,
        error: e.toString(),
      ));
    }
  }

  /// 翻译完成
  void _onTranslationCompleted(
    TranslationCompleted event,
    Emitter<ChatState> emit,
  ) {
    // 移除正在翻译状态
    final newTranslatingIds = Set<String>.from(state.translatingMessageIds)
      ..remove(event.messageId);

    if (event.success && event.translatedText != null) {
      // 保存翻译结果
      final newTranslatedMessages = Map<String, String>.from(state.translatedMessages)
        ..[event.messageId] = event.translatedText!;

      // 保存检测到的源语言
      final newDetectedLanguages = Map<String, String>.from(state.detectedSourceLanguages);
      if (event.detectedSourceLanguage != null) {
        newDetectedLanguages[event.messageId] = event.detectedSourceLanguage!;
      }

      emit(state.copyWith(
        translatingMessageIds: newTranslatingIds,
        translatedMessages: newTranslatedMessages,
        detectedSourceLanguages: newDetectedLanguages,
      ));

      debugPrint('ChatBloc: Translation completed for message ${event.messageId}');
    } else {
      // 翻译失败
      emit(state.copyWith(
        translatingMessageIds: newTranslatingIds,
        error: event.error ?? 'Translation failed',
      ));

      debugPrint('ChatBloc: Translation failed for message ${event.messageId}: ${event.error}');
    }
  }

  /// 清除消息翻译
  void _onClearTranslation(
    ClearTranslation event,
    Emitter<ChatState> emit,
  ) {
    final newTranslatedMessages = Map<String, String>.from(state.translatedMessages)
      ..remove(event.messageId);
    final newDetectedLanguages = Map<String, String>.from(state.detectedSourceLanguages)
      ..remove(event.messageId);

    emit(state.copyWith(
      translatedMessages: newTranslatedMessages,
      detectedSourceLanguages: newDetectedLanguages,
    ));

    debugPrint('ChatBloc: Cleared translation for message ${event.messageId}');
  }

  // ============================================
  // 离线消息自动重试
  // ============================================

  /// 设置同步状态监听，连接恢复后自动重试失败消息
  void _setupAutoRetry() {
    _syncStatusSubscription?.cancel();
    final syncStream = _clientManager?.onSyncStatus;
    if (syncStream == null) return;

    _syncStatusSubscription = syncStream.listen((status) {
      if (isClosed) return;

      if (status.status == SyncStatus.finished) {
        if (!_isConnected) {
          _isConnected = true;
          add(const ConnectionStatusChanged(true));
        }
        // 同步完成时，自动重试待发消息
        if (_pendingRetryMessages.isNotEmpty) {
          add(const RetryPendingMessages());
        }
      } else if (status.status == SyncStatus.error) {
        if (_isConnected) {
          _isConnected = false;
          add(const ConnectionStatusChanged(false));
        }
      }
    });
  }

  /// 将发送失败的消息加入待重试队列
  void _enqueueForRetry(String messageId) {
    // 已永久放弃的消息不再重试，避免 _pendingRetryMessages 移除 key 后
    // 下次调用 ?? 0 使计数清零导致死循环。
    if (_permanentlyFailedMessages.contains(messageId)) return;

    final currentCount = _pendingRetryMessages[messageId] ?? 0;
    if (currentCount >= _maxRetryCount) {
      debugPrint('ChatBloc: Message $messageId exceeded max retry count ($_maxRetryCount), giving up');
      _pendingRetryMessages.remove(messageId);
      _permanentlyFailedMessages.add(messageId);
      return;
    }
    _pendingRetryMessages[messageId] = currentCount;
    debugPrint('ChatBloc: Enqueued message $messageId for retry (attempt ${currentCount + 1}/$_maxRetryCount)');
  }

  /// 连接状态变化处理
  void _onConnectionStatusChanged(
    ConnectionStatusChanged event,
    Emitter<ChatState> emit,
  ) {
    debugPrint('ChatBloc: Connection status changed: ${event.isConnected}');
  }

  /// 自动重试所有待发消息
  Future<void> _onRetryPendingMessages(
    RetryPendingMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || _pendingRetryMessages.isEmpty) return;

    // 取出当前所有待重试的消息
    final messagesToRetry = Map<String, int>.from(_pendingRetryMessages);
    debugPrint('ChatBloc: Retrying ${messagesToRetry.length} pending messages');

    for (final entry in messagesToRetry.entries) {
      final messageId = entry.key;
      final retryCount = entry.value;

      // 指数退避延迟：2s → 4s → 8s
      final delayMs = _baseRetryDelayMs * (1 << retryCount);
      await Future<void>.delayed(Duration(milliseconds: min(delayMs, 8000)));

      if (isClosed) return;

      try {
        final success = await _messageRepository.resendMessage(
          _currentRoomId!,
          messageId,
        );
        if (success) {
          _pendingRetryMessages.remove(messageId);
          // 旧的 EventStatus.error 事件仍在 SDK 时间线中，将其 ID 加入本地删除集合
          // 使 _onMessagesUpdated 过滤掉它，防止 _scanFailedMessages 反复发现并重入队。
          _locallyDeletedMessageIds.add(messageId);
          debugPrint('ChatBloc: Message $messageId resent successfully, old event hidden');
        } else {
          _handleRetryFailure(messageId, retryCount);
        }
      } catch (e) {
        debugPrint('ChatBloc: Retry failed for $messageId: $e');
        _handleRetryFailure(messageId, retryCount);
      }
    }
  }

  /// 处理重试失败
  void _handleRetryFailure(String messageId, int currentRetryCount) {
    final nextCount = currentRetryCount + 1;
    if (nextCount >= _maxRetryCount) {
      _pendingRetryMessages.remove(messageId);
      // 标记为永久失败，防止 _scanFailedMessages 重新以计数 0 入队
      _permanentlyFailedMessages.add(messageId);
      debugPrint('ChatBloc: Message $messageId failed after $_maxRetryCount retries, requires manual resend');
    } else {
      _pendingRetryMessages[messageId] = nextCount;
      debugPrint('ChatBloc: Message $messageId retry count updated to $nextCount/$_maxRetryCount');
    }
  }

  /// 扫描当前消息列表中发送失败的消息，加入重试队列
  void _scanFailedMessages() {
    for (final message in state.messages) {
      if (message.isFailed && message.isFromMe) {
        // 已永久放弃或正在排队的消息跳过
        if (_permanentlyFailedMessages.contains(message.id)) continue;
        if (!_pendingRetryMessages.containsKey(message.id)) {
          _enqueueForRetry(message.id);
        }
      }
    }
  }

  /// 发送联系人名片消息
  Future<void> _onSendContactCardMessage(
    SendContactCardMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _messageRepository.sendCustomMessage(
        _currentRoomId!,
        msgType: 'n42.contact_card',
        content: '[Contact Card] ${event.displayName}',
        additionalData: {
          'user_id': event.userId,
          'display_name': event.displayName,
          if (event.avatarUrl != null) 'avatar_url': event.avatarUrl,
        },
      );
    } catch (e) {
      debugPrint('ChatBloc: Failed to send contact card: $e');
    }
  }
}

