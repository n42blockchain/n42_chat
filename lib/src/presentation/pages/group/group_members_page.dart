import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 群成员管理页面
class GroupMembersPage extends StatefulWidget {
  final String roomId;

  const GroupMembersPage({
    super.key,
    required this.roomId,
  });

  @override
  State<GroupMembersPage> createState() => _GroupMembersPageState();
}

class _GroupMembersPageState extends State<GroupMembersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(LoadGroupDetails(widget.roomId));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '群成员',
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

          if (state is! GroupDetailsLoaded) {
            return const N42EmptyState(
              icon: Icons.error_outline,
              title: '加载失败',
            );
          }

          return _buildBody(state, isDark);
        },
      ),
    );
  }

  Widget _buildBody(GroupDetailsLoaded state, bool isDark) {
    final group = state.group;
    var members = state.members;

    // 搜索过滤
    if (_searchQuery.isNotEmpty) {
      members = members
          .where((m) =>
              m.displayName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              m.userId.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // 排序：群主 > 管理员 > 普通成员
    members.sort((a, b) {
      if (a.isOwner) return -1;
      if (b.isOwner) return 1;
      if (a.isAdmin && !b.isAdmin) return -1;
      if (b.isAdmin && !a.isAdmin) return 1;
      return a.displayName.compareTo(b.displayName);
    });

    return Column(
      children: [
        // 搜索栏
        Container(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          padding: const EdgeInsets.all(12),
          child: N42SearchBar(
            controller: _searchController,
            hintText: '搜索成员',
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),

        // 成员数量
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            '共 ${state.group.memberCount} 位成员',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ),

        // 成员列表
        Expanded(
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return _buildMemberTile(member, group, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMemberTile(GroupMember member, GroupEntity group, bool isDark) {
    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListTile(
        leading: N42Avatar(
          imageUrl: member.avatarUrl,
          name: member.displayName,
          size: 44,
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                member.displayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (member.isOwner) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '群主',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ] else if (member.isAdmin) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '管理员',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          member.userId,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
        onTap: () => _showMemberOptions(member, group),
      ),
    );
  }

  void _showMemberOptions(GroupMember member, GroupEntity group) {
    final canManage = group.canKick && !member.isOwner;
    final canSetAdmin = group.isOwner && !member.isOwner;

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 查看资料
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('查看资料'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(this.context).pushNamed('/profile/${member.userId}');
              },
            ),

            // 发送消息
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('发送消息'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 创建私聊
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('功能开发中...')),
                );
              },
            ),

            // 设置/取消管理员
            if (canSetAdmin)
              ListTile(
                leading: Icon(
                  member.isAdmin ? Icons.remove_moderator : Icons.add_moderator,
                ),
                title: Text(member.isAdmin ? '取消管理员' : '设为管理员'),
                onTap: () {
                  Navigator.pop(context);
                  if (member.isAdmin) {
                    this.context.read<GroupBloc>().add(
                          RemoveAdmin(widget.roomId, member.userId),
                        );
                  } else {
                    this.context.read<GroupBloc>().add(
                          SetAsAdmin(widget.roomId, member.userId),
                        );
                  }
                },
              ),

            // 移出群聊
            if (canManage)
              ListTile(
                leading: const Icon(Icons.person_remove, color: Colors.red),
                title: const Text('移出群聊', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmKickMember(member);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _confirmKickMember(GroupMember member) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('移出成员'),
        content: Text('确定要将「${member.displayName}」移出群聊吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              this.context.read<GroupBloc>().add(
                    KickMember(widget.roomId, member.userId),
                  );
            },
            child: const Text('移出', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

