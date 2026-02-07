import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/group_entity.dart';
import '../../domain/entities/token_gate_entity.dart';
import '../../domain/repositories/group_repository.dart';
import '../../integration/wallet_bridge.dart';
import '../datasources/matrix/matrix_group_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// 群聊仓库实现
class GroupRepositoryImpl implements IGroupRepository {
  final MatrixGroupDataSource _groupDataSource;
  final MatrixClientManager _clientManager;
  final IWalletBridge? _walletBridge;

  GroupRepositoryImpl(
    this._groupDataSource,
    this._clientManager, {
    IWalletBridge? walletBridge,
  }) : _walletBridge = walletBridge;

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
  // 置顶消息管理
  // ============================================

  @override
  Future<List<String>> getPinnedEventIds(String roomId) async {
    return _groupDataSource.getPinnedEventIds(roomId);
  }

  @override
  Future<void> pinMessage(String roomId, String eventId) async {
    await _groupDataSource.pinMessage(roomId, eventId);
  }

  @override
  Future<void> unpinMessage(String roomId, String eventId) async {
    await _groupDataSource.unpinMessage(roomId, eventId);
  }

  @override
  Future<void> setPinnedMessages(String roomId, List<String> eventIds) async {
    await _groupDataSource.setPinnedMessages(roomId, eventIds);
  }

  @override
  bool canPinMessages(String roomId) {
    return _groupDataSource.canPinMessages(roomId);
  }

  // ============================================
  // 代币门控
  // ============================================

  @override
  Future<TokenGateConfig?> getTokenGate(String roomId) async {
    try {
      final data = _groupDataSource.getTokenGateConfig(roomId);
      if (data == null) return null;
      return TokenGateConfig.fromJson(data);
    } catch (e) {
      debugPrint('GroupRepository: Failed to get token gate: $e');
      return null;
    }
  }

  @override
  Future<void> setTokenGate(String roomId, TokenGateConfig config) async {
    await _groupDataSource.setTokenGateConfig(roomId, config.toJson());
  }

  @override
  Future<TokenGateVerificationResult> verifyTokenGate(String roomId) async {
    if (_walletBridge == null) {
      return TokenGateVerificationResult.error('Wallet not connected');
    }

    final config = await getTokenGate(roomId);
    if (config == null || !config.enabled || config.rules.isEmpty) {
      return const TokenGateVerificationResult(passed: true);
    }

    final ruleResults = <TokenGateRuleResult>[];

    for (final rule in config.rules) {
      try {
        BigInt actualBalance;

        switch (rule.tokenStandard) {
          case TokenStandard.erc20:
            actualBalance = await _walletBridge!.getErc20Balance(
              contractAddress: rule.contractAddress ?? '',
              chainId: rule.chainId,
            );
            break;
          case TokenStandard.erc721:
            final nftCount = await _walletBridge!.getErc721Balance(
              contractAddress: rule.contractAddress ?? '',
              chainId: rule.chainId,
            );
            actualBalance = BigInt.from(nftCount);
            break;
          case TokenStandard.erc1155:
            actualBalance = await _walletBridge!.getErc1155Balance(
              contractAddress: rule.contractAddress ?? '',
              tokenId: rule.tokenId ?? BigInt.zero,
              chainId: rule.chainId,
            );
            break;
          case TokenStandard.native:
            final balanceStr = await _walletBridge!.getBalance('ETH');
            final balanceDouble = double.tryParse(balanceStr) ?? 0;
            actualBalance = BigInt.from(balanceDouble * 1e18);
            break;
        }

        ruleResults.add(TokenGateRuleResult(
          rule: rule,
          passed: actualBalance >= rule.minBalance,
          actualBalance: actualBalance,
        ));
      } catch (e) {
        ruleResults.add(TokenGateRuleResult(
          rule: rule,
          passed: false,
          actualBalance: BigInt.zero,
          errorMessage: e.toString(),
        ));
      }
    }

    final passed = config.operator == GateOperator.and
        ? ruleResults.every((r) => r.passed)
        : ruleResults.any((r) => r.passed);

    return TokenGateVerificationResult(
      passed: passed,
      ruleResults: ruleResults,
    );
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

    // 成员数量包括已加入和已邀请的成员
    final joinedCount = room.summary.mJoinedMemberCount ?? 0;
    final invitedCount = room.summary.mInvitedMemberCount ?? 0;

    // 获取置顶消息ID列表
    final pinnedEventIds = _groupDataSource.getPinnedEventIds(room.id);

    // Read token gate config
    TokenGateConfig? tokenGateConfig;
    try {
      final tokenGateData = _groupDataSource.getTokenGateConfig(room.id);
      if (tokenGateData != null) {
        tokenGateConfig = TokenGateConfig.fromJson(tokenGateData);
      }
    } catch (_) {}

    return GroupEntity(
      roomId: room.id,
      name: room.getLocalizedDisplayname(),
      avatarUrl: avatarUrlStr,
      topic: room.topic,
      announcement: room.topic,
      pinnedEventIds: pinnedEventIds,
      memberCount: joinedCount + invitedCount,
      members: members?.map((u) => _mapUserToGroupMember(room.id, u)).toList() ?? [],
      isEncrypted: room.encrypted,
      isPublic: room.joinRules == matrix.JoinRules.public,
      createdAt: null, // StrippedStateEvent doesn't have originServerTs
      myRole: myRole,
      canInvite: _groupDataSource.canInviteMembers(room.id),
      canKick: _groupDataSource.canKickMembers(room.id),
      canChangeSettings: _groupDataSource.canChangeSettings(room.id),
      tokenGate: tokenGateConfig,
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

    // 根据 Matrix 用户状态确定成员状态
    final membershipStatus = user.membership == matrix.Membership.invite
        ? MembershipStatus.invited
        : MembershipStatus.joined;

    return GroupMember(
      userId: user.id,
      displayName: user.calcDisplayname(),
      avatarUrl: avatarUrl,
      role: role,
      powerLevel: powerLevel,
      membershipStatus: membershipStatus,
    );
  }
  
  /// 构建头像 HTTP URL（不再在 URL 中添加 access_token，改用请求头认证）
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
      
      // 使用认证媒体 API (Matrix 1.11+)
      return '$homeserver/_matrix/client/v1/media/thumbnail/$serverName/$mediaId?width=96&height=96&method=crop';
    } catch (e) {
      return null;
    }
  }
}

