import 'dart:math' as math;

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

  /// 朋友圈图标 - 四色花瓣
  Widget _buildMomentsIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _MomentsIconPainter(),
      ),
    );
  }

  /// 视频号图标 - 橙色无限符号样式
  Widget _buildChannelsIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _ChannelsIconPainter(),
      ),
    );
  }

  /// 直播图标 - 红色双圆圈
  Widget _buildLiveIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _LiveIconPainter(),
      ),
    );
  }

  /// 扫一扫图标 - 蓝色扫描框
  Widget _buildScanIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _ScanIconPainter(),
      ),
    );
  }

  /// 听一听图标 - 粉红色音符
  Widget _buildMusicIcon() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: Icon(
        Icons.music_note_outlined,
        color: Color(0xFFFF69B4),
        size: 24,
      ),
    );
  }

  /// 看一看图标 - 黄色六边形蜂窝
  Widget _buildWatchIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _WatchIconPainter(),
      ),
    );
  }

  /// 搜一搜图标 - 红色星形放大镜
  Widget _buildSearchIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _SearchIconPainter(),
      ),
    );
  }

  /// 附近的人图标 - 蓝色波纹定位
  Widget _buildNearbyIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _NearbyIconPainter(),
      ),
    );
  }

  /// 游戏图标 - 绿色钻石
  Widget _buildGameIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GameIconPainter(),
      ),
    );
  }

  /// 小程序图标 - 紫色S形
  Widget _buildMiniProgramIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _MiniProgramIconPainter(),
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
              SizedBox(
                width: 28,
                height: 28,
                child: Center(child: iconWidget),
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

/// 朋友圈图标 - 四色花瓣（蓝、橙、绿、红）
class _MomentsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.22;
    final offset = size.width * 0.18;
    
    final colors = [
      const Color(0xFF4FC3F7), // 上 - 蓝
      const Color(0xFFFF9800), // 右 - 橙
      const Color(0xFF66BB6A), // 下 - 绿
      const Color(0xFFEF5350), // 左 - 红
    ];
    
    final positions = [
      Offset(center.dx, center.dy - offset), // 上
      Offset(center.dx + offset, center.dy), // 右
      Offset(center.dx, center.dy + offset), // 下
      Offset(center.dx - offset, center.dy), // 左
    ];
    
    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(positions[i], radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 视频号图标 - 橙色波浪/无限符号
class _ChannelsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6B00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    final w = size.width;
    final h = size.height;
    
    final path = Path();
    // 画波浪形/M形
    path.moveTo(w * 0.1, h * 0.6);
    path.quadraticBezierTo(w * 0.25, h * 0.2, w * 0.4, h * 0.5);
    path.quadraticBezierTo(w * 0.5, h * 0.7, w * 0.6, h * 0.5);
    path.quadraticBezierTo(w * 0.75, h * 0.2, w * 0.9, h * 0.6);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 直播图标 - 红色双圆圈
class _LiveIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // 外圈
    final outerPaint = Paint()
      ..color = const Color(0xFFFF4D4D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, size.width * 0.4, outerPaint);
    
    // 内圈实心
    final innerPaint = Paint()
      ..color = const Color(0xFFFF4D4D)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width * 0.2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 扫一扫图标 - 蓝色扫描框
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
    final padding = w * 0.08;
    
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

/// 看一看图标 - 黄色六边形蜂窝
class _WatchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;
    
    // 画六边形
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 90) * math.pi / 180;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 搜一搜图标 - 红色星形放大镜
class _SearchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF4757)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final w = size.width;
    final h = size.height;
    
    // 画星形/X形
    final cx = w * 0.4;
    final cy = h * 0.4;
    final r = w * 0.22;
    
    // 四条线组成星形
    canvas.drawLine(Offset(cx - r, cy - r), Offset(cx + r, cy + r), paint);
    canvas.drawLine(Offset(cx + r, cy - r), Offset(cx - r, cy + r), paint);
    canvas.drawLine(Offset(cx, cy - r * 1.2), Offset(cx, cy + r * 1.2), paint);
    canvas.drawLine(Offset(cx - r * 1.2, cy), Offset(cx + r * 1.2, cy), paint);
    
    // 手柄
    canvas.drawLine(
      Offset(cx + r * 0.8, cy + r * 0.8),
      Offset(w * 0.9, h * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 附近的人图标 - 蓝色波纹定位
class _NearbyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final color = const Color(0xFF10AEFF);
    
    // 外圈波纹（左右弧线）
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    
    // 左弧
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width * 0.9, height: size.height * 0.9),
      math.pi * 0.7,
      math.pi * 0.6,
      false,
      arcPaint,
    );
    
    // 右弧
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width * 0.9, height: size.height * 0.9),
      -math.pi * 0.3,
      math.pi * 0.6,
      false,
      arcPaint,
    );
    
    // 中心人形
    final personPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    // 头
    canvas.drawCircle(Offset(center.dx, center.dy - size.height * 0.12), size.width * 0.1, personPaint);
    
    // 身体
    canvas.drawLine(
      Offset(center.dx, center.dy),
      Offset(center.dx, center.dy + size.height * 0.2),
      personPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 游戏图标 - 绿色钻石
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
    final padding = w * 0.1;
    
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
      Offset(w * 0.32, h * 0.35),
      Offset(w / 2, h - padding),
      paint,
    );
    canvas.drawLine(
      Offset(w * 0.68, h * 0.35),
      Offset(w / 2, h - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 小程序图标 - 紫色S形双弧
class _MiniProgramIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7B68EE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    final w = size.width;
    final h = size.height;
    
    // 上弧（向右弯）
    final path1 = Path();
    path1.moveTo(w * 0.65, h * 0.15);
    path1.quadraticBezierTo(w * 0.15, h * 0.15, w * 0.35, h * 0.5);
    canvas.drawPath(path1, paint);
    
    // 下弧（向左弯）
    final path2 = Path();
    path2.moveTo(w * 0.35, h * 0.5);
    path2.quadraticBezierTo(w * 0.85, h * 0.85, w * 0.35, h * 0.85);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
