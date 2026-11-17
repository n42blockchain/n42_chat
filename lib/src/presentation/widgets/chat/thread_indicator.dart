import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../core/theme/app_dimensions.dart';
import '../common/n42_tap_area.dart';

/// 线程指示器
///
/// 显示在线程根消息底部，展示回复数量和最新回复预览。
/// 点击后导航到线程详情页。
class ThreadIndicator extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback? onTap;

  const ThreadIndicator({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    final replyCount = message.threadReplyCount ?? 0;
    if (replyCount <= 0) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final s = S.of(context);

    final replyText = replyCount == 1
        ? (s?.threadReply ?? '1 reply')
        : (s?.threadReplies(replyCount) ?? '$replyCount replies');

    final hasUnread = (message.threadUnreadCount ?? 0) > 0;

    // Inside the sender's own (brand-filled) bubble a brand label on a brand
    // tint is unreadable: use white on the darker inset there (4.8:1).
    final isFromMe = message.isFromMe;
    final accent = isFromMe
        ? Colors.white
        : AppColors.primaryOnTintOf(
            context,
            over: ChatColors.of(context).bubbleOther,
          );
    final secondaryText = isFromMe
        ? Colors.white
        : theme.colorScheme.onSurface.withValues(alpha: 0.6);

    // 44pt hit area around the pill (HIG accessibility).
    return N42TapArea(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isFromMe
              ? AppColors.selfBubbleInset
              : AppColors.primaryOf(context).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 14,
              color: accent,
            ),
            const SizedBox(width: 6),
            Text(
              replyText,
              style: TextStyle(
                fontSize: 12,
                color: accent,
                fontWeight: FontWeight.w500,
              ),
            ),
            // 线程未读红点
            if (hasUnread) ...[
              const SizedBox(width: AppDimensions.spacingXS),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ],
            if (message.threadLatestReply != null) ...[
              const SizedBox(width: AppDimensions.spacingS),
              Flexible(
                child: Text(
                  message.threadLatestReply!,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            const SizedBox(width: AppDimensions.spacingXS),
            Icon(
              Icons.chevron_right,
              size: 14,
              color: accent,
            ),
          ],
        ),
      ),
    );
  }
}
