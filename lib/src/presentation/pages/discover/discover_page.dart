import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/common/common_widgets.dart';
import '../qrcode/scan_qr_page.dart';

/// 发现页面
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: N42AppBar(
        title: '发现',
        showBackButton: false,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          
          // 朋友圈
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.photo_library_rounded,
                iconColor: const Color(0xFF07C160),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 扫一扫、摇一摇
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.qr_code_scanner_rounded,
                iconColor: const Color(0xFF3D7EFF),
                title: '扫一扫',
                onTap: () => _openScanQR(context),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 看一看、搜一搜
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.article_rounded,
                iconColor: const Color(0xFFFF9500),
                title: '看一看',
                onTap: () => _showComingSoon(context, '看一看'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                icon: Icons.search_rounded,
                iconColor: const Color(0xFFFF3B30),
                title: '搜一搜',
                onTap: () => _showComingSoon(context, '搜一搜'),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 附近的人、购物、游戏
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.location_on_rounded,
                iconColor: const Color(0xFF5856D6),
                title: '附近',
                onTap: () => _showComingSoon(context, '附近'),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 小程序
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.apps_rounded,
                iconColor: const Color(0xFF5AC8FA),
                title: '小程序',
                onTap: () => _showComingSoon(context, '小程序'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, {required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    String? badge,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 58),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  void _openScanQR(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ScanQRPage()),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 功能即将推出'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

