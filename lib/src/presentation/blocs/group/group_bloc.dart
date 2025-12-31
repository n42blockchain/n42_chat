import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';
import 'group_event.dart';
import 'group_state.dart';

/// 群聊BLoC
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final IGroupRepository _groupRepository;

  StreamSubscription<List<GroupEntity>>? _groupsSubscription;

  GroupBloc(this._groupRepository) : super(const GroupInitial()) {
    on<LoadGroups>(_onLoadGroups);
    on<RefreshGroups>(_onRefreshGroups);
    on<LoadGroupDetails>(_onLoadGroupDetails);
    on<LoadGroupMembers>(_onLoadGroupMembers);
    on<CreateGroup>(_onCreateGroup);
    on<UpdateGroupName>(_onUpdateGroupName);
    on<UpdateGroupTopic>(_onUpdateGroupTopic);
    on<UpdateGroupAvatar>(_onUpdateGroupAvatar);
    on<InviteMembers>(_onInviteMembers);
    on<KickMember>(_onKickMember);
    on<SetAsAdmin>(_onSetAsAdmin);
    on<RemoveAdmin>(_onRemoveAdmin);
    on<LeaveGroup>(_onLeaveGroup);
    on<DeleteGroup>(_onDeleteGroup);
    on<LoadGroupInvites>(_onLoadGroupInvites);
    on<AcceptGroupInvite>(_onAcceptGroupInvite);
    on<RejectGroupInvite>(_onRejectGroupInvite);
    on<GroupsUpdated>(_onGroupsUpdated);
  }

  Future<void> _onLoadGroups(
    LoadGroups event,
    Emitter<GroupState> emit,
  ) async {
    emit(const GroupLoading());

    try {
      // 订阅群变化
      _groupsSubscription?.cancel();
      _groupsSubscription = _groupRepository.watchGroups().listen(
        (groups) {
          add(const GroupsUpdated());
        },
      );

      final groups = await _groupRepository.getGroups();
      final invites = await _groupRepository.getPendingGroupInvites();

      emit(GroupListLoaded(groups: groups, invites: invites));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onRefreshGroups(
    RefreshGroups event,
    Emitter<GroupState> emit,
  ) async {
    try {
      final groups = await _groupRepository.getGroups();
      final invites = await _groupRepository.getPendingGroupInvites();

      emit(GroupListLoaded(groups: groups, invites: invites));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onLoadGroupDetails(
    LoadGroupDetails event,
    Emitter<GroupState> emit,
  ) async {
    emit(const GroupLoading());

    try {
      final group = await _groupRepository.getGroup(event.roomId);
      if (group == null) {
        emit(const GroupError('群不存在'));
        return;
      }

      final members = await _groupRepository.getGroupMembers(event.roomId);

      emit(GroupDetailsLoaded(
        group: group,
        members: members,
      ));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onLoadGroupMembers(
    LoadGroupMembers event,
    Emitter<GroupState> emit,
  ) async {
    if (state is! GroupDetailsLoaded) return;

    final currentState = state as GroupDetailsLoaded;

    try {
      final members = await _groupRepository.getGroupMembers(event.roomId);
      emit(currentState.copyWith(members: members));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onCreateGroup(
    CreateGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(const GroupLoading());

    try {
      final roomId = await _groupRepository.createGroup(
        name: event.name,
        inviteUserIds: event.inviteUserIds,
        topic: event.topic,
        isPublic: event.isPublic,
        enableEncryption: event.enableEncryption,
        avatar: event.avatar,
      );

      emit(GroupCreated(roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onUpdateGroupName(
    UpdateGroupName event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setGroupName(event.roomId, event.name);
      emit(const GroupOperationSuccess('群名称已更新'));
      add(LoadGroupDetails(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onUpdateGroupTopic(
    UpdateGroupTopic event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setGroupTopic(event.roomId, event.topic);
      emit(const GroupOperationSuccess('群描述已更新'));
      add(LoadGroupDetails(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onUpdateGroupAvatar(
    UpdateGroupAvatar event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setGroupAvatar(event.roomId, event.avatar);
      emit(const GroupOperationSuccess('群头像已更新'));
      add(LoadGroupDetails(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.inviteUsers(event.roomId, event.userIds);
      emit(GroupOperationSuccess('已邀请 ${event.userIds.length} 人'));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onKickMember(
    KickMember event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.kickMember(
        event.roomId,
        event.userId,
        reason: event.reason,
      );
      emit(const GroupOperationSuccess('成员已移除'));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onSetAsAdmin(
    SetAsAdmin event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setAsAdmin(event.roomId, event.userId);
      emit(const GroupOperationSuccess('已设为管理员'));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onRemoveAdmin(
    RemoveAdmin event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.removeAdmin(event.roomId, event.userId);
      emit(const GroupOperationSuccess('已取消管理员'));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onLeaveGroup(
    LeaveGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.leaveGroup(event.roomId);
      emit(const GroupOperationSuccess('已退出群聊'));
      add(const RefreshGroups());
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onDeleteGroup(
    DeleteGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.deleteGroup(event.roomId);
      emit(const GroupOperationSuccess('群聊已解散'));
      add(const RefreshGroups());
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onLoadGroupInvites(
    LoadGroupInvites event,
    Emitter<GroupState> emit,
  ) async {
    if (state is! GroupListLoaded) return;

    final currentState = state as GroupListLoaded;

    try {
      final invites = await _groupRepository.getPendingGroupInvites();
      emit(currentState.copyWith(invites: invites));
    } catch (e) {
      // Ignore
    }
  }

  Future<void> _onAcceptGroupInvite(
    AcceptGroupInvite event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.acceptGroupInvite(event.roomId);
      emit(const GroupOperationSuccess('已加入群聊'));
      add(const RefreshGroups());
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onRejectGroupInvite(
    RejectGroupInvite event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.rejectGroupInvite(event.roomId);
      emit(const GroupOperationSuccess('已拒绝邀请'));
      add(const LoadGroupInvites());
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onGroupsUpdated(
    GroupsUpdated event,
    Emitter<GroupState> emit,
  ) async {
    add(const RefreshGroups());
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    return super.close();
  }
}

