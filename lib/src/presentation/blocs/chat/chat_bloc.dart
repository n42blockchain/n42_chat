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
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
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

      emit(state.copyWith(
        messages: messages,
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
        error: '加载消息失败: ${e.toString()}',
      ));
    }
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
        error: '加载更多消息失败',
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
    
    // 保留本地添加的 reactions（服务器聚合可能需要时间）
    final currentMessages = state.messages;
    final mergedMessages = filteredMessages.map((newMsg) {
      // 查找当前状态中的同一消息
      final currentMsg = currentMessages.firstWhere(
        (m) => m.id == newMsg.id,
        orElse: () => newMsg,
      );
      
      // 如果当前消息有 reactions 但新消息没有，保留当前的 reactions
      if (currentMsg.reactions.isNotEmpty && newMsg.reactions.isEmpty) {
        return newMsg.copyWith(reactions: currentMsg.reactions);
      }
      
      // 如果新消息有更多 reactions，使用新消息的（服务器聚合完成）
      return newMsg;
    }).toList();
    
    emit(state.copyWith(messages: mergedMessages));
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
        error: '发送失败',
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
        error: '发送图片失败: $e',
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
        error: '发送语音失败: $e',
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
        error: '发送文件失败',
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
        error: '发送视频失败: $e',
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
        error: '发送位置失败',
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
      emit(state.copyWith(error: '重发失败'));
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
      emit(state.copyWith(error: '撤回失败'));
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
    
    debugPrint('ChatBloc: Deleting failed message: ${event.messageId}');
    
    // 先从 UI 中移除
    _locallyDeletedMessageIds.add(event.messageId);
    final updatedMessages = state.messages
        .where((m) => m.id != event.messageId)
        .toList();
    emit(state.copyWith(messages: updatedMessages));
    
    // 然后尝试从服务器/本地数据库中删除
    try {
      await _messageRepository.deleteFailedMessage(_currentRoomId!, event.messageId);
      debugPrint('ChatBloc: Successfully deleted failed message from server/local');
    } catch (e) {
      debugPrint('ChatBloc: Error deleting failed message: $e');
      // 即使服务器删除失败，UI 已经移除了消息
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
        error: '回复失败',
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
      emit(state.copyWith(error: '添加回应失败'));
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
    emit(ChatState.initial());
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
}

