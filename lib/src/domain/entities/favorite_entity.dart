import 'package:equatable/equatable.dart';

/// 收藏类型
enum FavoriteType {
  /// 文本
  text,
  /// 图片
  image,
  /// 视频
  video,
  /// 文件
  file,
  /// 链接
  link,
  /// 语音
  voice,
  /// 位置
  location,
  /// 笔记（自己创建的）
  note,
}

/// 收藏实体
class FavoriteEntity extends Equatable {
  /// 收藏ID
  final String id;
  
  /// 收藏类型
  final FavoriteType type;
  
  /// 收藏内容（文本或描述）
  final String content;
  
  /// 媒体URL（图片、视频、文件等）
  final String? mediaUrl;
  
  /// 缩略图URL
  final String? thumbnailUrl;
  
  /// 文件名
  final String? fileName;
  
  /// 文件大小
  final int? fileSize;
  
  /// 来源会话ID
  final String? sourceRoomId;
  
  /// 来源会话名称
  final String? sourceRoomName;
  
  /// 来源消息ID
  final String? sourceMessageId;
  
  /// 来源发送者ID
  final String? sourceSenderId;
  
  /// 来源发送者名称
  final String? sourceSenderName;
  
  /// 收藏时间
  final DateTime createdAt;
  
  /// 标签
  final List<String> tags;
  
  /// 备注
  final String? remark;
  
  const FavoriteEntity({
    required this.id,
    required this.type,
    required this.content,
    this.mediaUrl,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    this.sourceRoomId,
    this.sourceRoomName,
    this.sourceMessageId,
    this.sourceSenderId,
    this.sourceSenderName,
    required this.createdAt,
    this.tags = const [],
    this.remark,
  });
  
  @override
  List<Object?> get props => [
    id,
    type,
    content,
    mediaUrl,
    thumbnailUrl,
    fileName,
    fileSize,
    sourceRoomId,
    sourceRoomName,
    sourceMessageId,
    sourceSenderId,
    sourceSenderName,
    createdAt,
    tags,
    remark,
  ];
  
  FavoriteEntity copyWith({
    String? id,
    FavoriteType? type,
    String? content,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    String? sourceRoomId,
    String? sourceRoomName,
    String? sourceMessageId,
    String? sourceSenderId,
    String? sourceSenderName,
    DateTime? createdAt,
    List<String>? tags,
    String? remark,
  }) {
    return FavoriteEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      sourceRoomId: sourceRoomId ?? this.sourceRoomId,
      sourceRoomName: sourceRoomName ?? this.sourceRoomName,
      sourceMessageId: sourceMessageId ?? this.sourceMessageId,
      sourceSenderId: sourceSenderId ?? this.sourceSenderId,
      sourceSenderName: sourceSenderName ?? this.sourceSenderName,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      remark: remark ?? this.remark,
    );
  }
  
  /// 从JSON创建
  factory FavoriteEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteEntity(
      id: json['id'] as String,
      type: FavoriteType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FavoriteType.text,
      ),
      content: json['content'] as String? ?? '',
      mediaUrl: json['media_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      fileName: json['file_name'] as String?,
      fileSize: json['file_size'] as int?,
      sourceRoomId: json['source_room_id'] as String?,
      sourceRoomName: json['source_room_name'] as String?,
      sourceMessageId: json['source_message_id'] as String?,
      sourceSenderId: json['source_sender_id'] as String?,
      sourceSenderName: json['source_sender_name'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      remark: json['remark'] as String?,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'content': content,
      'media_url': mediaUrl,
      'thumbnail_url': thumbnailUrl,
      'file_name': fileName,
      'file_size': fileSize,
      'source_room_id': sourceRoomId,
      'source_room_name': sourceRoomName,
      'source_message_id': sourceMessageId,
      'source_sender_id': sourceSenderId,
      'source_sender_name': sourceSenderName,
      'created_at': createdAt.millisecondsSinceEpoch,
      'tags': tags,
      'remark': remark,
    };
  }
  
  /// 获取类型描述
  String get typeDescription {
    switch (type) {
      case FavoriteType.text:
        return '文本';
      case FavoriteType.image:
        return '图片';
      case FavoriteType.video:
        return '视频';
      case FavoriteType.file:
        return '文件';
      case FavoriteType.link:
        return '链接';
      case FavoriteType.voice:
        return '语音';
      case FavoriteType.location:
        return '位置';
      case FavoriteType.note:
        return '笔记';
    }
  }
  
  /// 获取类型图标
  String get typeIcon {
    switch (type) {
      case FavoriteType.text:
        return '📝';
      case FavoriteType.image:
        return '🖼️';
      case FavoriteType.video:
        return '🎬';
      case FavoriteType.file:
        return '📁';
      case FavoriteType.link:
        return '🔗';
      case FavoriteType.voice:
        return '🎤';
      case FavoriteType.location:
        return '📍';
      case FavoriteType.note:
        return '📒';
    }
  }
}

/// 红包实体
class RedPacketEntity extends Equatable {
  /// 红包ID
  final String id;
  
  /// 发送者ID
  final String senderId;
  
  /// 发送者名称
  final String senderName;
  
  /// 金额
  final String amount;
  
  /// 代币符号
  final String token;
  
  /// 红包类型（普通/拼手气）
  final RedPacketType type;
  
  /// 红包数量（拼手气红包）
  final int count;
  
  /// 祝福语
  final String greeting;
  
  /// 状态
  final RedPacketEntityStatus status;
  
  /// 已领取数量
  final int claimedCount;
  
  /// 已领取金额
  final String claimedAmount;
  
  /// 创建时间
  final DateTime createdAt;
  
  /// 过期时间
  final DateTime? expiredAt;
  
  const RedPacketEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.amount,
    required this.token,
    this.type = RedPacketType.normal,
    this.count = 1,
    this.greeting = '恭喜发财，大吉大利',
    this.status = RedPacketEntityStatus.pending,
    this.claimedCount = 0,
    this.claimedAmount = '0',
    required this.createdAt,
    this.expiredAt,
  });
  
  @override
  List<Object?> get props => [
    id,
    senderId,
    senderName,
    amount,
    token,
    type,
    count,
    greeting,
    status,
    claimedCount,
    claimedAmount,
    createdAt,
    expiredAt,
  ];
  
  /// 是否已被领完
  bool get isEmpty => status == RedPacketEntityStatus.empty;
  
  /// 是否已过期
  bool get isExpired => status == RedPacketEntityStatus.expired ||
      (expiredAt != null && DateTime.now().isAfter(expiredAt!));
  
  /// 是否可领取
  bool get canClaim => status == RedPacketEntityStatus.pending && !isExpired;
  
  /// 从JSON创建
  factory RedPacketEntity.fromJson(Map<String, dynamic> json) {
    return RedPacketEntity(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      senderName: json['sender_name'] as String,
      amount: json['amount'] as String,
      token: json['token'] as String? ?? 'ETH',
      type: RedPacketType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => RedPacketType.normal,
      ),
      count: json['count'] as int? ?? 1,
      greeting: json['greeting'] as String? ?? '恭喜发财，大吉大利',
      status: RedPacketEntityStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RedPacketEntityStatus.pending,
      ),
      claimedCount: json['claimed_count'] as int? ?? 0,
      claimedAmount: json['claimed_amount'] as String? ?? '0',
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      expiredAt: json['expired_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['expired_at'] as int)
          : null,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'sender_name': senderName,
      'amount': amount,
      'token': token,
      'type': type.name,
      'count': count,
      'greeting': greeting,
      'status': status.name,
      'claimed_count': claimedCount,
      'claimed_amount': claimedAmount,
      'created_at': createdAt.millisecondsSinceEpoch,
      'expired_at': expiredAt?.millisecondsSinceEpoch,
    };
  }
}

/// 红包类型
enum RedPacketType {
  /// 普通红包
  normal,
  /// 拼手气红包
  lucky,
}

/// 红包状态
enum RedPacketEntityStatus {
  /// 待领取
  pending,
  /// 已领取
  opened,
  /// 已被领完
  empty,
  /// 已过期
  expired,
  /// 已退还
  refunded,
}

