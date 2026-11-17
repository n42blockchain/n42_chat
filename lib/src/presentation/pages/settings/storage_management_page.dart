import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/media_lifecycle_service.dart';
import '../../../core/services/storage_cleanup_service.dart';
import '../../../core/services/storage_manager_service.dart';
import '../../../core/services/storage_monitor_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../blocs/storage/storage_management_bloc.dart';
import '../../blocs/storage/storage_management_event.dart';
import '../../blocs/storage/storage_management_state.dart';
import '../../widgets/common/common_widgets.dart';
import 'room_storage_detail_page.dart';
import '../../../core/theme/app_dimensions.dart';

/// 微信风格存储管理页面
class StorageManagementPage extends StatelessWidget {
  const StorageManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StorageManagementBloc(
        storageManager: GetIt.instance<StorageManagerService>(),
        lifecycleService: GetIt.instance<MediaLifecycleService>(),
        cleanupService: GetIt.instance<StorageCleanupService>(),
        monitorService: GetIt.instance<StorageMonitorService>(),
      )..add(const LoadStorageInfo()),
      child: const _StorageManagementView(),
    );
  }
}

class _StorageManagementView extends StatelessWidget {
  const _StorageManagementView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          S.of(context)?.storageManagement ?? 'Storage',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
        leading: IconButton(
          icon: Icon(AppIcons.back, color: context.textPrimary, size: 20),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<StorageManagementBloc, StorageManagementState>(
        listenWhen: (previous, current) =>
            previous.lastCleanupResult != current.lastCleanupResult ||
            previous.error != current.error,
        listener: (context, state) {
          if (ModalRoute.of(context)?.isCurrent != true) {
            return;
          }
          if (state.lastCleanupResult != null) {
            final result = state.lastCleanupResult!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  S
                          .of(context)
                          ?.storageFreed(
                            StorageInfo.formatSize(result.bytesFreed),
                            result.filesDeleted,
                          ) ??
                      'Freed ${StorageInfo.formatSize(result.bytesFreed)} (${result.filesDeleted} files)',
                ),
                // Darkened green keeps the white label at 4.5:1.
                backgroundColor: ChatContrast.fillForWhiteText(
                  AppColors.success,
                ),
              ),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: AppColors.errorFill,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.storageInfo == null) {
            return const Center(child: N42Loading());
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<StorageManagementBloc>().add(
                const LoadStorageInfo(),
              );
            },
            child: ListView(
              children: [
                _StorageOverviewSection(state: state),
                if (state.storageStatus?.level != StorageLevel.normal)
                  _StorageWarningBanner(state: state),
                const SizedBox(height: 10),
                if (state.recommendations.isNotEmpty)
                  _SmartCleanupSection(state: state),
                const SizedBox(height: 10),
                _RoomStorageSection(state: state),
                const SizedBox(height: 10),
                _StorageSettingsSection(state: state),
                const SizedBox(height: 10),
                _ClearCacheButton(state: state),
                const SizedBox(height: AppDimensions.spacingXXL),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 总用量 + 环形图分类比例
class _StorageOverviewSection extends StatelessWidget {
  final StorageManagementState state;

  const _StorageOverviewSection({required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final info = state.storageInfo;
    if (info == null) return const SizedBox.shrink();

    final cardColor = context.surfaceColor;
    final textColor = context.textPrimary;
    final secondaryColor = context.textSecondary;

    return Container(
      color: cardColor,
      padding: const EdgeInsets.all(AppDimensions.spacingXL),
      child: Column(
        children: [
          // 环形图
          SizedBox(
            width: 160,
            height: 160,
            child: CustomPaint(
              painter: _StorageRingPainter(
                mediaRatio: info.totalSize > 0
                    ? info.mediaSize / info.totalSize
                    : 0,
                fileRatio: info.totalSize > 0
                    ? info.fileSize / info.totalSize
                    : 0,
                cacheRatio: info.totalSize > 0
                    ? info.cacheSize / info.totalSize
                    : 0,
                otherRatio: info.totalSize > 0
                    ? info.otherSize / info.totalSize
                    : 0,
                isDark: isDark,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      info.formattedTotal,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: textColor,
                      ),
                    ),
                    Text(
                      S.of(context)?.totalUsage ?? 'Total Usage',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingL),
          // 分类图例
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendItem(
                color: AppColors.info,
                label: S.of(context)?.mediaFiles ?? 'Media',
                size: info.formattedMedia,
              ),
              _LegendItem(
                color: AppColors.warning,
                label: S.of(context)?.files ?? 'Files',
                size: info.formattedFile,
              ),
              _LegendItem(
                color: AppColors.success,
                label: S.of(context)?.cache ?? 'Cache',
                size: info.formattedCache,
              ),
              _LegendItem(
                color: context.textTertiary,
                label: S.of(context)?.other ?? 'Other',
                size: info.formattedOther,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String size;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: AppDimensions.spacingXS),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            height: 1.3,
            color: context.textSecondary,
          ),
        ),
        Text(
          size,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            height: 1.3,
            fontWeight: FontWeight.w500,
            color: context.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// 预警横幅
class _StorageWarningBanner extends StatelessWidget {
  final StorageManagementState state;

  const _StorageWarningBanner({required this.state});

  @override
  Widget build(BuildContext context) {
    final level = state.storageStatus?.level ?? StorageLevel.normal;
    final isCritical = level == StorageLevel.critical;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: isCritical
            ? AppColors.error.withValues(alpha: 0.1)
            : AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: isCritical
              ? AppColors.error.withValues(alpha: 0.3)
              : AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCritical ? Icons.error : Icons.warning_amber,
            color: isCritical ? AppColors.error : AppColors.warning,
            size: 24,
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Text(
              isCritical
                  ? S.of(context)?.storageWarningCritical ??
                        'Storage is critically low. Please clean up to free space.'
                  : S.of(context)?.storageWarningHigh ??
                        'Storage usage is high. Consider cleaning up old files.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              // Orange/red text on its own 10% tint is below 4.5:1; the
              // colored icon and border carry the severity.
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: context.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 智能清理卡片 + 建议列表
class _SmartCleanupSection extends StatelessWidget {
  final StorageManagementState state;

  const _SmartCleanupSection({required this.state});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.surfaceColor;
    final textColor = context.textPrimary;

    return Material(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  Icons.auto_fix_high,
                  color: AppColors.primaryOf(context),
                  size: 20,
                ),
                const SizedBox(width: AppDimensions.spacingS),
                Text(
                  S.of(context)?.storageSmartCleanup ?? 'Smart Cleanup',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          ...state.recommendations
              .where((r) => r.type != CleanupRecommendationType.roomSpecific)
              .take(3)
              .map(
                (rec) => _RecommendationTile(
                  recommendation: rec,
                  isCleaning: state.isCleaning,
                ),
              ),
          const SizedBox(height: AppDimensions.spacingS),
        ],
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  final CleanupRecommendation recommendation;
  final bool isCleaning;

  const _RecommendationTile({
    required this.recommendation,
    required this.isCleaning,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor = context.textSecondary;

    IconData icon;
    Color color;
    switch (recommendation.type) {
      case CleanupRecommendationType.oldMedia:
        icon = Icons.history;
        color = AppColors.info;
        break;
      case CleanupRecommendationType.largeFiles:
        icon = Icons.file_present;
        color = AppColors.warning;
        break;
      case CleanupRecommendationType.cache:
        icon = Icons.cached;
        color = AppColors.success;
        break;
      case CleanupRecommendationType.roomSpecific:
        icon = Icons.chat;
        color = Colors.purple;
        break;
    }

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        recommendation.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 15, height: 1.3, color: context.textPrimary),
      ),
      subtitle: Text(
        recommendation.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, height: 1.4, color: secondaryColor),
      ),
      trailing: TextButton(
        onPressed: isCleaning ? null : () => _confirmCleanup(context),
        child: Text(
          recommendation.formattedSize,
          style: TextStyle(
            // Plain brand text is about 4.0:1 on white; use the 4.5:1 shade.
            color: isCleaning
                ? secondaryColor
                : AppColors.primaryOnTintOf(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Cleanup deletes local files, so ask before running it.
  Future<void> _confirmCleanup(BuildContext context) async {
    final bloc = context.read<StorageManagementBloc>();
    final confirmed = await context.showConfirmDialog(
      title: recommendation.title,
      content: recommendation.description,
      confirmText: S.of(context)?.commonDelete ?? 'Delete',
      isDanger: true,
    );
    if (confirmed) {
      bloc.add(ExecuteCleanup(recommendation));
    }
  }
}

/// 房间存储排行
class _RoomStorageSection extends StatefulWidget {
  final StorageManagementState state;

  const _RoomStorageSection({required this.state});

  @override
  State<_RoomStorageSection> createState() => _RoomStorageSectionState();
}

class _RoomStorageSectionState extends State<_RoomStorageSection> {
  bool _showAll = false;
  StorageManagementState get state => widget.state;

  @override
  Widget build(BuildContext context) {
    final cardColor = context.surfaceColor;
    final textColor = context.textPrimary;
    final secondaryColor = context.textSecondary;

    if (state.roomStorageList.isEmpty) return const SizedBox.shrink();

    return Material(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.roomStorageRanking ?? 'Room Storage',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: textColor,
              ),
            ),
          ),
          ...state.roomStorageList
              .take(_showAll ? state.roomStorageList.length : 5)
              .map(
                (room) => ListTile(
                  title: Text(
                    room.roomName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    S.of(context)?.mediaItemsCount(room.mediaCount) ??
                        '${room.mediaCount} files',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: secondaryColor,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        room.formattedSize,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingXS),
                      Icon(AppIcons.chevron, size: 20, color: secondaryColor),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                          value: context.read<StorageManagementBloc>(),
                          child: RoomStorageDetailPage(
                            roomId: room.roomId,
                            roomName: room.roomName,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          if (!_showAll && state.roomStorageList.length > 5)
            ListTile(
              title: Text(
                S
                        .of(context)
                        ?.storageViewAllRooms(state.roomStorageList.length) ??
                    'View all ${state.roomStorageList.length} rooms',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryOnTintOf(context),
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                setState(() => _showAll = true);
              },
            ),
          const SizedBox(height: AppDimensions.spacingS),
        ],
      ),
    );
  }
}

/// 存储设置
class _StorageSettingsSection extends StatelessWidget {
  final StorageManagementState state;

  const _StorageSettingsSection({required this.state});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.surfaceColor;
    final textColor = context.textPrimary;
    final secondaryColor = context.textSecondary;
    final config = state.storageConfig ?? const StorageConfig();

    return Material(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.storageSettings ?? 'Storage Settings',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          SwitchListTile(
            title: Text(
              S.of(context)?.storageAutoCleanup ?? 'Auto Cleanup',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, height: 1.3, color: textColor),
            ),
            subtitle: Text(
              S.of(context)?.storageAutoCleanupDesc(config.autoCleanupDays) ??
                  'Automatically clean files older than ${config.autoCleanupDays} days',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: secondaryColor,
              ),
            ),
            value: config.autoCleanupEnabled,
            activeTrackColor: AppColors.primaryOf(context),
            onChanged: (value) {
              context.read<StorageManagementBloc>().add(
                UpdateStorageConfig(autoCleanupEnabled: value),
              );
            },
          ),
          Divider(height: 1, indent: 16, color: context.dividerColor),
          ListTile(
            title: Text(
              S.of(context)?.storageCleanupPeriod ?? 'Cleanup Period',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, height: 1.3, color: textColor),
            ),
            trailing: DropdownButton<int>(
              value: config.autoCleanupDays,
              underline: const SizedBox.shrink(),
              items: [30, 60, 90, 180, 365].map((days) {
                return DropdownMenuItem(
                  value: days,
                  child: Text(
                    S.of(context)?.storageDays(days) ?? '$days days',
                  ),
                );
              }).toList(),
              onChanged: (days) {
                if (days != null) {
                  context.read<StorageManagementBloc>().add(
                    UpdateStorageConfig(autoCleanupDays: days),
                  );
                }
              },
            ),
          ),
          Divider(height: 1, indent: 16, color: context.dividerColor),
          SwitchListTile(
            title: Text(
              S.of(context)?.storagePreserveThumbnails ?? 'Preserve Thumbnails',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, height: 1.3, color: textColor),
            ),
            subtitle: Text(
              S.of(context)?.storagePreserveThumbnailsDesc ??
                  'Keep image thumbnails during cleanup',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: secondaryColor,
              ),
            ),
            value: config.preserveThumbnails,
            activeTrackColor: AppColors.primaryOf(context),
            onChanged: (value) {
              context.read<StorageManagementBloc>().add(
                UpdateStorageConfig(preserveThumbnails: value),
              );
            },
          ),
          const SizedBox(height: AppDimensions.spacingS),
        ],
      ),
    );
  }
}

/// 清除缓存按钮
class _ClearCacheButton extends StatelessWidget {
  final StorageManagementState state;

  const _ClearCacheButton({required this.state});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.surfaceColor;

    return Material(
      color: cardColor,
      child: ListTile(
        leading: Icon(
          Icons.cleaning_services,
          color: AppColors.primaryOf(context),
        ),
        title: Text(
          S.of(context)?.clearCache ?? 'Clear Cache',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(height: 1.3, color: context.textPrimary),
        ),
        subtitle: Text(
          state.storageInfo?.formattedCache ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.textSecondary,
            fontSize: 12,
            height: 1.3,
          ),
        ),
        trailing: state.isCleaning
            ? const SizedBox(
                width: AppDimensions.spacingL,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(AppIcons.chevron),
        onTap: state.isCleaning ? null : () => _confirmClearCache(context),
      ),
    );
  }

  void _confirmClearCache(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.clearCache ?? 'Clear Cache'),
        content: Text(
          S.of(context)?.confirmClearCache ?? 'Clear all cache data?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<StorageManagementBloc>().add(const ClearCache());
            },
            child: Text(
              S.of(context)?.commonConfirm ?? 'OK',
              // System red is 3.55:1 on a white dialog; errorFill is 4.5:1.
              style: TextStyle(
                color: context.isDarkMode
                    ? AppColors.error
                    : AppColors.errorFill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 环形图绘制器
class _StorageRingPainter extends CustomPainter {
  final double mediaRatio;
  final double fileRatio;
  final double cacheRatio;
  final double otherRatio;
  final bool isDark;

  _StorageRingPainter({
    required this.mediaRatio,
    required this.fileRatio,
    required this.cacheRatio,
    required this.otherRatio,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 16.0;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

    // 背景圆环
    final bgPaint = Paint()
      ..color = AppColors.placeholderOf(isDark)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    if (mediaRatio + fileRatio + cacheRatio + otherRatio == 0) return;

    // 绘制各段
    var startAngle = -math.pi / 2;
    void drawArc(double ratio, Color color) {
      if (ratio <= 0) return;
      final sweep = ratio * 2 * math.pi;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }

    drawArc(mediaRatio, AppColors.info);
    drawArc(fileRatio, AppColors.warning);
    drawArc(cacheRatio, AppColors.success);
    drawArc(otherRatio, AppColors.textTertiary);
  }

  @override
  bool shouldRepaint(covariant _StorageRingPainter oldDelegate) {
    return mediaRatio != oldDelegate.mediaRatio ||
        fileRatio != oldDelegate.fileRatio ||
        cacheRatio != oldDelegate.cacheRatio ||
        otherRatio != oldDelegate.otherRatio ||
        isDark != oldDelegate.isDark;
  }
}
