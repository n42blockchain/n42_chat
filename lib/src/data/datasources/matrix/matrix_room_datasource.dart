import 'dart:async';

import 'package:matrix/matrix.dart' as matrix;

import 'matrix_client_manager.dart';

/// Matrix房间数据源
///
/// 封装Matrix SDK的房间相关操作
class MatrixRoomDataSource {
  final MatrixClientManager _clientManager;

  MatrixRoomDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  // ============================================
  // 房间列表
  // ============================================

  /// 获取所有房间
  List<matrix.Room> getRooms() {
    return _client?.rooms ?? [];
  }

  /// 获取已加入的房间（过滤邀请等）
  List<matrix.Room> getJoinedRooms() {
    return getRooms()
        .where((room) => room.membership == matrix.Membership.join)
        .toList();
  }

  /// 获取私聊房间
  List<matrix.Room> getDirectChats() {
    return getJoinedRooms().where((room) => room.isDirectChat).toList();
  }

  /// 获取群聊房间
  List<matrix.Room> getGroupChats() {
    return getJoinedRooms().where((room) => !room.isDirectChat).toList();
  }

  /// 按最后活动时间排序的房间列表
  List<matrix.Room> getSortedRooms() {
    final rooms = getJoinedRooms();
    rooms.sort((a, b) {
      final aTime = a.lastEvent?.originServerTs ?? DateTime(1970);
      final bTime = b.lastEvent?.originServerTs ?? DateTime(1970);
      return bTime.compareTo(aTime);
    });
    return rooms;
  }

  // ============================================
  // 房间详情
  // ============================================

  /// 根据ID获取房间
  matrix.Room? getRoomById(String roomId) {
    return _client?.getRoomById(roomId);
  }

  /// 获取房间显示名称
  String getRoomDisplayName(matrix.Room room) {
    return room.getLocalizedDisplayname();
  }

  /// 获取房间头像URL
  Uri? getRoomAvatarUrl(matrix.Room room, {int size = 96}) {
    final avatarMxc = room.avatar;
    if (avatarMxc == null) return null;

    return avatarMxc.getThumbnail(
      _client!,
      width: size,
      height: size,
      method: matrix.ThumbnailMethod.crop,
    );
  }

  /// 获取房间未读消息数
  int getUnreadCount(matrix.Room room) {
    return room.notificationCount;
  }

  /// 获取房间高亮未读数（@提及）
  int getHighlightCount(matrix.Room room) {
    return room.highlightCount;
  }

  /// 房间是否免打扰
  bool isMuted(matrix.Room room) {
    return room.pushRuleState == matrix.PushRuleState.dontNotify;
  }

  /// 房间是否加密
  bool isEncrypted(matrix.Room room) {
    return room.encrypted;
  }

  // ============================================
  // 房间最后消息
  // ============================================

  /// 获取最后一条消息事件
  matrix.Event? getLastEvent(matrix.Room room) {
    return room.lastEvent;
  }

  /// 获取最后消息预览文本
  String getLastMessagePreview(matrix.Room room) {
    final lastEvent = room.lastEvent;
    if (lastEvent == null) return '';

    return _getEventPreview(lastEvent, room);
  }

  /// 获取最后消息时间
  DateTime? getLastMessageTime(matrix.Room room) {
    return room.lastEvent?.originServerTs;
  }

  /// 获取最后消息发送者名称
  String? getLastMessageSenderName(matrix.Room room) {
    final lastEvent = room.lastEvent;
    if (lastEvent == null) return null;

    final sender = room.unsafeGetUserFromMemoryOrFallback(lastEvent.senderId);
    return sender.calcDisplayname();
  }

  // ============================================
  // 房间成员
  // ============================================

  /// 获取房间成员列表
  Future<List<matrix.User>> getRoomMembers(matrix.Room room) async {
    await room.requestParticipants();
    return room.getParticipants();
  }

  /// 获取房间成员数量
  int getMemberCount(matrix.Room room) {
    return room.summary.mJoinedMemberCount ?? 
           room.summary.mInvitedMemberCount ?? 
           0;
  }

  /// 获取私聊对方用户
  matrix.User? getDirectChatPartner(matrix.Room room) {
    if (!room.isDirectChat) return null;
    return room.directChatMatrixID != null
        ? room.unsafeGetUserFromMemoryOrFallback(room.directChatMatrixID!)
        : null;
  }

  // ============================================
  // 房间操作
  // ============================================

  /// 创建私聊房间
  Future<String> createDirectChat(String userId) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }

    final roomId = await _client!.startDirectChat(userId);
    return roomId;
  }

  /// 创建群聊房间
  Future<String> createGroupChat({
    required String name,
    String? topic,
    List<String>? inviteUserIds,
    bool encrypted = true,
  }) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }

    final roomId = await _client!.createRoom(
      name: name,
      topic: topic,
      invite: inviteUserIds,
      preset: encrypted
          ? matrix.CreateRoomPreset.privateChat
          : matrix.CreateRoomPreset.publicChat,
      initialState: encrypted
          ? [
              matrix.StateEvent(
                type: matrix.EventTypes.Encryption,
                stateKey: '',
                content: {
                  'algorithm': matrix.AlgorithmTypes.megolmV1AesSha2,
                },
              ),
            ]
          : null,
    );

    return roomId;
  }

  /// 加入房间
  Future<void> joinRoom(String roomIdOrAlias) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }

    await _client!.joinRoom(roomIdOrAlias);
  }

  /// 离开房间
  Future<void> leaveRoom(String roomId) async {
    final room = getRoomById(roomId);
    if (room == null) return;

    await room.leave();
  }

  /// 设置房间免打扰
  Future<void> setRoomMuted(String roomId, bool muted) async {
    final room = getRoomById(roomId);
    if (room == null) return;

    await room.setPushRuleState(
      muted ? matrix.PushRuleState.dontNotify : matrix.PushRuleState.notify,
    );
  }

  /// 设置房间置顶
  Future<void> setRoomPinned(String roomId, bool pinned) async {
    final room = getRoomById(roomId);
    if (room == null) return;

    await room.setFavourite(pinned);
  }

  /// 标记房间已读
  Future<void> markRoomAsRead(String roomId) async {
    final room = getRoomById(roomId);
    if (room == null) return;

    await room.setReadMarker(
      room.lastEvent?.eventId ?? '',
      mRead: room.lastEvent?.eventId,
    );
  }

  // ============================================
  // 房间监听
  // ============================================

  /// 监听房间列表变化
  Stream<List<matrix.Room>>? get onRoomsChanged {
    return _client?.onSync.stream.map((_) => getSortedRooms());
  }

  /// 监听特定房间变化
  Stream<matrix.Room?>? watchRoom(String roomId) {
    return _client?.onSync.stream.map((_) => getRoomById(roomId));
  }

  // ============================================
  // 辅助方法
  // ============================================

  /// 获取事件预览文本
  String _getEventPreview(matrix.Event event, matrix.Room room) {
    switch (event.type) {
      case matrix.EventTypes.Message:
        return _getMessagePreview(event);
      case matrix.EventTypes.Encrypted:
        return '[加密消息]';
      case matrix.EventTypes.Sticker:
        return '[表情]';
      case matrix.EventTypes.RoomMember:
        return _getMemberEventPreview(event, room);
      case matrix.EventTypes.RoomCreate:
        return '创建了群聊';
      case matrix.EventTypes.RoomName:
        return '修改了群名称';
      case matrix.EventTypes.RoomAvatar:
        return '修改了群头像';
      case matrix.EventTypes.RoomTopic:
        return '修改了群公告';
      default:
        return '';
    }
  }

  /// 获取消息预览文本
  String _getMessagePreview(matrix.Event event) {
    final msgType = event.messageType;
    final body = event.body;

    switch (msgType) {
      case matrix.MessageTypes.Text:
        return body;
      case matrix.MessageTypes.Image:
        return '[图片]';
      case matrix.MessageTypes.Video:
        return '[视频]';
      case matrix.MessageTypes.Audio:
        return '[语音]';
      case matrix.MessageTypes.File:
        return '[文件]';
      case matrix.MessageTypes.Location:
        return '[位置]';
      case matrix.MessageTypes.Notice:
        return body;
      case matrix.MessageTypes.Emote:
        return body;
      default:
        return body.isNotEmpty ? body : '[未知消息]';
    }
  }

  /// 获取成员事件预览文本
  String _getMemberEventPreview(matrix.Event event, matrix.Room room) {
    final sender = room.unsafeGetUserFromMemoryOrFallback(event.senderId);
    final senderName = sender.calcDisplayname();
    final membership = event.content['membership'] as String?;

    switch (membership) {
      case 'join':
        return '$senderName 加入了群聊';
      case 'leave':
        return '$senderName 离开了群聊';
      case 'invite':
        return '$senderName 被邀请加入';
      case 'ban':
        return '$senderName 被移出群聊';
      default:
        return '';
    }
  }
}

