import 'package:equatable/equatable.dart';

import '../../../domain/entities/message_entity.dart';

/// 聊天状态
class ChatState extends Equatable {
  /// 房间ID
  final String? roomId;

  /// 消息列表（按时间倒序）
  final List<MessageEntity> messages;

  /// 是否正在加载
  final bool isLoading;

  /// 是否正在加载更多
  final bool isLoadingMore;

  /// 是否还有更多历史消息
  final bool hasMore;

  /// 是否正在发送消息
  final bool isSending;

  /// 错误信息
  final String? error;

  /// 回复目标消息
  final MessageEntity? replyTarget;

  /// 正在输入的用户
  final List<String> typingUsers;

  /// 草稿
  final String? draft;

  const ChatState({
    this.roomId,
    this.messages = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.isSending = false,
    this.error,
    this.replyTarget,
    this.typingUsers = const [],
    this.draft,
  });

  /// 初始状态
  factory ChatState.initial() {
    return const ChatState(isLoading: true);
  }

  /// 是否为空
  bool get isEmpty => messages.isEmpty;

  /// 是否有回复目标
  bool get hasReplyTarget => replyTarget != null;

  /// 是否有人正在输入
  bool get hasTypingUsers => typingUsers.isNotEmpty;

  /// 获取正在输入提示文本
  String get typingText {
    if (typingUsers.isEmpty) return '';
    if (typingUsers.length == 1) {
      return '${typingUsers.first}正在输入...';
    }
    return '${typingUsers.length}人正在输入...';
  }

  ChatState copyWith({
    String? roomId,
    List<MessageEntity>? messages,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    bool? isSending,
    String? error,
    MessageEntity? replyTarget,
    List<String>? typingUsers,
    String? draft,
    bool clearError = false,
    bool clearReplyTarget = false,
  }) {
    return ChatState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      isSending: isSending ?? this.isSending,
      error: clearError ? null : (error ?? this.error),
      replyTarget: clearReplyTarget ? null : (replyTarget ?? this.replyTarget),
      typingUsers: typingUsers ?? this.typingUsers,
      draft: draft ?? this.draft,
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        messages,
        isLoading,
        isLoadingMore,
        hasMore,
        isSending,
        error,
        replyTarget,
        typingUsers,
        draft,
      ];
}

