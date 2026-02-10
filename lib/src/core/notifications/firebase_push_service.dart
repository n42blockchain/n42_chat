import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:uuid/uuid.dart';

import '../../services/voip/call_manager.dart';
import 'push_notification_service.dart';

/// 后台消息处理器 - 顶级函数，供独立使用 n42_chat 插件时注册。
///
/// 在集成到主 app (n42appv2) 时，不应直接注册此函数。
/// 主 app 应使用 [FirebasePushService.handleBackgroundMessage] 在其统一的
/// 后台消息处理器中委托 Matrix/Chat 消息。
/// （全局只允许一个 `FirebaseMessaging.onBackgroundMessage` 处理器）
@pragma('vm:entry-point')
Future<void> firebasePushBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebasePushService.handleBackgroundMessage(message);
}

/// Firebase 推送通知服务实现
///
/// 实现功能：
/// - Android/iOS 后台推送支持
/// - 本地通知显示
/// - 推送 Token 注册到 Matrix 服务器
/// - 点击通知跳转到对应聊天
class FirebasePushService implements IPushNotificationService {
  final matrix.Client _client;

  /// 推送网关 URL（Matrix Sygnal 服务器）
  final String? pushGatewayUrl;

  /// 应用标识符
  final String appId;

  /// 推送类型 (fcm / http)
  final String pushkeyType;

  /// 通知点击回调
  final void Function(String? roomId, String? eventId)? onNotificationTap;

  /// 本地通知插件
  static FlutterLocalNotificationsPlugin? _localNotifications;

  /// Android 通知渠道
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'n42_chat_messages',
    'N42 Chat Messages',
    description: 'N42 Chat message notifications',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  String? _fcmToken;
  String? _apnsToken;
  bool _isInitialized = false;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<matrix.SyncUpdate>? _syncSubscription;

  /// 通话状态自动重置定时器（防止 _isInCall 泄漏）
  Timer? _callStateResetTimer;

  /// 通知配置
  NotificationConfig _notificationConfig = const NotificationConfig();

  /// 当前活跃的房间 ID（用户正在查看的房间不弹通知）
  String? _activeRoomId;

  /// 是否正在通话中（通话期间禁用所有消息通知）
  bool _isInCall = false;

  /// 上次同步时间（用于过滤旧消息）
  DateTime? _lastSyncTime;

  FirebasePushService(
    this._client, {
    this.pushGatewayUrl,
    this.appId = 'com.n42.chat',
    this.pushkeyType = 'http',
    this.onNotificationTap,
  });

  /// 设置通知配置
  void setNotificationConfig(NotificationConfig config) {
    _notificationConfig = config;
  }

  /// 设置当前活跃房间（正在查看的房间不弹通知）
  void setActiveRoom(String? roomId) {
    _activeRoomId = roomId;
    debugPrint('FirebasePushService: Active room set to $roomId');
  }

  /// 获取当前活跃房间
  String? get activeRoomId => _activeRoomId;

  /// 设置通话状态（通话期间禁用所有消息通知）
  void setInCall(bool inCall) {
    _isInCall = inCall;
    _callStateResetTimer?.cancel();
    if (inCall) {
      // 安全机制：90 秒后自动重置，防止状态泄漏
      // （正常通话会由 CallManager 主动调用 setInCall(false)）
      _callStateResetTimer = Timer(const Duration(seconds: 90), () {
        if (_isInCall) {
          _isInCall = false;
          debugPrint('FirebasePushService: Auto-reset _isInCall after timeout');
        }
      });
    }
    debugPrint('FirebasePushService: In call set to $inCall');
  }

  /// 获取是否正在通话
  bool get isInCall => _isInCall;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 初始化本地通知
      await _initializeLocalNotifications();

      // 注意：后台消息处理器由主 app 统一注册（全局只允许一个）。
      // 主 app 的处理器会将 Matrix/Chat 消息委托给
      // FirebasePushService.handleBackgroundMessage()。

      // iOS 前台通知展示选项（确保前台时也能显示系统推送横幅）
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // 监听前台消息
      _foregroundSubscription = FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // 监听通知点击（从后台打开）
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // 检查是否通过通知启动应用
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }

      // 获取 FCM Token
      await _initializeToken();

      // 监听 Token 刷新
      _tokenRefreshSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        _fcmToken = token;
        // 重新注册推送
        if (_client.isLogged()) {
          registerForPush();
        }
      });

      // 监听新消息（用于本地通知）
      _syncSubscription = _client.onSync.stream.listen(_handleSyncUpdate);

      _isInitialized = true;
    } catch (e) {
      debugPrint('N42Chat: Failed to initialize push service: $e');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    // Android 初始化设置
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 初始化设置
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications!.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationResponse,
    );

    // 创建 Android 通知渠道
    if (Platform.isAndroid) {
      await _localNotifications!
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);
    }
  }

  Future<void> _initializeToken() async {
    // 请求通知权限
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('FirebasePushService: Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('FirebasePushService: Permission granted, getting tokens...');

      // iOS 需要先等待 APNs Token，FCM Token 依赖它
      if (Platform.isIOS) {
        _apnsToken = await _getAPNsTokenWithRetry();
        debugPrint('FirebasePushService: APNs token: ${_apnsToken != null ? '${_apnsToken!.substring(0, 10)}...' : 'null'}');
        if (_apnsToken == null) {
          debugPrint('FirebasePushService: WARNING - APNs token is null, iOS push may not work!');
        }
      }

      // 获取 FCM Token（带重试）
      _fcmToken = await _getFCMTokenWithRetry();
      debugPrint('FirebasePushService: FCM token: ${_fcmToken != null ? '${_fcmToken!.substring(0, 10)}...' : 'null'}');

      if (_fcmToken == null) {
        debugPrint('FirebasePushService: WARNING - FCM token is null after retries!');
      }
    } else {
      debugPrint('FirebasePushService: Notification permission DENIED (${settings.authorizationStatus}). '
          'Push notifications will NOT work. User must enable in Settings.');
      // 尝试获取 token（某些 Android 设备即使未授权也能获取 token）
      if (Platform.isAndroid) {
        _fcmToken = await _getFCMTokenWithRetry(maxRetries: 1);
        if (_fcmToken != null) {
          debugPrint('FirebasePushService: Got FCM token despite permission denied (Android)');
        }
      }
    }
  }

  /// 带重试的 APNs Token 获取（iOS）
  Future<String?> _getAPNsTokenWithRetry({int maxRetries = 5}) async {
    for (var i = 0; i < maxRetries; i++) {
      try {
        final token = await FirebaseMessaging.instance.getAPNSToken();
        if (token != null) return token;
      } catch (e) {
        debugPrint('FirebasePushService: APNs token attempt ${i + 1} failed: $e');
      }
      if (i < maxRetries - 1) {
        // APNs 注册可能需要时间，逐渐增加等待
        await Future<void>.delayed(Duration(seconds: (i + 1) * 2));
      }
    }
    debugPrint('FirebasePushService: Failed to get APNs token after $maxRetries attempts');
    return null;
  }

  /// 带重试的 FCM Token 获取
  Future<String?> _getFCMTokenWithRetry({int maxRetries = 3}) async {
    for (var i = 0; i < maxRetries; i++) {
      try {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) return token;
      } catch (e) {
        debugPrint('FirebasePushService: FCM token attempt ${i + 1} failed: $e');
      }
      if (i < maxRetries - 1) {
        await Future<void>.delayed(Duration(seconds: (i + 1) * 2));
      }
    }
    debugPrint('FirebasePushService: Failed to get FCM token after $maxRetries attempts');
    return null;
  }

  /// 处理前台消息
  void _handleForegroundMessage(RemoteMessage message) {
    // 检查通知配置
    if (!_notificationConfig.enabled) return;
    if (_notificationConfig.isInDoNotDisturbPeriod()) return;

    // 通话期间禁用所有消息通知
    if (_isInCall) {
      debugPrint('FirebasePushService: Skipping foreground notification during call');
      return;
    }

    // 过滤通话相关的推送
    final eventType = message.data['type'] as String?;
    if (eventType == 'm.call.invite') {
      setInCall(true);
      debugPrint('FirebasePushService: Set isInCall=true for incoming call');
      // 前台保护：如果 CallManager 尚未初始化或尚未处理此来电，
      // 主动触发 CallKit 作为 fallback（避免 sync 未建立时来电丢失）
      final callManager = CallManager();
      if (!callManager.isInitialized || !callManager.isInCall) {
        debugPrint('FirebasePushService: CallManager not handling call, showing CallKit as fallback');
        _showBackgroundCallKit(message).catchError((Object e) {
          debugPrint('FirebasePushService: Failed to show foreground CallKit fallback: $e');
        });
      }
      return;
    }
    if (eventType == 'm.call.hangup' || eventType == 'm.call.reject') {
      // 对方挂断或拒接 → 清除通话状态，恢复消息通知
      if (_isInCall) {
        setInCall(false);
        debugPrint('FirebasePushService: Cleared _isInCall on $eventType');
      }
      return;
    }
    if (eventType != null && eventType.startsWith('m.call.')) {
      debugPrint('FirebasePushService: Skipping foreground notification for call event: $eventType');
      return;
    }

    // 解析 Matrix 推送数据
    final roomId = message.data['room_id'] as String?;
    final eventId = message.data['event_id'] as String?;

    if (roomId != null) {
      final room = _client.getRoomById(roomId);
      if (room != null) {
        // 检查房间是否静音
        if (room.pushRuleState == matrix.PushRuleState.dontNotify) {
          return;
        }

        // 从房间获取信息显示通知
        final roomName = room.getLocalizedDisplayname();
        showLocalNotification(
          title: roomName,
          body: 'You have a new message',
          roomId: roomId,
          eventId: eventId,
        );
        return;
      }
    }

    // 如果有 notification payload，使用它
    final notification = message.notification;
    if (notification != null) {
      showLocalNotification(
        title: notification.title ?? 'New Message',
        body: notification.body ?? '',
        roomId: roomId,
        eventId: eventId,
        imageUrl: notification.android?.imageUrl ?? notification.apple?.imageUrl,
      );
    } else {
      // 没有 notification payload，显示默认通知
      showLocalNotification(
        title: 'N42 Chat',
        body: 'You have a new message',
        roomId: roomId,
        eventId: eventId,
      );
    }
  }

  /// 处理后台推送消息的公开入口
  ///
  /// 供主 app 的统一后台消息处理器调用。
  /// 由于 `FirebaseMessaging.onBackgroundMessage` 全局只能注册一个处理器，
  /// 主 app 应在其统一处理器中判断消息类型，将 Matrix/Chat 消息委托给此方法。
  static Future<void> handleBackgroundMessage(RemoteMessage message) =>
      _handleBackgroundMessage(message);

  /// 测试入口：显示后台 CallKit
  @visibleForTesting
  static Future<void> showBackgroundCallKitForTest(RemoteMessage message) =>
      _showBackgroundCallKit(message);

  /// 测试入口：处理后台消息（handleBackgroundMessage 的别名）
  @visibleForTesting
  static Future<void> handleBackgroundMessageForTest(RemoteMessage message) =>
      _handleBackgroundMessage(message);

  /// 处理后台消息（静态方法）
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    final eventType = message.data['type'] as String?;

    // m.call.invite: 后台来电，直接触发 CallKit 显示来电界面
    if (eventType == 'm.call.invite') {
      debugPrint('FirebasePushService: Background call invite received, showing CallKit');
      try {
        await _showBackgroundCallKit(message);
      } catch (e) {
        debugPrint('FirebasePushService: Failed to show background CallKit: $e');
      }
      return;
    }

    // m.call.hangup/reject: 对方取消或拒接 → 结束后台 CallKit 来电界面
    if (eventType == 'm.call.hangup' || eventType == 'm.call.reject') {
      debugPrint('FirebasePushService: Background $eventType received, ending CallKit');
      try {
        await FlutterCallkitIncoming.endAllCalls();
      } catch (e) {
        debugPrint('FirebasePushService: Failed to end CallKit on $eventType: $e');
      }
      return;
    }

    // 其他 m.call.* 事件（如 m.call.candidates, m.call.answer）跳过
    if (eventType != null && eventType.startsWith('m.call.')) {
      debugPrint('FirebasePushService: Skipping background notification for call event: $eventType');
      return;
    }

    // 后台消息在单独的 isolate 中运行，需要初始化本地通知
    if (_localNotifications == null) {
      _localNotifications = FlutterLocalNotificationsPlugin();

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications!.initialize(settings: initSettings);

      // 创建 Android 通知渠道
      if (Platform.isAndroid) {
        await _localNotifications!
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_channel);
      }
    }

    // 如果没有 notification payload，手动显示通知
    if (message.notification == null) {
      final roomId = message.data['room_id'] as String?;
      final eventId = message.data['event_id'] as String?;

      // 构建 payload
      final payload = json.encode({
        'room_id': roomId,
        'event_id': eventId,
      });

      // 使用时间戳生成唯一通知 ID
      final notificationId = DateTime.now().millisecondsSinceEpoch % 2147483647;

      final androidDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications!.show(
        id: notificationId,
        title: 'N42 Chat',
        body: 'You have a new message',
        notificationDetails: details,
        payload: payload,
      );
    }
  }

  /// 后台推送触发 CallKit 来电界面（静态方法，可在后台 isolate 中调用）
  static Future<void> _showBackgroundCallKit(RemoteMessage message) async {
    final roomId = message.data['room_id'] as String?;
    final senderId = message.data['sender'] as String?;
    final senderName = message.data['sender_display_name'] as String?
        ?? message.notification?.title
        ?? senderId
        ?? 'Unknown';

    final callId = const Uuid().v4();

    final params = CallKitParams(
      id: callId,
      nameCaller: senderName,
      appName: 'N42 Chat',
      handle: senderId ?? '',
      type: 0, // 默认语音（后台推送无法确定通话类型）
      duration: 60000,
      extra: <String, dynamic>{
        'callerId': senderId,
        'roomId': roomId,
      },
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        ringtonePath: 'ringtone_default',
        backgroundColor: '#0955fa',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'videoChat',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        ringtonePath: 'ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
    debugPrint('FirebasePushService: Background CallKit shown for call $callId from $senderName');
  }

  /// 处理通知点击
  void _handleNotificationTap(RemoteMessage message) {
    final roomId = message.data['room_id'] as String?;
    final eventId = message.data['event_id'] as String?;
    onNotificationTap?.call(roomId, eventId);
  }

  /// 本地通知点击响应
  void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      try {
        final data = json.decode(response.payload!);
        final roomId = data['room_id'] as String?;
        final eventId = data['event_id'] as String?;
        onNotificationTap?.call(roomId, eventId);
      } catch (_) {
        // 忽略解析错误
      }
    }
  }

  /// 后台通知点击响应
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationResponse(NotificationResponse response) {
    // 后台点击会通过 FirebaseMessaging.onMessageOpenedApp 处理
  }

  /// 处理 Matrix 同步更新（用于本地通知）
  void _handleSyncUpdate(matrix.SyncUpdate syncUpdate) {
    if (!_notificationConfig.enabled) return;

    final joinedRooms = syncUpdate.rooms?.join;
    if (joinedRooms == null) return;

    // 记录当前同步时间
    final syncTime = DateTime.now();

    // 首次同步时，只记录时间，不弹通知（避免历史消息弹通知）
    if (_lastSyncTime == null) {
      _lastSyncTime = syncTime;
      debugPrint('FirebasePushService: First sync, skipping notifications for historical messages');
      return;
    }

    for (final entry in joinedRooms.entries) {
      final roomId = entry.key;
      final roomUpdate = entry.value;
      final events = roomUpdate.timeline?.events ?? [];

      for (final event in events) {
        if (_shouldShowNotification(event, roomId)) {
          _showNotificationForEvent(roomId, event);
        }
      }
    }

    _lastSyncTime = syncTime;
  }

  bool _shouldShowNotification(matrix.MatrixEvent event, String roomId) {
    // 通话期间禁用所有消息通知
    if (_isInCall) {
      debugPrint('FirebasePushService: Skipping notification during call');
      return false;
    }

    // 过滤通话相关事件（m.call.*）- 这些由 CallKit 通知处理
    final eventType = event.type;
    if (eventType.startsWith('m.call.')) {
      // 收到来电事件时，立即设置通话状态，防止后续消息通知
      if (eventType == 'm.call.invite' && event.senderId != _client.userID) {
        setInCall(true);
        debugPrint('FirebasePushService: Set isInCall=true for incoming call event');
      }
      // 对方挂断或拒接 → 清除通话状态
      if (eventType == 'm.call.hangup' || eventType == 'm.call.reject') {
        if (_isInCall) {
          setInCall(false);
          debugPrint('FirebasePushService: Cleared _isInCall on sync $eventType');
        }
      }
      debugPrint('FirebasePushService: Skipping notification for call event: $eventType');
      return false;
    }

    // 只显示消息类型的通知
    if (eventType != matrix.EventTypes.Message) return false;

    // 不显示自己发送的消息
    if (event.senderId == _client.userID) return false;

    // 不显示当前正在查看的房间的消息
    if (_activeRoomId == roomId) {
      debugPrint('FirebasePushService: Skipping notification for active room $roomId');
      return false;
    }

    // 检查消息时间戳，只显示新消息的通知
    final originServerTs = event.originServerTs;
    if (_lastSyncTime != null) {
      // 只显示在上次同步之后产生的消息
      // 给 5 秒的容差，避免网络延迟导致的问题
      final threshold = _lastSyncTime!.subtract(const Duration(seconds: 5));
      if (originServerTs.isBefore(threshold)) {
        debugPrint('FirebasePushService: Skipping notification for old message (${originServerTs.toIso8601String()})');
        return false;
      }
    }

    // 检查房间是否静音
    final room = _client.getRoomById(roomId);
    if (room != null && room.pushRuleState == matrix.PushRuleState.dontNotify) {
      return false;
    }

    // 检查免打扰
    if (_notificationConfig.isInDoNotDisturbPeriod()) {
      return false;
    }

    return true;
  }

  void _showNotificationForEvent(String roomId, matrix.MatrixEvent event) {
    final room = _client.getRoomById(roomId);
    if (room == null) return;

    final senderName = room.unsafeGetUserFromMemoryOrFallback(event.senderId).calcDisplayname();
    final roomName = room.getLocalizedDisplayname();
    final body = _getNotificationBody(event);

    String title;
    if (room.isDirectChat) {
      title = senderName;
    } else {
      title = roomName;
    }

    showLocalNotification(
      title: title,
      body: _notificationConfig.showPreview ? body : 'You have a new message',
      roomId: roomId,
      eventId: event.eventId,
    );
  }

  String _getNotificationBody(matrix.MatrixEvent event) {
    final content = event.content;
    final msgType = content['msgtype'] as String?;

    switch (msgType) {
      case 'm.text':
        return content['body'] as String? ?? '';
      case 'm.image':
        return '[Image]';
      case 'm.video':
        return '[Video]';
      case 'm.audio':
        return '[Voice Message]';
      case 'm.file':
        return '[File]';
      case 'm.location':
        return '[Location]';
      case 'm.sticker':
        return '[Sticker]';
      default:
        return '[Message]';
    }
  }

  @override
  Future<void> registerForPush() async {
    // 如果 FCM Token 还没有获取到，尝试获取
    if (_fcmToken == null) {
      debugPrint('FirebasePushService: FCM token is null, attempting to get token...');
      _fcmToken = await _getFCMTokenWithRetry(maxRetries: 2);
    }

    if (_fcmToken == null) {
      debugPrint('FirebasePushService: Cannot register push - FCM token is null');
      return;
    }
    if (pushGatewayUrl == null) {
      debugPrint('FirebasePushService: Cannot register push - pushGatewayUrl is null');
      return;
    }

    // iOS: 优先使用 APNs token 作为 pushkey
    // Sygnal 服务器为 iOS (appId=*.ios) 通常配置 type: apns，需要 APNs device token
    // Android: 使用 FCM token
    final String pushkey;
    if (Platform.isIOS && _apnsToken != null) {
      pushkey = _apnsToken!;
      debugPrint('FirebasePushService: iOS using APNs token as pushkey');
    } else {
      pushkey = _fcmToken!;
      debugPrint('FirebasePushService: Using FCM token as pushkey');
    }

    try {
      debugPrint('FirebasePushService: Registering pusher...');
      debugPrint('  appId: $appId');
      debugPrint('  pushkeyType: $pushkeyType');
      debugPrint('  gateway: $pushGatewayUrl');
      debugPrint('  pushkey: ${pushkey.substring(0, 10)}...');

      // 注册 Pusher 到 Matrix 服务器
      await _client.postPusher(
        matrix.Pusher(
          pushkey: pushkey,
          kind: pushkeyType,
          appId: appId,
          appDisplayName: 'N42 Chat',
          deviceDisplayName: _client.deviceName ?? 'Unknown Device',
          lang: 'en',
          data: matrix.PusherData(
            url: Uri.parse(pushGatewayUrl!),
            // iOS (APNs): 不使用 event_id_only，让 Sygnal 发送完整通知内容
            // (包含 alert/sound/badge)，否则 APNs 只收到静默推送不会显示给用户。
            // Android (FCM): 使用 event_id_only，由 Firebase onBackgroundMessage 处理。
            format: Platform.isIOS ? null : 'event_id_only',
          ),
        ),
        append: false,
      );
      debugPrint('FirebasePushService: Pusher registered successfully');
    } catch (e) {
      debugPrint('FirebasePushService: Failed to register push: $e');
    }
  }

  @override
  Future<void> unregisterPush() async {
    // 使用与注册时相同的 pushkey
    final String? pushkey;
    if (Platform.isIOS && _apnsToken != null) {
      pushkey = _apnsToken;
    } else {
      pushkey = _fcmToken;
    }
    if (pushkey == null) return;

    try {
      await _client.deletePusher(
        matrix.Pusher(
          pushkey: pushkey,
          kind: '',
          appId: appId,
          appDisplayName: 'N42 Chat',
          deviceDisplayName: _client.deviceName ?? 'Unknown Device',
          lang: 'en',
          data: matrix.PusherData(),
        ),
      );
    } catch (_) {
      // 忽略注销错误
    }
  }

  @override
  Future<void> handleNotification(Map<String, dynamic> message) async {
    final roomId = message['room_id'] as String?;
    final eventId = message['event_id'] as String?;
    onNotificationTap?.call(roomId, eventId);
  }

  @override
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? roomId,
    String? eventId,
    String? imageUrl,
  }) async {
    if (_localNotifications == null) return;

    try {
      // 构建 payload
      final payload = json.encode({
        'room_id': roomId,
        'event_id': eventId,
      });

      // 使用时间戳生成唯一通知 ID
      final notificationId = DateTime.now().millisecondsSinceEpoch % 2147483647;

      // Android 通知详情
      final androidDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
        groupKey: 'n42_chat_messages',
        category: AndroidNotificationCategory.message,
        fullScreenIntent: true,
      );

      // iOS 通知详情
      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications!.show(
        id: notificationId,
        title: title,
        body: body,
        notificationDetails: details,
        payload: payload,
      );
    } catch (_) {
      // 忽略通知显示错误
    }
  }

  @override
  Future<void> clearNotificationsForRoom(String roomId) async {
    if (_localNotifications == null) return;
    final notificationId = roomId.hashCode;
    await _localNotifications!.cancel(id: notificationId);
  }

  @override
  Future<void> clearAllNotifications() async {
    if (_localNotifications == null) return;
    await _localNotifications!.cancelAll();
  }

  @override
  Future<NotificationPermissionStatus> getPermissionStatus() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return NotificationPermissionStatus.granted;
      case AuthorizationStatus.denied:
        return NotificationPermissionStatus.denied;
      case AuthorizationStatus.notDetermined:
        return NotificationPermissionStatus.notDetermined;
      case AuthorizationStatus.provisional:
        return NotificationPermissionStatus.granted;
    }
  }

  @override
  Future<bool> requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized ||
           settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// 获取当前 FCM Token
  String? get fcmToken => _fcmToken;

  /// 获取当前 APNs Token (iOS only)
  String? get apnsToken => _apnsToken;

  /// 释放资源
  Future<void> dispose() async {
    await _foregroundSubscription?.cancel();
    await _tokenRefreshSubscription?.cancel();
    await _syncSubscription?.cancel();
    _callStateResetTimer?.cancel();
    _isInitialized = false;
  }
}

/// Firebase 推送服务构建器
class FirebasePushServiceBuilder {
  matrix.Client? _client;
  String? _pushGatewayUrl;
  String _appId = 'com.n42.chat';
  String _pushkeyType = 'http';
  void Function(String?, String?)? _onNotificationTap;

  FirebasePushServiceBuilder();

  FirebasePushServiceBuilder withClient(matrix.Client client) {
    _client = client;
    return this;
  }

  FirebasePushServiceBuilder withPushGatewayUrl(String url) {
    _pushGatewayUrl = url;
    return this;
  }

  FirebasePushServiceBuilder withAppId(String appId) {
    _appId = appId;
    return this;
  }

  FirebasePushServiceBuilder withPushkeyType(String type) {
    _pushkeyType = type;
    return this;
  }

  FirebasePushServiceBuilder withNotificationTapHandler(
    void Function(String? roomId, String? eventId) handler,
  ) {
    _onNotificationTap = handler;
    return this;
  }

  FirebasePushService build() {
    if (_client == null) {
      throw StateError('Matrix client is required');
    }

    return FirebasePushService(
      _client!,
      pushGatewayUrl: _pushGatewayUrl,
      appId: _appId,
      pushkeyType: _pushkeyType,
      onNotificationTap: _onNotificationTap,
    );
  }
}
