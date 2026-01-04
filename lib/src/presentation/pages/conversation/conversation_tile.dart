import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/remark_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 会话列表项（仿微信）
class ConversationTile extends StatelessWidget {
  /// 会话数据
  final ConversationEntity conversation;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  const ConversationTile({
    super.key,
    required this.conversation,
    this.onTap,
    this.onLongPress,
  });
  
  /// 获取显示名称（私聊时优先使用备注名）
  String _getDisplayName(BuildContext context) {
    // 群聊直接使用会话名称
    if (conversation.type == ConversationType.group) {
      return conversation.name;
    }
    
    // 私聊使用 RemarkService 获取备注名
    final remarkService = RemarkService.instance;
    final remark = remarkService.getRemark(conversation.id);
    if (remark != null && remark.isNotEmpty) {
      return remark;
    }
    
    // 也尝试从 ContactBloc 获取（兼容）
    try {
      final contactBloc = context.read<ContactBloc>();
      final state = contactBloc.state;
      if (state is ContactLoaded) {
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) {
            if (c == null) return false;
            if (c.directRoomId == conversation.id) return true;
            if (c.userId == conversation.id) return true;
            if (c.displayName == conversation.name) return true;
            return false;
          },
          orElse: () => null,
        );
        if (contact != null && contact.remark != null && contact.remark!.isNotEmpty) {
          return contact.remark!;
        }
      }
    } catch (e) {
      // ContactBloc 可能不可用，使用原始名称
    }
    
    return conversation.name;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = conversation.isPinned
        ? (isDark ? const Color(0xFF252525) : const Color(0xFFF5F5F5))
        : (isDark ? AppColors.surfaceDark : AppColors.surface);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: bgColor,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // 头像（带未读红点）
                  _buildAvatar(isDark),
                  const SizedBox(width: 12),

                  // 内容
                  Expanded(
                    child: _buildContent(context, isDark),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 分割线
        Container(
          margin: const EdgeInsets.only(left: 76),
          height: 0.5,
          color: isDark ? AppColors.dividerDark : AppColors.divider,
        ),
      ],
    );
  }

  Widget _buildAvatar(bool isDark) {
    Widget avatarWidget;
    
    // 三人及以上群聊：使用九宫格头像
    if (conversation.type == ConversationType.group &&
        conversation.memberAvatarUrls != null &&
        conversation.memberAvatarUrls!.length >= 3) {
      final avatarKey = conversation.memberAvatarUrls!
          .map((url) => url ?? 'null')
          .join('_');
      avatarWidget = N42GroupAvatar(
        key: ValueKey('group_${conversation.id}_$avatarKey'),
        memberAvatars: conversation.memberAvatarUrls!,
        memberNames: conversation.memberNames,
        size: 48,
        borderRadius: 8,
      );
    } else {
      // 私聊或两人群聊：使用普通头像
      avatarWidget = N42Avatar(
        imageUrl: conversation.avatarUrl,
        name: conversation.name,
        size: 48,
        borderRadius: 8, // 微信风格圆角
      );
    }
    
    // 未读消息红点/红色数字
    if (conversation.unreadCount > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatarWidget,
          Positioned(
            top: -4,
            right: -4,
            child: _buildUnreadBadge(),
          ),
        ],
      );
    }
    
    return avatarWidget;
  }

  Widget _buildUnreadBadge() {
    // 免打扰时显示灰色小圆点（无边框）
    if (conversation.isMuted) {
      return Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF888888),
          shape: BoxShape.circle,
        ),
      );
    }
    
    // 未读数 > 99 显示 99+
    final count = conversation.unreadCount;
    final text = count > 99 ? '99+' : '$count';
    
    // 根据数字位数调整宽度
    final minWidth = text.length > 2 ? 26.0 : (text.length > 1 ? 20.0 : 18.0);
    
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: 18,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.badge,
        borderRadius: BorderRadius.circular(9),
        // 微信风格：无白色边框
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    final displayName = _getDisplayName(context);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行：名称 + 时间
        Row(
          children: [
            // 名称
            Expanded(
              child: Row(
                children: [
                  // 加密标识
                  if (conversation.isEncrypted)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.lock,
                        size: 14,
                        color: AppColors.encrypted,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 时间
            if (conversation.lastMessageTime != null)
              Text(
                N42DateUtils.formatConversationTime(
                    conversation.lastMessageTime!),
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : AppColors.textTertiary,
                ),
              ),
          ],
        ),

        const SizedBox(height: 4),

        // 副标题行：消息内容 + 免打扰图标
        Row(
          children: [
            // 草稿标识
            if (conversation.draft != null && conversation.draft!.isNotEmpty)
              Text(
                '[草稿] ',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.error,
                ),
              ),

            // 最后消息
            Expanded(
              child: Text(
                _getLastMessageText(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : AppColors.textSecondary,
                ),
              ),
            ),

            // 免打扰图标（在右侧）
            if (conversation.isMuted)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.notifications_off,
                  size: 16,
                  color: isDark ? Colors.white24 : AppColors.muted,
                ),
              ),
          ],
        ),
      ],
    );
  }

  String _getLastMessageText() {
    // 草稿
    if (conversation.draft != null && conversation.draft!.isNotEmpty) {
      return conversation.draft!;
    }

    // 最后消息
    if (conversation.lastMessage == null || conversation.lastMessage!.isEmpty) {
      return '';
    }

    // 群聊显示发送者名称
    if (conversation.type == ConversationType.group &&
        conversation.lastMessageSenderName != null) {
      return '${conversation.lastMessageSenderName}: ${conversation.lastMessage}';
    }

    return conversation.lastMessage!;
  }
}
