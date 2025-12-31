import 'dart:async';

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
    on<SendLocationMessage>(_onSendLocationMessage);
    on<ResendMessage>(_onResendMessage);
    on<RedactMessage>(_onRedactMessage);
    on<ReplyToMessage>(_onReplyToMessage);
    on<SetReplyTarget>(_onSetReplyTarget);
    on<AddReaction>(_onAddReaction);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
    on<SendTypingNotification>(_onSendTypingNotification);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<DisposeChat>(_onDisposeChat);
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
    emit(state.copyWith(messages: event.messages));
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
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      await _messageRepository.sendImageMessage(
        _currentRoomId!,
        imageBytes: event.imageBytes,
        filename: event.filename,
        mimeType: event.mimeType,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: '发送图片失败',
      ));
    }
  }

  /// 发送语音消息
  Future<void> _onSendVoiceMessage(
    SendVoiceMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (_currentRoomId == null) return;

    emit(state.copyWith(isSending: true, clearError: true));

    try {
      await _messageRepository.sendVoiceMessage(
        _currentRoomId!,
        audioBytes: event.audioBytes,
        filename: event.filename,
        duration: event.duration,
        mimeType: event.mimeType,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: '发送语音失败',
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
    } catch (e) {
      emit(state.copyWith(error: '撤回失败'));
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
      await _messageRepository.addReaction(
        _currentRoomId!,
        event.messageId,
        event.emoji,
      );
    } catch (e) {
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
    emit(ChatState.initial());
  }
}

