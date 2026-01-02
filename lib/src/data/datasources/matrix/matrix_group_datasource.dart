import 'dart:typed_data';

import 'package:matrix/matrix.dart' as matrix;

import 'matrix_client_manager.dart';

/// Matrix群聊数据源
///
/// 封装Matrix SDK的群聊相关操作
class MatrixGroupDataSource {
  final MatrixClientManager _clientManager;

  MatrixGroupDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  // ============================================
  // 群聊创建
  // ============================================

  /// 创建群聊
  ///
  /// [name] 群名称
  /// [inviteUserIds] 邀请的用户ID列表
  /// [topic] 群话题/描述
  /// [isPublic] 是否公开群
  /// [enableEncryption] 是否启用端到端加密
  Future<String> createGroup({
    required String name,
    List<String> inviteUserIds = const [],
    String? topic,
    bool isPublic = false,
    bool enableEncryption = false,
    Uint8List? avatar,
  }) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }

    final roomId = await _client!.createRoom(
      name: name,
      topic: topic,
      invite: inviteUserIds,
      preset: isPublic
          ? matrix.CreateRoomPreset.publicChat
          : matrix.CreateRoomPreset.privateChat,
      visibility: isPublic ? matrix.Visibility.public : matrix.Visibility.private,
      initialState: enableEncryption
          ? [
              matrix.StateEvent(
                type: matrix.EventTypes.Encryption,
                stateKey: '',
                content: {
                  'algorithm': matrix.Client.supportedGroupEncryptionAlgorithms.first,
                },
              ),
            ]
          : null,
    );

    // 设置群头像
    if (avatar != null) {
      final room = _client!.getRoomById(roomId);
      if (room != null) {
        final matrixFile = matrix.MatrixFile(bytes: avatar, name: 'avatar.png');
        await room.setAvatar(matrixFile);
      }
    }

    return roomId;
  }

  // ============================================
  // 群信息管理
  // ============================================

  /// 获取群信息
  matrix.Room? getGroup(String roomId) {
    return _client?.getRoomById(roomId);
  }

  /// 获取所有群聊
  List<matrix.Room> getAllGroups() {
    return _client?.rooms
            .where((room) =>
                !room.isDirectChat &&
                room.membership == matrix.Membership.join)
            .toList() ??
        [];
  }

  /// 获取群名称
  String getGroupName(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.getLocalizedDisplayname() ?? '群聊';
  }

  /// 设置群名称
  Future<void> setGroupName(String roomId, String name) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.setName(name);
  }

  /// 获取群话题/描述
  String? getGroupTopic(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.topic;
  }

  /// 设置群话题/描述
  Future<void> setGroupTopic(String roomId, String topic) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.setDescription(topic);
  }

  /// 获取群头像URL（手动构建 HTTP URL）
  String? getGroupAvatarUrl(String roomId, {int size = 96}) {
    final room = _client?.getRoomById(roomId);
    final avatarMxc = room?.avatar?.toString();
    return _buildAvatarHttpUrl(avatarMxc, size);
  }
  
  /// 构建头像 HTTP URL（不再在 URL 中添加 access_token，改用请求头认证）
  String? _buildAvatarHttpUrl(String? mxcUrl, int size) {
    if (mxcUrl == null || mxcUrl.isEmpty || _client == null) return null;
    if (!mxcUrl.startsWith('mxc://')) return mxcUrl;
    
    try {
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
      
      if (serverName.isEmpty || mediaId.isEmpty) return null;
      
      final homeserver = _client!.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return null;
      
      // 使用认证媒体 API (Matrix 1.11+)
      return '$homeserver/_matrix/client/v1/media/thumbnail/$serverName/$mediaId?width=$size&height=$size&method=crop';
    } catch (e) {
      return null;
    }
  }

  /// 设置群头像
  Future<void> setGroupAvatar(String roomId, Uint8List avatar) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    final matrixFile = matrix.MatrixFile(bytes: avatar, name: 'avatar.png');
    await room.setAvatar(matrixFile);
  }

  /// 获取群是否加密
  bool isGroupEncrypted(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.encrypted ?? false;
  }

  // ============================================
  // 成员管理
  // ============================================

  /// 获取群成员列表
  Future<List<matrix.User>> getGroupMembers(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    await room.requestParticipants();
    return room.getParticipants();
  }

  /// 获取群成员数量
  int getGroupMemberCount(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.summary.mJoinedMemberCount ?? 0;
  }

  /// 邀请用户加入群
  Future<void> inviteUser(String roomId, String userId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.invite(userId);
  }

  /// 批量邀请用户加入群
  Future<void> inviteUsers(String roomId, List<String> userIds) async {
    for (final userId in userIds) {
      await inviteUser(roomId, userId);
    }
  }

  /// 踢出成员
  Future<void> kickMember(String roomId, String userId, {String? reason}) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.kick(userId);
  }

  /// 封禁成员
  Future<void> banMember(String roomId, String userId, {String? reason}) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.ban(userId);
  }

  /// 解除封禁
  Future<void> unbanMember(String roomId, String userId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.unban(userId);
  }

  /// 获取用户在群中的权限级别
  int getUserPowerLevel(String roomId, String userId) {
    final room = _client?.getRoomById(roomId);
    return room?.getPowerLevelByUserId(userId) ?? 0;
  }

  /// 设置用户权限级别
  Future<void> setUserPowerLevel(String roomId, String userId, int powerLevel) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.setPower(userId, powerLevel);
  }

  /// 检查是否是群管理员
  bool isGroupAdmin(String roomId, String? userId) {
    if (userId == null) return false;
    return getUserPowerLevel(roomId, userId) >= 50;
  }

  /// 检查是否是群主
  bool isGroupOwner(String roomId, String? userId) {
    if (userId == null) return false;
    return getUserPowerLevel(roomId, userId) >= 100;
  }

  /// 检查当前用户是否可以踢人
  bool canKickMembers(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.canKick ?? false;
  }

  /// 检查当前用户是否可以邀请
  bool canInviteMembers(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.canInvite ?? false;
  }

  /// 检查当前用户是否可以修改群设置
  bool canChangeSettings(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.canChangePowerLevel ?? false;
  }

  // ============================================
  // 群操作
  // ============================================

  /// 加入群
  Future<void> joinGroup(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room != null) {
      await room.join();
    } else {
      await _client?.joinRoom(roomId);
    }
  }

  /// 通过邀请链接加入群
  Future<String> joinGroupByAlias(String alias) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }
    return await _client!.joinRoom(alias);
  }

  /// 离开群
  Future<void> leaveGroup(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.leave();
  }

  /// 解散群（仅群主）
  Future<void> deleteGroup(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    // 踢出所有成员
    final members = await getGroupMembers(roomId);
    for (final member in members) {
      if (member.id != _client?.userID) {
        await room.kick(member.id);
      }
    }

    // 离开群
    await room.leave();
  }

  // ============================================
  // 群设置
  // ============================================

  /// 获取群是否可以被搜索到
  bool isGroupPublic(String roomId) {
    final room = _client?.getRoomById(roomId);
    return room?.joinRules == matrix.JoinRules.public;
  }

  /// 设置群可见性
  Future<void> setGroupVisibility(String roomId, bool isPublic) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    await room.setJoinRules(
      isPublic ? matrix.JoinRules.public : matrix.JoinRules.invite,
    );
  }

  /// 获取邀请的群
  List<matrix.Room> getPendingGroupInvites() {
    return _client?.rooms
            .where((room) =>
                !room.isDirectChat &&
                room.membership == matrix.Membership.invite)
            .toList() ??
        [];
  }

  /// 接受群邀请
  Future<void> acceptGroupInvite(String roomId) async {
    await joinGroup(roomId);
  }

  /// 拒绝群邀请
  Future<void> rejectGroupInvite(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    await room.leave();
  }

  // ============================================
  // 群公告
  // ============================================

  /// 获取群公告（使用 topic 作为公告）
  String? getGroupAnnouncement(String roomId) {
    return getGroupTopic(roomId);
  }

  /// 设置群公告
  Future<void> setGroupAnnouncement(String roomId, String announcement) async {
    await setGroupTopic(roomId, announcement);
  }

  // ============================================
  // 监听
  // ============================================

  /// 监听群变化
  Stream<void>? get onGroupsChanged => _client?.onSync.stream;
}

