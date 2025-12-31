import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 语音消息组件
///
/// 特点：
/// - 播放动画
/// - 时长显示
/// - 已读/未读状态（红点）
class VoiceMessageWidget extends StatefulWidget {
  /// 语音时长（秒）
  final int duration;

  /// 是否是自己发送的
  final bool isSelf;

  /// 是否正在播放
  final bool isPlaying;

  /// 是否已读
  final bool isRead;

  /// 点击回调
  final VoidCallback? onTap;

  const VoiceMessageWidget({
    super.key,
    required this.duration,
    required this.isSelf,
    this.isPlaying = false,
    this.isRead = true,
    this.onTap,
  });

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (widget.isPlaying) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(VoiceMessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _animationController.repeat();
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 根据时长计算宽度（微信样式）
  double _calculateWidth() {
    // 最短60dp，最长200dp
    const minWidth = 60.0;
    const maxWidth = 200.0;
    const maxDuration = 60;

    final ratio = (widget.duration / maxDuration).clamp(0.0, 1.0);
    return minWidth + (maxWidth - minWidth) * ratio;
  }

  @override
  Widget build(BuildContext context) {
    final width = _calculateWidth();
    final iconColor = widget.isSelf ? Colors.white : AppColors.primary;
    final textColor = widget.isSelf ? Colors.white : AppColors.textPrimary;

    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 未读红点（对方消息，在左侧显示）
          if (!widget.isSelf && !widget.isRead)
            Container(
              margin: const EdgeInsets.only(right: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.badge,
                shape: BoxShape.circle,
              ),
            ),

          // 语音内容
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment:
                  widget.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                // 左侧图标（对方消息）
                if (!widget.isSelf)
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => _buildVoiceIcon(
                      iconColor,
                      isReversed: false,
                    ),
                  ),

                // 时长
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${widget.duration}"',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),

                // 右侧图标（自己的消息）
                if (widget.isSelf)
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => _buildVoiceIcon(
                      iconColor,
                      isReversed: true,
                    ),
                  ),
              ],
            ),
          ),

          // 未读红点（自己的消息，在右侧显示）
          if (widget.isSelf && !widget.isRead)
            Container(
              margin: const EdgeInsets.only(left: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.badge,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVoiceIcon(Color color, {required bool isReversed}) {
    if (!widget.isPlaying) {
      return Transform.flip(
        flipX: isReversed,
        child: Icon(
          Icons.wifi,
          size: 20,
          color: color,
        ),
      );
    }

    // 播放动画：三条线依次闪烁
    final value = _animationController.value;
    final line1Opacity = _calculateLineOpacity(value, 0);
    final line2Opacity = _calculateLineOpacity(value, 0.33);
    final line3Opacity = _calculateLineOpacity(value, 0.66);

    return Transform.flip(
      flipX: isReversed,
      child: SizedBox(
        width: 20,
        height: 20,
        child: CustomPaint(
          painter: _VoiceWavePainter(
            color: color,
            line1Opacity: line1Opacity,
            line2Opacity: line2Opacity,
            line3Opacity: line3Opacity,
          ),
        ),
      ),
    );
  }

  double _calculateLineOpacity(double value, double offset) {
    final adjustedValue = (value + offset) % 1.0;
    if (adjustedValue < 0.5) {
      return adjustedValue * 2;
    } else {
      return (1 - adjustedValue) * 2;
    }
  }
}

class _VoiceWavePainter extends CustomPainter {
  final Color color;
  final double line1Opacity;
  final double line2Opacity;
  final double line3Opacity;

  _VoiceWavePainter({
    required this.color,
    required this.line1Opacity,
    required this.line2Opacity,
    required this.line3Opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final centerY = size.height / 2;

    // 第一条线（最短）
    paint.color = color.withValues(alpha: line1Opacity);
    canvas.drawLine(
      Offset(4, centerY - 3),
      Offset(4, centerY + 3),
      paint,
    );

    // 第二条线（中等）
    paint.color = color.withValues(alpha: line2Opacity);
    canvas.drawLine(
      Offset(9, centerY - 5),
      Offset(9, centerY + 5),
      paint,
    );

    // 第三条线（最长）
    paint.color = color.withValues(alpha: line3Opacity);
    canvas.drawLine(
      Offset(14, centerY - 7),
      Offset(14, centerY + 7),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _VoiceWavePainter oldDelegate) {
    return oldDelegate.line1Opacity != line1Opacity ||
        oldDelegate.line2Opacity != line2Opacity ||
        oldDelegate.line3Opacity != line3Opacity;
  }
}

