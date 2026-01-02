import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 聊天更多功能面板
///
/// 微信风格的底部功能面板，包含：
/// - 照片、拍摄、视频通话、位置
/// - 红包、转账、文件、名片
/// - 收藏、音乐、卡券等（可滑动）
class ChatMorePanel extends StatelessWidget {
  /// 选择照片回调
  final VoidCallback? onPhotoPressed;

  /// 拍摄回调
  final VoidCallback? onCameraPressed;

  /// 视频通话回调
  final VoidCallback? onVideoCallPressed;

  /// 位置回调
  final VoidCallback? onLocationPressed;

  /// 红包回调
  final VoidCallback? onRedPacketPressed;

  /// 转账回调
  final VoidCallback? onTransferPressed;

  /// 文件回调
  final VoidCallback? onFilePressed;

  /// 名片回调
  final VoidCallback? onContactCardPressed;

  /// 收藏回调
  final VoidCallback? onFavoritePressed;

  /// 音乐回调
  final VoidCallback? onMusicPressed;

  /// 卡券回调
  final VoidCallback? onCouponPressed;

  /// 礼物回调
  final VoidCallback? onGiftPressed;

  const ChatMorePanel({
    super.key,
    this.onPhotoPressed,
    this.onCameraPressed,
    this.onVideoCallPressed,
    this.onLocationPressed,
    this.onRedPacketPressed,
    this.onTransferPressed,
    this.onFilePressed,
    this.onContactCardPressed,
    this.onFavoritePressed,
    this.onMusicPressed,
    this.onCouponPressed,
    this.onGiftPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.inputBarDark : AppColors.inputBar,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 220,
          child: PageView(
            children: [
              // 第一页
              _buildPage(
                context,
                isDark,
                [
                  _MoreItem(
                    icon: Icons.photo_library_outlined,
                    label: '照片',
                    onTap: onPhotoPressed,
                  ),
                  _MoreItem(
                    icon: Icons.camera_alt_outlined,
                    label: '拍摄',
                    onTap: onCameraPressed,
                  ),
                  _MoreItem(
                    icon: Icons.videocam_outlined,
                    label: '视频通话',
                    onTap: onVideoCallPressed,
                  ),
                  _MoreItem(
                    icon: Icons.location_on_outlined,
                    label: '位置',
                    onTap: onLocationPressed,
                  ),
                  _MoreItem(
                    icon: Icons.card_giftcard,
                    label: '红包',
                    onTap: onRedPacketPressed,
                    iconColor: AppColors.redPacket,
                  ),
                  _MoreItem(
                    icon: Icons.swap_horiz,
                    label: '转账',
                    onTap: onTransferPressed,
                  ),
                  _MoreItem(
                    icon: Icons.folder_outlined,
                    label: '文件',
                    onTap: onFilePressed,
                  ),
                  _MoreItem(
                    icon: Icons.person_outline,
                    label: '名片',
                    onTap: onContactCardPressed,
                  ),
                ],
              ),
              // 第二页
              _buildPage(
                context,
                isDark,
                [
                  _MoreItem(
                    icon: Icons.star_outline,
                    label: '收藏',
                    onTap: onFavoritePressed,
                  ),
                  _MoreItem(
                    icon: Icons.music_note_outlined,
                    label: '音乐',
                    onTap: onMusicPressed,
                  ),
                  _MoreItem(
                    icon: Icons.confirmation_num_outlined,
                    label: '卡券',
                    onTap: onCouponPressed,
                  ),
                  _MoreItem(
                    icon: Icons.redeem,
                    label: '礼物',
                    onTap: onGiftPressed,
                    iconColor: AppColors.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, bool isDark, List<_MoreItem> items) {
    return Column(
      children: [
        // 第一行
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 4; i++)
                if (i < items.length)
                  _buildItem(context, items[i], isDark)
                else
                  const SizedBox(width: 70),
            ],
          ),
        ),
        // 第二行
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 4; i < 8; i++)
                if (i < items.length)
                  _buildItem(context, items[i], isDark)
                else
                  const SizedBox(width: 70),
            ],
          ),
        ),
        // 页面指示器
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, _MoreItem item, bool isDark) {
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final defaultIconColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GestureDetector(
      onTap: item.onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.icon,
                size: 28,
                color: item.iconColor ?? defaultIconColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? iconColor;

  const _MoreItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor,
  });
}
