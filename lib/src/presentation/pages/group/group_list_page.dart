import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 群聊列表页面
class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(const LoadGroups());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.groupChat ?? 'Group Chat',
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: () => _navigateToCreateGroup(),
          ),
        ],
      ),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is GroupOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is GroupLoading) {
            return const N42Loading();
          }

          if (state is GroupListLoaded) {
            return _buildGroupList(state, isDark);
          }

          return N42EmptyState(
            icon: Icons.group_outlined,
            title: S.of(context)?.noGroups ?? 'No groups',
            description: S.of(context)?.createGroupToChat ?? 'Create a group to start chatting',
          );
        },
      ),
    );
  }

  Widget _buildGroupList(GroupListLoaded state, bool isDark) {
    if (state.groups.isEmpty && state.invites.isEmpty) {
      return Center(
        child: N42EmptyState(
          icon: Icons.group_outlined,
          title: S.of(context)?.noGroups ?? 'No groups',
          description: S.of(context)?.createGroupToChat ?? 'Create a group to start chatting',
          buttonText: S.of(context)?.createGroup ?? 'Create Group',
          onButtonPressed: () => _navigateToCreateGroup(),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupBloc>().add(const RefreshGroups());
      },
      child: ListView(
        children: [
          // 群邀请
          if (state.invites.isNotEmpty) ...[
            _buildSectionHeader(S.of(context)?.groupInvites ?? 'Group Invites', isDark),
            ...state.invites.map((invite) => _buildInviteTile(invite, isDark)),
          ],

          // 我的群聊
          if (state.groups.isNotEmpty) ...[
            _buildSectionHeader(S.of(context)?.myGroups(state.groups.length) ?? 'My Groups (${state.groups.length})', isDark),
            ...state.groups.map((group) => _buildGroupTile(group, isDark)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isDark ? AppColors.backgroundDark : AppColors.background,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildGroupTile(GroupEntity group, bool isDark) {
    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListTile(
        leading: N42Avatar(
          imageUrl: group.avatarUrl,
          name: group.name,
          size: 48,
        ),
        title: Text(
          group.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          S.of(context)?.memberCount(group.memberCount) ?? '${group.memberCount} members',
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
        trailing: group.isEncrypted
            ? Icon(
                Icons.lock,
                size: 16,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              )
            : null,
        onTap: () => _navigateToChat(group.roomId),
        onLongPress: () => _showGroupOptions(group),
      ),
    );
  }

  Widget _buildInviteTile(GroupEntity group, bool isDark) {
    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListTile(
        leading: N42Avatar(
          imageUrl: group.avatarUrl,
          name: group.name,
          size: 48,
        ),
        title: Text(
          group.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          S.of(context)?.invitedToJoinGroup ?? 'Invited to join group',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                context.read<GroupBloc>().add(RejectGroupInvite(group.roomId));
              },
              child: Text(S.of(context)?.reject ?? 'Reject'),
            ),
            TextButton(
              onPressed: () {
                context.read<GroupBloc>().add(AcceptGroupInvite(group.roomId));
              },
              child: Text(S.of(context)?.accept ?? 'Accept'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateGroup() async {
    final roomId = await Navigator.of(context).pushNamed('/group/create');
    if (roomId != null && roomId is String) {
      _navigateToChat(roomId);
    }
  }

  void _navigateToChat(String roomId) {
    Navigator.of(context).pushNamed('/chat/$roomId');
  }

  void _showGroupOptions(GroupEntity group) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(S.of(context)?.groupProfile ?? 'Group Info'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(this.context).pushNamed('/group/settings/${group.roomId}');
              },
            ),
            if (group.isOwner)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(S.of(context)?.dissolveGroup ?? 'Dissolve Group', style: const TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteGroup(group);
                },
              )
            else
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: Text(S.of(context)?.leaveGroup ?? 'Leave Group', style: const TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmLeaveGroup(group);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _confirmLeaveGroup(GroupEntity group) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.leaveGroup ?? 'Leave Group'),
        content: Text(S.of(context)?.confirmLeaveGroup(group.name) ?? 'Are you sure you want to leave "${group.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              this.context.read<GroupBloc>().add(LeaveGroup(group.roomId));
            },
            child: Text(S.of(context)?.leave ?? 'Leave', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteGroup(GroupEntity group) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.dissolveGroup ?? 'Dissolve Group'),
        content: Text(S.of(context)?.confirmDissolveGroup(group.name) ?? 'Are you sure you want to dissolve "${group.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              this.context.read<GroupBloc>().add(DeleteGroup(group.roomId));
            },
            child: Text(S.of(context)?.dissolve ?? 'Dissolve', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

