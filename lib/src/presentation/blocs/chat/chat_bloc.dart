import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

/// 聊天BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IMessageRepository _messageRepository;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  StreamSubscription<Map<String, dynamic>>? _pollResponsesSubscription;
  String? _currentRoomId;

  // 已本地删除的消息ID集合（防止被消息订阅恢复）
  final Set<String> _locallyDeletedMessageIds = {};

  ChatBloc({
    required IMessageRepository messageRepository,
  })  : _messageRepository = messageRepository,
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
    on<PollEnded>(_onPollEnded);
    on<SendCustomMessage>(_onSendCustomMessage);
    on<ClearChatHistory>(_onClearChatHistory);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _pollResponsesSubscription?.cancel();
    return super.close();
  }

  /// 初始化聊天室
  Future<void> _onInitializeChat(
    InitializeChat event,
    Emitter<ChatState> emit,
  ) async {
    _currentRoomId = event.roomId;
    _locallyDeletedMessageIds.clear(); // 新聊天室，清除已删除消息ID集合
    emit(state.copyWith(roomId: event.roomId, isLoading: true, clearError: true));

    // 加载消息并订阅更新
    add(LoadMessages(event.roomId));
    add(const SubscribeMessages());

    // 订阅投票响应事件
    _subscribeToPollResponses(event.roomId);
  }

  /// 订阅投票响应事件
  void _subscribeToPollResponses(String roomId) {
    _pollResponsesSubscription?.cancel();
    final stream = _messageRepository.watchPollResponses(roomId);
    if (stream == null) return;

    _pollResponsesSubscription = stream.listen((response) {
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
    });
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

      // 保留之前的 reactions（服务器聚合可能需要时间）
      final currentMessages = state.messages;
      var mergedMessages = messages.map((newMsg) {
        final currentMsg = currentMessages.firstWhere(
          (m) => m.id == newMsg.id,
          orElse: () => newMsg,
        );
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
            final oldMetadata = pollMsg.metadata!;
            updatedMessages[index] = pollMsg.copyWith(
              metadata: MessageMetadata(
                pollQuestion: oldMetadata.pollQuestion,
                pollOptions: oldMetadata.pollOptions,
                pollOptionIds: oldMetadata.pollOptionIds,
                maxSelections: oldMetadata.maxSelections,
                pollEnded: pollEnded,
                voteCounts: voteCounts,
                totalVoters: totalVoters,
                myVotes: myVotes,
                mediaUrl: oldMetadata.mediaUrl,
                httpUrl: oldMetadata.httpUrl,
                thumbnailUrl: oldMetadata.thumbnailUrl,
                mimeType: oldMetadata.mimeType,
                size: oldMetadata.size,
                width: oldMetadata.width,
                height: oldMetadata.height,
                duration: oldMetadata.duration,
                fileName: oldMetadata.fileName,
                isPlayed: oldMetadata.isPlayed,
                waveform: oldMetadata.waveform,
                latitude: oldMetadata.latitude,
                longitude: oldMetadata.longitude,
                locationName: oldMetadata.locationName,
                amount: oldMetadata.amount,
                token: oldMetadata.token,
                transferStatus: oldMetadata.transferStatus,
                txHash: oldMetadata.txHash,
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
        .listen((messages) {
      add(MessagesUpdated(messages));
    });
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
    // 过滤掉已本地删除的消息
    final filteredMessages = event.messages
        .where((m) => !_locallyDeletedMessageIds.contains(m.id))
        .toList();
    
    // 保留本地添加的 reactions 和投票状态（服务器聚合可能需要时间）
    final currentMessages = state.messages;
    final mergedMessages = filteredMessages.map((newMsg) {
      // 查找当前状态中的同一消息
      final currentMsg = currentMessages.firstWhere(
        (m) => m.id == newMsg.id,
        orElse: () => newMsg,
      );
      
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
        await _messageRepository.sendTextMessage(_currentRoomId!, event.text);
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
    } catch (e) {
      emit(state.copyWith(error: 'Failed to resend'));
    }
  }

  /// 撤回消息
  Future<void> _onRedactMessage(
    RedactMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _messageRepository.redactMessage(
        _currentRoomId!,
        event.messageId,
        reason: event.reason,
      );
      
      // 从本地列表中移除消息
      final updatedMessages = state.messages
          .where((m) => m.id != event.messageId)
          .toList();
      emit(state.copyWith(messages: updatedMessages));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to recall'));
    }
  }
  
  /// 本地删除消息（不发送到服务器）
  void _onDeleteMessagesLocally(
    DeleteMessagesLocally event,
    Emitter<ChatState> emit,
  ) {
    final idsToDelete = event.messageIds.toSet();
    
    // 将删除的消息ID添加到集合中，防止被消息订阅恢复
    _locallyDeletedMessageIds.addAll(idsToDelete);
    debugPrint('ChatBloc: Locally deleted message IDs: $idsToDelete');
    
    final updatedMessages = state.messages
        .where((m) => !idsToDelete.contains(m.id))
        .toList();
    emit(state.copyWith(messages: updatedMessages));
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
      emit(state.copyWith(replyTarget: event.message));
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
  Future<void> _onMarkMessageAsRead(
    MarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _messageRepository.markAsRead(_currentRoomId!, event.messageId);
    } catch (e) {
      // 静默失败
    }
  }

  /// 发送正在输入状态
  Future<void> _onSendTypingNotification(
    SendTypingNotification event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _messageRepository.sendTypingNotification(
        _currentRoomId!,
        event.isTyping,
      );
    } catch (e) {
      // 静默失败
    }
  }

  /// 清理聊天室
  Future<void> _onDisposeChat(
    DisposeChat event,
    Emitter<ChatState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;
    _currentRoomId = null;
    _locallyDeletedMessageIds.clear(); // 清除已删除消息ID集合
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
      String? pokeText = event.pokerPokeText;
      
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
        debugPrint('ChatBloc: Vote submitted successfully, updating local state');
        
        // 本地更新投票消息以立即显示反馈
        final updatedMessages = state.messages.map((msg) {
          if (msg.id == event.pollEventId && msg.metadata != null) {
            final oldMetadata = msg.metadata!;
            final newVoteCounts = Map<String, int>.from(oldMetadata.voteCounts ?? {});
            final myVotes = List<String>.from(event.selectedOptionIds);
            
            // 更新选中选项的票数
            for (final optionId in event.selectedOptionIds) {
              newVoteCounts[optionId] = (newVoteCounts[optionId] ?? 0) + 1;
            }
            
            // 计算新的总投票人数
            final totalVoters = (oldMetadata.totalVoters ?? 0) + 1;
            
            return msg.copyWith(
              metadata: MessageMetadata(
                pollQuestion: oldMetadata.pollQuestion,
                pollOptions: oldMetadata.pollOptions,
                pollOptionIds: oldMetadata.pollOptionIds,
                maxSelections: oldMetadata.maxSelections,
                pollEnded: oldMetadata.pollEnded,
                voteCounts: newVoteCounts,
                totalVoters: totalVoters,
                myVotes: myVotes,
                // 保留其他元数据
                mediaUrl: oldMetadata.mediaUrl,
                httpUrl: oldMetadata.httpUrl,
                thumbnailUrl: oldMetadata.thumbnailUrl,
                mimeType: oldMetadata.mimeType,
                size: oldMetadata.size,
                width: oldMetadata.width,
                height: oldMetadata.height,
                duration: oldMetadata.duration,
                fileName: oldMetadata.fileName,
                isPlayed: oldMetadata.isPlayed,
                waveform: oldMetadata.waveform,
                latitude: oldMetadata.latitude,
                longitude: oldMetadata.longitude,
                locationName: oldMetadata.locationName,
                amount: oldMetadata.amount,
                token: oldMetadata.token,
                transferStatus: oldMetadata.transferStatus,
                txHash: oldMetadata.txHash,
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
          metadata: MessageMetadata(
            pollQuestion: oldMetadata.pollQuestion,
            pollOptions: oldMetadata.pollOptions,
            pollOptionIds: oldMetadata.pollOptionIds,
            maxSelections: oldMetadata.maxSelections,
            pollEnded: oldMetadata.pollEnded,
            voteCounts: newVoteCounts,
            totalVoters: totalVoters,
            myVotes: oldMetadata.myVotes,
            mediaUrl: oldMetadata.mediaUrl,
            httpUrl: oldMetadata.httpUrl,
            thumbnailUrl: oldMetadata.thumbnailUrl,
            mimeType: oldMetadata.mimeType,
            size: oldMetadata.size,
            width: oldMetadata.width,
            height: oldMetadata.height,
            duration: oldMetadata.duration,
            fileName: oldMetadata.fileName,
            isPlayed: oldMetadata.isPlayed,
            waveform: oldMetadata.waveform,
            latitude: oldMetadata.latitude,
            longitude: oldMetadata.longitude,
            locationName: oldMetadata.locationName,
            amount: oldMetadata.amount,
            token: oldMetadata.token,
            transferStatus: oldMetadata.transferStatus,
            txHash: oldMetadata.txHash,
          ),
        );
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages));
  }

  /// 处理投票结束事件
  Future<void> _onPollEnded(
    PollEnded event,
    Emitter<ChatState> emit,
  ) async {
    if (isClosed) return;

    debugPrint('ChatBloc: Poll ended - poll: ${event.pollEventId}');

    final updatedMessages = state.messages.map((msg) {
      if (msg.id == event.pollEventId && msg.metadata != null) {
        final oldMetadata = msg.metadata!;

        return msg.copyWith(
          metadata: MessageMetadata(
            pollQuestion: oldMetadata.pollQuestion,
            pollOptions: oldMetadata.pollOptions,
            pollOptionIds: oldMetadata.pollOptionIds,
            maxSelections: oldMetadata.maxSelections,
            pollEnded: true,
            voteCounts: oldMetadata.voteCounts,
            totalVoters: oldMetadata.totalVoters,
            myVotes: oldMetadata.myVotes,
            mediaUrl: oldMetadata.mediaUrl,
            httpUrl: oldMetadata.httpUrl,
            thumbnailUrl: oldMetadata.thumbnailUrl,
            mimeType: oldMetadata.mimeType,
            size: oldMetadata.size,
            width: oldMetadata.width,
            height: oldMetadata.height,
            duration: oldMetadata.duration,
            fileName: oldMetadata.fileName,
            isPlayed: oldMetadata.isPlayed,
            waveform: oldMetadata.waveform,
            latitude: oldMetadata.latitude,
            longitude: oldMetadata.longitude,
            locationName: oldMetadata.locationName,
            amount: oldMetadata.amount,
            token: oldMetadata.token,
            transferStatus: oldMetadata.transferStatus,
            txHash: oldMetadata.txHash,
          ),
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
}

