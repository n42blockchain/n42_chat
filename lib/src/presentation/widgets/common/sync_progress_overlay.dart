import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/entities/chat_sync_phase.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../../l10n/app_localizations.dart';

/// 首次同步进度覆盖层
///
/// 在用户首次登录后、Matrix 客户端完成初始同步前，显示加载动画与进度提示。
/// 同步完成后自动消失（淡出动画）。
class SyncProgressOverlay extends StatefulWidget {
  const SyncProgressOverlay({super.key, this.clientManager});

  final MatrixClientManager? clientManager;

  @override
  State<SyncProgressOverlay> createState() => _SyncProgressOverlayState();
}

class _SyncProgressOverlayState extends State<SyncProgressOverlay>
    with SingleTickerProviderStateMixin {
  bool _isSyncing = false;
  bool _visible = false;
  bool _hasError = false;
  bool _retrying = false;
  bool Function()? _ownsSession;
  Future<void> Function()? _retrySync;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  StreamSubscription<ChatSyncPhase>? _syncSub;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _checkSyncState();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _syncSub?.cancel();
    super.dispose();
  }

  void _checkSyncState() {
    final clientManager = widget.clientManager ?? MatrixClientManager.instance;
    final onSyncStatus = clientManager.onChatSyncPhase;
    if (onSyncStatus == null) return;

    // 若 prevBatch 为 null，说明尚未完成首次同步
    final client = clientManager.client;
    if (client != null && client.prevBatch == null) {
      final userId = client.userID;
      final deviceId = client.deviceID;
      final token = client.accessToken;
      final homeserver = client.homeserver;
      _ownsSession = () =>
          identical(clientManager.client, client) &&
          client.userID == userId &&
          client.deviceID == deviceId &&
          client.accessToken == token &&
          client.homeserver == homeserver;
      _retrySync = () => client.oneShotSync(timeout: Duration.zero);
      setState(() {
        _isSyncing = true;
        _visible = true;
      });
      _fadeController.value = 1.0;

      _syncSub = onSyncStatus.listen((status) {
        if (!mounted || !_isSyncing) return;
        if (_ownsSession?.call() != true) {
          _hideSyncOverlay();
          return;
        }
        if (status == ChatSyncPhase.error) {
          setState(() => _hasError = true);
        }
        if (status == ChatSyncPhase.finished && _isSyncing) {
          _hideSyncOverlay();
        }
      });
    }
  }

  Future<void> _retry() async {
    if (_retrying || !_isSyncing) return;
    if (_ownsSession?.call() != true) {
      _hideSyncOverlay();
      return;
    }
    setState(() => _retrying = true);
    try {
      await _retrySync?.call();
    } catch (_) {
      // Preserve recovery controls. The SDK normally reports failure on its
      // stream, but transport/start failures can also complete with an error.
    } finally {
      if (mounted && _isSyncing) {
        if (_ownsSession?.call() != true) {
          _hideSyncOverlay();
        } else {
          setState(() => _retrying = false);
        }
      }
    }
  }

  void _hideSyncOverlay() {
    setState(() => _isSyncing = false);
    _fadeController.reverse().then((_) {
      if (mounted) setState(() => _visible = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    final l10n = S.of(context);

    final secondary = context.textSecondary;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: context.pageBackground.withValues(alpha: 0.92),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_hasError)
                  Icon(Icons.sync_problem, size: 48, color: secondary)
                else
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                const SizedBox(height: AppDimensions.spacingL),
                Text(
                  _hasError
                      ? (l10n?.commonLoadFailed ?? 'Failed to load')
                      : (l10n?.syncInProgress ?? 'Syncing message history...'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(color: secondary),
                ),
                const SizedBox(height: AppDimensions.spacingL),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppDimensions.spacingM,
                  children: [
                    if (_hasError)
                      FilledButton(
                        onPressed: _retrying ? null : _retry,
                        child: Text(l10n?.commonRetry ?? 'Retry'),
                      ),
                    TextButton(
                      onPressed: _hideSyncOverlay,
                      child: Text(l10n?.commonClose ?? 'Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
