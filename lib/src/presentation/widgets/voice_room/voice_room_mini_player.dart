import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/entities/voice_room_entity.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

/// 语音房间悬浮小窗
///
/// 当用户离开语音房间页面但仍在收听时显示。
class VoiceRoomMiniPlayer extends StatelessWidget {
  final VoiceRoomEntity room;
  final bool isMuted;
  final VoidCallback? onTap;
  final VoidCallback? onLeave;

  const VoiceRoomMiniPlayer({
    super.key,
    required this.room,
    this.isMuted = true,
    this.onTap,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    // Brand fill that carries white text at 4.5:1.
    final fill = AppColors.primaryFillOf(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Fill on the Material so the InkWell ripple is visible.
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingM,
              vertical: AppDimensions.spacingS,
            ),
            child: Row(
              children: [
                // 脉冲动画指示器
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingS),
                // 房间名称
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        room.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${room.participantCount} ${s?.voiceRoomListeners ?? 'listeners'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // 离开按钮
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  tooltip: s?.voiceRoomLeave ?? 'Leave',
                  onPressed: onLeave,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
