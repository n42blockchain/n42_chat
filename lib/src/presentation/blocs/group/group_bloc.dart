import 'package:flutter/foundation.dart';
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
    on<SetTokenGate>(_onSetTokenGate);
    on<VerifyTokenGate>(_onVerifyTokenGate);
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
        emit(const GroupError('Group not found'));
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

  /// Helper for group update operations with state preservation
  Future<void> _updateGroupProperty({
    required String roomId,
    required Future<void> Function() operation,
    required String successMessage,
    required String errorPrefix,
    required Emitter<GroupState> emit,
  }) async {
    final currentState = state;
    try {
      await operation();
      final group = await _groupRepository.getGroup(roomId);
      if (group != null) {
        final members = await _groupRepository.getGroupMembers(roomId);
        emit(GroupDetailsLoaded(group: group, members: members));
      }
      emit(GroupOperationSuccess(successMessage));
    } catch (e) {
      if (currentState is GroupDetailsLoaded) emit(currentState);
      // Extract clean error message without "Exception:" prefix
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      emit(GroupError(errorMessage));
    }
  }

  Future<void> _onUpdateGroupName(UpdateGroupName event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupName(event.roomId, event.name),
        successMessage: 'Group name updated',
        errorPrefix: 'Failed to update group name',
        emit: emit,
      );

  Future<void> _onUpdateGroupTopic(UpdateGroupTopic event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupTopic(event.roomId, event.topic),
        successMessage: 'Group description updated',
        errorPrefix: 'Failed to update group description',
        emit: emit,
      );

  Future<void> _onUpdateGroupAvatar(UpdateGroupAvatar event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupAvatar(event.roomId, event.avatar),
        successMessage: 'Group avatar updated',
        errorPrefix: 'Failed to update group avatar',
        emit: emit,
      );

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.inviteUsers(event.roomId, event.userIds);
      emit(GroupOperationSuccess('Invited ${event.userIds.length} member(s)'));
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
      emit(const GroupOperationSuccess('Member removed'));
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
      emit(const GroupOperationSuccess('Set as admin'));
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
      emit(const GroupOperationSuccess('Admin removed'));
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
      emit(const GroupOperationSuccess('Left the group'));
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
      emit(const GroupOperationSuccess('Group disbanded'));
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
      debugPrint('Error: $e');
    }
  }

  Future<void> _onAcceptGroupInvite(
    AcceptGroupInvite event,
    Emitter<GroupState> emit,
  ) async {
    try {
      // Check token gate before accepting invite
      final tokenGate = await _groupRepository.getTokenGate(event.roomId);
      if (tokenGate != null && tokenGate.enabled && tokenGate.rules.isNotEmpty) {
        final result = await _groupRepository.verifyTokenGate(event.roomId);
        if (!result.passed) {
          emit(TokenGateVerified(roomId: event.roomId, result: result));
          return;
        }
      }

      await _groupRepository.acceptGroupInvite(event.roomId);
      emit(const GroupOperationSuccess('Joined the group'));
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
      emit(const GroupOperationSuccess('Invitation declined'));
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

  Future<void> _onSetTokenGate(
    SetTokenGate event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setTokenGate(event.roomId, event.config);
      emit(const GroupOperationSuccess('Token gate updated'));
      add(LoadGroupDetails(event.roomId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onVerifyTokenGate(
    VerifyTokenGate event,
    Emitter<GroupState> emit,
  ) async {
    try {
      emit(const GroupLoading());
      final result = await _groupRepository.verifyTokenGate(event.roomId);
      emit(TokenGateVerified(roomId: event.roomId, result: result));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    return super.close();
  }
}

