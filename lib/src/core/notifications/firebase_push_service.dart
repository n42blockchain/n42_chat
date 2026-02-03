import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matrix/matrix.dart' as matrix;

import 'push_notification_service.dart';

/// 后台消息处理器 - 必须是顶级函数
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 确保 Firebase 已初始化
  await Firebase.initializeApp();

  debugPrint('N42Chat: Background message received: ${message.messageId}');

  // 处理后台推送
  await FirebasePushService._handleBackgroundMessage(message);
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

  /// 静态实例（用于后台处理）
  static FirebasePushService? _instance;

  /// 通知配置
  NotificationConfig _notificationConfig = const NotificationConfig();

  FirebasePushService(
    this._client, {
    this.pushGatewayUrl,
    this.appId = 'com.n42.chat',
    this.pushkeyType = 'http',
    this.onNotificationTap,
  }) {
    _instance = this;
  }

  /// 设置通知配置
  void setNotificationConfig(NotificationConfig config) {
    _notificationConfig = config;
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 初始化本地通知
      await _initializeLocalNotifications();

      // 设置后台消息处理器
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        debugPrint('N42Chat: FCM token refreshed');
        // 重新注册推送
        if (_client.isLogged()) {
          registerForPush();
        }
      });

      // 监听新消息（用于本地通知）
      _syncSubscription = _client.onSync.stream.listen(_handleSyncUpdate);

      _isInitialized = true;
      debugPrint('N42Chat: Firebase push service initialized');
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

    // flutter_local_notifications 20.x 使用命名参数
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

    debugPrint('N42Chat: Notification permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      // 获取 FCM Token
      _fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('N42Chat: FCM token obtained');

      // iOS 还需要获取 APNs Token
      if (Platform.isIOS) {
        _apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        debugPrint('N42Chat: APNs token obtained');
      }
    }
  }

  /// 处理前台消息
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('N42Chat: Foreground message: ${message.messageId}');

    // 检查通知配置
    if (!_notificationConfig.enabled) return;
    if (_notificationConfig.isInDoNotDisturbPeriod()) return;

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
      }
    }

    // 显示本地通知
    final notification = message.notification;
    if (notification != null) {
      showLocalNotification(
        title: notification.title ?? 'New Message',
        body: notification.body ?? '',
        roomId: roomId,
        eventId: eventId,
        imageUrl: notification.android?.imageUrl ?? notification.apple?.imageUrl,
      );
    }
  }

  /// 处理后台消息（静态方法）
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('N42Chat: Background message: ${message.messageId}');

    // 后台消息通常由系统自动显示通知
    // 这里可以添加额外的处理逻辑，如更新徽章数等
  }

  /// 处理通知点击
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('N42Chat: Notification tapped: ${message.messageId}');

    final roomId = message.data['room_id'] as String?;
    final eventId = message.data['event_id'] as String?;

    onNotificationTap?.call(roomId, eventId);
  }

  /// 本地通知点击响应
  void _onNotificationResponse(NotificationResponse response) {
    debugPrint('N42Chat: Local notification tapped: ${response.payload}');

    if (response.payload != null) {
      try {
        final data = json.decode(response.payload!);
        final roomId = data['room_id'] as String?;
        final eventId = data['event_id'] as String?;
        onNotificationTap?.call(roomId, eventId);
      } catch (e) {
        debugPrint('N42Chat: Failed to parse notification payload: $e');
      }
    }
  }

  /// 后台通知点击响应
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationResponse(NotificationResponse response) {
    debugPrint('N42Chat: Background notification tapped: ${response.payload}');
    // 后台点击会通过 FirebaseMessaging.onMessageOpenedApp 处理
  }

  /// 处理 Matrix 同步更新（用于本地通知）
  void _handleSyncUpdate(matrix.SyncUpdate syncUpdate) {
    if (!_notificationConfig.enabled) return;

    final joinedRooms = syncUpdate.rooms?.join;
    if (joinedRooms == null) return;

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
  }

  bool _shouldShowNotification(matrix.MatrixEvent event, String roomId) {
    // 只显示消息类型的通知
    if (event.type != matrix.EventTypes.Message) return false;

    // 不显示自己发送的消息
    if (event.senderId == _client.userID) return false;

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
    if (_fcmToken == null) {
      debugPrint('N42Chat: No FCM token available');
      return;
    }

    if (pushGatewayUrl == null) {
      debugPrint('N42Chat: Push gateway URL not configured');
      return;
    }

    try {
      // 注册 Pusher 到 Matrix 服务器
      await _client.postPusher(
        matrix.Pusher(
          pushkey: _fcmToken!,
          kind: pushkeyType,
          appId: appId,
          appDisplayName: 'N42 Chat',
          deviceDisplayName: _client.deviceName ?? 'Unknown Device',
          lang: 'en',
          data: matrix.PusherData(
            url: Uri.parse(pushGatewayUrl!),
            format: 'event_id_only',
          ),
        ),
        append: false,
      );

      debugPrint('N42Chat: Push registered successfully');
    } catch (e) {
      debugPrint('N42Chat: Failed to register push: $e');
    }
  }

  @override
  Future<void> unregisterPush() async {
    if (_fcmToken == null) return;

    try {
      await _client.deletePusher(
        matrix.Pusher(
          pushkey: _fcmToken!,
          kind: '',
          appId: appId,
          appDisplayName: 'N42 Chat',
          deviceDisplayName: _client.deviceName ?? 'Unknown Device',
          lang: 'en',
          data: matrix.PusherData(),
        ),
      );

      debugPrint('N42Chat: Push unregistered');
    } catch (e) {
      debugPrint('N42Chat: Failed to unregister push: $e');
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

    // 构建 payload
    final payload = json.encode({
      'room_id': roomId,
      'event_id': eventId,
    });

    // 生成通知 ID（使用 roomId 的 hash，这样同一房间的通知会覆盖）
    final notificationId = roomId?.hashCode ?? DateTime.now().millisecondsSinceEpoch;

    // Android 通知详情
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      playSound: _notificationConfig.playSound,
      enableVibration: _notificationConfig.vibrate,
      groupKey: 'n42_chat_messages',
      category: AndroidNotificationCategory.message,
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

    // flutter_local_notifications 18.x 使用命名参数
    await _localNotifications!.show(
      id: notificationId,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  @override
  Future<void> clearNotificationsForRoom(String roomId) async {
    if (_localNotifications == null) return;

    // 使用 roomId 的 hash 作为通知 ID
    final notificationId = roomId.hashCode;
    // flutter_local_notifications 18.x 使用命名参数
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
