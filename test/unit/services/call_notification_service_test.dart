import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/services/voip/call_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> callkitCalls = <MethodCall>[];

  setUp(() {
    callkitCalls.clear();
    SharedPreferences.setMockInitialValues({});

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('flutter_callkit_incoming'),
          (MethodCall methodCall) async {
            callkitCalls.add(methodCall);
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

  Future<void> nativeEvent(
    String action,
    String id, {
    Map<String, dynamic> extraBody = const {},
  }) async {
    final done = Completer<void>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          'flutter_callkit_incoming_events',
          const StandardMethodCodec().encodeSuccessEnvelope({
            'event': 'com.hiennv.flutter_callkit_incoming.$action',
            'body': {
              'id': id,
              'nameCaller': 'Alice',
              'handle': '@alice:hs',
              'extra': {'roomId': '!room:hs', 'callerId': '@alice:hs'},
              ...extraBody,
            },
          }),
          (_) => done.complete(),
        );
    await done.future;
    await Future<void>.delayed(Duration.zero);
  }

  for (final entry in {
    'ACTION_CALL_ACCEPT': CallAction.accept,
    'ACTION_CALL_DECLINE': CallAction.decline,
    'ACTION_CALL_TIMEOUT': CallAction.timeout,
    'ACTION_CALL_CALLBACK': CallAction.callback,
  }.entries) {
    test('typed native ${entry.key} preserves call identity', () async {
      final service = CallNotificationService();
      await service.initialize();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_INCOMING', 'typed-${entry.key}');
      await nativeEvent(entry.key, 'typed-${entry.key}');
      expect(actions.single.$1, entry.value);
      expect(actions.single.$2.callId, 'typed-${entry.key}');
      expect(actions.single.$2.callerId, '@alice:hs');
      expect(actions.single.$2.roomId, '!room:hs');
      if (entry.value == CallAction.accept) {
        expect(
          service.consumePendingAcceptAction()?.$2.callId,
          'typed-${entry.key}',
        );
        expect(service.consumePendingAcceptAction(), isNull);
      }
    });
  }

  test(
    'typed hold and mute events never become accept or end actions',
    () async {
      final service = CallNotificationService();
      await service.initialize();
      final actions = <CallAction>[];
      final sub = service.callActions.listen((event) => actions.add(event.$1));
      addTearDown(sub.cancel);
      for (final enabled in [true, false]) {
        await nativeEvent(
          'ACTION_CALL_TOGGLE_HOLD',
          'held-call',
          extraBody: {'isOnHold': enabled},
        );
        await nativeEvent(
          'ACTION_CALL_TOGGLE_MUTE',
          'muted-call',
          extraBody: {'isMuted': enabled},
        );
      }
      expect(actions, isEmpty);
    },
  );

  test(
    'call metadata retention is bounded to the most recent 64 calls',
    () async {
      final service = CallNotificationService();
      service.dispose();
      await Future<void>.delayed(Duration.zero);
      await service.initialize();
      for (var index = 0; index < 65; index++) {
        await nativeEvent('ACTION_CALL_INCOMING', 'bounded-$index');
      }
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_CALLBACK', 'bounded-0');
      await nativeEvent('ACTION_CALL_CALLBACK', 'bounded-64');
      expect(actions.first.$2.callId, 'bounded-0');
      expect(actions.first.$2.callerId, isEmpty);
      expect(actions.last.$2.callerId, '@alice:hs');
      service.dispose();
    },
  );

  test('timeout clears retained call metadata', () async {
    final service = CallNotificationService();
    await service.initialize();
    final actions = <(CallAction, IncomingCallInfo)>[];
    final sub = service.callActions.listen(actions.add);
    addTearDown(sub.cancel);
    await nativeEvent('ACTION_CALL_INCOMING', 'expiring-call');
    await nativeEvent('ACTION_CALL_TIMEOUT', 'expiring-call');
    await nativeEvent('ACTION_CALL_CALLBACK', 'expiring-call');
    expect(actions.first.$2.callerId, '@alice:hs');
    expect(actions.last.$2.callId, 'expiring-call');
    expect(actions.last.$2.callerId, isEmpty);
    expect(service.currentCallId, isNull);
  });

  test('localized answer labels are passed to Android parameters', () async {
    await CallNotificationService().showIncomingCall(
      callerId: '@alice:hs',
      callerName: 'Alice',
      textAccept: 'Accept custom',
      textDecline: 'Decline custom',
    );
    final args =
        callkitCalls
                .firstWhere((c) => c.method == 'showCallkitIncoming')
                .arguments
            as Map;
    expect(args['android']['textAccept'], 'Accept custom');
    expect(args['android']['textDecline'], 'Decline custom');
  });

  test(
    'Android acceptance silences only the connected call without ending it',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      addTearDown(() {
        debugDefaultTargetPlatformOverride = null;
      });
      final service = CallNotificationService();
      await service.setCallConnected('answered-call');
      expect(callkitCalls.map((c) => c.method), [
        'hideCallkitIncoming',
        'callConnected',
      ]);
      expect(callkitCalls.first.arguments['id'], 'answered-call');
      expect(
        callkitCalls.any(
          (c) => c.method == 'endAllCalls' || c.method == 'endCall',
        ),
        isFalse,
      );
    },
  );

  test('system hangup emits an end action for the active call', () async {
    final service = CallNotificationService();
    await service.initialize();
    final id = await service.showOutgoingCall(
      calleeId: '@alice:hs',
      calleeName: 'Alice',
    );
    final actions = <CallAction>[];
    final sub = service.callActions.listen((event) => actions.add(event.$1));
    await nativeEvent('ACTION_CALL_ENDED', id);
    expect(actions, [CallAction.ended]);
    expect(service.currentCallId, isNull);
    await sub.cancel();
  });

  test(
    'programmatic dismissal does not hang up an accepted or subsequent call',
    () async {
      final service = CallNotificationService();
      final old = await service.showOutgoingCall(
        calleeId: '@alice:hs',
        calleeName: 'Alice',
      );
      await service.endAllCalls();
      final next = await service.showOutgoingCall(
        calleeId: '@bob:hs',
        calleeName: 'Bob',
      );
      final actions = <CallAction>[];
      final sub = service.callActions.listen((event) => actions.add(event.$1));
      await nativeEvent('ACTION_CALL_ENDED', old);
      expect(actions, isEmpty);
      expect(service.currentCallId, next);
      await nativeEvent('ACTION_CALL_ENDED', next);
      expect(actions, [CallAction.ended]);
      await sub.cancel();
    },
  );

  test(
    'native actions remain connected after dispose and reinitialize',
    () async {
      final service = CallNotificationService();
      service.dispose();
      await Future<void>.delayed(Duration.zero);
      await service.initialize();
      final id = await service.showOutgoingCall(
        calleeId: '@alice:hs',
        calleeName: 'Alice',
      );
      final actions = <CallAction>[];
      final sub = service.callActions.listen((event) => actions.add(event.$1));
      await nativeEvent('ACTION_CALL_ENDED', id);
      expect(actions, [CallAction.ended]);
      await sub.cancel();
    },
  );

  test(
    'showIncomingCall uses stored ringtone preference for CallKit params',
    () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'n42_chat_incoming_call_ringtone':
            '{"mode":"silent","label":"Silent","sourceKey":"silent"}',
      });

      await CallNotificationService().showIncomingCall(
        callerId: '@alice:matrix.org',
        callerName: 'Alice',
      );

      expect(callkitCalls, isNotEmpty);
      final incoming = callkitCalls.firstWhere(
        (call) => call.method == 'showCallkitIncoming',
      );
      final args = incoming.arguments as Map<dynamic, dynamic>;
      final android = args['android'] as Map<dynamic, dynamic>;
      final ios = args['ios'] as Map<dynamic, dynamic>;

      expect(incoming.method, 'showCallkitIncoming');
      expect(android['ringtonePath'], 'silent');
      expect(ios['ringtonePath'], 'system_ringtone_default');
    },
  );
}
