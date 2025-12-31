import 'dart:typed_data';

import '../entities/group_entity.dart';

/// 群聊仓库接口
abstract class IGroupRepository {
  // ============================================
  // 群聊获取
  // ============================================

  /// 获取所有群聊
  Future<List<GroupEntity>> getGroups();

  /// 监听群聊列表变化
  Stream<List<GroupEntity>> watchGroups();

  /// 获取群详情
  Future<GroupEntity?> getGroup(String roomId);

  /// 获取群成员列表
  Future<List<GroupMember>> getGroupMembers(String roomId);

  // ============================================
  // 群聊创建
  // ============================================

  /// 创建群聊
  Future<String> createGroup({
    required String name,
    List<String> inviteUserIds = const [],
    String? topic,
    bool isPublic = false,
    bool enableEncryption = false,
    Uint8List? avatar,
  });

  // ============================================
  // 群信息管理
  // ============================================

  /// 设置群名称
  Future<void> setGroupName(String roomId, String name);

  /// 设置群话题
  Future<void> setGroupTopic(String roomId, String topic);

  /// 设置群头像
  Future<void> setGroupAvatar(String roomId, Uint8List avatar);

  /// 设置群公告
  Future<void> setGroupAnnouncement(String roomId, String announcement);

  /// 设置群可见性
  Future<void> setGroupVisibility(String roomId, bool isPublic);

  // ============================================
  // 成员管理
  // ============================================

  /// 邀请用户
  Future<void> inviteUser(String roomId, String userId);

  /// 批量邀请用户
  Future<void> inviteUsers(String roomId, List<String> userIds);

  /// 踢出成员
  Future<void> kickMember(String roomId, String userId, {String? reason});

  /// 封禁成员
  Future<void> banMember(String roomId, String userId, {String? reason});

  /// 解除封禁
  Future<void> unbanMember(String roomId, String userId);

  /// 设置成员权限级别
  Future<void> setMemberPowerLevel(String roomId, String userId, int powerLevel);

  /// 设置成员为管理员
  Future<void> setAsAdmin(String roomId, String userId);

  /// 取消管理员
  Future<void> removeAdmin(String roomId, String userId);

  // ============================================
  // 群操作
  // ============================================

  /// 加入群
  Future<void> joinGroup(String roomId);

  /// 通过别名加入群
  Future<String> joinGroupByAlias(String alias);

  /// 离开群
  Future<void> leaveGroup(String roomId);

  /// 解散群
  Future<void> deleteGroup(String roomId);

  // ============================================
  // 群邀请
  // ============================================

  /// 获取待处理的群邀请
  Future<List<GroupEntity>> getPendingGroupInvites();

  /// 接受群邀请
  Future<void> acceptGroupInvite(String roomId);

  /// 拒绝群邀请
  Future<void> rejectGroupInvite(String roomId);
}

