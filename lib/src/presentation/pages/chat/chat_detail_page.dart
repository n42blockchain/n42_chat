import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/services/remark_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/n42_avatar.dart';
import '../contact/contact_detail_page.dart';

/// 聊天详情页面（仿微信）
class ChatDetailPage extends StatefulWidget {
  /// 会话信息
  final ConversationEntity conversation;

  const ChatDetailPage({
    super.key,
    required this.conversation,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  bool _isPinned = false;
  bool _isMuted = false;
  bool _isStrongReminder = false;
  
  // 备注更新订阅
  StreamSubscription<RemarkUpdateEvent>? _remarkSubscription;
  
  // 缓存对方用户ID
  String? _cachedOtherUserId;

  @override
  void initState() {
    super.initState();
    _isPinned = widget.conversation.isPinned;
    _isMuted = widget.conversation.isMuted;
    
    // 使用 conversation.directUserId 初始化
    _cachedOtherUserId = widget.conversation.directUserId;
    
    // 监听备注更新
    _remarkSubscription = RemarkService.instance.onRemarkUpdated.listen((event) {
      final targetUserId = widget.conversation.directUserId;
      if (targetUserId != null && event.userId == targetUserId && mounted) {
        debugPrint('ChatDetailPage: Remark updated for $targetUserId, refreshing UI');
        setState(() {});
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                        onTap: () {},
                      ),
                      // 删除成员按钮（群聊时显示）
                      if (isGroup)
                        _buildAddButton(
                          icon: Icons.remove,
                          onTap: () {},
                        ),
                    ],
                  ),
                  if (isGroup) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          S.of(context)?.viewAllGroupMembers ?? 'View all members',
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryTextColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.conversation.memberCount ?? 0})',
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryTextColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: secondaryTextColor,
                        ),
                      ],
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
                    value: widget.conversation.name,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () {},
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
                  },
                ),
                _buildDivider(dividerColor),
                _buildSwitchItem(
                  title: S.of(context)?.pinChat ?? 'Pin Chat',
                  value: _isPinned,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isPinned = value;
                    });
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
                color: Theme.of(context).brightness == Brightness.dark
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

    for (int i = 0; i < avatars.length && i < 8; i++) {
      members.add(_buildMemberItem(
        avatarUrl: avatars[i],
        name: names.length > i ? names[i] : '',
        onTap: () {},
      ));
    }

    return members;
  }

  Widget _buildAddButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const Spacer(),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
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
      MaterialPageRoute(
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
    showDialog(
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
              // TODO: 实现清空聊天记录
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

