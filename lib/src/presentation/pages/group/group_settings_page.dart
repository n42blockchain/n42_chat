import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 群设置页面
class GroupSettingsPage extends StatefulWidget {
  final String roomId;

  const GroupSettingsPage({
    super.key,
    required this.roomId,
  });

  @override
  State<GroupSettingsPage> createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(LoadGroupDetails(widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<GroupBloc, GroupState>(
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
          return Scaffold(
            appBar: N42AppBar(title: '群聊资料'),
            body: const N42Loading(),
          );
        }

        if (state is! GroupDetailsLoaded) {
          return Scaffold(
            appBar: N42AppBar(title: '群聊资料'),
            body: const N42EmptyState(
              icon: Icons.error_outline,
              title: '加载失败',
            ),
          );
        }

        return _buildBody(state, isDark);
      },
    );
  }

  Widget _buildBody(GroupDetailsLoaded state, bool isDark) {
    final group = state.group;
    final members = state.members;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '群聊资料',
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () => _showMoreOptions(group),
          ),
        ],
      ),
      body: ListView(
        children: [
          // 群基本信息
          _buildGroupHeader(group, isDark),

          const SizedBox(height: 10),

          // 成员列表预览
          _buildMembersSection(group, members, isDark),

          const SizedBox(height: 10),

          // 群设置
          _buildSettingsSection(group, isDark),

          const SizedBox(height: 10),

          // 操作按钮
          _buildActionSection(group, isDark),
        ],
      ),
    );
  }

  Widget _buildGroupHeader(GroupEntity group, bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 群头像
          GestureDetector(
            onTap: group.canChangeSettings ? () => _changeAvatar() : null,
            child: Stack(
              children: [
                N42Avatar(
                  imageUrl: group.avatarUrl,
                  name: group.name,
                  size: 64,
                ),
                if (group.canChangeSettings)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // 群名称和信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: group.canChangeSettings ? () => _editGroupName(group) : null,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          group.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (group.canChangeSettings) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.edit,
                          size: 16,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: group.roomId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('群ID已复制')),
                    );
                  },
                  child: Text(
                    '${group.memberCount}人 · 点击复制群ID',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection(
    GroupEntity group,
    List<GroupMember> members,
    bool isDark,
  ) {
    const maxShow = 8;
    final showMembers = members.take(maxShow).toList();

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '群成员 (${group.memberCount})',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => _navigateToMemberList(group),
                child: const Text('查看全部'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 成员头像列表
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ...showMembers.map((member) => _buildMemberItem(member)),
              if (group.canInvite) _buildAddMemberButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem(GroupMember member) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/profile/${member.userId}'),
      child: Column(
        children: [
          Stack(
            children: [
              N42Avatar(
                imageUrl: member.avatarUrl,
                name: member.displayName,
                size: 44,
              ),
              if (member.isOwner)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '群主',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              else if (member.isAdmin)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '管理',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 50,
            child: Text(
              member.displayName,
              style: const TextStyle(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberButton() {
    return GestureDetector(
      onTap: () => _inviteMembers(),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          const SizedBox(
            width: 50,
            child: Text(
              '邀请',
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(GroupEntity group, bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          // 群公告
          ListTile(
            title: const Text('群公告'),
            subtitle: Text(
              group.announcement?.isNotEmpty == true
                  ? group.announcement!
                  : '未设置',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editAnnouncement(group),
          ),

          Divider(height: 1, indent: 16, color: isDark ? AppColors.dividerDark : AppColors.divider),

          // 群描述
          ListTile(
            title: const Text('群简介'),
            subtitle: Text(
              group.topic?.isNotEmpty == true ? group.topic! : '未设置',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: group.canChangeSettings ? () => _editTopic(group) : null,
          ),

          if (group.canChangeSettings) ...[
            Divider(height: 1, indent: 16, color: isDark ? AppColors.dividerDark : AppColors.divider),

            // 群可见性
            SwitchListTile(
              title: const Text('公开群聊'),
              subtitle: const Text('允许其他人搜索并加入'),
              value: group.isPublic,
              onChanged: (value) {
                // TODO: 实现
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionSection(GroupEntity group, bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          // 清空聊天记录
          ListTile(
            title: const Text('清空聊天记录'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _clearChatHistory(),
          ),

          Divider(height: 1, indent: 16, color: isDark ? AppColors.dividerDark : AppColors.divider),

          // 退出/解散群聊
          ListTile(
            title: Text(
              group.isOwner ? '解散群聊' : '退出群聊',
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              if (group.isOwner) {
                _confirmDeleteGroup(group);
              } else {
                _confirmLeaveGroup(group);
              }
            },
          ),
        ],
      ),
    );
  }

  void _changeAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      context.read<GroupBloc>().add(UpdateGroupAvatar(widget.roomId, bytes));
    }
  }

  void _editGroupName(GroupEntity group) {
    final controller = TextEditingController(text: group.name);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改群名称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入群名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                Navigator.pop(context);
                this.context.read<GroupBloc>().add(UpdateGroupName(widget.roomId, name));
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _editTopic(GroupEntity group) {
    final controller = TextEditingController(text: group.topic);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改群简介'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入群简介',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              this.context.read<GroupBloc>().add(
                    UpdateGroupTopic(widget.roomId, controller.text.trim()),
                  );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _editAnnouncement(GroupEntity group) {
    final controller = TextEditingController(text: group.announcement);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑群公告'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入群公告',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // 群公告使用 topic 实现
              this.context.read<GroupBloc>().add(
                    UpdateGroupTopic(widget.roomId, controller.text.trim()),
                  );
            },
            child: const Text('发布'),
          ),
        ],
      ),
    );
  }

  void _navigateToMemberList(GroupEntity group) {
    Navigator.of(context).pushNamed('/group/members/${group.roomId}');
  }

  void _inviteMembers() {
    Navigator.of(context).pushNamed('/group/invite/${widget.roomId}');
  }

  void _clearChatHistory() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空聊天记录'),
        content: const Text('确定要清空聊天记录吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 实现清空聊天记录
              ScaffoldMessenger.of(this.context).showSnackBar(
                const SnackBar(content: Text('功能开发中...')),
              );
            },
            child: const Text('清空', style: TextStyle(color: Colors.red)),
          ),
        ],
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
              this.context.read<GroupBloc>().add(LeaveGroup(widget.roomId));
              Navigator.of(this.context).pop();
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
              this.context.read<GroupBloc>().add(DeleteGroup(widget.roomId));
              Navigator.of(this.context).pop();
            },
            child: const Text('解散', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(GroupEntity group) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('群二维码'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('功能开发中...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('查找聊天记录'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('功能开发中...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

