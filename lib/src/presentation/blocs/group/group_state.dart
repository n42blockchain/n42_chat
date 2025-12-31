import 'package:equatable/equatable.dart';

import '../../../domain/entities/group_entity.dart';

/// 群聊状态基类
abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

/// 群聊初始状态
class GroupInitial extends GroupState {
  const GroupInitial();
}

/// 群聊加载中
class GroupLoading extends GroupState {
  const GroupLoading();
}

/// 群聊列表加载完成
class GroupListLoaded extends GroupState {
  /// 群聊列表
  final List<GroupEntity> groups;

  /// 群邀请列表
  final List<GroupEntity> invites;

  const GroupListLoaded({
    required this.groups,
    this.invites = const [],
  });

  @override
  List<Object?> get props => [groups, invites];

  GroupListLoaded copyWith({
    List<GroupEntity>? groups,
    List<GroupEntity>? invites,
  }) {
    return GroupListLoaded(
      groups: groups ?? this.groups,
      invites: invites ?? this.invites,
    );
  }
}

/// 群详情加载完成
class GroupDetailsLoaded extends GroupState {
  /// 群详情
  final GroupEntity group;

  /// 成员列表
  final List<GroupMember> members;

  const GroupDetailsLoaded({
    required this.group,
    required this.members,
  });

  @override
  List<Object?> get props => [group, members];

  GroupDetailsLoaded copyWith({
    GroupEntity? group,
    List<GroupMember>? members,
  }) {
    return GroupDetailsLoaded(
      group: group ?? this.group,
      members: members ?? this.members,
    );
  }
}

/// 群创建成功
class GroupCreated extends GroupState {
  final String roomId;

  const GroupCreated(this.roomId);

  @override
  List<Object?> get props => [roomId];
}

/// 群操作成功
class GroupOperationSuccess extends GroupState {
  final String message;

  const GroupOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// 群聊加载失败
class GroupError extends GroupState {
  final String message;

  const GroupError(this.message);

  @override
  List<Object?> get props => [message];
}

