import 'dart:async';
import 'dart:typed_data';

import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/group_entity.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/matrix/matrix_group_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// 群聊仓库实现
class GroupRepositoryImpl implements IGroupRepository {
  final MatrixGroupDataSource _groupDataSource;
  final MatrixClientManager _clientManager;

  GroupRepositoryImpl(this._groupDataSource, this._clientManager);

  @override
  Future<List<GroupEntity>> getGroups() async {
    final rooms = _groupDataSource.getAllGroups();
    return rooms.map(_mapRoomToGroupEntity).toList();
  }

  @override
  Stream<List<GroupEntity>> watchGroups() async* {
    yield await getGroups();

    final stream = _groupDataSource.onGroupsChanged;
    if (stream != null) {
      await for (final _ in stream) {
        yield await getGroups();
      }
    }
  }

  @override
  Future<GroupEntity?> getGroup(String roomId) async {
    final room = _groupDataSource.getGroup(roomId);
    if (room == null) return null;

    final members = await _groupDataSource.getGroupMembers(roomId);
    return _mapRoomToGroupEntity(room, members: members);
  }

  @override
  Future<List<GroupMember>> getGroupMembers(String roomId) async {
    final users = await _groupDataSource.getGroupMembers(roomId);
    return users.map((user) => _mapUserToGroupMember(roomId, user)).toList();
  }

  @override
  Future<String> createGroup({
    required String name,
    List<String> inviteUserIds = const [],
    String? topic,
    bool isPublic = false,
    bool enableEncryption = false,
    Uint8List? avatar,
  }) async {
    return await _groupDataSource.createGroup(
      name: name,
      inviteUserIds: inviteUserIds,
      topic: topic,
      isPublic: isPublic,
      enableEncryption: enableEncryption,
      avatar: avatar,
    );
  }

  @override
  Future<void> setGroupName(String roomId, String name) async {
    await _groupDataSource.setGroupName(roomId, name);
  }

  @override
  Future<void> setGroupTopic(String roomId, String topic) async {
    await _groupDataSource.setGroupTopic(roomId, topic);
  }

  @override
  Future<void> setGroupAvatar(String roomId, Uint8List avatar) async {
    await _groupDataSource.setGroupAvatar(roomId, avatar);
  }

  @override
  Future<void> setGroupAnnouncement(String roomId, String announcement) async {
    await _groupDataSource.setGroupAnnouncement(roomId, announcement);
  }

  @override
  Future<void> setGroupVisibility(String roomId, bool isPublic) async {
    await _groupDataSource.setGroupVisibility(roomId, isPublic);
  }

  @override
  Future<void> inviteUser(String roomId, String userId) async {
    await _groupDataSource.inviteUser(roomId, userId);
  }

  @override
  Future<void> inviteUsers(String roomId, List<String> userIds) async {
    await _groupDataSource.inviteUsers(roomId, userIds);
  }

  @override
  Future<void> kickMember(String roomId, String userId, {String? reason}) async {
    await _groupDataSource.kickMember(roomId, userId, reason: reason);
  }

  @override
  Future<void> banMember(String roomId, String userId, {String? reason}) async {
    await _groupDataSource.banMember(roomId, userId, reason: reason);
  }

  @override
  Future<void> unbanMember(String roomId, String userId) async {
    await _groupDataSource.unbanMember(roomId, userId);
  }

  @override
  Future<void> setMemberPowerLevel(String roomId, String userId, int powerLevel) async {
    await _groupDataSource.setUserPowerLevel(roomId, userId, powerLevel);
  }

  @override
  Future<void> setAsAdmin(String roomId, String userId) async {
    await setMemberPowerLevel(roomId, userId, 50);
  }

  @override
  Future<void> removeAdmin(String roomId, String userId) async {
    await setMemberPowerLevel(roomId, userId, 0);
  }

  @override
  Future<void> joinGroup(String roomId) async {
    await _groupDataSource.joinGroup(roomId);
  }

  @override
  Future<String> joinGroupByAlias(String alias) async {
    return await _groupDataSource.joinGroupByAlias(alias);
  }

  @override
  Future<void> leaveGroup(String roomId) async {
    await _groupDataSource.leaveGroup(roomId);
  }

  @override
  Future<void> deleteGroup(String roomId) async {
    await _groupDataSource.deleteGroup(roomId);
  }

  @override
  Future<List<GroupEntity>> getPendingGroupInvites() async {
    final rooms = _groupDataSource.getPendingGroupInvites();
    return rooms.map(_mapRoomToGroupEntity).toList();
  }

  @override
  Future<void> acceptGroupInvite(String roomId) async {
    await _groupDataSource.acceptGroupInvite(roomId);
  }

  @override
  Future<void> rejectGroupInvite(String roomId) async {
    await _groupDataSource.rejectGroupInvite(roomId);
  }

  // ============================================
  // 辅助方法
  // ============================================

  GroupEntity _mapRoomToGroupEntity(matrix.Room room, {List<matrix.User>? members}) {
    final avatarUrlStr = _groupDataSource.getGroupAvatarUrl(room.id);
    final myUserId = _clientManager.client?.userID;

    GroupRole myRole = GroupRole.member;
    if (_groupDataSource.isGroupOwner(room.id, myUserId)) {
      myRole = GroupRole.owner;
    } else if (_groupDataSource.isGroupAdmin(room.id, myUserId)) {
      myRole = GroupRole.admin;
    }

    return GroupEntity(
      roomId: room.id,
      name: room.getLocalizedDisplayname(),
      avatarUrl: avatarUrlStr,
      topic: room.topic,
      announcement: room.topic,
      memberCount: room.summary.mJoinedMemberCount ?? 0,
      members: members?.map((u) => _mapUserToGroupMember(room.id, u)).toList() ?? [],
      isEncrypted: room.encrypted,
      isPublic: room.joinRules == matrix.JoinRules.public,
      createdAt: null, // StrippedStateEvent doesn't have originServerTs
      myRole: myRole,
      canInvite: _groupDataSource.canInviteMembers(room.id),
      canKick: _groupDataSource.canKickMembers(room.id),
      canChangeSettings: _groupDataSource.canChangeSettings(room.id),
    );
  }

  GroupMember _mapUserToGroupMember(String roomId, matrix.User user) {
    final powerLevel = _groupDataSource.getUserPowerLevel(roomId, user.id);

    GroupRole role = GroupRole.member;
    if (powerLevel >= 100) {
      role = GroupRole.owner;
    } else if (powerLevel >= 50) {
      role = GroupRole.admin;
    }

    String? avatarUrl;
    final client = _clientManager.client;
    if (user.avatarUrl != null && client != null) {
      avatarUrl = _buildAvatarHttpUrl(user.avatarUrl.toString(), client);
    }

    return GroupMember(
      userId: user.id,
      displayName: user.calcDisplayname(),
      avatarUrl: avatarUrl,
      role: role,
      powerLevel: powerLevel,
    );
  }
  
  /// 构建头像 HTTP URL
  String? _buildAvatarHttpUrl(String? mxcUrl, matrix.Client client) {
    if (mxcUrl == null || mxcUrl.isEmpty) return null;
    if (!mxcUrl.startsWith('mxc://')) return mxcUrl;
    
    try {
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
      
      if (serverName.isEmpty || mediaId.isEmpty) return null;
      
      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return null;
      
      return '$homeserver/_matrix/media/v3/thumbnail/$serverName/$mediaId?width=96&height=96&method=crop';
    } catch (e) {
      return null;
    }
  }
}

