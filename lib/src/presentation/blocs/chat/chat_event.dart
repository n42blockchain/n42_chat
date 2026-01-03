import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/message_entity.dart';

/// 聊天事件
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

/// 初始化聊天室
class InitializeChat extends ChatEvent {
  final String roomId;

  const InitializeChat(this.roomId);

  @override
  List<Object?> get props => [roomId];
}

/// 加载消息
class LoadMessages extends ChatEvent {
  final String roomId;
  final int limit;

  const LoadMessages(this.roomId, {this.limit = 50});

  @override
  List<Object?> get props => [roomId, limit];
}

/// 加载更多历史消息
class LoadMoreMessages extends ChatEvent {
  const LoadMoreMessages();
}

/// 订阅消息更新
class SubscribeMessages extends ChatEvent {
  const SubscribeMessages();
}

/// 取消订阅
class UnsubscribeMessages extends ChatEvent {
  const UnsubscribeMessages();
}

/// 发送文本消息
class SendTextMessage extends ChatEvent {
  final String text;

  const SendTextMessage(this.text);

  @override
  List<Object?> get props => [text];
}

/// 发送图片消息
class SendImageMessage extends ChatEvent {
  final Uint8List imageBytes;
  final String filename;
  final String? mimeType;

  const SendImageMessage({
    required this.imageBytes,
    required this.filename,
    this.mimeType,
  });

  @override
  List<Object?> get props => [imageBytes, filename, mimeType];
}

/// 发送语音消息
class SendVoiceMessage extends ChatEvent {
  final Uint8List audioBytes;
  final String filename;
  final int duration;
  final String? mimeType;

  const SendVoiceMessage({
    required this.audioBytes,
    required this.filename,
    required this.duration,
    this.mimeType,
  });

  @override
  List<Object?> get props => [audioBytes, filename, duration, mimeType];
}

/// 发送文件消息
class SendFileMessage extends ChatEvent {
  final Uint8List fileBytes;
  final String filename;
  final String? mimeType;

  const SendFileMessage({
    required this.fileBytes,
    required this.filename,
    this.mimeType,
  });

  @override
  List<Object?> get props => [fileBytes, filename, mimeType];
}

/// 发送位置消息
class SendLocationMessage extends ChatEvent {
  final double latitude;
  final double longitude;
  final String? description;

  const SendLocationMessage({
    required this.latitude,
    required this.longitude,
    this.description,
  });

  @override
  List<Object?> get props => [latitude, longitude, description];
}

/// 重发消息
class ResendMessage extends ChatEvent {
  final String messageId;

  const ResendMessage(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

/// 撤回消息
class RedactMessage extends ChatEvent {
  final String messageId;
  final String? reason;

  const RedactMessage(this.messageId, {this.reason});

  @override
  List<Object?> get props => [messageId, reason];
}

/// 本地删除消息（不发送到服务器，仅从 UI 中移除）
class DeleteMessagesLocally extends ChatEvent {
  final List<String> messageIds;

  const DeleteMessagesLocally(this.messageIds);

  @override
  List<Object?> get props => [messageIds];
}

/// 回复消息
class ReplyToMessage extends ChatEvent {
  final String replyToMessageId;
  final String text;

  const ReplyToMessage({
    required this.replyToMessageId,
    required this.text,
  });

  @override
  List<Object?> get props => [replyToMessageId, text];
}

/// 设置回复目标
class SetReplyTarget extends ChatEvent {
  final MessageEntity? message;

  const SetReplyTarget(this.message);

  @override
  List<Object?> get props => [message];
}

/// 添加表情回应
class AddReaction extends ChatEvent {
  final String messageId;
  final String emoji;

  const AddReaction({
    required this.messageId,
    required this.emoji,
  });

  @override
  List<Object?> get props => [messageId, emoji];
}

/// 标记消息已读
class MarkMessageAsRead extends ChatEvent {
  final String messageId;

  const MarkMessageAsRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

/// 发送正在输入状态
class SendTypingNotification extends ChatEvent {
  final bool isTyping;

  const SendTypingNotification(this.isTyping);

  @override
  List<Object?> get props => [isTyping];
}

/// 消息列表更新（内部事件）
class MessagesUpdated extends ChatEvent {
  final List<MessageEntity> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

/// 清理聊天室
class DisposeChat extends ChatEvent {
  const DisposeChat();
}

/// 发送系统通知/拍一拍消息
class SendSystemNotice extends ChatEvent {
  final String notice;

  const SendSystemNotice(this.notice);

  @override
  List<Object?> get props => [notice];
}

/// 发送拍一拍消息
class SendPokeMessage extends ChatEvent {
  final String pokerName;
  final String targetUserId;
  final String targetName;
  final String? pokerPokeText; // 拍人者的 pokeText（用于拍自己时）

  const SendPokeMessage({
    required this.pokerName,
    required this.targetUserId,
    required this.targetName,
    this.pokerPokeText,
  });

  @override
  List<Object?> get props => [pokerName, targetUserId, targetName, pokerPokeText];
}

