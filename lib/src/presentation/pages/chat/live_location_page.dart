import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/live_location_entity.dart';
import '../../blocs/live_location/live_location_bloc.dart';
import '../../blocs/live_location/live_location_event.dart';
import '../../blocs/live_location/live_location_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 实时位置共享页面
class LiveLocationPage extends StatelessWidget {
  final String roomId;

  const LiveLocationPage({
    super.key,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LiveLocationBloc>(
      create: (_) => GetIt.instance<LiveLocationBloc>(),
      child: BlocBuilder<LiveLocationBloc, LiveLocationState>(
        builder: (context, state) {
          return _LiveLocationView(
            roomId: roomId,
            state: state,
          );
        },
      ),
    );
  }
}

class _LiveLocationView extends StatelessWidget {
  final String roomId;
  final LiveLocationState state;

  const _LiveLocationView({
    required this.roomId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        title: Text(
          S.of(context)?.liveLocation ?? 'Live Location',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 地图区域（占位）
          Expanded(
            child: Container(
              color: isDark ? Colors.grey[900] : Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: isDark ? Colors.white38 : Colors.black26,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context)?.mapView ?? 'Map View',
                      style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black26,
                        fontSize: 16,
                      ),
                    ),
                    if (state.activeSharings.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        S.of(context)?.liveLocationSharingCount(state.activeSharings.length) ?? '${state.activeSharings.length} people sharing location',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // 底部面板
          _buildBottomPanel(context),
        ],
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 共享者列表
            if (state.activeSharings.isNotEmpty)
              ...state.activeSharings.values.map(
                (location) => _buildSharingItem(context, location),
              ),

            // 开始/停止共享按钮
            Padding(
              padding: const EdgeInsets.all(16),
              child: state.isSharing
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<LiveLocationBloc>()
                              .add(StopLiveLocation(roomId: roomId));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                            S.of(context)?.stopLiveLocation ??
                                'Stop Sharing'),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showDurationPicker(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                            S.of(context)?.startLiveLocation ??
                                'Share My Location'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharingItem(BuildContext context, LiveLocationEntity location) {
    final isDark = context.isDarkMode;

    return ListTile(
      leading: N42Avatar(
        imageUrl: location.avatarUrl,
        name: location.displayName,
        size: 40,
      ),
      title: Text(
        location.displayName,
        style: TextStyle(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        _formatRemaining(context, location),
        style: TextStyle(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.my_location,
        color: AppColors.primary,
        size: 20,
      ),
    );
  }

  String _formatRemaining(BuildContext context, LiveLocationEntity location) {
    final data = location.remainingTimeData;
    final l10n = S.of(context);
    switch (data.type) {
      case 'expired':
        return l10n?.locationExpired ?? 'Expired';
      case 'seconds':
        return l10n?.secondsRemaining(data.values[0]) ?? '${data.values[0]}s';
      case 'minutes':
        return l10n?.minutesRemaining(data.values[0]) ?? '${data.values[0]}min';
      case 'hoursMinutes':
        return l10n?.hoursMinutesRemaining(data.values[0], data.values[1]) ?? '${data.values[0]}h ${data.values[1]}min';
      default:
        return '';
    }
  }

  void _showDurationPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                S.of(context)?.selectDuration ?? 'Select Duration',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              title: Text(S.of(context)?.minutes15 ?? '15 minutes'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.read<LiveLocationBloc>().add(
                      StartLiveLocation(roomId: roomId, durationMinutes: 15),
                    );
              },
            ),
            ListTile(
              title: Text(S.of(context)?.minutes30 ?? '30 minutes'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.read<LiveLocationBloc>().add(
                      StartLiveLocation(roomId: roomId, durationMinutes: 30),
                    );
              },
            ),
            ListTile(
              title: Text(S.of(context)?.hour1 ?? '1 hour'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.read<LiveLocationBloc>().add(
                      StartLiveLocation(roomId: roomId, durationMinutes: 60),
                    );
              },
            ),
            ListTile(
              title: Text(S.of(context)?.hours8 ?? '8 hours'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.read<LiveLocationBloc>().add(
                      StartLiveLocation(roomId: roomId, durationMinutes: 480),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
