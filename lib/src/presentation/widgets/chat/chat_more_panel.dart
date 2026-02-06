import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

/// 聊天更多功能面板
///
/// 微信风格的底部功能面板，包含：
/// - 照片、拍摄、视频通话、位置
/// - 红包、转账、文件、名片
/// - 收藏、音乐、卡券等（可滑动）
class ChatMorePanel extends StatefulWidget {
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
  
  /// 投票回调
  final VoidCallback? onPollPressed;

  /// GIF 回调
  final VoidCallback? onGifPressed;

  /// 贴纸回调
  final VoidCallback? onStickerPressed;

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
    this.onPollPressed,
    this.onGifPressed,
    this.onStickerPressed,
  });

  @override
  State<ChatMorePanel> createState() => _ChatMorePanelState();
}

class _ChatMorePanelState extends State<ChatMorePanel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    // 获取底部安全区域高度
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // 内容高度（两行图标 + 页面指示器）- 增加高度避免溢出
    const contentHeight = 210.0;

    return Container(
      // 固定高度 = 内容高度 + 底部安全区域
      height: contentHeight + bottomPadding,
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
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  // 第一页
                  _buildPage(
                    context,
                    isDark,
                    [
                      _MoreItem(
                        icon: Icons.photo_library_outlined,
                        label: S.of(context)?.photos ?? 'Photos',
                        onTap: widget.onPhotoPressed,
                      ),
                      _MoreItem(
                        icon: Icons.camera_alt_outlined,
                        label: S.of(context)?.takePhoto ?? 'Camera',
                        onTap: widget.onCameraPressed,
                      ),
                      _MoreItem(
                        icon: Icons.videocam_outlined,
                        label: S.of(context)?.videoCall ?? 'Video Call',
                        onTap: widget.onVideoCallPressed,
                      ),
                      _MoreItem(
                        icon: Icons.location_on_outlined,
                        label: S.of(context)?.locationLabel ?? 'Location',
                        onTap: widget.onLocationPressed,
                      ),
                      _MoreItem(
                        icon: Icons.card_giftcard,
                        label: S.of(context)?.redPacket ?? 'Red Packet',
                        onTap: widget.onRedPacketPressed,
                        iconColor: AppColors.redPacket,
                      ),
                      _MoreItem(
                        icon: Icons.swap_horiz,
                        label: S.of(context)?.transfer ?? 'Transfer',
                        onTap: widget.onTransferPressed,
                      ),
                      _MoreItem(
                        icon: Icons.folder_outlined,
                        label: S.of(context)?.fileLabel ?? 'File',
                        onTap: widget.onFilePressed,
                      ),
                      _MoreItem(
                        icon: Icons.person_outline,
                        label: S.of(context)?.contactLabel ?? 'Contact',
                        onTap: widget.onContactCardPressed,
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
                        label: S.of(context)?.favorites ?? 'Favorites',
                        onTap: widget.onFavoritePressed,
                      ),
                      _MoreItem(
                        icon: Icons.music_note_outlined,
                        label: S.of(context)?.music ?? 'Music',
                        onTap: widget.onMusicPressed,
                      ),
                      _MoreItem(
                        icon: Icons.confirmation_num_outlined,
                        label: S.of(context)?.coupon ?? 'Coupon',
                        onTap: widget.onCouponPressed,
                      ),
                      _MoreItem(
                        icon: Icons.redeem,
                        label: S.of(context)?.gift ?? 'Gift',
                        onTap: widget.onGiftPressed,
                        iconColor: AppColors.error,
                      ),
                      _MoreItem(
                        icon: Icons.poll_outlined,
                        label: S.of(context)?.poll ?? 'Poll',
                        onTap: widget.onPollPressed,
                        iconColor: AppColors.primary,
                      ),
                      _MoreItem(
                        icon: Icons.gif_box_outlined,
                        label: 'GIF',
                        onTap: widget.onGifPressed,
                        iconColor: AppColors.textLink,
                      ),
                      _MoreItem(
                        icon: Icons.emoji_emotions_outlined,
                        label: S.of(context)?.stickers ?? 'Stickers',
                        onTap: widget.onStickerPressed,
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 页面指示器（移到 PageView 外部）
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == 0
                          ? AppColors.textSecondary
                          : AppColors.textTertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == 1
                          ? AppColors.textSecondary
                          : AppColors.textTertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, bool isDark, List<_MoreItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 第一行
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 4; i++)
                    if (i < items.length)
                      _buildItem(context, items[i], isDark)
                    else
                      const SizedBox(width: 70),
                ],
              ),
            ),
          ),
          // 第二行
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 4; i < 8; i++)
                    if (i < items.length)
                      _buildItem(context, items[i], isDark)
                    else
                      const SizedBox(width: 70),
                ],
              ),
            ),
          ),
        ],
      ),
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
