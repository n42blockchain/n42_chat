import 'package:equatable/equatable.dart';

/// 消息类型
enum MessageType {
  /// 文本消息
  text,
  /// 图片消息
  image,
  /// 语音消息
  voice,
  /// 音频消息（别名）
  audio,
  /// 视频消息
  video,
  /// 文件消息
  file,
  /// 位置消息
  location,
  /// 贴纸/表情
  sticker,
  /// 系统消息
  system,
  /// 通知消息（入群、退群等）
  notice,
  /// 已加密（无法解密）
  encrypted,
  /// 已撤回
  redacted,
  /// 转账消息
  transfer,
  /// 收款请求
  paymentRequest,
  /// 红包
  redPacket,
  /// 未知类型
  unknown,
}

/// 消息状态
enum MessageStatus {
  /// 发送中
  sending,
  /// 已发送
  sent,
  /// 已送达
  delivered,
  /// 已读
  read,
  /// 发送失败
  failed,
}

/// 消息实体
///
/// 表示聊天中的一条消息
class MessageEntity extends Equatable {
  /// Matrix事件ID
  final String id;

  /// 房间ID
  final String roomId;

  /// 发送者用户ID
  final String senderId;

  /// 发送者显示名称
  final String senderName;

  /// 发送者头像URL
  final String? senderAvatarUrl;

  /// 消息内容
  final String content;

  /// 格式化后的内容（如HTML）
  final String? formattedContent;

  /// 消息类型
  final MessageType type;

  /// 发送时间
  final DateTime timestamp;

  /// 消息状态
  final MessageStatus status;

  /// 是否是当前用户发送
  final bool isFromMe;

  /// 别名：isMe
  bool get isMe => isFromMe;

  /// 回复的消息ID
  final String? replyToId;

  /// 回复的消息内容预览
  final String? replyToContent;

  /// 回复的消息发送者
  final String? replyToSender;

  /// 是否已编辑
  final bool isEdited;

  /// 编辑时间
  final DateTime? editedAt;

  /// 附加数据（图片URL、文件信息等）
  final MessageMetadata? metadata;

  /// 反应（emoji reactions）
  final List<MessageReaction> reactions;

  /// 已读回执用户列表
  final List<String> readBy;

  const MessageEntity({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.content,
    this.formattedContent,
    required this.type,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.isFromMe = false,
    this.replyToId,
    this.replyToContent,
    this.replyToSender,
    this.isEdited = false,
    this.editedAt,
    this.metadata,
    this.reactions = const [],
    this.readBy = const [],
  });

  /// 是否是文本消息
  bool get isText => type == MessageType.text;

  /// 是否是媒体消息
  bool get isMedia =>
      type == MessageType.image ||
      type == MessageType.voice ||
      type == MessageType.video;

  /// 是否是系统/通知消息
  bool get isSystemMessage =>
      type == MessageType.system || type == MessageType.notice;

  /// 是否有回复
  bool get hasReply => replyToId != null;

  /// 是否正在发送
  bool get isSending => status == MessageStatus.sending;

  /// 是否发送失败
  bool get isFailed => status == MessageStatus.failed;

  /// 获取发送者首字母
  String get senderInitials {
    if (senderName.isEmpty) return '?';
    final words = senderName.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return senderName.substring(0, senderName.length.clamp(0, 2)).toUpperCase();
    }
    return words
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
  }

  @override
  List<Object?> get props => [
        id,
        roomId,
        senderId,
        senderName,
        senderAvatarUrl,
        content,
        formattedContent,
        type,
        timestamp,
        status,
        isFromMe,
        replyToId,
        replyToContent,
        replyToSender,
        isEdited,
        editedAt,
        metadata,
        reactions,
        readBy,
      ];

  MessageEntity copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? senderName,
    String? senderAvatarUrl,
    String? content,
    String? formattedContent,
    MessageType? type,
    DateTime? timestamp,
    MessageStatus? status,
    bool? isFromMe,
    String? replyToId,
    String? replyToContent,
    String? replyToSender,
    bool? isEdited,
    DateTime? editedAt,
    MessageMetadata? metadata,
    List<MessageReaction>? reactions,
    List<String>? readBy,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatarUrl: senderAvatarUrl ?? this.senderAvatarUrl,
      content: content ?? this.content,
      formattedContent: formattedContent ?? this.formattedContent,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isFromMe: isFromMe ?? this.isFromMe,
      replyToId: replyToId ?? this.replyToId,
      replyToContent: replyToContent ?? this.replyToContent,
      replyToSender: replyToSender ?? this.replyToSender,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      metadata: metadata ?? this.metadata,
      reactions: reactions ?? this.reactions,
      readBy: readBy ?? this.readBy,
    );
  }
}

/// 消息附加数据
class MessageMetadata extends Equatable {
  // ============================================
  // 媒体通用属性
  // ============================================

  /// 媒体URL (mxc://)
  final String? mediaUrl;

  /// HTTP URL (用于预览)
  final String? httpUrl;

  /// 缩略图URL
  final String? thumbnailUrl;

  /// MIME类型
  final String? mimeType;

  /// 文件大小（字节）
  final int? size;

  // ============================================
  // 图片/视频属性
  // ============================================

  /// 宽度
  final int? width;

  /// 高度
  final int? height;

  // ============================================
  // 音频/视频属性
  // ============================================

  /// 时长（毫秒）
  final int? duration;

  // ============================================
  // 文件属性
  // ============================================

  /// 文件名
  final String? fileName;

  // ============================================
  // 语音消息属性
  // ============================================

  /// 是否已播放
  final bool? isPlayed;

  /// 波形数据
  final List<int>? waveform;

  // ============================================
  // 位置属性
  // ============================================

  /// 纬度
  final double? latitude;

  /// 经度
  final double? longitude;

  /// 位置名称
  final String? locationName;

  // ============================================
  // 转账属性
  // ============================================

  /// 转账金额
  final String? amount;

  /// 代币符号
  final String? token;

  /// 转账状态
  final String? transferStatus;

  /// 交易哈希
  final String? txHash;

  const MessageMetadata({
    this.mediaUrl,
    this.httpUrl,
    this.thumbnailUrl,
    this.mimeType,
    this.size,
    this.width,
    this.height,
    this.duration,
    this.fileName,
    this.isPlayed,
    this.waveform,
    this.latitude,
    this.longitude,
    this.locationName,
    this.amount,
    this.token,
    this.transferStatus,
    this.txHash,
  });

  /// 格式化文件大小
  String get formattedSize {
    if (size == null) return '';
    if (size! < 1024) return '$size B';
    if (size! < 1024 * 1024) return '${(size! / 1024).toStringAsFixed(1)} KB';
    if (size! < 1024 * 1024 * 1024) {
      return '${(size! / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(size! / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// 格式化时长
  String get formattedDuration {
    if (duration == null) return '';
    final seconds = (duration! / 1000).round();
    if (seconds < 60) return '$seconds"';
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (remainingSeconds == 0) return "$minutes'";
    return "$minutes'$remainingSeconds\"";
  }

  @override
  List<Object?> get props => [
        mediaUrl,
        httpUrl,
        thumbnailUrl,
        mimeType,
        size,
        width,
        height,
        duration,
        fileName,
        isPlayed,
        waveform,
        latitude,
        longitude,
        locationName,
        amount,
        token,
        transferStatus,
        txHash,
      ];
}

/// 消息反应（Reaction）
class MessageReaction extends Equatable {
  /// 反应内容（emoji）
  final String key;

  /// 反应的用户ID列表
  final List<String> userIds;

  /// 当前用户是否已反应
  final bool isMe;

  const MessageReaction({
    required this.key,
    required this.userIds,
    this.isMe = false,
  });

  /// 反应数量
  int get count => userIds.length;

  @override
  List<Object?> get props => [key, userIds, isMe];
}

