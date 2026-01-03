import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/common/common_widgets.dart';
import '../qrcode/scan_qr_page.dart';

/// 发现页面（仿微信）
class DiscoverPage extends StatelessWidget {
  /// 是否显示 AppBar（嵌入到主框架时可设为 false）
  final bool showAppBar;
  
  const DiscoverPage({
    super.key,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: showAppBar ? N42AppBar(
        title: '发现',
        showBackButton: false,
      ) : null,
      body: ListView(
        children: [
          const SizedBox(height: 8),
          
          // 朋友圈、视频号、直播
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildMomentsIcon(),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildChannelsIcon(),
                title: '视频号',
                onTap: () => _showComingSoon(context, '视频号'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildLiveIcon(),
                title: '直播',
                onTap: () => _showComingSoon(context, '直播'),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 扫一扫、听一听
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildScanIcon(),
                title: '扫一扫',
                onTap: () => _openScanQR(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildMusicIcon(),
                title: '听一听',
                onTap: () => _showComingSoon(context, '听一听'),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 看一看、搜一搜
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildWatchIcon(),
                title: '看一看',
                onTap: () => _showComingSoon(context, '看一看'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildSearchIcon(),
                title: '搜一搜',
                onTap: () => _showComingSoon(context, '搜一搜'),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 附近的人
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildNearbyIcon(),
                title: '附近的人',
                onTap: () => _showComingSoon(context, '附近的人'),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 游戏、小程序
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildGameIcon(),
                title: '游戏',
                onTap: () => _showComingSoon(context, '游戏'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _buildMiniProgramIcon(),
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

  // ==================== 图标组件 ====================

  /// 朋友圈图标 - 彩色蝴蝶/花瓣
  Widget _buildMomentsIcon() {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _MomentsIconPainter(),
      ),
    );
  }

  /// 视频号图标 - 橙色波浪
  Widget _buildChannelsIcon() {
    return const SizedBox(
      width: 28,
      height: 28,
      child: Icon(
        Icons.slow_motion_video,
        color: Color(0xFFFF6B00),
        size: 24,
      ),
    );
  }

  /// 直播图标 - 红色圆圈
  Widget _buildLiveIcon() {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFFF4D4D), width: 2),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF4D4D),
            ),
          ),
        ),
      ),
    );
  }

  /// 扫一扫图标 - 蓝色扫描框
  Widget _buildScanIcon() {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _ScanIconPainter(),
      ),
    );
  }

  /// 听一听图标 - 粉红色音符
  Widget _buildMusicIcon() {
    return const SizedBox(
      width: 28,
      height: 28,
      child: Icon(
        Icons.music_note,
        color: Color(0xFFFF69B4),
        size: 24,
      ),
    );
  }

  /// 看一看图标 - 黄色六边形
  Widget _buildWatchIcon() {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _WatchIconPainter(),
      ),
    );
  }

  /// 搜一搜图标 - 红色放大镜
  Widget _buildSearchIcon() {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _SearchIconPainter(),
      ),
    );
  }

  /// 附近的人图标 - 蓝色定位
  Widget _buildNearbyIcon() {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF10AEFF), width: 2),
        ),
        child: const Center(
          child: Icon(
            Icons.person_outline,
            color: Color(0xFF10AEFF),
            size: 14,
          ),
        ),
      ),
    );
  }

  /// 游戏图标 - 绿色钻石
  Widget _buildGameIcon() {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _GameIconPainter(),
      ),
    );
  }

  /// 小程序图标 - 紫色S
  Widget _buildMiniProgramIcon() {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF7B68EE), width: 2),
        ),
        child: const Center(
          child: Text(
            'S',
            style: TextStyle(
              color: Color(0xFF7B68EE),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== 通用组件 ====================

  Widget _buildGroupCard(BuildContext context, bool isDark, {required List<Widget> children}) {
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
    required bool isDark,
    required Widget iconWidget,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              iconWidget,
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
              if (trailing != null) trailing,
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

  Widget _buildDivider(BuildContext context, bool isDark) {
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

// ==================== 自定义图标绘制 ====================

/// 朋友圈图标绘制器 - 彩色花瓣
class _MomentsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;
    
    // 四个花瓣的颜色
    final colors = [
      const Color(0xFF4FC3F7), // 蓝色
      const Color(0xFFFFB74D), // 橙色
      const Color(0xFF81C784), // 绿色
      const Color(0xFFE57373), // 红色
    ];
    
    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      
      final angle = (i * 90 - 45) * 3.14159 / 180;
      final petalCenter = Offset(
        center.dx + radius * 0.5 * cos(angle),
        center.dy + radius * 0.5 * sin(angle),
      );
      
      canvas.drawCircle(petalCenter, radius * 0.55, paint);
    }
  }
  
  double cos(double radians) => _cos(radians);
  double sin(double radians) => _sin(radians);
  
  double _cos(double x) {
    return 1 - (x * x) / 2 + (x * x * x * x) / 24 - (x * x * x * x * x * x) / 720;
  }
  
  double _sin(double x) {
    return x - (x * x * x) / 6 + (x * x * x * x * x) / 120;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 扫一扫图标绘制器
class _ScanIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF10AEFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    final w = size.width;
    final h = size.height;
    final cornerLen = w * 0.3;
    final padding = w * 0.1;
    
    // 左上角
    canvas.drawLine(Offset(padding, padding + cornerLen), Offset(padding, padding), paint);
    canvas.drawLine(Offset(padding, padding), Offset(padding + cornerLen, padding), paint);
    
    // 右上角
    canvas.drawLine(Offset(w - padding - cornerLen, padding), Offset(w - padding, padding), paint);
    canvas.drawLine(Offset(w - padding, padding), Offset(w - padding, padding + cornerLen), paint);
    
    // 左下角
    canvas.drawLine(Offset(padding, h - padding - cornerLen), Offset(padding, h - padding), paint);
    canvas.drawLine(Offset(padding, h - padding), Offset(padding + cornerLen, h - padding), paint);
    
    // 右下角
    canvas.drawLine(Offset(w - padding, h - padding - cornerLen), Offset(w - padding, h - padding), paint);
    canvas.drawLine(Offset(w - padding - cornerLen, h - padding), Offset(w - padding, h - padding), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 看一看图标绘制器 - 黄色六边形
class _WatchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 90) * 3.14159 / 180;
      final x = center.dx + radius * _cos(angle);
      final y = center.dy + radius * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
    
    // 中心圆点
    final dotPaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.25, dotPaint);
  }
  
  double _cos(double x) {
    // 简单的余弦近似
    while (x > 3.14159) x -= 2 * 3.14159;
    while (x < -3.14159) x += 2 * 3.14159;
    return 1 - (x * x) / 2 + (x * x * x * x) / 24;
  }
  
  double _sin(double x) {
    while (x > 3.14159) x -= 2 * 3.14159;
    while (x < -3.14159) x += 2 * 3.14159;
    return x - (x * x * x) / 6 + (x * x * x * x * x) / 120;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 搜一搜图标绘制器 - 红色放大镜
class _SearchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF4757)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    final center = Offset(size.width * 0.4, size.height * 0.4);
    final radius = size.width * 0.28;
    
    // 圆圈
    canvas.drawCircle(center, radius, paint);
    
    // 手柄（斜线）
    final handleStart = Offset(
      center.dx + radius * 0.7,
      center.dy + radius * 0.7,
    );
    final handleEnd = Offset(
      size.width * 0.85,
      size.height * 0.85,
    );
    canvas.drawLine(handleStart, handleEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 游戏图标绘制器 - 绿色钻石
class _GameIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    final w = size.width;
    final h = size.height;
    final padding = w * 0.15;
    
    // 钻石形状
    final path = Path()
      ..moveTo(w / 2, padding) // 顶点
      ..lineTo(w - padding, h * 0.35) // 右上
      ..lineTo(w / 2, h - padding) // 底点
      ..lineTo(padding, h * 0.35) // 左上
      ..close();
    
    canvas.drawPath(path, paint);
    
    // 内部横线
    canvas.drawLine(
      Offset(padding, h * 0.35),
      Offset(w - padding, h * 0.35),
      paint,
    );
    
    // 内部斜线
    canvas.drawLine(
      Offset(w * 0.3, h * 0.35),
      Offset(w / 2, h - padding),
      paint,
    );
    canvas.drawLine(
      Offset(w * 0.7, h * 0.35),
      Offset(w / 2, h - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
