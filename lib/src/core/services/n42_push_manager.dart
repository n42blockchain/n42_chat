part of '../../n42_chat.dart';

/// N42Chat 推送通知服务管理器
///
/// 从 N42Chat 主类中提取的推送通知相关字段和方法。
/// 作为 part file 存在，所有成员对 N42Chat 可见。
class _N42PushManager {
  _N42PushManager._();

  /// 推送通知服务
  static FirebasePushService? _pushService;
  static Completer<void>? _pushInitCompleter;

  /// 获取推送服务
  static FirebasePushService? get pushService => _pushService;

  /// 初始化推送服务
  ///
  /// 使用 Completer 防止并发初始化（auth 恢复可能与初始化并行执行）
  static Future<void> initializePushService(N42ChatConfig config) async {
    // 防止并发初始化：如果正在初始化中，等待完成
    if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
      debugLog(
        'N42Chat: Push service initialization already in progress, waiting...',
      );
      await _pushInitCompleter!.future;
      // 如果等待后已初始化成功，直接返回
      if (_pushService != null) return;
      // 否则继续尝试初始化
    }

    // 已初始化则跳过
    if (_pushService != null) return;

    _pushInitCompleter = Completer<void>();

    try {
      // 获取 Matrix 客户端管理器
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;

      if (client == null) {
        debugLog(
          '[PUSH_INIT] Matrix client not initialized, push service will be initialized on login',
        );
        return;
      }

      debugLog(
        '[PUSH_INIT] Creating push service with gateway: ${config.pushGatewayUrl}, appId: ${config.pushAppId}',
      );

      // 创建推送服务
      _pushService = FirebasePushService(
        client,
        pushGatewayUrl: config.pushGatewayUrl,
        appId: config.pushAppId,
        onNotificationTap: (roomId, eventId) {
          debugLog(
            '[PUSH_TAP] Notification tapped - roomId: $roomId, eventId: $eventId',
          );
          N42Chat.handleNotificationTap(roomId: roomId, eventId: eventId);
        },
      );

      // 初始化（包括获取 FCM Token）
      await _pushService!.initialize();
      final savedNotificationSettings =
          await N42Chat.getSavedNotificationSettings();
      _pushService!.setNotificationConfig(
        N42Chat._notificationConfigFromSettings(savedNotificationSettings),
      );
      debugLog(
        '[PUSH_INIT] Push service initialized, isLogged=${client.isLogged()}',
      );

      // 如果已登录，立即注册推送
      if (client.isLogged()) {
        await _pushService!.registerForPush();
      }

      debugLog(
        '[PUSH_INIT_OK] Push service ready (verified=${_pushService?.isPusherVerified})',
      );
    } catch (e) {
      debugLog('[PUSH_INIT_FAIL] Failed to initialize push service: $e');
      // 初始化失败，清除 pushService 以允许后续重试
      _pushService = null;
    } finally {
      if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
        _pushInitCompleter!.complete();
      }
    }
  }

  /// 注册推送通知
  ///
  /// 登录成功后调用此方法注册推送。
  /// 如果推送服务正在初始化中（竞态），会等待初始化完成后再注册。
  static Future<void> registerPushNotifications() async {
    debugLog('[PUSH_CHAIN] registerPushNotifications called');

    // 等待正在进行的初始化完成
    if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
      debugLog(
        '[PUSH_CHAIN] Waiting for push service initialization to complete...',
      );
      await _pushInitCompleter!.future;
    }

    // 如果推送服务未初始化，尝试初始化（可能之前因 client 为 null 跳过）
    final config = N42Chat._config;
    if (_pushService == null &&
        config != null &&
        config.enablePushNotifications) {
      debugLog(
        '[PUSH_CHAIN] Push service is null, attempting initialization...',
      );
      await initializePushService(config);
    }

    if (_pushService != null) {
      debugLog('[PUSH_CHAIN] Calling registerForPush...');
      await _pushService!.registerForPush();
      debugLog(
        '[PUSH_CHAIN] registerForPush completed (verified=${_pushService!.isPusherVerified})',
      );
    } else {
      debugLog(
        '[PUSH_CHAIN_FAIL] Cannot register push - push service is null '
        '(config: ${config != null}, enablePush: ${config?.enablePushNotifications})',
      );
    }
  }

  /// 取消注册推送通知
  static Future<void> unregisterPushNotifications() async {
    if (_pushService != null) {
      await _pushService!.unregisterPush();
    }
  }

  /// 清除所有通知
  static Future<void> clearAllNotifications() async {
    if (_pushService != null) {
      await _pushService!.clearAllNotifications();
    }
  }

  /// 清除指定房间的通知
  static Future<void> clearNotificationsForRoom(String roomId) async {
    if (_pushService != null) {
      await _pushService!.clearNotificationsForRoom(roomId);
    }
  }

  /// 获取推送诊断信息
  static Map<String, dynamic> getPushDiagnostics() {
    if (_pushService == null) {
      return {
        'status': 'not_initialized',
        'config_exists': N42Chat._config != null,
        'push_enabled': N42Chat._config?.enablePushNotifications ?? false,
      };
    }
    return _pushService!.getDiagnosticInfo();
  }

  /// 强制重新注册推送
  static Future<void> forceReRegisterPush() async {
    debugLog('[PUSH_FORCE] Force re-register push requested');
    if (_pushService != null) {
      await _pushService!.forceReRegister();
    } else {
      debugLog(
        '[PUSH_FORCE] Push service is null, attempting full initialization...',
      );
      final config = N42Chat._config;
      if (config != null && config.enablePushNotifications) {
        await initializePushService(config);
      }
    }
  }

  /// 释放推送服务资源
  static Future<void> dispose() async {
    try {
      await _pushService?.dispose();
    } catch (_) {}
    _pushService = null;
    _pushInitCompleter = null;
  }
}
