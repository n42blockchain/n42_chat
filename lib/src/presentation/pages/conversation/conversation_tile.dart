import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 会话列表项
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
                  // 头像
                  _buildAvatar(),
                  const SizedBox(width: 12),

                  // 内容
                  Expanded(
                    child: _buildContent(isDark),
                  ),

                  // 右侧信息
                  _buildTrailing(isDark),
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

  Widget _buildAvatar() {
    Widget avatarWidget;
    
    // 三人及以上群聊：使用九宫格头像
    // 条件：是群聊 + 成员数 >= 3 + 有成员信息
    if (conversation.type == ConversationType.group &&
        conversation.memberAvatarUrls != null &&
        conversation.memberAvatarUrls!.length >= 3) {
      // 使用成员信息生成唯一 key，确保数据变化时刷新
      final avatarKey = conversation.memberAvatarUrls!
          .map((url) => url ?? 'null')
          .join('_');
      avatarWidget = N42GroupAvatar(
        key: ValueKey('group_${conversation.id}_$avatarKey'),
        memberAvatars: conversation.memberAvatarUrls!,
        memberNames: conversation.memberNames,
        size: 48,
      );
    } else {
      // 私聊或两人群聊：使用普通头像
      // 显示对方头像，如果没有则显示字母头像
      avatarWidget = N42Avatar(
        imageUrl: conversation.avatarUrl,
        name: conversation.name,
        size: 48,
      );
    }
    
    // 如果有未读消息，在头像右上角显示红点
    if (conversation.unreadCount > 0 && !conversation.isMuted) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatarWidget,
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.badge,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    return avatarWidget;
  }

  Widget _buildContent(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
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
                      conversation.name,
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
                  color: AppColors.textTertiary,
                ),
              ),
          ],
        ),

        const SizedBox(height: 4),

        // 副标题行
        Row(
          children: [
            // 免打扰图标
            if (conversation.isMuted)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.notifications_off,
                  size: 14,
                  color: AppColors.muted,
                ),
              ),

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
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrailing(bool isDark) {
    // 免打扰时有未读消息显示灰色点
    if (conversation.unreadCount > 0 && conversation.isMuted) {
      return Container(
        margin: const EdgeInsets.only(left: 8),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.textTertiary,
          shape: BoxShape.circle,
        ),
      );
    }

    return const SizedBox.shrink();
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

