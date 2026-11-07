import 'dart:async';

import '../../../data/datasources/matrix/message/encrypted_send_guard.dart';
import '../../../data/datasources/matrix/message/direct_chat_send_guard.dart';

import 'dart:io';
import 'dart:math' show min;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_sync_phase.dart';

import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../core/services/speech_to_text_service.dart';
import '../../../core/services/translation_service.dart';
import '../../../core/utils/content_filter_utils.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../../data/datasources/local/chat_history_clear_store.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../core/utils/event_message_data.dart';
import '../../../domain/entities/scheduled_message_draft.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../data/services/account_action_capture.dart';
import '../../../data/services/scheduled_draft_operation.dart';
import '../../../domain/repositories/message_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../../../core/utils/debug_log.dart';

part 'chat_bloc_message_handlers.part.dart';
part 'chat_bloc_send_handlers.part.dart';
part 'chat_bloc_action_handlers.part.dart';
part 'chat_bloc_poll_handlers.part.dart';
part 'chat_bloc_feature_handlers.part.dart';
part 'chat_bloc_retry_handlers.part.dart';

/// 聊天BLoC
class _ScheduledAccount {
  final String userId;
  final bool Function() isCurrent;
  _ScheduledAccount(this.userId, this.isCurrent);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IMessageRepository _messageRepository;
  final PreferencesDataSource _secureStorage;
  final ChatHistoryClearStore? _historyClearStore;
  DateTime? _historyClearedThrough;
  String? _historyOwner;
  bool _historyReady = true;
  final IGroupRepository? _groupRepository;
  final ITranslationService? _translationService;
  final MatrixClientManager? _clientManager;
  final IAuthRepository? _authRepository;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  StreamSubscription<Map<String, dynamic>>? _pollResponsesSubscription;
  String? _currentRoomId;
  int _chatGeneration = 0;
  final Map<String, Object> _translationRequests = {};

  // 阅后即焚定时器
  Timer? _destructionTimer;

  // 定时发送检查定时器
  Timer? _scheduledMessageTimer;

  // 输入状态过期刷新定时器
  Timer? _typingUsersTimer;

  // 已本地删除的消息ID集合（防止被消息订阅恢复）
  final Set<String> _locallyDeletedMessageIds = {};

  // ============================================
  // 离线消息自动重试
  // ============================================

  /// 待重试的消息ID及其重试次数
  final Map<String, int> _pendingRetryMessages = {};
  int? _activeRetryGeneration;
  bool Function()? _retryQueueIsCurrent;

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
  StreamSubscription<ChatSyncPhase>? _syncStatusSubscription;

  /// 重试定时器
  Timer? _retryTimer;

  /// 当前是否处于连接状态
  bool _isConnected = true;

  ChatBloc({
    required IMessageRepository messageRepository,
    required PreferencesDataSource secureStorage,
    ChatHistoryClearStore? historyClearStore,
    IGroupRepository? groupRepository,
    ITranslationService? translationService,
    MatrixClientManager? clientManager,
    IAuthRepository? authRepository,
  }) : _messageRepository = messageRepository,
       _secureStorage = secureStorage,
       _historyClearStore = historyClearStore,
       _groupRepository = groupRepository,
       _translationService = translationService,
       _clientManager = clientManager,
       _authRepository = authRepository,
       super(ChatState.initial()) {
    // 消息加载/订阅/更新
    on<InitializeChat>(_onInitializeChat);
    on<LoadMessages>(onLoadMessages);
    on<LoadMoreMessages>(onLoadMoreMessages);
    on<SubscribeMessages>(onSubscribeMessages);
    on<UnsubscribeMessages>(onUnsubscribeMessages);
    on<MessagesUpdated>(onMessagesUpdated);
    on<TypingUsersUpdated>(onTypingUsersUpdated);
    on<DisposeChat>(onDisposeChat);

    // 消息发送（各类型）
    on<SendTextMessage>(onSendTextMessage);
    on<SendImageMessage>(onSendImageMessage);
    on<SendVoiceMessage>(onSendVoiceMessage);
    on<SendFileMessage>(onSendFileMessage);
    on<SendVideoMessage>(onSendVideoMessage);
    on<SendLocationMessage>(onSendLocationMessage);
    on<SendGifMessage>(onSendGifMessage);
    on<SendStickerMessage>(onSendStickerMessage);
    on<SendCustomMessage>(onSendCustomMessage);
    on<SendContactCardMessage>(onSendContactCardMessage);
    on<SendSystemNotice>(onSendSystemNotice);
    on<SendPokeMessage>(onSendPokeMessage);

    // 消息操作（重发、撤回、删除、回复、编辑、表情）
    on<ResendMessage>(onResendMessage);
    on<RedactMessage>(onRedactMessage);
    on<DeleteMessagesLocally>(onDeleteMessagesLocally);
    on<DeleteFailedMessage>(onDeleteFailedMessage);
    on<ReplyToMessage>(onReplyToMessage);
    on<SetReplyTarget>(onSetReplyTarget);
    on<SetEditTarget>(onSetEditTarget);
    on<AddReaction>(onAddReaction);
    on<MarkMessageAsRead>(onMarkMessageAsRead);
    on<SendTypingNotification>(onSendTypingNotification);
    on<ClearChatHistory>(onClearChatHistory);
    on<ExecuteSlashCommand>(onExecuteSlashCommand);
    on<ClearPendingCommand>(_onClearPendingCommand);
    on<ReportMessage>(onReportMessage);

    // 投票
    on<SendPollMessage>(onSendPollMessage);
    on<VoteOnPoll>(onVoteOnPoll);
    on<PollResponseReceived>(onPollResponseReceived);
    on<EndPoll>(onEndPoll);
    on<PollEnded>(onPollEnded);

    // 阅后即焚
    on<StartMessageDestruction>(onStartMessageDestruction);
    on<DestroyExpiredMessages>(onDestroyExpiredMessages);
    on<UpdateDestructionCountdown>(onUpdateDestructionCountdown);
    on<DestructionTimesLoaded>(_onDestructionTimesLoaded);

    // 定时消息
    on<SendScheduledMessage>(onSendScheduledMessage);
    on<CancelScheduledMessage>(onCancelScheduledMessage);
    on<SendDueScheduledMessages>(onSendDueScheduledMessages);

    // 语音转文字
    on<TranscribeVoiceMessage>(onTranscribeVoiceMessage);
    on<VoiceTranscriptionCompleted>(onVoiceTranscriptionCompleted);

    // 置顶消息
    on<LoadPinnedMessages>(onLoadPinnedMessages);
    on<PinMessage>(onPinMessage);
    on<UnpinMessage>(onUnpinMessage);
    on<NavigatePinnedMessage>(onNavigatePinnedMessage);

    // 消息翻译
    on<TranslateMessage>(onTranslateMessage);
    on<TranslationCompleted>(onTranslationCompleted);
    on<ClearTranslation>(onClearTranslation);
    on<UpdateTranslationSettings>(onUpdateTranslationSettings);
    on<TranslationSettingsLoaded>(_onTranslationSettingsLoaded);

    // 离线重试
    on<RetryPendingMessages>(onRetryPendingMessages);
    on<ConnectionStatusChanged>(onConnectionStatusChanged);

    // 房间信息（频道/权限）
    on<RoomInfoLoaded>(_onRoomInfoLoaded);
    on<ContentFilterLoaded>(_onContentFilterLoaded);
    on<ScheduledMessagesPreviewLoaded>(_onScheduledMessagesPreviewLoaded);
    on<RecipientLanguageDetected>(_onRecipientLanguageDetected);
  }

  Future<int?> _resolveSelfDestructAfter(int? explicitValue) async {
    if (explicitValue != null) {
      return explicitValue > 0 ? explicitValue : null;
    }

    final defaultSeconds = await _secureStorage.getDefaultSelfDestructSeconds();
    if (defaultSeconds == null || defaultSeconds <= 0) {
      return null;
    }
    return defaultSeconds;
  }

  /// 处理销毁时间加载完成事件
  Future<void> _onDestructionTimesLoaded(
    DestructionTimesLoaded event,
    Emitter<ChatState> emit,
  ) async {
    if (event.isCurrent != null && !event.isCurrent!()) return;
    final updatedMessages = state.messages.map((msg) {
      final destroyedAt = event.destructionTimes[msg.id];
      if (destroyedAt != null &&
          msg.isSelfDestructing &&
          !msg.isDestructionStarted) {
        return msg.copyWith(destroyedAt: destroyedAt);
      }
      return msg;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));
  }

  bool _historyBoundaryReached(List<MessageEntity> messages) =>
      _historyClearedThrough != null && messages.any((message) =>
          !message.timestamp.isAfter(_historyClearedThrough!));

  List<MessageEntity> _visibleHistory(List<MessageEntity> messages) {
    if (!_historyReady) return [];
    final boundary = _historyClearedThrough;
    return messages.where((message) =>
      !_locallyDeletedMessageIds.contains(message.id) &&
      (boundary == null || message.timestamp.isAfter(boundary))).toList();
  }

  /// Retain the originating session for callbacks kept by child routes.
  bool Function() captureCurrentSession() =>
      _captureChatContext(null, _currentRoomId);

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _pollResponsesSubscription?.cancel();
    _destructionTimer?.cancel();
    _scheduledMessageTimer?.cancel();
    _typingUsersTimer?.cancel();
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
    _chatGeneration++;
    _pendingRetryMessages.clear();
    _permanentlyFailedMessages.clear();
    _translationRequests.clear();
    _currentRoomId = event.roomId;
    _historyOwner = null;
    _historyClearedThrough = null;
    _historyReady = _historyClearStore == null;
    final current = _captureChatContext(emit, event.roomId);
    _locallyDeletedMessageIds.clear();

    // 从持久化存储加载已删除的消息ID（异步，不阻塞）
    _loadDeletedMessageIds(event.roomId);

    // 立即显示界面，不等待网络
    emit(
      ChatState.initial().copyWith(
        roomId: event.roomId, isLoading: false, clearError: true,
        isSendingText: false, isSending: false, activeMediaSends: 0,
      ),
    );

    if (_historyClearStore != null) {
      try {
        final owner = await _messageRepository.getCurrentUserId();
        if (!current()) return;
        if (owner == null || owner.isEmpty) throw StateError('History owner unavailable');
        final boundary = await _historyClearStore.read(
          ownerUserId: owner, roomId: event.roomId, isCurrent: current,
        );
        if (!current()) return;
        _historyOwner = owner;
        _historyClearedThrough = boundary;
        _historyReady = true;
      } catch (error) {
        if (current()) emit(state.copyWith(error: 'Failed to load chat history'));
        return;
      }
    }

    // 先尝试快速加载本地缓存消息
    try {
      final cachedMessages = await _messageRepository.getMessages(
        event.roomId,
        limit: 30, // 首屏只需要 30 条
      );

      if (!current()) return;
      if (cachedMessages.isNotEmpty) {
        // 过滤已删除的消息
        final filteredMessages = cachedMessages
            .where((m) => !_locallyDeletedMessageIds.contains(m.id))
            .toList();

        emit(
          state.copyWith(
            messages: _visibleHistory(_withLocalScheduledPreviews(filteredMessages)),
            isLoading: false,
            hasMore: !_historyBoundaryReached(cachedMessages),
          ),
        );
        debugLog(
          'ChatBloc: Displayed ${filteredMessages.length} cached messages instantly',
        );
      }
    } catch (e) {
      debugLog('ChatBloc: Failed to load cached messages: $e');
    }

    if (!current()) return;

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
    setupAutoRetry();

    // 加载关键词过滤配置
    _loadContentFilter(event.roomId);

    // 加载翻译设置
    _loadTranslationSettings();

    // 加载房间信息（频道/权限判断）
    _loadRoomInfo(event.roomId);
  }

  void _loadContentFilter(String roomId) {
    final current = _captureChatContext(null, roomId);
    Future.microtask(() async {
      if (!current()) return;
      try {
        final filter = await _groupRepository?.getContentFilter(roomId);
        if (current()) {
          add(ContentFilterLoaded(filter, isCurrent: current));
        }
      } catch (e) {
        // content filter 不影响聊天主流程，静默忽略错误
      }
    });
  }

  void _onContentFilterLoaded(
    ContentFilterLoaded event,
    Emitter<ChatState> emit,
  ) {
    if (event.isCurrent != null && !event.isCurrent!()) return;
    emit(state.copyWith(contentFilter: event.config));
  }

  void _loadTranslationSettings() {
    final current = _captureChatContext(null, _currentRoomId);
    Future.microtask(() async {
      if (!current()) return;
      try {
        final settings = await _secureStorage.getTranslationSettings();
        if (current() && settings != null) {
          add(
            TranslationSettingsLoaded(
              isCurrent: current,
              autoTranslate: settings['autoTranslate'] as bool? ?? false,
              defaultTargetLanguage: normalizeTranslationLanguageCode(
                settings['defaultTargetLanguage'] as String? ??
                    getDeviceLanguageCode(),
              ),
              smartReplyTranslate:
                  settings['smartReplyTranslate'] as bool? ?? false,
            ),
          );
        }
      } catch (e) {
        debugLog('ChatBloc: Failed to load translation settings: $e');
      }
    });
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
    final current = _captureChatContext(null, roomId);
    Future.microtask(() async {
      if (!current()) return;
      try {
        final destructionTimes = await _secureStorage
            .getMessageDestructionTimes(roomId);
        if (destructionTimes.isEmpty || !current()) return;
        add(DestructionTimesLoaded(destructionTimes, isCurrent: current));
      } catch (e) {
        debugLog('ChatBloc: Failed to load saved destruction times: $e');
      }
    });
  }

  /// 后台加载完整消息数据
  List<MessageEntity> _withLocalScheduledPreviews(List<MessageEntity> messages) {
    final ids = messages.map((message) => message.id).toSet();
    final owner = _clientManager?.client?.userID ?? _authRepository?.currentUser?.userId;
    final previews = state.messages.where((message) =>
        message.isScheduled &&
        message.isFromMe &&
        message.roomId == _currentRoomId &&
        (owner == null || message.senderId == owner) &&
        ids.add(message.id)).toList();
    if (previews.isEmpty) return messages;
    return [...messages, ...previews]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void _loadFullMessagesInBackground(String roomId) {
    final current = _captureChatContext(null, roomId);
    Future.microtask(() async {
      if (!current()) return;

      try {
        // 延迟加载 reactions 和 polls，避免阻塞首屏
        await Future<void>.delayed(const Duration(milliseconds: 100));

        if (!current()) return;

        // 触发完整消息加载（包含 reactions 和 polls）
        add(LoadMessages(roomId));
      } catch (e) {
        debugLog('ChatBloc: Background load failed: $e');
      }
    });
  }

  /// 异步加载已删除消息ID
  void _loadDeletedMessageIds(String roomId) {
    final current = _captureChatContext(null, roomId);
    Future.microtask(() async {
      try {
        final persistedDeletedIds = await _messageRepository
            .getLocallyDeletedMessageIds(roomId);
        if (!current()) return;
        _locallyDeletedMessageIds.addAll(persistedDeletedIds);
        debugLog(
          'ChatBloc: Loaded ${persistedDeletedIds.length} locally deleted message IDs from storage',
        );
      } catch (e) {
        debugLog('ChatBloc: Failed to load locally deleted message IDs: $e');
      }
    });
  }

  /// 订阅投票响应事件
  void _subscribeToPollResponses(String roomId) {
    final isCurrent = _captureChatContext(null, roomId);
    if (!isCurrent()) return;
    _pollResponsesSubscription?.cancel();
    final stream = _messageRepository.watchPollResponses(roomId);
    if (stream == null) return;

    _pollResponsesSubscription = stream.listen(
      (response) {
        // 防止在 BLoC 关闭后添加事件
        if (!isCurrent()) return;

        final type = response['type'] as String?;
        final pollEventId = response['pollEventId'] as String?;

        if (pollEventId == null) return;

        if (type == 'vote') {
          final answers =
              (response['answers'] as List<dynamic>?)?.cast<String>() ?? [];
          final senderId = response['senderId'] as String? ?? '';
          final isCurrentUser = response['isCurrentUser'] as bool? ?? false;

          add(
            PollResponseReceived(
              pollEventId: pollEventId,
              selectedOptionIds: answers,
              senderId: senderId,
              isCurrentUser: isCurrentUser,
              isCurrent: isCurrent,
            ),
          );
        } else if (type == 'end') {
          add(PollEnded(pollEventId: pollEventId, isCurrent: isCurrent));
        }
      },
      onError: (Object error) {
        debugLog('ChatBloc: Poll responses stream error: $error');
      },
    );
  }

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

  Future<_ScheduledAccount?> _captureScheduledAccount() async {
    final manager = _clientManager;
    final auth = _authRepository;
    final origin = manager != null && auth != null
        ? captureAccountAction(manager, auth)
        : null;
    // A configured lifecycle must supply a live generation, never fall back to
    // matching user/token values after logout and a same-account login.
    if (auth != null && origin == null) return null;
    final client = manager?.client;
    final user = client?.userID,
        token = client?.accessToken,
        device = client?.deviceID,
        server = client?.homeserver;
    final owner = await _messageRepository.getCurrentUserId();
    bool current() =>
        !isClosed &&
        (origin == null || origin.isCurrent) &&
        (manager == null ||
            (client != null &&
                identical(manager.client, client) &&
                client.isLogged() &&
                client.userID == user &&
                user == owner &&
                client.accessToken == token &&
                client.deviceID == device &&
                client.homeserver == server));
    if (owner == null || owner.isEmpty || !current()) return null;
    return _ScheduledAccount(owner, current);
  }

  Future<bool> _scheduledAccountIsCurrent(_ScheduledAccount account) async =>
      account.isCurrent() &&
      await _messageRepository.getCurrentUserId() == account.userId &&
      account.isCurrent();

  /// Load only drafts owned by the current account, and reject late previews.
  void _loadScheduledMessages(String roomId) {
    Future.microtask(() async {
      try {
        final account = await _captureScheduledAccount();
        if (account == null) return;
        final scheduledMessages = await _secureStorage.getScheduledMessages(
          roomId,
          ownerUserId: account.userId,
        );
        if (_currentRoomId != roomId ||
            !await _scheduledAccountIsCurrent(account)) {
          return;
        }
        final previews = scheduledMessages
            .map(
              (draft) => draft.toPreviewMessage(
                roomId: roomId,
                senderId: account.userId,
              ),
            )
            .toList(growable: false);
        if (previews.isNotEmpty) {
          add(
            ScheduledMessagesPreviewLoaded(
              previews,
              ownerUserId: account.userId,
              isCurrent: account.isCurrent,
            ),
          );
        }
      } catch (e) {
        debugLog('ChatBloc: Failed to load scheduled messages: $e');
      }
    });
  }

  void _onScheduledMessagesPreviewLoaded(
    ScheduledMessagesPreviewLoaded event,
    Emitter<ChatState> emit,
  ) {
    if (event.isCurrent != null && !event.isCurrent!()) return;
    if (event.previewMessages.any(
      (message) => message.roomId != _currentRoomId,
    )) {
      return;
    }
    if (event.ownerUserId != null &&
        _clientManager != null &&
        _clientManager.client?.userID != event.ownerUserId) {
      return;
    }
    final allMessages = [...state.messages, ...event.previewMessages];
    allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    emit(state.copyWith(messages: allMessages));
  }
}
