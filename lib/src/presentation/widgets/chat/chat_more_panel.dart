import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 聊天更多功能面板
///
/// 微信风格的底部功能面板，包含：
/// - 照片、拍摄、收藏、发起收款
/// - 红包、文档、日程、快递会议等
class ChatMorePanel extends StatelessWidget {
  /// 选择照片回调
  final VoidCallback? onPhotoPressed;

  /// 拍摄回调
  final VoidCallback? onCameraPressed;

  /// 收藏回调
  final VoidCallback? onFavoritePressed;

  /// 发起收款回调
  final VoidCallback? onPaymentPressed;

  /// 红包回调
  final VoidCallback? onRedPacketPressed;

  /// 文档回调
  final VoidCallback? onDocumentPressed;

  /// 位置回调
  final VoidCallback? onLocationPressed;

  /// 转账回调
  final VoidCallback? onTransferPressed;

  /// 文件回调
  final VoidCallback? onFilePressed;

  /// 名片回调
  final VoidCallback? onContactCardPressed;

  const ChatMorePanel({
    super.key,
    this.onPhotoPressed,
    this.onCameraPressed,
    this.onFavoritePressed,
    this.onPaymentPressed,
    this.onRedPacketPressed,
    this.onDocumentPressed,
    this.onLocationPressed,
    this.onTransferPressed,
    this.onFilePressed,
    this.onContactCardPressed,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 第一行
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildItem(
                    context,
                    icon: Icons.photo_library_outlined,
                    label: '照片',
                    onTap: onPhotoPressed,
                    isDark: isDark,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.camera_alt_outlined,
                    label: '拍摄',
                    onTap: onCameraPressed,
                    isDark: isDark,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.video_call_outlined,
                    label: '视频通话',
                    onTap: onFavoritePressed,
                    isDark: isDark,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.location_on_outlined,
                    label: '位置',
                    onTap: onLocationPressed,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            // 第二行
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildItem(
                    context,
                    icon: Icons.account_balance_wallet_outlined,
                    label: '红包',
                    onTap: onRedPacketPressed,
                    isDark: isDark,
                    iconColor: AppColors.redPacket,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.swap_horiz,
                    label: '转账',
                    onTap: onTransferPressed,
                    isDark: isDark,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.folder_outlined,
                    label: '文件',
                    onTap: onFilePressed,
                    isDark: isDark,
                  ),
                  _buildItem(
                    context,
                    icon: Icons.person_outline,
                    label: '名片',
                    onTap: onContactCardPressed,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool isDark,
    Color? iconColor,
  }) {
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final defaultIconColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
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
              icon,
              size: 28,
              color: iconColor ?? defaultIconColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

