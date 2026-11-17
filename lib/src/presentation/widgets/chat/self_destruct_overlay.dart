import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/services/self_destruct_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../core/theme/app_dimensions.dart';

/// 阅后即焚倒计时覆盖层
///
/// 在消息气泡上方显示剩余时间 badge，消息过期后显示 "已销毁" 占位符。
class SelfDestructOverlay extends StatefulWidget {
  final MessageEntity message;
  final Widget child;

  const SelfDestructOverlay({
    super.key,
    required this.message,
    required this.child,
  });

  @override
  State<SelfDestructOverlay> createState() => _SelfDestructOverlayState();
}

class _SelfDestructOverlayState extends State<SelfDestructOverlay> {
  Timer? _ticker;
  int _remainingSeconds = 0;
  bool _isDestroyed = false;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    // 每秒刷新一次剩余时间
    if (widget.message.isDestructionStarted && !_isDestroyed) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        _updateRemaining();
      });
    }
  }

  void _updateRemaining() {
    final remaining = widget.message.remainingDestructionSeconds;
    if (remaining != null && remaining <= 0) {
      setState(() {
        _isDestroyed = true;
        _remainingSeconds = 0;
      });
      _ticker?.cancel();
    } else {
      setState(() {
        _remainingSeconds = remaining ?? widget.message.selfDestructAfter ?? 0;
      });
    }
  }

  @override
  void didUpdateWidget(SelfDestructOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.destroyedAt != widget.message.destroyedAt) {
      _updateRemaining();
      if (widget.message.isDestructionStarted &&
          _ticker == null &&
          !_isDestroyed) {
        _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
          _updateRemaining();
        });
      }
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDestroyed) {
      return _buildDestroyedPlaceholder(context);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned(
          top: -4,
          right: widget.message.isFromMe ? null : -4,
          left: widget.message.isFromMe ? -4 : null,
          child: _buildCountdownBadge(context),
        ),
      ],
    );
  }

  Widget _buildCountdownBadge(BuildContext context) {
    final text = SelfDestructService.formatDuration(_remainingSeconds);
    final isUrgent = _remainingSeconds <= 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        // Solid fills that carry the white label at >= 4.5:1; the
        // translucent red/orange measured about 2.2-3.4:1.
        color: isUrgent
            ? AppColors.errorFill
            : ChatContrast.fillForWhiteText(AppColors.warning),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            size: 10,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestroyedPlaceholder(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: ChatColors.of(context).selfDestructBg,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: ChatColors.of(context).selfDestructBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_delete_outlined,
            size: 14,
            color: context.textSupporting,
          ),
          const SizedBox(width: 6),
          Text(
            S.of(context)?.messageDestroyed ?? 'Message destroyed',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: context.textSupporting,
            ),
          ),
        ],
      ),
    );
  }
}

/// 阅后即焚未启动时的定时器图标提示
class SelfDestructPendingIcon extends StatelessWidget {
  final int durationSeconds;

  const SelfDestructPendingIcon({super.key, required this.durationSeconds});

  @override
  Widget build(BuildContext context) {
    final time = SelfDestructService.formatDuration(durationSeconds);
    return Tooltip(
      message:
          S.of(context)?.selfDestructCountdown(time) ?? 'Self-destruct: $time',
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Icon(
          Icons.timer_outlined,
          size: 12,
          // >= 3:1 on light surfaces; plain warning at 70% measured ~1.7:1.
          color: context.isDarkMode
              ? AppColors.warning
              : ChatContrast.fillForWhiteText(AppColors.warning),
        ),
      ),
    );
  }
}
