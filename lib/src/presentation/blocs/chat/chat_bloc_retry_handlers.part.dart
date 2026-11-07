part of 'chat_bloc.dart';

/// 离线消息自动重试相关逻辑
extension ChatBlocRetryHandlers on ChatBloc {
  /// 设置同步状态监听，连接恢复后自动重试失败消息
  void setupAutoRetry() {
    _syncStatusSubscription?.cancel();
    final syncStream = _clientManager?.onChatSyncPhase;
    if (syncStream == null) return;

    final current = _captureChatContext(null, _currentRoomId);
    _syncStatusSubscription = syncStream.listen((status) {
      if (!current()) return;

      if (status == ChatSyncPhase.finished) {
        if (!_isConnected) {
          _isConnected = true;
          add(const ConnectionStatusChanged(true));
        }
        // 同步完成时，自动重试待发消息
        if (_pendingRetryMessages.isNotEmpty) {
          add(const RetryPendingMessages());
        }
      } else if (status == ChatSyncPhase.error) {
        if (_isConnected) {
          _isConnected = false;
          add(const ConnectionStatusChanged(false));
        }
      }
    });
  }

  /// 将发送失败的消息加入待重试队列
  void enqueueForRetry(String messageId) {
    if (_retryQueueIsCurrent?.call() != true) {
      _pendingRetryMessages.clear();
      _permanentlyFailedMessages.clear();
      _retryQueueIsCurrent = _captureChatContext(null, _currentRoomId);
    }
    if (_retryQueueIsCurrent?.call() != true) return;
    // 已永久放弃的消息不再重试，避免 _pendingRetryMessages 移除 key 后
    // 下次调用 ?? 0 使计数清零导致死循环。
    if (_permanentlyFailedMessages.contains(messageId)) return;

    final currentCount = _pendingRetryMessages[messageId] ?? 0;
    if (currentCount >= ChatBloc._maxRetryCount) {
      debugLog(
        'ChatBloc: Message $messageId exceeded max retry count (${ChatBloc._maxRetryCount}), giving up',
      );
      _pendingRetryMessages.remove(messageId);
      _permanentlyFailedMessages.add(messageId);
      return;
    }
    _pendingRetryMessages[messageId] = currentCount;
    debugLog(
      'ChatBloc: Enqueued message $messageId for retry (attempt ${currentCount + 1}/${ChatBloc._maxRetryCount})',
    );
  }

  /// 连接状态变化处理
  void onConnectionStatusChanged(
    ConnectionStatusChanged event,
    Emitter<ChatState> emit,
  ) {
    debugLog('ChatBloc: Connection status changed: ${event.isConnected}');
  }

  /// 自动重试所有待发消息
  Future<void> onRetryPendingMessages(
    RetryPendingMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (_retryQueueIsCurrent?.call() != true) {
      _pendingRetryMessages.clear();
      return;
    }
    final roomId = _currentRoomId;
    final generation = _chatGeneration;
    if (roomId == null ||
        _pendingRetryMessages.isEmpty ||
        _activeRetryGeneration == generation) {
      return;
    }
    final current = _captureChatContext(emit, roomId);
    if (!current()) return;
    _activeRetryGeneration = generation;
    try {
      final messagesToRetry = Map<String, int>.from(_pendingRetryMessages);
      for (final entry in messagesToRetry.entries) {
        final messageId = entry.key;
        final retryCount = entry.value;
        final delayMs = ChatBloc._baseRetryDelayMs * (1 << retryCount);
        await Future<void>.delayed(Duration(milliseconds: min(delayMs, 8000)));
        if (!current()) return;
        // A manual resend, deletion, or another state update may have removed
        // the entry while this batch was waiting.
        if (_pendingRetryMessages[messageId] != retryCount ||
            _locallyDeletedMessageIds.contains(messageId) ||
            _permanentlyFailedMessages.contains(messageId)) {
          continue;
        }
        try {
          final success = await _messageRepository.resendMessage(
            roomId,
            messageId,
          );
          if (!current()) return;
          if (success) {
            _pendingRetryMessages.remove(messageId);
            _locallyDeletedMessageIds.add(messageId);
          } else {
            _handleRetryFailure(messageId, retryCount);
          }
        } catch (e) {
          if (!current()) return;
          debugLog('ChatBloc: Retry failed for $messageId: $e');
          _handleRetryFailure(messageId, retryCount);
        }
      }
    } finally {
      // An older batch must not release a newer room's in-flight guard.
      if (_activeRetryGeneration == generation) _activeRetryGeneration = null;
    }
  }

  /// 处理重试失败
  void _handleRetryFailure(String messageId, int currentRetryCount) {
    final nextCount = currentRetryCount + 1;
    if (nextCount >= ChatBloc._maxRetryCount) {
      _pendingRetryMessages.remove(messageId);
      // 标记为永久失败，防止 scanFailedMessages 重新以计数 0 入队
      _permanentlyFailedMessages.add(messageId);
      debugLog(
        'ChatBloc: Message $messageId failed after ${ChatBloc._maxRetryCount} retries, requires manual resend',
      );
    } else {
      _pendingRetryMessages[messageId] = nextCount;
      debugLog(
        'ChatBloc: Message $messageId retry count updated to $nextCount/${ChatBloc._maxRetryCount}',
      );
    }
  }

  /// 扫描当前消息列表中发送失败的消息，加入重试队列
  void scanFailedMessages() {
    for (final message in state.messages) {
      if (message.isFailed && message.isFromMe) {
        // 已永久放弃或正在排队的消息跳过
        if (_permanentlyFailedMessages.contains(message.id)) continue;
        if (!_pendingRetryMessages.containsKey(message.id)) {
          enqueueForRetry(message.id);
        }
      }
    }
  }
}
