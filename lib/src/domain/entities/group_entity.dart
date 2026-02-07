import 'package:equatable/equatable.dart';

import 'contact_entity.dart';
import 'token_gate_entity.dart';

/// 群成员角色
enum GroupRole {
  /// 群主
  owner,
  /// 管理员
  admin,
  /// 普通成员
  member,
}

/// 群成员状态
enum MembershipStatus {
  /// 已加入
  joined,
  /// 已邀请（等待接受）
  invited,
}

/// 群组类型
enum GroupType {
  /// 普通群组
  group,
  /// 频道（单向广播）
  channel,
  /// 超级群（大规模群组）
  superGroup,
}

/// 加入方式
enum JoinRule {
  /// 公开（任何人可加入）
  public,
  /// 私有（需邀请）
  invite,
  /// 敲门（需申请审批）
  knock,
  /// 受限（需满足条件）
  restricted,
}

/// 群成员实体
class GroupMember extends Equatable {
  /// 用户ID
  final String userId;

  /// 显示名称
  final String displayName;

  /// 头像URL
  final String? avatarUrl;

  /// 角色
  final GroupRole role;

  /// 权限级别
  final int powerLevel;

  /// 是否在线
  final bool isOnline;

  /// 加入时间
  final DateTime? joinedAt;

  /// 成员状态
  final MembershipStatus membershipStatus;

  const GroupMember({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.role = GroupRole.member,
    this.powerLevel = 0,
    this.isOnline = false,
    this.joinedAt,
    this.membershipStatus = MembershipStatus.joined,
  });

  /// 是否已邀请但未加入
  bool get isInvited => membershipStatus == MembershipStatus.invited;

  /// 从 ContactEntity 创建
  factory GroupMember.fromContact(
    ContactEntity contact, {
    GroupRole role = GroupRole.member,
    int powerLevel = 0,
  }) {
    return GroupMember(
      userId: contact.userId,
      displayName: contact.effectiveDisplayName,
      avatarUrl: contact.avatarUrl,
      role: role,
      powerLevel: powerLevel,
      isOnline: contact.isOnline,
    );
  }

  /// 获取用户名
  String get username {
    if (userId.startsWith('@')) {
      final colonIndex = userId.indexOf(':');
      if (colonIndex > 1) {
        return userId.substring(1, colonIndex);
      }
      return userId.substring(1);
    }
    return userId;
  }

  /// 获取首字母
  String get initials {
    if (displayName.isEmpty) return '?';

    final words = displayName.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return displayName.substring(0, displayName.length.clamp(0, 2)).toUpperCase();
    }

    return words
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
  }

  /// 是否是群主
  bool get isOwner => role == GroupRole.owner || powerLevel >= 100;

  /// 是否是管理员
  bool get isAdmin => role == GroupRole.admin || powerLevel >= 50;

  @override
  List<Object?> get props => [
        userId,
        displayName,
        avatarUrl,
        role,
        powerLevel,
        isOnline,
        joinedAt,
        membershipStatus,
      ];

  GroupMember copyWith({
    String? userId,
    String? displayName,
    String? avatarUrl,
    GroupRole? role,
    int? powerLevel,
    bool? isOnline,
    DateTime? joinedAt,
    MembershipStatus? membershipStatus,
  }) {
    return GroupMember(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      powerLevel: powerLevel ?? this.powerLevel,
      isOnline: isOnline ?? this.isOnline,
      joinedAt: joinedAt ?? this.joinedAt,
      membershipStatus: membershipStatus ?? this.membershipStatus,
    );
  }
}

/// 群实体
class GroupEntity extends Equatable {
  /// 房间ID
  final String roomId;

  /// 群名称
  final String name;

  /// 群头像URL
  final String? avatarUrl;

  /// 群话题/描述
  final String? topic;

  /// 群公告
  final String? announcement;

  /// 置顶消息事件ID列表
  final List<String> pinnedEventIds;

  /// 成员数量
  final int memberCount;

  /// 成员列表
  final List<GroupMember> members;

  /// 是否加密
  final bool isEncrypted;

  /// 是否公开
  final bool isPublic;

  /// 创建时间
  final DateTime? createdAt;

  /// 当前用户的角色
  final GroupRole myRole;

  /// 当前用户是否可以邀请
  final bool canInvite;

  /// 当前用户是否可以踢人
  final bool canKick;

  /// 当前用户是否可以修改设置
  final bool canChangeSettings;

  // ============================================
  // 频道/超级群属性
  // ============================================

  /// 群组类型
  final GroupType groupType;

  /// 是否是频道
  bool get isChannel => groupType == GroupType.channel;

  /// 是否是超级群
  bool get isSuperGroup => groupType == GroupType.superGroup;

  /// 订阅者数量（频道专用）
  final int subscriberCount;

  /// 加入方式
  final JoinRule joinRule;

  /// 是否允许成员发言（频道中默认只有管理员可发言）
  final bool membersCanSpeak;

  /// 是否显示成员列表
  final bool showMemberList;

  /// 慢速模式间隔（秒），0 表示不限制
  final int slowModeInterval;

  /// 频道用户名（用于公开链接，如 @channel_name）
  final String? channelUsername;

  /// 频道链接
  String? get channelLink => channelUsername != null ? 'https://n42.app/$channelUsername' : null;

  /// 是否已验证（官方频道）
  final bool isVerified;

  /// 频道分类
  final String? category;

  /// 代币门控配置
  final TokenGateConfig? tokenGate;

  const GroupEntity({
    required this.roomId,
    required this.name,
    this.avatarUrl,
    this.topic,
    this.announcement,
    this.pinnedEventIds = const [],
    this.memberCount = 0,
    this.members = const [],
    this.isEncrypted = false,
    this.isPublic = false,
    this.createdAt,
    this.myRole = GroupRole.member,
    this.canInvite = false,
    this.canKick = false,
    this.canChangeSettings = false,
    this.groupType = GroupType.group,
    this.subscriberCount = 0,
    this.joinRule = JoinRule.invite,
    this.membersCanSpeak = true,
    this.showMemberList = true,
    this.slowModeInterval = 0,
    this.channelUsername,
    this.isVerified = false,
    this.category,
    this.tokenGate,
  });

  /// 是否有置顶消息
  bool get hasPinnedMessages => pinnedEventIds.isNotEmpty;

  /// 获取置顶消息数量
  int get pinnedMessageCount => pinnedEventIds.length;

  /// 是否是群主
  bool get isOwner => myRole == GroupRole.owner;

  /// 是否是管理员
  bool get isAdmin => myRole == GroupRole.admin || isOwner;

  /// 获取群主
  GroupMember? get owner {
    try {
      return members.firstWhere((m) => m.isOwner);
    } catch (e) {
      return null;
    }
  }

  /// 获取管理员列表
  List<GroupMember> get admins {
    return members.where((m) => m.isAdmin && !m.isOwner).toList();
  }

  /// 获取普通成员列表
  List<GroupMember> get normalMembers {
    return members.where((m) => !m.isAdmin).toList();
  }

  @override
  List<Object?> get props => [
        roomId,
        name,
        avatarUrl,
        topic,
        announcement,
        pinnedEventIds,
        memberCount,
        members,
        isEncrypted,
        isPublic,
        createdAt,
        myRole,
        canInvite,
        canKick,
        canChangeSettings,
        groupType,
        subscriberCount,
        joinRule,
        membersCanSpeak,
        showMemberList,
        slowModeInterval,
        channelUsername,
        isVerified,
        category,
        tokenGate,
      ];

  GroupEntity copyWith({
    String? roomId,
    String? name,
    String? avatarUrl,
    String? topic,
    String? announcement,
    List<String>? pinnedEventIds,
    int? memberCount,
    List<GroupMember>? members,
    bool? isEncrypted,
    bool? isPublic,
    DateTime? createdAt,
    GroupRole? myRole,
    bool? canInvite,
    bool? canKick,
    bool? canChangeSettings,
    GroupType? groupType,
    int? subscriberCount,
    JoinRule? joinRule,
    bool? membersCanSpeak,
    bool? showMemberList,
    int? slowModeInterval,
    String? channelUsername,
    bool? isVerified,
    String? category,
    TokenGateConfig? tokenGate,
  }) {
    return GroupEntity(
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      topic: topic ?? this.topic,
      announcement: announcement ?? this.announcement,
      pinnedEventIds: pinnedEventIds ?? this.pinnedEventIds,
      memberCount: memberCount ?? this.memberCount,
      members: members ?? this.members,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      myRole: myRole ?? this.myRole,
      canInvite: canInvite ?? this.canInvite,
      canKick: canKick ?? this.canKick,
      canChangeSettings: canChangeSettings ?? this.canChangeSettings,
      groupType: groupType ?? this.groupType,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      joinRule: joinRule ?? this.joinRule,
      membersCanSpeak: membersCanSpeak ?? this.membersCanSpeak,
      showMemberList: showMemberList ?? this.showMemberList,
      slowModeInterval: slowModeInterval ?? this.slowModeInterval,
      channelUsername: channelUsername ?? this.channelUsername,
      isVerified: isVerified ?? this.isVerified,
      category: category ?? this.category,
      tokenGate: tokenGate ?? this.tokenGate,
    );
  }

  /// 创建频道
  factory GroupEntity.channel({
    required String roomId,
    required String name,
    String? avatarUrl,
    String? topic,
    int subscriberCount = 0,
    String? channelUsername,
    bool isVerified = false,
    String? category,
  }) {
    return GroupEntity(
      roomId: roomId,
      name: name,
      avatarUrl: avatarUrl,
      topic: topic,
      groupType: GroupType.channel,
      subscriberCount: subscriberCount,
      joinRule: JoinRule.public,
      membersCanSpeak: false,
      showMemberList: false,
      channelUsername: channelUsername,
      isVerified: isVerified,
      category: category,
    );
  }

  /// 创建超级群
  factory GroupEntity.superGroup({
    required String roomId,
    required String name,
    String? avatarUrl,
    String? topic,
    int memberCount = 0,
    int slowModeInterval = 0,
  }) {
    return GroupEntity(
      roomId: roomId,
      name: name,
      avatarUrl: avatarUrl,
      topic: topic,
      groupType: GroupType.superGroup,
      memberCount: memberCount,
      joinRule: JoinRule.public,
      membersCanSpeak: true,
      showMemberList: true,
      slowModeInterval: slowModeInterval,
    );
  }
}

