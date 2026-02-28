part of 'chat_bloc.dart';

/// 功能性 handler 方法
///
/// 包含：阅后即焚（自毁消息）、定时发送消息、语音转文字、
/// 置顶消息、消息翻译等。
extension ChatBlocFeatureHandlers on ChatBloc {
  // ============================================
  // 阅后即焚（自毁消息）
  // ============================================

  /// 开始消息的自毁倒计时
  Future<void> onStartMessageDestruction(
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
  Future<void> onDestroyExpiredMessages(
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
  void onUpdateDestructionCountdown(
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

  /// 发送定时消息
  Future<void> onSendScheduledMessage(
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
  Future<void> onCancelScheduledMessage(
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
  Future<void> onSendDueScheduledMessages(
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
  Future<void> onTranscribeVoiceMessage(
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
  void onVoiceTranscriptionCompleted(
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

  // ============================================
  // 置顶消息处理
  // ============================================

  /// 加载置顶消息
  Future<void> onLoadPinnedMessages(
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
  Future<void> onPinMessage(
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
  Future<void> onUnpinMessage(
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
  void onNavigatePinnedMessage(
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
  Future<void> onTranslateMessage(
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
  void onTranslationCompleted(
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
  void onClearTranslation(
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

  /// 更新翻译设置
  Future<void> onUpdateTranslationSettings(
    UpdateTranslationSettings event,
    Emitter<ChatState> emit,
  ) async {
    final newAutoTranslate = event.autoTranslate ?? state.autoTranslate;
    final newTargetLang =
        event.defaultTargetLanguage ?? state.defaultTargetLanguage;

    emit(state.copyWith(
      autoTranslate: newAutoTranslate,
      defaultTargetLanguage: newTargetLang,
    ));

    // 持久化设置
    try {
      await _secureStorage.saveTranslationSettings(
        autoTranslate: newAutoTranslate,
        defaultTargetLanguage: newTargetLang,
      );
    } catch (e) {
      debugPrint('ChatBloc: Failed to save translation settings: $e');
    }

    // 如果刚开启自动翻译，对当前可见的未翻译消息触发翻译
    if (newAutoTranslate) {
      _autoTranslateMessages(emit);
    }
  }

  /// 翻译设置加载完成
  void _onTranslationSettingsLoaded(
    TranslationSettingsLoaded event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      autoTranslate: event.autoTranslate,
      defaultTargetLanguage: event.defaultTargetLanguage,
    ));

    if (event.autoTranslate) {
      _autoTranslateMessages(emit);
    }
  }

  /// 自动翻译未翻译的消息（每次最多 5 条，防止 API 洪水）
  void _autoTranslateMessages(Emitter<ChatState> emit) {
    if (_translationService == null) return;

    final targetLang = state.defaultTargetLanguage;
    final messagesToTranslate = state.messages
        .where((m) =>
            !m.isFromMe &&
            m.type == MessageType.text &&
            m.content.trim().isNotEmpty &&
            !state.translatedMessages.containsKey(m.id) &&
            !state.translatingMessageIds.contains(m.id))
        .take(5)
        .toList();

    for (final msg in messagesToTranslate) {
      // 检测消息语言，与目标语言相同则跳过
      _translationService.detectLanguage(msg.content).then((detected) {
        if (detected != targetLang && !isClosed) {
          add(TranslateMessage(
            messageId: msg.id,
            targetLanguage: targetLang,
          ));
        }
      });
    }
  }

  // ============================================
  // 房间信息（频道/权限）
  // ============================================

  /// 加载房间信息以判断频道类型和发言权限
  void _loadRoomInfo(String roomId) {
    Future.microtask(() async {
      if (_groupRepository == null) return;
      try {
        final group = await _groupRepository.getGroup(roomId);
        if (group == null || isClosed) return;

        final isChannel = group.isChannel;
        // 频道中：如果 membersCanSpeak == false 且当前用户不是管理员，则不能发言
        final canSend = !isChannel ||
            group.membersCanSpeak ||
            group.isAdmin;

        add(RoomInfoLoaded(
          isChannel: isChannel,
          canSendMessages: canSend,
          slowModeInterval: group.slowModeInterval,
        ));
      } catch (e) {
        debugPrint('ChatBloc: Failed to load room info: $e');
      }
    });
  }

  /// 处理房间信息加载完成
  void _onRoomInfoLoaded(
    RoomInfoLoaded event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      isChannel: event.isChannel,
      canSendMessages: event.canSendMessages,
      slowModeInterval: event.slowModeInterval,
    ));
  }
}
