import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '群聊',
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

          return const N42EmptyState(
            icon: Icons.group_outlined,
            title: '暂无群聊',
            description: '创建一个群聊开始聊天吧',
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
          title: '暂无群聊',
          description: '创建一个群聊开始聊天吧',
          buttonText: '发起群聊',
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
            _buildSectionHeader('群邀请', isDark),
            ...state.invites.map((invite) => _buildInviteTile(invite, isDark)),
          ],

          // 我的群聊
          if (state.groups.isNotEmpty) ...[
            _buildSectionHeader('我的群聊 (${state.groups.length})', isDark),
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
          '${group.memberCount} 人',
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
          '邀请你加入群聊',
          style: TextStyle(
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
              child: const Text('拒绝'),
            ),
            TextButton(
              onPressed: () {
                context.read<GroupBloc>().add(AcceptGroupInvite(group.roomId));
              },
              child: const Text('接受'),
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
              title: const Text('群资料'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(this.context).pushNamed('/group/settings/${group.roomId}');
              },
            ),
            if (group.isOwner)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('解散群聊', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteGroup(group);
                },
              )
            else
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('退出群聊', style: TextStyle(color: Colors.red)),
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
      builder: (context) => AlertDialog(
        title: const Text('退出群聊'),
        content: Text('确定要退出「${group.name}」吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              this.context.read<GroupBloc>().add(LeaveGroup(group.roomId));
            },
            child: const Text('退出', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteGroup(GroupEntity group) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('解散群聊'),
        content: Text('确定要解散「${group.name}」吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              this.context.read<GroupBloc>().add(DeleteGroup(group.roomId));
            },
            child: const Text('解散', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

