part of 'chat_bloc.dart';

/// 消息发送相关 handler 方法
///
/// 包含：文本、图片、语音、文件、视频、位置、GIF、贴纸、
/// 联系人名片、自定义消息（红包/转账/音乐）、系统通知、拍一拍等。
extension ChatBlocSendHandlers on ChatBloc {
  /// 发送文本消息
  Future<void> onSendTextMessage(
    SendTextMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null || event.text.trim().isEmpty) return;

    // 斜杠命令拦截
    final trimmed = event.text.trim();
    if (trimmed.startsWith('/')) {
      final parts = trimmed.substring(1).split(RegExp(r'\s+'));
      final cmd = parts.isNotEmpty ? parts[0].toLowerCase() : '';
      final args = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      add(ExecuteSlashCommand(command: cmd, args: args));
      return;
    }

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
  Future<void> onSendImageMessage(
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
  Future<void> onSendVoiceMessage(
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
  Future<void> onSendFileMessage(
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
  Future<void> onSendVideoMessage(
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
  Future<void> onSendLocationMessage(
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

  /// 发送 GIF 消息
  Future<void> onSendGifMessage(
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
  Future<void> onSendStickerMessage(
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

  /// 发送自定义消息（红包、转账等）
  Future<void> onSendCustomMessage(
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

  /// 发送联系人名片消息
  Future<void> onSendContactCardMessage(
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

  /// 发送系统通知/拍一拍消息
  Future<void> onSendSystemNotice(
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
  Future<void> onSendPokeMessage(
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
}
