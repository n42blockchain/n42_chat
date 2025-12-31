import 'package:equatable/equatable.dart';

import 'contact_entity.dart';

/// 群成员角色
enum GroupRole {
  /// 群主
  owner,
  /// 管理员
  admin,
  /// 普通成员
  member,
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

  const GroupMember({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.role = GroupRole.member,
    this.powerLevel = 0,
    this.isOnline = false,
    this.joinedAt,
  });

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
      ];

  GroupMember copyWith({
    String? userId,
    String? displayName,
    String? avatarUrl,
    GroupRole? role,
    int? powerLevel,
    bool? isOnline,
    DateTime? joinedAt,
  }) {
    return GroupMember(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      powerLevel: powerLevel ?? this.powerLevel,
      isOnline: isOnline ?? this.isOnline,
      joinedAt: joinedAt ?? this.joinedAt,
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

  const GroupEntity({
    required this.roomId,
    required this.name,
    this.avatarUrl,
    this.topic,
    this.announcement,
    this.memberCount = 0,
    this.members = const [],
    this.isEncrypted = false,
    this.isPublic = false,
    this.createdAt,
    this.myRole = GroupRole.member,
    this.canInvite = false,
    this.canKick = false,
    this.canChangeSettings = false,
  });

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
        memberCount,
        members,
        isEncrypted,
        isPublic,
        createdAt,
        myRole,
        canInvite,
        canKick,
        canChangeSettings,
      ];

  GroupEntity copyWith({
    String? roomId,
    String? name,
    String? avatarUrl,
    String? topic,
    String? announcement,
    int? memberCount,
    List<GroupMember>? members,
    bool? isEncrypted,
    bool? isPublic,
    DateTime? createdAt,
    GroupRole? myRole,
    bool? canInvite,
    bool? canKick,
    bool? canChangeSettings,
  }) {
    return GroupEntity(
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      topic: topic ?? this.topic,
      announcement: announcement ?? this.announcement,
      memberCount: memberCount ?? this.memberCount,
      members: members ?? this.members,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      myRole: myRole ?? this.myRole,
      canInvite: canInvite ?? this.canInvite,
      canKick: canKick ?? this.canKick,
      canChangeSettings: canChangeSettings ?? this.canChangeSettings,
    );
  }
}

