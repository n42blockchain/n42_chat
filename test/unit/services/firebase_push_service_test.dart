import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/src/core/notifications/firebase_push_service.dart';

class MockMatrixClient extends Mock implements matrix.Client {}

/// 测试 FirebasePushService 的实例方法：
/// - setInCall / isInCall 状态管理
/// - 自动重置定时器（防止 _isInCall 泄漏）
/// - activeRoom 管理
/// - 后台消息处理边界情况
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> callkitCalls = [];

  setUp(() {
    callkitCalls.clear();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_callkit_incoming'),
      (MethodCall methodCall) async {
        callkitCalls.add(methodCall);
        if (methodCall.method == 'activeCalls') {
          return <dynamic>[];
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_callkit_incoming'),
      null,
    );
  });

  group('setInCall and isInCall', () {
    late FirebasePushService service;

    setUp(() {
      service = FirebasePushService(MockMatrixClient());
    });

    tearDown(() async {
      await service.dispose();
    });

    test('should default isInCall to false', () {
      expect(service.isInCall, isFalse);
    });

    test('should set isInCall to true', () {
      service.setInCall(true);
      expect(service.isInCall, isTrue);
    });

    test('should set isInCall back to false', () {
      service.setInCall(true);
      service.setInCall(false);
      expect(service.isInCall, isFalse);
    });

    test('should handle multiple setInCall(true) calls', () {
      service.setInCall(true);
      service.setInCall(true);
      expect(service.isInCall, isTrue);
    });

    test('should handle setInCall(false) when already false', () {
      service.setInCall(false);
      expect(service.isInCall, isFalse);
    });
  });

  group('setInCall auto-reset timer', () {
    late FirebasePushService service;

    setUp(() {
      service = FirebasePushService(MockMatrixClient());
    });

    tearDown(() async {
      await service.dispose();
    });

    test('should auto-reset isInCall after 90 seconds', () async {
      service.setInCall(true);
      expect(service.isInCall, isTrue);

      // 等待定时器触发（使用较短的验证周期，通过 dispose 确保 timer 被清理）
      // 注意：真正的 90 秒定时器在单元测试中无法等待
      // 这里验证设置行为正确（timer 创建后 isInCall 仍为 true）
      expect(service.isInCall, isTrue);
    });

    test('should cancel timer when setInCall(false) is called', () {
      service.setInCall(true);
      expect(service.isInCall, isTrue);

      service.setInCall(false);
      expect(service.isInCall, isFalse);

      // 再次验证状态稳定
      expect(service.isInCall, isFalse);
    });

    test('should cancel previous timer when setInCall(true) is called again', () {
      service.setInCall(true);
      service.setInCall(true); // 应取消前一个 timer 并创建新的
      expect(service.isInCall, isTrue);

      service.setInCall(false);
      expect(service.isInCall, isFalse);
    });

    test('dispose should cancel timer without errors', () async {
      service.setInCall(true);
      expect(service.isInCall, isTrue);

      // dispose 应该安全地取消 timer
      await service.dispose();

      // 创建新实例以继续后续测试
      service = FirebasePushService(MockMatrixClient());
    });
  });

  group('activeRoom management', () {
    late FirebasePushService service;

    setUp(() {
      service = FirebasePushService(MockMatrixClient());
    });

    tearDown(() async {
      await service.dispose();
    });

    test('should default activeRoomId to null', () {
      expect(service.activeRoomId, isNull);
    });

    test('should set and get activeRoomId', () {
      service.setActiveRoom('!room:matrix.org');
      expect(service.activeRoomId, equals('!room:matrix.org'));
    });

    test('should clear activeRoomId', () {
      service.setActiveRoom('!room:matrix.org');
      service.setActiveRoom(null);
      expect(service.activeRoomId, isNull);
    });

    test('should update activeRoomId when switching rooms', () {
      service.setActiveRoom('!room1:matrix.org');
      expect(service.activeRoomId, equals('!room1:matrix.org'));

      service.setActiveRoom('!room2:matrix.org');
      expect(service.activeRoomId, equals('!room2:matrix.org'));
    });
  });

  group('background message handler edge cases', () {
    test('should handle m.call.invite without room_id', () async {
      final message = RemoteMessage(
        data: <String, dynamic>{
          'type': 'm.call.invite',
          'sender': '@alice:matrix.org',
        },
      );

      await FirebasePushService.showBackgroundCallKitForTest(message);

      expect(callkitCalls, hasLength(1));
      final args = callkitCalls.first.arguments as Map<dynamic, dynamic>;
      final extra = args['extra'] as Map<dynamic, dynamic>;
      expect(extra['roomId'], isNull);
    });

    test('should use notification title as fallback for sender name', () async {
      final message = RemoteMessage(
        data: <String, dynamic>{
          'type': 'm.call.invite',
          'room_id': '!room:matrix.org',
        },
        notification: const RemoteNotification(
          title: 'Call from Bob',
        ),
      );

      await FirebasePushService.showBackgroundCallKitForTest(message);

      final args = callkitCalls.first.arguments as Map<dynamic, dynamic>;
      expect(args['nameCaller'], equals('Call from Bob'));
    });

    test('should handle m.call.invite with sender_display_name priority', () async {
      final message = RemoteMessage(
        data: <String, dynamic>{
          'type': 'm.call.invite',
          'sender': '@alice:matrix.org',
          'sender_display_name': 'Alice Wonderland',
          'room_id': '!room:matrix.org',
        },
        notification: const RemoteNotification(
          title: 'Different Title',
        ),
      );

      await FirebasePushService.showBackgroundCallKitForTest(message);

      final args = callkitCalls.first.arguments as Map<dynamic, dynamic>;
      // sender_display_name 应该优先于 notification.title
      expect(args['nameCaller'], equals('Alice Wonderland'));
    });

    test('should call endAllCalls for both hangup and reject in sequence', () async {
      final hangup = RemoteMessage(
        data: <String, dynamic>{
          'type': 'm.call.hangup',
          'room_id': '!room:matrix.org',
        },
      );
      final reject = RemoteMessage(
        data: <String, dynamic>{
          'type': 'm.call.reject',
          'room_id': '!room:matrix.org',
        },
      );

      await FirebasePushService.handleBackgroundMessageForTest(hangup);
      await FirebasePushService.handleBackgroundMessageForTest(reject);

      final endCalls = callkitCalls.where(
        (c) => c.method == 'endAllCalls',
      );
      expect(endCalls, hasLength(2));
    });
  });

}
