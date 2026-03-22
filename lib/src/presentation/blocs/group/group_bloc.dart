import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';
import '../bloc_message_keys.dart';
import 'group_event.dart';
import 'group_state.dart';
import '../../../core/utils/debug_log.dart';

/// 群聊BLoC
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final IGroupRepository _groupRepository;

  StreamSubscription<List<GroupEntity>>? _groupsSubscription;
  final Map<String, StreamSubscription<String>> _memberJoinSubscriptions = {};

  GroupBloc(this._groupRepository) : super(const GroupState.initial()) {
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
    on<SetMaxMembers>(_onSetMaxMembers);
    on<SetContentFilter>(_onSetContentFilter);
    on<SetBotConfig>(_onSetBotConfig);
    on<LoadChannels>(_onLoadChannels);
    on<CreateChannel>(_onCreateChannel);
    on<UpdateChannel>(_onUpdateChannel);
    on<DeleteChannel>(_onDeleteChannel);
    on<SubscribeToMemberJoins>(_onSubscribeToMemberJoins);
    on<MemberJoined>(_onMemberJoined);
  }

  Future<void> _onLoadGroups(
    LoadGroups event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(status: GroupStatus.loading));

    try {
      // 订阅群变化
      unawaited(_groupsSubscription?.cancel());
      _groupsSubscription = _groupRepository.watchGroups().listen(
        (groups) {
          add(const GroupsUpdated());
        },
      );

      final groups = await _groupRepository.getGroups();
      final invites = await _groupRepository.getPendingGroupInvites();

      emit(state.copyWith(
        status: GroupStatus.loaded,
        groups: groups,
        invites: invites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshGroups(
    RefreshGroups event,
    Emitter<GroupState> emit,
  ) async {
    try {
      final groups = await _groupRepository.getGroups();
      final invites = await _groupRepository.getPendingGroupInvites();

      emit(state.copyWith(
        status: GroupStatus.loaded,
        groups: groups,
        invites: invites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadGroupDetails(
    LoadGroupDetails event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(status: GroupStatus.loading));

    try {
      final group = await _groupRepository.getGroup(event.roomId);
      if (group == null) {
        emit(state.copyWith(
          status: GroupStatus.error,
          errorMessage: BlocMessageKeys.groupNotFound,
        ));
        return;
      }

      final members = await _groupRepository.getGroupMembers(event.roomId);

      emit(state.copyWith(
        status: GroupStatus.loaded,
        currentGroup: group,
        members: members,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadGroupMembers(
    LoadGroupMembers event,
    Emitter<GroupState> emit,
  ) async {
    try {
      final members = await _groupRepository.getGroupMembers(event.roomId);
      emit(state.copyWith(members: members));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateGroup(
    CreateGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(status: GroupStatus.loading));

    try {
      final roomId = await _groupRepository.createGroup(
        name: event.name,
        inviteUserIds: event.inviteUserIds,
        topic: event.topic,
        isPublic: event.isPublic,
        enableEncryption: event.enableEncryption,
        avatar: event.avatar,
      );

      emit(state.copyWith(
        status: GroupStatus.created,
        createdRoomId: roomId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
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
    try {
      await operation();
      final group = await _groupRepository.getGroup(roomId);
      if (group != null) {
        final members = await _groupRepository.getGroupMembers(roomId);
        emit(state.copyWith(
          currentGroup: group,
          members: members,
        ));
      }
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: successMessage,
      ));
    } catch (e) {
      // Extract clean error message without "Exception:" prefix
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onUpdateGroupName(UpdateGroupName event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupName(event.roomId, event.name),
        successMessage: BlocMessageKeys.groupNameUpdated,
        errorPrefix: 'Failed to update group name',
        emit: emit,
      );

  Future<void> _onUpdateGroupTopic(UpdateGroupTopic event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupTopic(event.roomId, event.topic),
        successMessage: BlocMessageKeys.groupDescriptionUpdated,
        errorPrefix: 'Failed to update group description',
        emit: emit,
      );

  Future<void> _onUpdateGroupAvatar(UpdateGroupAvatar event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setGroupAvatar(event.roomId, event.avatar),
        successMessage: BlocMessageKeys.groupAvatarUpdated,
        errorPrefix: 'Failed to update group avatar',
        emit: emit,
      );

  Future<void> _onLoadChannels(LoadChannels event, Emitter<GroupState> emit) async {
    try {
      final channels = await _groupRepository.getChannels(event.roomId);
      emit(state.copyWith(channels: channels));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateChannel(CreateChannel event, Emitter<GroupState> emit) async {
    try {
      await _groupRepository.createChannel(
        event.parentRoomId,
        name: event.name,
        topic: event.topic,
      );
      final channels = await _groupRepository.getChannels(event.parentRoomId);
      emit(state.copyWith(
        channels: channels,
        status: GroupStatus.success,
        successMessage: 'Channel created',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateChannel(UpdateChannel event, Emitter<GroupState> emit) async {
    try {
      await _groupRepository.updateChannel(
        event.parentRoomId,
        event.channelRoomId,
        name: event.name,
        topic: event.topic,
      );
      final channels = await _groupRepository.getChannels(event.parentRoomId);
      emit(state.copyWith(channels: channels, status: GroupStatus.success, successMessage: 'Channel updated'));
    } catch (e) {
      emit(state.copyWith(status: GroupStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDeleteChannel(DeleteChannel event, Emitter<GroupState> emit) async {
    try {
      await _groupRepository.deleteChannel(event.parentRoomId, event.channelRoomId);
      final channels = await _groupRepository.getChannels(event.parentRoomId);
      emit(state.copyWith(channels: channels, status: GroupStatus.success, successMessage: 'Channel deleted'));
    } catch (e) {
      emit(state.copyWith(status: GroupStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSetBotConfig(SetBotConfig event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setBotConfig(event.roomId, event.config),
        successMessage: BlocMessageKeys.groupBotConfigUpdated,
        errorPrefix: 'Failed to update bot config',
        emit: emit,
      );

  Future<void> _onSetContentFilter(SetContentFilter event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setContentFilter(event.roomId, event.config),
        successMessage: BlocMessageKeys.groupContentFilterUpdated,
        errorPrefix: 'Failed to update content filter',
        emit: emit,
      );

  Future<void> _onSetMaxMembers(SetMaxMembers event, Emitter<GroupState> emit) =>
      _updateGroupProperty(
        roomId: event.roomId,
        operation: () => _groupRepository.setMaxMembers(event.roomId, event.maxMembers),
        successMessage: BlocMessageKeys.groupMaxMembersUpdated,
        errorPrefix: 'Failed to update max members',
        emit: emit,
      );

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<GroupState> emit,
  ) async {
    // 检查群人数上限
    final group = state.currentGroup;
    if (group != null && group.isFull) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: BlocMessageKeys.groupFull,
      ));
      return;
    }

    try {
      await _groupRepository.inviteUsers(event.roomId, event.userIds);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: '${BlocMessageKeys.groupMembersInvited}:${event.userIds.length}',
      ));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
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
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupMemberRemoved,
      ));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSetAsAdmin(
    SetAsAdmin event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.setAsAdmin(event.roomId, event.userId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupSetAsAdmin,
      ));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveAdmin(
    RemoveAdmin event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.removeAdmin(event.roomId, event.userId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupAdminRemoved,
      ));
      add(LoadGroupMembers(event.roomId));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLeaveGroup(
    LeaveGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.leaveGroup(event.roomId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupLeft,
      ));
      add(const RefreshGroups());
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteGroup(
    DeleteGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.deleteGroup(event.roomId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupDisbanded,
      ));
      add(const RefreshGroups());
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadGroupInvites(
    LoadGroupInvites event,
    Emitter<GroupState> emit,
  ) async {
    try {
      final invites = await _groupRepository.getPendingGroupInvites();
      emit(state.copyWith(invites: invites));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
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
          emit(state.copyWith(
            status: GroupStatus.tokenGateVerified,
            tokenGateRoomId: event.roomId,
            tokenGateResult: result,
          ));
          return;
        }
      }

      await _groupRepository.acceptGroupInvite(event.roomId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupJoined,
      ));
      add(const RefreshGroups());
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRejectGroupInvite(
    RejectGroupInvite event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await _groupRepository.rejectGroupInvite(event.roomId);
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupInviteDeclined,
      ));
      add(const LoadGroupInvites());
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
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
      emit(state.copyWith(
        status: GroupStatus.success,
        successMessage: BlocMessageKeys.groupTokenGateUpdated,
      ));
      add(LoadGroupDetails(event.roomId));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onVerifyTokenGate(
    VerifyTokenGate event,
    Emitter<GroupState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GroupStatus.loading));
      final result = await _groupRepository.verifyTokenGate(event.roomId);
      emit(state.copyWith(
        status: GroupStatus.tokenGateVerified,
        tokenGateRoomId: event.roomId,
        tokenGateResult: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroupStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSubscribeToMemberJoins(
    SubscribeToMemberJoins event,
    Emitter<GroupState> emit,
  ) async {
    // 移除并取消已有订阅
    final oldSub = _memberJoinSubscriptions.remove(event.roomId);
    await oldSub?.cancel();

    // 检查是否有 Bot 配置且启用了欢迎消息
    final botConfig = await _groupRepository.getBotConfig(event.roomId);
    if (botConfig == null || !botConfig.enabled || botConfig.welcomeMessage == null) {
      return;
    }

    // 订阅成员加入事件
    _memberJoinSubscriptions[event.roomId] =
        _groupRepository.watchMemberJoinEvents(event.roomId).listen(
      (userId) => add(MemberJoined(event.roomId, userId)),
      onError: (Object e) {
        debugLog('GroupBloc: Member join stream error: $e');
        _memberJoinSubscriptions.remove(event.roomId);
      },
      onDone: () => _memberJoinSubscriptions.remove(event.roomId),
    );
  }

  Future<void> _onMemberJoined(
    MemberJoined event,
    Emitter<GroupState> emit,
  ) async {
    try {
      final botConfig = await _groupRepository.getBotConfig(event.roomId);
      if (botConfig == null || !botConfig.enabled || botConfig.welcomeMessage == null) {
        return;
      }

      // 获取成员信息以替换 {name} 占位符
      final members = await _groupRepository.getGroupMembers(event.roomId);
      final member = members.where((m) => m.userId == event.userId).firstOrNull;
      final memberName = member?.displayName ?? event.userId.split(':').first.replaceFirst('@', '');

      // 替换占位符
      final message = botConfig.welcomeMessage!.replaceAll('{name}', memberName);

      // 发送 notice 消息
      await _groupRepository.sendBotNotice(event.roomId, message);
      debugLog('GroupBloc: Sent welcome message to ${event.userId} in ${event.roomId}');
    } catch (e) {
      debugLog('GroupBloc: Failed to send welcome message: $e');
    }
  }

  @override
  Future<void> close() async {
    try { await _groupsSubscription?.cancel(); } catch (_) {}
    for (final sub in _memberJoinSubscriptions.values) {
      try { await sub.cancel(); } catch (_) {}
    }
    _memberJoinSubscriptions.clear();
    return super.close();
  }
}
