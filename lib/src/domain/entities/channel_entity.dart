import 'package:equatable/equatable.dart';

import 'message_entity.dart';

/// 子频道实体（群话题频道）
class ChannelEntity extends Equatable {
  /// 频道房间 ID
  final String roomId;

  /// 父群组 ID
  final String parentRoomId;

  /// 频道名称
  final String name;

  /// 频道话题（可选）
  final String? topic;

  /// 排序序号（越小越靠前）
  final int order;

  /// 未读消息数
  final int unreadCount;

  /// 最后一条消息（用于列表预览）
  final MessageEntity? lastMessage;

  const ChannelEntity({
    required this.roomId,
    required this.parentRoomId,
    required this.name,
    this.topic,
    this.order = 0,
    this.unreadCount = 0,
    this.lastMessage,
  });

  ChannelEntity copyWith({
    String? roomId,
    String? parentRoomId,
    String? name,
    String? topic,
    int? order,
    int? unreadCount,
    MessageEntity? lastMessage,
  }) {
    return ChannelEntity(
      roomId: roomId ?? this.roomId,
      parentRoomId: parentRoomId ?? this.parentRoomId,
      name: name ?? this.name,
      topic: topic ?? this.topic,
      order: order ?? this.order,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        parentRoomId,
        name,
        topic,
        order,
        unreadCount,
        lastMessage,
      ];
}
