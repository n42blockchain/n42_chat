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
                iconWidget: _MomentsIcon(),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _ChannelsIcon(),
                title: '视频号',
                onTap: () => _showComingSoon(context, '视频号'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _LiveIcon(),
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
                iconWidget: _ScanIcon(),
                title: '扫一扫',
                onTap: () => _openScanQR(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _MusicIcon(),
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
                iconWidget: _WatchIcon(),
                title: '看一看',
                onTap: () => _showComingSoon(context, '看一看'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _SearchIcon(),
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
                iconWidget: _NearbyIcon(),
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
                iconWidget: _GameIcon(),
                title: '游戏',
                onTap: () => _showComingSoon(context, '游戏'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                iconWidget: _MiniProgramIcon(),
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
                width: 26,
                height: 26,
                child: iconWidget,
              ),
              const SizedBox(width: 16),
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

// ==================== 图标组件 ====================

/// 朋友圈图标 - 彩色花瓣/蝴蝶
class _MomentsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _MomentsIconPainter(),
    );
  }
}

class _MomentsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.28;
    
    // 四个椭圆花瓣，交织在一起
    final colors = [
      const Color(0xFF56CCF2), // 上 - 蓝
      const Color(0xFFFF9F43), // 右 - 橙
      const Color(0xFF26DE81), // 下 - 绿
      const Color(0xFFFC5C65), // 左 - 粉红
    ];
    
    // 绘制四个交织的椭圆
    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(i * math.pi / 2 + math.pi / 4);
      
      final rect = Rect.fromCenter(
        center: Offset(r * 0.5, 0),
        width: r * 1.5,
        height: r * 0.9,
      );
      canvas.drawOval(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 视频号图标 - 橙色波浪/无限符号
class _ChannelsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _ChannelsIconPainter(),
    );
  }
}

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
    
    // 画类似∞的波浪形
    final path = Path();
    path.moveTo(w * 0.08, h * 0.55);
    path.cubicTo(
      w * 0.08, h * 0.2,
      w * 0.45, h * 0.2,
      w * 0.5, h * 0.5,
    );
    path.cubicTo(
      w * 0.55, h * 0.8,
      w * 0.92, h * 0.8,
      w * 0.92, h * 0.45,
    );
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 直播图标 - 红色同心圆
class _LiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _LiveIconPainter(),
    );
  }
}

class _LiveIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final color = const Color(0xFFFF4757);
    
    // 外圈描边
    final outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, size.width * 0.38, outerPaint);
    
    // 内圈实心
    final innerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width * 0.15, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 扫一扫图标 - 蓝色扫描框
class _ScanIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _ScanIconPainter(),
    );
  }
}

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
    final corner = w * 0.28;
    final p = w * 0.1;
    
    // 左上
    canvas.drawLine(Offset(p, p + corner), Offset(p, p), paint);
    canvas.drawLine(Offset(p, p), Offset(p + corner, p), paint);
    
    // 右上
    canvas.drawLine(Offset(w - p - corner, p), Offset(w - p, p), paint);
    canvas.drawLine(Offset(w - p, p), Offset(w - p, p + corner), paint);
    
    // 左下
    canvas.drawLine(Offset(p, h - p - corner), Offset(p, h - p), paint);
    canvas.drawLine(Offset(p, h - p), Offset(p + corner, h - p), paint);
    
    // 右下
    canvas.drawLine(Offset(w - p, h - p - corner), Offset(w - p, h - p), paint);
    canvas.drawLine(Offset(w - p - corner, h - p), Offset(w - p, h - p), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 听一听图标 - 粉色音符
class _MusicIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.music_note,
      color: Color(0xFFFF69B4),
      size: 26,
    );
  }
}

/// 看一看图标 - 黄色蜂窝六边形
class _WatchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _WatchIconPainter(),
    );
  }
}

class _WatchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final color = const Color(0xFFFFB300);
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    
    // 六边形
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 90) * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
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
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r * 0.22, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 搜一搜图标 - 红色星形放大镜
class _SearchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _SearchIconPainter(),
    );
  }
}

class _SearchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final color = const Color(0xFFFF4757);
    final w = size.width;
    final h = size.height;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final cx = w * 0.38;
    final cy = h * 0.38;
    final r = w * 0.2;
    
    // 六芒星/放射线
    for (int i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x1 = cx + r * 0.4 * math.cos(angle);
      final y1 = cy + r * 0.4 * math.sin(angle);
      final x2 = cx + r * 1.3 * math.cos(angle);
      final y2 = cy + r * 1.3 * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
    
    // 手柄
    canvas.drawLine(
      Offset(cx + r * 0.9, cy + r * 0.9),
      Offset(w * 0.9, h * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 附近的人图标 - 蓝色雷达人形
class _NearbyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _NearbyIconPainter(),
    );
  }
}

class _NearbyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final color = const Color(0xFF10AEFF);
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    
    // 左侧弧线
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, cy), width: size.width * 0.9, height: size.height * 0.9),
      math.pi * 0.65,
      math.pi * 0.7,
      false,
      paint,
    );
    
    // 右侧弧线
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, cy), width: size.width * 0.9, height: size.height * 0.9),
      -math.pi * 0.35,
      math.pi * 0.7,
      false,
      paint,
    );
    
    // 人形 - 头
    final headPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(cx, cy - size.height * 0.1), size.width * 0.1, headPaint);
    
    // 人形 - 身体
    canvas.drawLine(
      Offset(cx, cy + size.height * 0.02),
      Offset(cx, cy + size.height * 0.22),
      headPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 游戏图标 - 绿色钻石
class _GameIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _GameIconPainter(),
    );
  }
}

class _GameIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final color = const Color(0xFF4CAF50);
    final w = size.width;
    final h = size.height;
    final p = w * 0.12;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    
    // 钻石轮廓
    final path = Path()
      ..moveTo(w / 2, p) // 顶
      ..lineTo(w - p, h * 0.35) // 右上
      ..lineTo(w / 2, h - p) // 底
      ..lineTo(p, h * 0.35) // 左上
      ..close();
    canvas.drawPath(path, paint);
    
    // 横线
    canvas.drawLine(Offset(p, h * 0.35), Offset(w - p, h * 0.35), paint);
    
    // 左斜线
    canvas.drawLine(Offset(w * 0.33, h * 0.35), Offset(w / 2, h - p), paint);
    
    // 右斜线
    canvas.drawLine(Offset(w * 0.67, h * 0.35), Offset(w / 2, h - p), paint);
    
    // 顶部两条线
    canvas.drawLine(Offset(w / 2, p), Offset(w * 0.33, h * 0.35), paint);
    canvas.drawLine(Offset(w / 2, p), Offset(w * 0.67, h * 0.35), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 小程序图标 - 紫色S形
class _MiniProgramIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _MiniProgramIconPainter(),
    );
  }
}

class _MiniProgramIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final color = const Color(0xFF7B68EE);
    final w = size.width;
    final h = size.height;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    // S形由两个半圆弧组成
    // 上半部分 - 向左的弧
    canvas.drawArc(
      Rect.fromLTWH(w * 0.2, h * 0.1, w * 0.45, h * 0.4),
      -math.pi * 0.5,
      math.pi,
      false,
      paint,
    );
    
    // 下半部分 - 向右的弧
    canvas.drawArc(
      Rect.fromLTWH(w * 0.35, h * 0.5, w * 0.45, h * 0.4),
      math.pi * 0.5,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
