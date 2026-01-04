import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';

/// 语音转文字回调
typedef VoiceToTextCallback = Future<String?> Function(String voiceUrl);

/// 语音消息组件
///
/// 特点：
/// - 点击播放/暂停
/// - 播放动画
/// - 时长显示
/// - 已读/未读状态（红点）
/// - 语音转文字功能
class VoiceMessageWidget extends StatefulWidget {
  /// 语音时长（秒）
  final int duration;

  /// 是否是自己发送的
  final bool isSelf;

  /// 语音URL
  final String? voiceUrl;

  /// 是否已读
  final bool isRead;

  /// 点击回调（自定义播放逻辑时使用）
  final VoidCallback? onTap;

  /// 语音转文字回调
  final VoiceToTextCallback? onConvertToText;

  /// 转换后的文字（如果已经转换过）
  final String? convertedText;

  const VoiceMessageWidget({
    super.key,
    required this.duration,
    required this.isSelf,
    this.voiceUrl,
    this.isRead = true,
    this.onTap,
    this.onConvertToText,
    this.convertedText,
  });

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final VoiceService _voiceService = VoiceService();
  
  bool _isPlaying = false;
  bool _isConverting = false;
  String? _convertedText;
  StreamSubscription<PlaybackState>? _playbackSubscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _convertedText = widget.convertedText;

    // 监听播放状态
    _playbackSubscription = _voiceService.playbackStateStream.listen((state) {
      if (mounted) {
        final isThisPlaying = state.isPlaying && 
            state.url != null && 
            state.url == widget.voiceUrl;
        
        if (_isPlaying != isThisPlaying) {
          setState(() {
            _isPlaying = isThisPlaying;
          });
          
          if (_isPlaying) {
            _animationController.repeat();
          } else {
            _animationController.stop();
            _animationController.reset();
          }
        }
      }
    });
  }

  @override
  void didUpdateWidget(VoiceMessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.convertedText != oldWidget.convertedText) {
      _convertedText = widget.convertedText;
    }
  }

  @override
  void dispose() {
    _playbackSubscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  /// 根据时长计算宽度（微信样式）
  double _calculateWidth() {
    // 最短80dp，最长200dp
    const minWidth = 80.0;
    const maxWidth = 200.0;
    const maxDuration = 60;

    final ratio = (widget.duration / maxDuration).clamp(0.0, 1.0);
    return minWidth + (maxWidth - minWidth) * ratio;
  }

  void _handleTap() {
    debugPrint('VoiceMessageWidget: _handleTap called, voiceUrl=${widget.voiceUrl}, isSelf=${widget.isSelf}');
    
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }
    
    // 默认播放逻辑
    if (widget.voiceUrl == null || widget.voiceUrl!.isEmpty) {
      debugPrint('VoiceMessageWidget: voiceUrl is null or empty, cannot play');
      // 提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('语音加载中，请稍后再试'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    
    if (_isPlaying) {
      debugPrint('VoiceMessageWidget: stopping playback');
      _voiceService.stop();
    } else {
      debugPrint('VoiceMessageWidget: starting playback: ${widget.voiceUrl}');
      _voiceService.play(widget.voiceUrl!);
    }
  }

  Future<void> _convertToText() async {
    if (_isConverting || widget.onConvertToText == null || widget.voiceUrl == null) {
      return;
    }
    
    setState(() {
      _isConverting = true;
    });
    
    try {
      final text = await widget.onConvertToText!(widget.voiceUrl!);
      if (mounted && text != null) {
        setState(() {
          _convertedText = text;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('语音转文字失败'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isConverting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = _calculateWidth();
    final iconColor = widget.isSelf ? AppColors.messageTextSent : AppColors.primary;
    final textColor = widget.isSelf ? AppColors.messageTextSent : AppColors.textPrimary;

    return Column(
      crossAxisAlignment: 
          widget.isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // 语音消息主体
        GestureDetector(
          onTap: _handleTap,
          onLongPress: widget.onConvertToText != null ? _showContextMenu : null,
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
        ),
        
        // 转换的文字
        if (_convertedText != null && _convertedText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.placeholder.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _convertedText!,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.isSelf 
                      ? AppColors.messageTextSent 
                      : AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
          ),
          
        // 转文字按钮（仅在没有转换文字时显示）
        if (_convertedText == null && widget.onConvertToText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: GestureDetector(
              onTap: _isConverting ? null : _convertToText,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isConverting)
                    const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation(AppColors.textSecondary),
                      ),
                    )
                  else
                    const Icon(
                      Icons.text_fields,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    _isConverting ? '转换中...' : '转文字',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _showContextMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (_convertedText == null)
                ListTile(
                  leading: const Icon(Icons.text_fields),
                  title: const Text('转为文字'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _convertToText();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('取消'),
                onTap: () => Navigator.pop(ctx),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceIcon(Color color, {required bool isReversed}) {
    if (!_isPlaying) {
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
