import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/remark_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/n42_avatar.dart';
import '../contact/contact_detail_page.dart';

/// 聊天详情页面（仿微信）
class ChatDetailPage extends StatefulWidget {
  /// 会话信息
  final ConversationEntity conversation;

  /// 是否可以踢人（群主/管理员）
  final bool canKickMembers;

  /// 是否可以修改群设置（群名称等）
  final bool canChangeSettings;

  /// 添加成员到群的回调
  final VoidCallback? onAddMember;

  /// 移除成员的回调
  final void Function(String userId)? onRemoveMember;

  /// 点击成员头像的回调（返回true表示是好友，可以直接聊天）
  final void Function(String userId, String displayName, String? avatarUrl)? onMemberTap;

  /// 清空聊天记录的回调
  final VoidCallback? onClearHistory;

  const ChatDetailPage({
    super.key,
    required this.conversation,
    this.canKickMembers = false,
    this.canChangeSettings = false,
    this.onAddMember,
    this.onRemoveMember,
    this.onMemberTap,
    this.onClearHistory,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  bool _isPinned = false;
  bool _isMuted = false;
  bool _isStrongReminder = false;

  // 群名称（可编辑）
  late String _groupName;

  // 备注更新订阅
  StreamSubscription<RemarkUpdateEvent>? _remarkSubscription;

  @override
  void initState() {
    super.initState();
    _isPinned = widget.conversation.isPinned;
    _isMuted = widget.conversation.isMuted;
    _groupName = widget.conversation.name;

    // 加载强提醒状态
    _loadStrongReminderStatus();

    // 监听备注更新
    _remarkSubscription = RemarkService.instance.onRemarkUpdated.listen((event) {
      final targetUserId = widget.conversation.directUserId;
      if (targetUserId != null && event.userId == targetUserId && mounted) {
        debugPrint('ChatDetailPage: Remark updated for $targetUserId, refreshing UI');
        setState(() {});
      }
    });
  }

  /// 加载强提醒状态
  Future<void> _loadStrongReminderStatus() async {
    try {
      final repository = getIt<IConversationRepository>();
      final isStrongReminder = await repository.getStrongReminder(widget.conversation.id);
      if (mounted) {
        setState(() {
          _isStrongReminder = isStrongReminder;
        });
      }
    } catch (e) {
      debugPrint('ChatDetailPage: Failed to load strong reminder status: $e');
    }
  }
  
  @override
  void dispose() {
    _remarkSubscription?.cancel();
    super.dispose();
  }
  
  /// 获取对方用户ID
  String? _getOtherUserId() {
    return widget.conversation.directUserId;
  }
  
  /// 获取显示名称（私聊时优先使用备注名）
  String _getDisplayName() {
    // 群聊直接使用会话名称
    if (widget.conversation.type == ConversationType.group) {
      return widget.conversation.name;
    }

    // 私聊：直接使用 conversation.directUserId 获取备注名
    final otherUserId = widget.conversation.directUserId;
    if (otherUserId != null) {
      return RemarkService.instance.getDisplayName(otherUserId, widget.conversation.name);
    }

    return widget.conversation.name;
  }

  /// 更新免打扰状态
  Future<void> _updateMuteStatus(bool muted) async {
    try {
      final repository = getIt<IConversationRepository>();
      await repository.setMuted(widget.conversation.id, muted);
      debugPrint('ChatDetailPage: Mute status updated to $muted');
    } catch (e) {
      debugPrint('ChatDetailPage: Failed to update mute status: $e');
      // 恢复原状态
      if (mounted) {
        setState(() {
          _isMuted = !muted;
        });
      }
    }
  }

  /// 更新置顶状态
  Future<void> _updatePinnedStatus(bool pinned) async {
    debugPrint('ChatDetailPage: _updatePinnedStatus called with pinned=$pinned, roomId=${widget.conversation.id}');
    try {
      final repository = getIt<IConversationRepository>();
      await repository.setPinned(widget.conversation.id, pinned);
      debugPrint('ChatDetailPage: Pin status updated successfully to $pinned');
    } catch (e) {
      debugPrint('ChatDetailPage: Failed to update pin status: $e');
      // 恢复原状态
      if (mounted) {
        setState(() {
          _isPinned = !pinned;
        });
      }
    }
  }

  /// 更新强提醒状态
  Future<void> _updateStrongReminderStatus(bool enabled) async {
    try {
      final repository = getIt<IConversationRepository>();
      await repository.setStrongReminder(widget.conversation.id, enabled);
      debugPrint('ChatDetailPage: Strong reminder status updated to $enabled');
    } catch (e) {
      debugPrint('ChatDetailPage: Failed to update strong reminder status: $e');
      // 恢复原状态
      if (mounted) {
        setState(() {
          _isStrongReminder = !enabled;
        });
      }
    }
  }

  /// 显示编辑群名称对话框
  Future<void> _showEditGroupNameDialog() async {
    // 检查权限
    if (!widget.canChangeSettings) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.noPermissionToModify ?? 'You do not have permission to modify'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final controller = TextEditingController(text: _groupName);
    final isDark = context.isDarkMode;

    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        title: Text(
          S.of(context)?.groupName ?? 'Group Name',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 50,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: S.of(context)?.enterGroupName ?? 'Enter group name',
            hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
            counterStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(S.of(context)?.save ?? 'Save'),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty && newName != _groupName) {
      await _updateGroupName(newName);
    }
  }

  /// 更新群名称
  Future<void> _updateGroupName(String newName) async {
    try {
      final groupRepository = getIt<IGroupRepository>();
      await groupRepository.setGroupName(widget.conversation.id, newName);

      if (mounted) {
        setState(() {
          _groupName = newName;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.groupNameUpdated ?? 'Group name updated'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('ChatDetailPage: Failed to update group name: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.updateFailed ?? 'Update failed'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? Colors.black : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;

    final isGroup = widget.conversation.type == ConversationType.group;
    
    // 检查 ContactBloc 是否可用
    bool hasContactBloc = false;
    try {
      context.read<ContactBloc>();
      hasContactBloc = true;
    } catch (e) {
      // ContactBloc 不可用
    }

    Widget scaffold = Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context)?.chatDetails ?? 'Chat Details',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 成员头像区域
            Container(
              color: cardColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      // 对方头像（私聊）或群成员头像（群聊）
                      if (!isGroup)
                        _buildMemberItem(
                          avatarUrl: widget.conversation.avatarUrl,
                          name: _getDisplayName(),
                          onTap: () => _openContactDetail(),
                        )
                      else ...[
                        // 群聊显示多个成员头像
                        ..._buildGroupMembers(),
                      ],
                      // 添加成员按钮
                      _buildAddButton(
                        icon: Icons.add,
                        onTap: () => _addMemberToGroup(),
                      ),
                      // 移除成员按钮（仅群主/管理员显示）
                      if (isGroup && widget.canKickMembers)
                        _buildAddButton(
                          icon: Icons.remove,
                          onTap: () => _removeMemberFromGroup(),
                        ),
                    ],
                  ),
                  if (isGroup) ...[
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _openGroupMemberList(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${S.of(context)?.viewAllGroupMembers ?? "View All Members"} ',
                            style: TextStyle(
                              fontSize: 13,
                              color: secondaryTextColor,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 设置选项
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                if (isGroup) ...[
                  _buildMenuItem(
                    title: S.of(context)?.groupName ?? 'Group Name',
                    value: _groupName,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: _showEditGroupNameDialog,
                  ),
                  _buildDivider(dividerColor),
                  _buildMenuItem(
                    title: S.of(context)?.groupAnnouncement ?? 'Group Announcement',
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () {},
                  ),
                  _buildDivider(dividerColor),
                  _buildMenuItem(
                    title: S.of(context)?.groupManagement ?? 'Group Management',
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () {},
                  ),
                  _buildDivider(dividerColor),
                  _buildMenuItem(
                    title: S.of(context)?.myNicknameInGroup ?? 'My Nickname in Group',
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () {},
                  ),
                  _buildDivider(dividerColor),
                ],
                _buildMenuItem(
                  title: S.of(context)?.searchChatHistory ?? 'Search Chat History',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 消息免打扰、置顶等开关
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildSwitchItem(
                  title: S.of(context)?.mute ?? 'Mute',
                  value: _isMuted,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isMuted = value;
                    });
                    // 持久化设置
                    _updateMuteStatus(value);
                  },
                ),
                _buildDivider(dividerColor),
                _buildSwitchItem(
                  title: S.of(context)?.pinChat ?? 'Pin Chat',
                  value: _isPinned,
                  textColor: textColor,
                  onChanged: (value) {
                    debugPrint('ChatDetailPage: Pin switch toggled to $value');
                    setState(() {
                      _isPinned = value;
                    });
                    // 持久化设置
                    _updatePinnedStatus(value);
                  },
                ),
                _buildDivider(dividerColor),
                _buildSwitchItem(
                  title: S.of(context)?.strongReminder ?? 'Strong Reminder',
                  value: _isStrongReminder,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isStrongReminder = value;
                    });
                    // 持久化强提醒设置
                    _updateStrongReminderStatus(value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 设置背景
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: S.of(context)?.setChatBackground ?? 'Set Chat Background',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 清空聊天记录
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: S.of(context)?.clearChatHistory ?? 'Clear Chat History',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _showClearConfirm(),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 投诉
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: S.of(context)?.report ?? 'Report',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
    
    // 如果有 ContactBloc，用 BlocListener 包装
    if (hasContactBloc) {
      return BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactRemarkUpdated || state is ContactLoaded) {
            if (mounted) setState(() {});
          }
        },
        child: scaffold,
      );
    }
    
    return scaffold;
  }

  Widget _buildMemberItem({
    required String? avatarUrl,
    required String name,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            N42Avatar(
              imageUrl: avatarUrl,
              name: name,
              size: 50,
              borderRadius: 6,
            ),
            const SizedBox(height: 4),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: context.isDarkMode
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGroupMembers() {
    final members = <Widget>[];
    final avatars = widget.conversation.memberAvatarUrls ?? [];
    final names = widget.conversation.memberNames ?? [];
    final ids = widget.conversation.memberIds ?? [];

    // 如果有踢人权限，显示 16 个头像（留空间给 +- 按钮）；否则显示 17 个（只有 + 按钮）
    final maxMembers = widget.canKickMembers ? 16 : 17;

    for (int i = 0; i < avatars.length && i < maxMembers; i++) {
      final memberId = ids.length > i ? ids[i] : '';
      final memberName = names.length > i ? names[i] : '';
      final memberAvatar = avatars[i];

      members.add(_buildMemberItem(
        avatarUrl: memberAvatar,
        name: memberName,
        onTap: () => _onMemberTap(memberId, memberName, memberAvatar),
      ));
    }

    return members;
  }

  /// 点击成员头像
  void _onMemberTap(String userId, String displayName, String? avatarUrl) {
    if (userId.isEmpty) return;

    // 如果提供了回调，使用回调
    if (widget.onMemberTap != null) {
      widget.onMemberTap!(userId, displayName, avatarUrl);
      return;
    }

    // 默认行为：打开联系人详情页
    _openMemberDetail(userId, displayName, avatarUrl);
  }

  /// 打开成员详情页
  void _openMemberDetail(String userId, String displayName, String? avatarUrl) {
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) {
          final page = ContactDetailPage(
            userId: userId,
            displayName: displayName,
            avatarUrl: avatarUrl,
            onSendMessage: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          );

          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    );
  }

  /// 打开群成员列表
  void _openGroupMemberList() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => _GroupMemberListPage(
          roomId: widget.conversation.id,
          roomName: widget.conversation.name,
          onMemberTap: (userId, displayName, avatarUrl) {
            _onMemberTap(userId, displayName, avatarUrl);
          },
        ),
      ),
    );
  }

  /// 添加成员到群
  void _addMemberToGroup() {
    if (widget.onAddMember != null) {
      widget.onAddMember!();
    } else {
      // TODO: 默认实现
      debugPrint('Add member to group');
    }
  }

  /// 从群中移除成员
  void _removeMemberFromGroup() {
    if (widget.onRemoveMember != null) {
      // 显示选择成员的对话框
      _showRemoveMemberDialog();
    } else {
      debugPrint('Remove member from group');
    }
  }

  /// 显示移除成员的对话框
  void _showRemoveMemberDialog() {
    final names = widget.conversation.memberNames ?? [];
    final ids = widget.conversation.memberIds ?? [];

    if (ids.isEmpty) return;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.removeFromGroup ?? 'Remove from Group'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: ids.length,
            itemBuilder: (context, index) {
              final name = names.length > index ? names[index] : ids[index];
              return ListTile(
                title: Text(name),
                onTap: () {
                  Navigator.of(ctx).pop();
                  widget.onRemoveMember?.call(ids[index]);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isDark = context.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Colors.white30 : Colors.black26,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: isDark ? Colors.white30 : Colors.black26,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            const Text(''),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection({
    required Color cardColor,
    required Color dividerColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(
          top: BorderSide(color: dividerColor, width: 0.5),
          bottom: BorderSide(color: dividerColor, width: 0.5),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    String? value,
    required Color textColor,
    required Color secondaryTextColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
            if (value != null)
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: secondaryTextColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required Color textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          debugPrint('ChatDetailPage: Switch row tapped for $title, current value: $value');
          onChanged(!value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: (newValue) {
                  debugPrint('ChatDetailPage: Switch widget toggled for $title to $newValue');
                  onChanged(newValue);
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(height: 0.5, thickness: 0.5, color: color),
    );
  }

  void _openContactDetail() {
    // 获取对方用户ID（私聊时需要真实的用户ID，而不是房间ID）
    final otherUserId = _getOtherUserId();
    if (otherUserId == null) {
      // 无法获取用户ID，使用房间ID作为后备
      debugPrint('ChatDetailPage: Cannot get other user ID, using room ID as fallback');
    }
    
    final userId = otherUserId ?? widget.conversation.id;
    
    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) {
          final page = ContactDetailPage(
            userId: userId,
            displayName: _getDisplayName(),
            avatarUrl: widget.conversation.avatarUrl,
            onSendMessage: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          );

          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    ).then((_) {
      // 返回时刷新显示名称
      if (mounted) setState(() {});
    });
  }

  void _showClearConfirm() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.clearChatHistoryTitle ?? 'Clear Chat History'),
        content: Text(S.of(context)?.clearHistoryConfirm ?? 'Are you sure you want to clear all chat history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              widget.onClearHistory?.call();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context)?.chatHistoryCleared ?? 'Chat history cleared'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Text(
              S.of(context)?.clearAction ?? 'Clear',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

/// 群成员列表页面
class _GroupMemberListPage extends StatefulWidget {
  final String roomId;
  final String roomName;
  final void Function(String userId, String displayName, String? avatarUrl)? onMemberTap;

  const _GroupMemberListPage({
    required this.roomId,
    required this.roomName,
    this.onMemberTap,
  });

  @override
  State<_GroupMemberListPage> createState() => _GroupMemberListPageState();
}

class _GroupMemberListPageState extends State<_GroupMemberListPage> {
  List<Map<String, dynamic>> _members = [];
  List<Map<String, dynamic>> _filteredMembers = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMembers() async {
    try {
      final groupRepository = getIt<IGroupRepository>();
      final members = await groupRepository.getGroupMembers(widget.roomId);

      if (mounted) {
        setState(() {
          _members = members.map((m) => {
            'id': m.userId,
            'name': m.displayName,
            'avatarUrl': m.avatarUrl,
            'role': m.role.name,
          }).toList();
          _filteredMembers = _members;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading members: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _filterMembers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMembers = _members;
      } else {
        _filteredMembers = _members.where((m) {
          final name = (m['name'] as String?)?.toLowerCase() ?? '';
          final id = (m['id'] as String?)?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) || id.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? Colors.black : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context)?.groupMembers(_members.length) ?? 'Members (${_members.length})',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 搜索框
          Container(
            color: cardColor,
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterMembers,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: S.of(context)?.searchMemberHint ?? 'Search members',
                hintStyle: TextStyle(color: secondaryTextColor),
                prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          // 成员列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredMembers.isEmpty
                    ? Center(
                        child: Text(
                          _searchQuery.isEmpty
                              ? (S.of(context)?.noMembers ?? 'No members')
                              : (S.of(context)?.noMatchingMembers ?? 'No matching members found'),
                          style: TextStyle(color: secondaryTextColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredMembers.length,
                        itemBuilder: (context, index) {
                          final member = _filteredMembers[index];
                          final name = member['name'] as String? ?? (S.of(context)?.unknownMember ?? 'Unknown');
                          final id = member['id'] as String? ?? '';
                          final avatarUrl = member['avatarUrl'] as String?;
                          final role = member['role'] as String?;

                          return ListTile(
                            leading: N42Avatar(
                              imageUrl: avatarUrl,
                              name: name,
                              size: 44,
                              borderRadius: 6,
                            ),
                            title: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (role == 'owner') ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      S.of(context)?.groupOwner ?? 'Owner',
                                      style: const TextStyle(fontSize: 10, color: Colors.orange),
                                    ),
                                  ),
                                ] else if (role == 'admin') ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      S.of(context)?.groupAdmin ?? 'Admin',
                                      style: const TextStyle(fontSize: 10, color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            onTap: () {
                              widget.onMemberTap?.call(id, name, avatarUrl);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
