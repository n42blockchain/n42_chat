import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 群设置页面
class GroupSettingsPage extends StatefulWidget {
  final String roomId;
  final VoidCallback? onClearHistory;

  const GroupSettingsPage({
    super.key,
    required this.roomId,
    this.onClearHistory,
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
    final isDark = context.isDarkMode;

    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is GroupOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GroupLoading) {
          return Scaffold(
            appBar: N42AppBar(title: S.of(context)?.groupProfile ?? 'Group Info'),
            body: const N42Loading(),
          );
        }

        if (state is! GroupDetailsLoaded) {
          return Scaffold(
            appBar: N42AppBar(title: S.of(context)?.groupProfile ?? 'Group Info'),
            body: N42EmptyState(
              icon: Icons.error_outline,
              title: S.of(context)?.loadFailed ?? 'Load failed',
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
        title: S.of(context)?.groupProfile ?? 'Group Info',
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
                  onTap: () {
                    debugPrint('Group name tapped: canChangeSettings=${group.canChangeSettings}, myRole=${group.myRole}');
                    if (group.canChangeSettings) {
                      _editGroupName(group);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context)?.noPermissionToEditGroupName ?? 'You do not have permission to edit group name'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
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
                      const SizedBox(width: 4),
                      Icon(
                        group.canChangeSettings ? Icons.edit : Icons.lock_outline,
                        size: 16,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: group.roomId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context)?.groupIdCopied ?? 'Group ID copied')),
                    );
                  },
                  child: Text(
                    S.of(context)?.memberCountClickToCopy(group.memberCount) ?? '${group.memberCount} members - Click to copy group ID',
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
                S.of(context)?.groupMembers(group.memberCount) ?? 'Group Members (${group.memberCount})',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => _navigateToMemberList(group),
                child: Text(S.of(context)?.viewAll ?? 'View All'),
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
                    child: Text(
                      S.of(context)?.owner ?? 'Owner',
                      style: const TextStyle(
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
                    child: Text(
                      S.of(context)?.admin ?? 'Admin',
                      style: const TextStyle(
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
          SizedBox(
            width: 50,
            child: Text(
              S.of(context)?.invite ?? 'Invite',
              style: const TextStyle(fontSize: 11),
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
            title: Text(S.of(context)?.groupAnnouncement ?? 'Group Announcement'),
            subtitle: Text(
              group.announcement?.isNotEmpty == true
                  ? group.announcement!
                  : S.of(context)?.notSet ?? 'Not set',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editAnnouncement(group),
          ),

          Divider(height: 1, indent: 16, color: isDark ? AppColors.dividerDark : AppColors.divider),

          // 群描述
          ListTile(
            title: Text(S.of(context)?.groupDescription ?? 'Group Description'),
            subtitle: Text(
              group.topic?.isNotEmpty == true ? group.topic! : S.of(context)?.notSet ?? 'Not set',
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
              title: Text(S.of(context)?.publicGroup ?? 'Public Group'),
              subtitle: Text(S.of(context)?.allowOthersToSearchAndJoin ?? 'Allow others to search and join'),
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
            title: Text(S.of(context)?.clearChatHistory ?? 'Clear Chat History'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _clearChatHistory(),
          ),

          Divider(height: 1, indent: 16, color: isDark ? AppColors.dividerDark : AppColors.divider),

          // 退出/解散群聊
          ListTile(
            title: Text(
              group.isOwner ? (S.of(context)?.dissolveGroup ?? 'Dissolve Group') : (S.of(context)?.leaveGroup ?? 'Leave Group'),
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
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.changeGroupName ?? 'Change Group Name'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: S.of(context)?.enterGroupName ?? 'Enter group name',
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                Navigator.pop(dialogContext);
                this.context.read<GroupBloc>().add(UpdateGroupName(widget.roomId, name));
              }
            },
            child: Text(S.of(context)?.confirm ?? 'OK'),
          ),
        ],
      ),
    );
  }

  void _editTopic(GroupEntity group) {
    final controller = TextEditingController(text: group.topic);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.editGroupDescription ?? 'Edit Group Description'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: S.of(context)?.enterGroupDescription ?? 'Enter group description',
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              this.context.read<GroupBloc>().add(
                    UpdateGroupTopic(widget.roomId, controller.text.trim()),
                  );
            },
            child: Text(S.of(context)?.confirm ?? 'OK'),
          ),
        ],
      ),
    );
  }

  void _editAnnouncement(GroupEntity group) {
    final controller = TextEditingController(text: group.announcement);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.editGroupAnnouncement ?? 'Edit Group Announcement'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: S.of(context)?.enterGroupAnnouncement ?? 'Enter group announcement',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // 群公告使用 topic 实现
              this.context.read<GroupBloc>().add(
                    UpdateGroupTopic(widget.roomId, controller.text.trim()),
                  );
            },
            child: Text(S.of(context)?.publish ?? 'Publish'),
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
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.clearChatHistory ?? 'Clear Chat History'),
        content: Text(S.of(context)?.confirmClearChatHistory ?? 'Are you sure you want to clear chat history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onClearHistory?.call();
              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(content: Text(S.of(context)?.chatHistoryCleared ?? 'Chat history cleared')),
              );
            },
            child: Text(S.of(context)?.clear ?? 'Clear', style: const TextStyle(color: Colors.red)),
          ),
        ],
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
              this.context.read<GroupBloc>().add(LeaveGroup(widget.roomId));
              Navigator.of(this.context).pop();
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
              this.context.read<GroupBloc>().add(DeleteGroup(widget.roomId));
              Navigator.of(this.context).pop();
            },
            child: Text(S.of(context)?.dissolve ?? 'Dissolve', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(GroupEntity group) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: Text(S.of(context)?.groupQrCode ?? 'Group QR Code'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.featureInDevelopment('') ?? 'Feature in development')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(S.of(context)?.searchChatHistory ?? 'Search Chat History'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.featureInDevelopment('') ?? 'Feature in development')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

