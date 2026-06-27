import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/notifications/firebase_push_service.dart';
import 'package:n42_chat/src/core/notifications/push_dedup_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockMatrixClient extends Mock implements matrix.Client {}

/// 覆盖通知重复 / 丢失修复的回归测试：
/// - 后台消息按 event_id 跨 isolate 去重（同事件只弹一次）
/// - 后台通知 ID 用稳定哈希（进程重启不再覆盖通知栏旧通知）
/// - 本地通知点击的宿主回退路由（非聊天 payload 转交宿主）
/// - resume catch-up 时间闸门（解锁瞬间不再重复弹后台期间的消息）
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> notificationCalls = [];

  setUp(() {
    notificationCalls.clear();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    FirebasePushService.hostFallbackNotificationTapHandler = null;

    // 测试环境无插件注册流程，手动安装 Android 平台实现，
    // 使 show/initialize 走下面 mock 的 MethodChannel。
    FlutterLocalNotificationsPlatform.instance =
        AndroidFlutterLocalNotificationsPlugin();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (MethodCall methodCall) async {
        notificationCalls.add(methodCall);
        if (methodCall.method == 'initialize') {
          return true;
        }
        if (methodCall.method == 'getNotificationAppLaunchDetails') {
          return null;
        }
        return null;
      },
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_callkit_incoming'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'activeCalls') {
          return <dynamic>[];
        }
        return null;
      },
    );
  });

  tearDown(() {
    FirebasePushService.hostFallbackNotificationTapHandler = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      null,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_callkit_incoming'),
      null,
    );
  });

  List<MethodCall> showCalls() =>
      notificationCalls.where((c) => c.method == 'show').toList();

  group('background message dedup', () {
    test('same event_id only shows one notification', () async {
      const message = RemoteMessage(
        messageId: 'fcm-1',
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$dup-event-1',
        },
      );

      await FirebasePushService.handleBackgroundMessageForTest(message);
      expect(showCalls(), hasLength(1));

      // FCM at-least-once 重发同一条消息 → 不应再弹。
      await FirebasePushService.handleBackgroundMessageForTest(message);
      expect(showCalls(), hasLength(1));
    });

    test('different events each show a notification', () async {
      const m1 = RemoteMessage(
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$evt-a',
        },
      );
      const m2 = RemoteMessage(
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$evt-b',
        },
      );

      await FirebasePushService.handleBackgroundMessageForTest(m1);
      await FirebasePushService.handleBackgroundMessageForTest(m2);

      expect(showCalls(), hasLength(2));
    });

    test('uses stable notification id derived from event_id', () async {
      const message = RemoteMessage(
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$stable-evt',
        },
      );

      await FirebasePushService.handleBackgroundMessageForTest(message);

      final args = showCalls().single.arguments as Map<dynamic, dynamic>;
      expect(
        args['id'],
        PushDedupStore.notificationIdForKey(r'$stable-evt'),
        reason: '通知 ID 必须由 event_id 稳定派生，进程重启后不变，'
            '避免计数器归零覆盖通知栏旧通知',
      );
    });

    test('falls back to messageId for dedup when event_id missing', () async {
      const message = RemoteMessage(
        messageId: 'fcm-only-id',
        data: <String, dynamic>{'room_id': '!room:m.org'},
      );

      await FirebasePushService.handleBackgroundMessageForTest(message);
      await FirebasePushService.handleBackgroundMessageForTest(message);

      expect(showCalls(), hasLength(1));
    });

    test('event already notified by another channel is skipped', () async {
      // 模拟主 isolate（sync 路径）已为该事件弹过通知。
      expect(
        await PushDedupStore.instance.tryMarkNotified(r'$cross-channel'),
        isTrue,
      );

      const message = RemoteMessage(
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$cross-channel',
        },
      );
      await FirebasePushService.handleBackgroundMessageForTest(message);

      expect(showCalls(), isEmpty);
    });
  });

  group('notification tap fallback routing', () {
    late FirebasePushService service;
    late List<(String?, String?)> chatTaps;

    setUp(() {
      chatTaps = [];
      service = FirebasePushService(
        MockMatrixClient(),
        onNotificationTap: (roomId, eventId) => chatTaps.add((roomId, eventId)),
      );
    });

    tearDown(() async {
      await service.dispose();
    });

    test('chat payload routes to onNotificationTap', () {
      service.handleNotificationResponseForTest(
        const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: '{"room_id":"!room:m.org","event_id":"\$evt"}',
        ),
      );

      expect(chatTaps, [('!room:m.org', r'$evt')]);
    });

    test('non-chat payload routes to host fallback handler', () {
      final hostPayloads = <String>[];
      FirebasePushService.hostFallbackNotificationTapHandler =
          hostPayloads.add;

      final payload = json.encode({'type': 'device_login', 'device_id': 'x'});
      service.handleNotificationResponseForTest(
        NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: payload,
        ),
      );

      expect(hostPayloads, [payload],
          reason: '无 room_id 的宿主通知 payload 必须转交宿主回退处理器');
      expect(chatTaps, isEmpty,
          reason: '宿主通知不应触发聊天跳转回调');
    });

    test('non-chat payload without fallback keeps legacy behavior', () {
      service.handleNotificationResponseForTest(
        const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: '{"type":"transfer"}',
        ),
      );

      expect(chatTaps, [(null, null)]);
    });

    test('malformed payload is ignored without throwing', () {
      service.handleNotificationResponseForTest(
        const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: 'not-json{{{',
        ),
      );

      expect(chatTaps, isEmpty);
    });
  });

  group('isResumeCatchUpEvent', () {
    final resumedAt = DateTime(2026, 6, 12, 10, 0, 0);

    test('message produced while backgrounded is catch-up', () {
      expect(
        isResumeCatchUpEvent(
          originServerTs: resumedAt.subtract(const Duration(minutes: 5)),
          lastResumedAt: resumedAt,
        ),
        isTrue,
      );
    });

    test('real-time message after resume is not catch-up', () {
      expect(
        isResumeCatchUpEvent(
          originServerTs: resumedAt.add(const Duration(seconds: 1)),
          lastResumedAt: resumedAt,
        ),
        isFalse,
      );
    });

    test('clock-skew tolerance protects borderline real-time messages', () {
      // 服务器时钟比设备慢 20s 的实时消息不应被误杀。
      expect(
        isResumeCatchUpEvent(
          originServerTs: resumedAt.subtract(const Duration(seconds: 20)),
          lastResumedAt: resumedAt,
        ),
        isFalse,
      );
      // 超出容差（30s）则视为后台期间的消息。
      expect(
        isResumeCatchUpEvent(
          originServerTs: resumedAt.subtract(const Duration(seconds: 31)),
          lastResumedAt: resumedAt,
        ),
        isTrue,
      );
    });
  });

  group('foreground message routing (audit regressions)', () {
    late MockMatrixClient client;
    late FirebasePushService service;

    setUp(() {
      client = MockMatrixClient();
      when(() => client.userID).thenReturn('@me:m.org');
      when(() => client.getRoomById(any())).thenReturn(null);
      service = FirebasePushService(client);
    });

    tearDown(() async {
      await service.dispose();
    });

    test('non-chat message is ignored and does not consume dedup mark',
        () async {
      const message = RemoteMessage(
        messageId: 'host-msg-1',
        data: <String, dynamic>{'type': 'device_login', 'device_id': 'x'},
      );

      await service.handleForegroundMessageForTest(message);

      expect(showCalls(), isEmpty,
          reason: '无 room_id 的宿主推送不归聊天插件展示');
      expect(
        await PushDedupStore.instance.tryMarkNotified('host-msg-1'),
        isTrue,
        reason: '不得抢占宿主监听器的 messageId 去重标记',
      );
    });

    test('chat message shows once, duplicate delivery is skipped', () async {
      const message = RemoteMessage(
        messageId: 'fcm-fg-1',
        data: <String, dynamic>{
          'room_id': '!room:m.org',
          'event_id': r'$fg-evt-1',
        },
      );

      await service.handleForegroundMessageForTest(message);
      expect(showCalls(), hasLength(1));

      await service.handleForegroundMessageForTest(message);
      expect(showCalls(), hasLength(1));
    });

    test('active room message is skipped without consuming dedup mark',
        () async {
      service.setActiveRoom('!active:m.org');
      const message = RemoteMessage(
        data: <String, dynamic>{
          'room_id': '!active:m.org',
          'event_id': r'$active-evt',
        },
      );

      await service.handleForegroundMessageForTest(message);

      expect(showCalls(), isEmpty);
      expect(
        await PushDedupStore.instance.tryMarkNotified(r'$active-evt'),
        isTrue,
        reason: '正在查看的房间不弹通知，但不应消耗其他通道的去重标记',
      );
    });
  });

  group('active room suppression is foreground-only (T2 #6 regression)', () {
    late MockMatrixClient client;
    late FirebasePushService service;

    setUp(() {
      client = MockMatrixClient();
      when(() => client.userID).thenReturn('@me:m.org');
      when(() => client.getRoomById(any())).thenReturn(null);
      service = FirebasePushService(client);
    });
    tearDown(() async {
      await service.dispose();
    });

    matrix.MatrixEvent freshMsg() => matrix.MatrixEvent(
          type: 'm.room.message',
          content: const <String, Object?>{'msgtype': 'm.text', 'body': 'hi'},
          senderId: '@other:m.org',
          eventId: r'$t2-6',
          originServerTs: DateTime.now(),
        );

    test('foreground + active room -> suppressed', () {
      service.setActiveRoom('!room:m.org');
      service.setAppInForegroundForTest(value: true);
      expect(
        service.shouldShowNotificationForTest(freshMsg(), '!room:m.org'),
        isFalse,
      );
    });

    test('background + active room -> notifies (not suppressed)', () {
      // 真机 T2 #6：按 Home 键后台，activeRoom 残留，sync 投递的消息
      // 不应被 active-room 静默——后台用户并未「正在查看」。
      service.setActiveRoom('!room:m.org');
      service.setAppInForegroundForTest(value: false);
      expect(
        service.shouldShowNotificationForTest(freshMsg(), '!room:m.org'),
        isTrue,
      );
    });
  });

  group('sync path dedup ordering (audit regressions)', () {
    late MockMatrixClient client;
    late FirebasePushService service;

    setUp(() {
      client = MockMatrixClient();
      when(() => client.userID).thenReturn('@me:m.org');
      when(() => client.getRoomById(any())).thenReturn(null);
      service = FirebasePushService(client);
    });

    tearDown(() async {
      await service.dispose();
    });

    matrix.SyncUpdate syncWithMessage(String eventId) {
      return matrix.SyncUpdate(
        nextBatch: 'batch',
        rooms: matrix.RoomsUpdate(
          join: <String, matrix.JoinedRoomUpdate>{
            '!room:m.org': matrix.JoinedRoomUpdate(
              timeline: matrix.TimelineUpdate(
                events: <matrix.MatrixEvent>[
                  matrix.MatrixEvent(
                    type: 'm.room.message',
                    content: const <String, Object?>{
                      'msgtype': 'm.text',
                      'body': 'hi',
                    },
                    senderId: '@other:m.org',
                    eventId: eventId,
                    originServerTs: DateTime.now(),
                  ),
                ],
              ),
            ),
          },
        ),
      );
    }

    test('unknown room does not consume the dedup mark', () async {
      // 首次 sync 仅记录时间、跳过历史消息。
      service.handleSyncUpdateForTest(syncWithMessage(r'$warmup'));
      // 第二次 sync：事件可见，但 getRoomById 返回 null → 不弹。
      service.handleSyncUpdateForTest(syncWithMessage(r'$no-room-evt'));
      // 让 fire-and-forget 的通知 future 完成。
      await Future<void>.delayed(Duration.zero);

      expect(showCalls(), isEmpty);
      expect(
        await PushDedupStore.instance.tryMarkNotified(r'$no-room-evt'),
        isTrue,
        reason: 'room 未同步到本地时不得消耗去重标记，'
            '否则 FCM 路径的同一事件会被跳过、通知永久丢失',
      );
    });
  });

  group('showLocalNotification stable id', () {
    late FirebasePushService service;

    setUp(() {
      service = FirebasePushService(MockMatrixClient());
    });

    tearDown(() async {
      await service.dispose();
    });

    test('same event always maps to the same notification id', () async {
      // 直接调用展示 API 不做去重（去重在各消息路径入口），但同一
      // 事件必须映射到同一通知 ID —— 竞态双弹时原地覆盖而非叠加。
      await service.showLocalNotification(
        title: 'A',
        body: 'b1',
        roomId: '!r:m.org',
        eventId: r'$same-evt',
      );
      await service.showLocalNotification(
        title: 'A',
        body: 'b2',
        roomId: '!r:m.org',
        eventId: r'$same-evt',
      );

      final ids = showCalls()
          .map((c) => (c.arguments as Map<dynamic, dynamic>)['id'])
          .toSet();
      expect(ids, hasLength(1));
      expect(ids.single, PushDedupStore.notificationIdForKey(r'$same-evt'));
    });
  });
}
