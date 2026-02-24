import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/repositories/on_chain_notification_repository.dart';
import '../../integration/wallet_bridge.dart';
import 'in_app_notification_service.dart';

/// 链上事件推送后台服务
///
/// 定时轮询 Push Protocol API，为新到达的通知触发应用内横幅。
/// 首次轮询时记录全部历史通知为"已见"，后续仅对增量条目弹出横幅。
class OnChainNotificationService {
  final IOnChainNotificationRepository _repository;
  final IWalletBridge _walletBridge;
  final InAppNotificationService _inAppService;
  final int _chainId;
  final Duration _pollInterval;

  Timer? _timer;
  Set<String> _seenIds = {};
  bool _isFirstPoll = true;
  bool _isRunning = false;

  OnChainNotificationService({
    required IOnChainNotificationRepository repository,
    required IWalletBridge walletBridge,
    required InAppNotificationService inAppNotificationService,
    int chainId = 1,
    Duration pollInterval = const Duration(minutes: 1),
  })  : _repository = repository,
        _walletBridge = walletBridge,
        _inAppService = inAppNotificationService,
        _chainId = chainId,
        _pollInterval = pollInterval;

  bool get isRunning => _isRunning;

  /// 启动轮询
  ///
  /// [context] 用于显示应用内横幅，需要是有效的 BuildContext
  void start(BuildContext context) {
    if (_isRunning) return;
    _isRunning = true;
    _poll(context);
    _timer = Timer.periodic(_pollInterval, (_) => _poll(context));
  }

  /// 停止轮询
  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  /// 立即触发一次轮询（用于前台回来时刷新）
  Future<void> pollNow(BuildContext context) => _poll(context);

  Future<void> _poll(BuildContext context) async {
    final walletAddress = _walletBridge.walletAddress;
    if (walletAddress == null || walletAddress.isEmpty) return;

    try {
      final notifications = await _repository.fetchNotifications(
        walletAddress: walletAddress,
        chainId: _chainId,
        limit: 20,
      );

      if (_isFirstPoll) {
        // 首次轮询：仅记录历史 ID，不弹窗
        _seenIds = notifications.map((n) => n.id).toSet();
        _isFirstPoll = false;
        return;
      }

      for (final notif in notifications) {
        if (!_seenIds.contains(notif.id) && !notif.isRead) {
          _seenIds.add(notif.id);
          if (context.mounted) {
            _inAppService.show(
              context,
              InAppNotification(
                title: notif.channelName,
                body: notif.title,
                avatarUrl: notif.imageUrl,
                onTap: notif.ctaUrl != null ? () {} : null,
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('OnChainNotificationService: poll error: $e');
    }
  }
}
