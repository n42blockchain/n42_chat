import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:n42_chat/src/core/notifications/firebase_push_service.dart';
import 'package:n42_chat/src/core/notifications/push_recipient_binding_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:matrix/src/utils/cached_stream_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/services/voip/call_manager.dart';
import 'package:n42_chat/src/services/voip/call_notification_service.dart';
import 'package:n42_chat/src/services/voip/webrtc_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Client extends Mock implements matrix.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> callkitCalls = <MethodCall>[];
  String? account;

  setUp(() async {
    callkitCalls.clear();
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    account = '@me:hs';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('flutter_callkit_incoming'),
          (MethodCall methodCall) async {
            callkitCalls.add(methodCall);
            return null;
          },
        );
    await CallNotificationService().initialize(currentAccountId: () => account);
  });

  tearDown(() {
    CallNotificationService().dispose();
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
    bool waitEventLoop = true,
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
    if (waitEventLoop) await Future<void>.delayed(Duration.zero);
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
      final id = entry.value == CallAction.accept
          ? await service.showIncomingCall(
              callerId: '@alice:hs',
              callerName: 'Alice',
              roomId: '!room:hs',
            )
          : 'typed-${entry.key}';
      await nativeEvent('ACTION_CALL_INCOMING', id);
      await nativeEvent(entry.key, id);
      expect(actions.single.$1, entry.value);
      expect(actions.single.$2.callId, id);
      expect(actions.single.$2.callerId, '@alice:hs');
      expect(actions.single.$2.roomId, '!room:hs');
      if (entry.value == CallAction.accept) {
        expect((await service.consumePendingAcceptAction())?.$2.callId, id);
        expect(await service.consumePendingAcceptAction(), isNull);
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
      await service.initialize(currentAccountId: () => account);
      for (var index = 0; index < 65; index++) {
        await nativeEvent('ACTION_CALL_INCOMING', 'bounded-$index');
      }
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_CALLBACK', 'bounded-0');
      await nativeEvent('ACTION_CALL_CALLBACK', 'bounded-64');
      expect(actions, hasLength(1));
      expect(actions.single.$2.callId, 'bounded-64');
      expect(actions.single.$2.callerId, '@alice:hs');
      service.dispose();
    },
  );

  test(
    'timeout callback retains routing metadata and consumes it once',
    () async {
      final service = CallNotificationService();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_INCOMING', 'missed-call');
      await nativeEvent('ACTION_CALL_TIMEOUT', 'missed-call');
      await nativeEvent('ACTION_CALL_CALLBACK', 'missed-call');
      expect(actions.last.$1, CallAction.callback);
      expect(actions.last.$2.callId, 'missed-call');
      expect(actions.last.$2.callerId, '@alice:hs');
      expect(actions.last.$2.roomId, '!room:hs');
      expect(service.currentCallId, isNull);
      await nativeEvent('ACTION_CALL_CALLBACK', 'missed-call');
      expect(actions, hasLength(2));
    },
  );

  test(
    'CallManager missed notification callback starts the original room call',
    () async {
      final client = _Client();
      when(() => client.userID).thenReturn('@me:hs');
      final timeline = CachedStreamController<matrix.Event>();
      final calls = CachedStreamController<List<matrix.BasicEventWithSender>>();
      when(() => client.onTimelineEvent).thenReturn(timeline);
      when(() => client.onCallEvents).thenReturn(calls);
      // Stop after routing reaches WebRTC rather than opening a real microphone.
      when(() => client.getRoomById(any())).thenReturn(null);
      var textureId = 0;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('FlutterWebRTC.Method'),
            (call) async {
              if (call.method == 'createVideoRenderer')
                return {'textureId': ++textureId};
              return null;
            },
          );
      final manager = CallManager();
      await manager.initialize(client: client);
      addTearDown(() async {
        await manager.dispose();
        await timeline.close();
        await calls.close();
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel('FlutterWebRTC.Method'),
              null,
            );
      });
      await nativeEvent('ACTION_CALL_INCOMING', 'displayed-call');
      await nativeEvent('ACTION_CALL_TIMEOUT', 'displayed-call');
      await Future<void>.delayed(Duration.zero);
      final args =
          callkitCalls
                  .lastWhere((c) => c.method == 'showMissCallNotification')
                  .arguments
              as Map;
      expect(args['id'], 'displayed-call');
      expect(args['extra']['roomId'], '!room:hs');
      await manager.dispose();
      await CallNotificationService().initialize();
      await nativeEvent('ACTION_CALL_CALLBACK', args['id'] as String);
      expect(callkitCalls.where((call) => call.method == 'startCall'), isEmpty);
      await manager.initialize(client: client);
      await Future<void>.delayed(Duration.zero);
      final outgoing =
          callkitCalls.lastWhere((c) => c.method == 'startCall').arguments
              as Map;
      expect(outgoing['handle'], '@alice:hs');
      expect(outgoing['extra']['roomId'], '!room:hs');
      verify(() => client.getRoomById('!room:hs')).called(1);
    },
  );

  test(
    'early cold-start callback waits for account binding then restores routing',
    () async {
      final service = CallNotificationService();
      await nativeEvent('ACTION_CALL_INCOMING', 'cold-call');
      await nativeEvent('ACTION_CALL_TIMEOUT', 'cold-call');
      service.dispose();
      await service
          .initialize(); // Starts listening before authentication is ready.
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_CALLBACK', 'cold-call');
      expect(actions, isEmpty);
      await service.initialize(currentAccountId: () => account);
      await Future<void>.delayed(Duration.zero);
      expect(actions.single.$2.roomId, '!room:hs');
      expect(actions.single.$2.callerId, '@alice:hs');
      await nativeEvent('ACTION_CALL_CALLBACK', 'cold-call');
      expect(actions, hasLength(1));
    },
  );

  test('cold-start callback never routes to a different account', () async {
    final service = CallNotificationService();
    await nativeEvent('ACTION_CALL_INCOMING', 'other-account-call');
    service.dispose();
    await service.initialize();
    final actions = <(CallAction, IncomingCallInfo)>[];
    final sub = service.callActions.listen(actions.add);
    addTearDown(sub.cancel);
    await nativeEvent('ACTION_CALL_CALLBACK', 'other-account-call');
    account = '@other:hs';
    await service.initialize(currentAccountId: () => account);
    await Future<void>.delayed(Duration.zero);
    expect(actions, isEmpty);
  });

  test(
    'account switch before timeout cannot rebind a saved callback',
    () async {
      final service = CallNotificationService();
      await nativeEvent('ACTION_CALL_INCOMING', 'switch-before-timeout');
      account = '@other:hs';
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_TIMEOUT', 'switch-before-timeout');
      await nativeEvent('ACTION_CALL_CALLBACK', 'switch-before-timeout');
      expect(actions, isEmpty);
      account = '@me:hs';
      await nativeEvent('ACTION_CALL_CALLBACK', 'switch-before-timeout');
      expect(actions.single.$2.roomId, '!room:hs');
    },
  );

  test(
    'unscoped background push cannot route a callback as the current account',
    () async {
      await FirebasePushService.showBackgroundCallKitForTest(
        const RemoteMessage(
          data: {
            'type': 'm.call.invite',
            'room_id': '!background:hs',
            'sender': '@alice:hs',
          },
        ),
      );
      final args =
          callkitCalls
                  .lastWhere((c) => c.method == 'showCallkitIncoming')
                  .arguments
              as Map;
      final actions = <CallAction>[];
      final sub = CallNotificationService().callActions.listen(
        (event) => actions.add(event.$1),
      );
      addTearDown(sub.cancel);
      await nativeEvent(
        'ACTION_CALL_INCOMING',
        args['id'] as String,
        extraBody: {'extra': args['extra']},
      );
      await nativeEvent('ACTION_CALL_CALLBACK', args['id'] as String);
      expect(actions, isEmpty);
    },
  );

  test('early id-only callback waits for its verified account', () async {
    await PushRecipientBindingStore().activate('@me:hs', 'generation-a');
    await FirebasePushService.showBackgroundCallKitForTest(
      const RemoteMessage(
        data: {
          'type': 'm.call.invite',
          'room_id': '!background:hs',
          'sender': '@alice:hs',
          'n42_receiver_account_id': '@me:hs',
          'n42_push_binding_id': 'generation-a',
        },
      ),
    );
    final args =
        callkitCalls
                .lastWhere((call) => call.method == 'showCallkitIncoming')
                .arguments
            as Map;
    final service = CallNotificationService();
    service.dispose();
    await service.initialize();
    final delivered = Completer<(CallAction, IncomingCallInfo)>();
    final sub = service.callActions.listen(delivered.complete);
    addTearDown(sub.cancel);
    await nativeEvent('ACTION_CALL_CALLBACK', args['id'] as String);
    await service.initialize(currentAccountId: () => account);
    final action = await delivered.future;
    expect(action.$1, CallAction.callback);
    expect(action.$2.roomId, '!background:hs');
  });

  test(
    'verified background accept before account binding is retained once',
    () async {
      await PushRecipientBindingStore().activate('@me:hs', 'generation-a');
      await FirebasePushService.showBackgroundCallKitForTest(
        const RemoteMessage(
          data: {
            'type': 'm.call.invite',
            'room_id': '!background:hs',
            'sender': '@alice:hs',
            'n42_receiver_account_id': '@me:hs',
            'n42_push_binding_id': 'generation-a',
          },
        ),
      );
      final args =
          callkitCalls
                  .lastWhere((call) => call.method == 'showCallkitIncoming')
                  .arguments
              as Map;
      final service = CallNotificationService();
      service.dispose();
      await service.initialize();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent(
        'ACTION_CALL_ACCEPT',
        args['id'] as String,
        extraBody: {'extra': args['extra']},
      );
      await nativeEvent(
        'ACTION_CALL_ACCEPT',
        args['id'] as String,
        extraBody: {'extra': args['extra']},
      );
      expect(actions, isEmpty);
      await service.initialize(currentAccountId: () => account);
      final pending = await service.consumePendingAcceptAction();
      expect(pending?.$1, CallAction.accept);
      expect(pending?.$2.roomId, '!background:hs');
      expect(await service.consumePendingAcceptAction(), isNull);
    },
  );

  test(
    'legacy untagged background accept cannot borrow the next login',
    () async {
      final service = CallNotificationService();
      service.dispose();
      await service.initialize();
      await nativeEvent('ACTION_CALL_ACCEPT', 'legacy-background');
      await service.initialize(currentAccountId: () => account);
      expect(await service.consumePendingAcceptAction(), isNull);
    },
  );

  test('revoked background generation cannot leave a pending accept', () async {
    final bindings = PushRecipientBindingStore();
    await bindings.activate('@me:hs', 'generation-a');
    await FirebasePushService.showBackgroundCallKitForTest(
      const RemoteMessage(
        data: {
          'type': 'm.call.invite',
          'room_id': '!room:hs',
          'sender': '@alice:hs',
          'n42_receiver_account_id': '@me:hs',
          'n42_push_binding_id': 'generation-a',
        },
      ),
    );
    final args =
        callkitCalls
                .lastWhere((call) => call.method == 'showCallkitIncoming')
                .arguments
            as Map;
    final service = CallNotificationService();
    service.dispose();
    await service.initialize();
    await nativeEvent(
      'ACTION_CALL_ACCEPT',
      args['id'] as String,
      extraBody: {'extra': args['extra']},
    );
    await bindings.revokeAccount('@me:hs');
    await service.initialize(currentAccountId: () => account);
    expect(await service.consumePendingAcceptAction(), isNull);
  });

  test(
    'revocation after account binding blocks pending accept consumption',
    () async {
      final bindings = PushRecipientBindingStore();
      await bindings.activate('@me:hs', 'generation-a');
      await FirebasePushService.showBackgroundCallKitForTest(
        const RemoteMessage(
          data: {
            'type': 'm.call.invite',
            'room_id': '!room:hs',
            'sender': '@alice:hs',
            'n42_receiver_account_id': '@me:hs',
            'n42_push_binding_id': 'generation-a',
          },
        ),
      );
      final args =
          callkitCalls
                  .lastWhere((call) => call.method == 'showCallkitIncoming')
                  .arguments
              as Map;
      final service = CallNotificationService();
      service.dispose();
      await service.initialize();
      await nativeEvent(
        'ACTION_CALL_ACCEPT',
        args['id'] as String,
        extraBody: {'extra': args['extra']},
      );
      await service.initialize(currentAccountId: () => account);
      await bindings.revokeAccount('@me:hs');
      expect(await service.consumePendingAcceptAction(), isNull);
    },
  );

  test('account B cannot take account A pending accept', () async {
    await PushRecipientBindingStore().activate('@a:hs', 'generation-a');
    await FirebasePushService.showBackgroundCallKitForTest(
      const RemoteMessage(
        data: {
          'type': 'm.call.invite',
          'room_id': '!a-room:hs',
          'sender': '@alice:hs',
          'n42_receiver_account_id': '@a:hs',
          'n42_push_binding_id': 'generation-a',
        },
      ),
    );
    final args =
        callkitCalls
                .lastWhere((call) => call.method == 'showCallkitIncoming')
                .arguments
            as Map;
    final service = CallNotificationService();
    service.dispose();
    await service.initialize();
    await nativeEvent(
      'ACTION_CALL_ACCEPT',
      args['id'] as String,
      extraBody: {'extra': args['extra']},
    );
    account = '@b:hs';
    await service.initialize(currentAccountId: () => account);
    expect(await service.consumePendingAcceptAction(), isNull);
  });

  test('CallManager dispatches early verified accept', () async {
    await PushRecipientBindingStore().activate('@me:hs', 'generation-a');
    await FirebasePushService.showBackgroundCallKitForTest(
      const RemoteMessage(
        data: {
          'type': 'm.call.invite',
          'room_id': '!background:hs',
          'sender': '@alice:hs',
          'n42_receiver_account_id': '@me:hs',
          'n42_push_binding_id': 'generation-a',
        },
      ),
    );
    final args =
        callkitCalls
                .lastWhere((call) => call.method == 'showCallkitIncoming')
                .arguments
            as Map;
    final service = CallNotificationService();
    service.dispose();
    await service.initialize();
    await nativeEvent(
      'ACTION_CALL_ACCEPT',
      args['id'] as String,
      extraBody: {'extra': args['extra']},
    );

    final client = _Client();
    when(() => client.userID).thenReturn('@me:hs');
    final timeline = CachedStreamController<matrix.Event>();
    final calls = CachedStreamController<List<matrix.BasicEventWithSender>>();
    when(() => client.onTimelineEvent).thenReturn(timeline);
    when(() => client.onCallEvents).thenReturn(calls);
    final managerReady = Completer<void>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('flutter_callkit_incoming'),
          (call) async {
            callkitCalls.add(call);
            if (call.method == 'activeCalls' && !managerReady.isCompleted) {
              managerReady.complete();
              return <dynamic>[];
            }
            return null;
          },
        );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('FlutterWebRTC.Method'), (
          call,
        ) async {
          if (call.method == 'createVideoRenderer') {
            return {'textureId': 1};
          }
          return null;
        });
    final manager = CallManager();
    final debugMessages = <String>[];
    final previousDebugPrint = debugPrint;
    debugPrint = (message, {wrapWidth}) {
      if (message != null) debugMessages.add(message);
      previousDebugPrint(message, wrapWidth: wrapWidth);
    };
    addTearDown(() => debugPrint = previousDebugPrint);
    addTearDown(() async {
      await manager.dispose();
      await timeline.close();
      await calls.close();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('FlutterWebRTC.Method'),
            null,
          );
    });
    await manager.initialize(client: client);
    await managerReady.future.timeout(const Duration(seconds: 5));
    expect(await service.consumePendingAcceptAction(), isNull);

    final incomingHandled = Completer<void>();
    manager.onIncomingCall = (_) => incomingHandled.complete();
    final nativeIncomingCount = callkitCalls
        .where((call) => call.method == 'showCallkitIncoming')
        .length;
    manager.webRTCService!.onIncomingCall!.call(
      CallSession(
        callId: 'matrix-invite',
        roomId: '!background:hs',
        peerId: '@alice:hs',
        peerName: 'Alice',
        type: CallType.voice,
        direction: CallDirection.incoming,
        startTime: DateTime.now(),
      ),
    );
    await incomingHandled.future.timeout(const Duration(seconds: 5));
    expect(debugMessages, contains(startsWith('WebRTCService: answerCall -')));
    expect(
      callkitCalls.where((call) => call.method == 'showCallkitIncoming'),
      hasLength(nativeIncomingCount),
    );
  });

  test(
    'verified background push survives service recreation and dials once',
    () async {
      await PushRecipientBindingStore().activate('@me:hs', 'generation-a');
      await FirebasePushService.showBackgroundCallKitForTest(
        const RemoteMessage(
          data: {
            'type': 'm.call.invite',
            'room_id': '!background:hs',
            'sender': '@alice:hs',
            'n42_receiver_account_id': '@me:hs',
            'n42_push_binding_id': 'generation-a',
          },
        ),
      );
      final args =
          callkitCalls
                  .lastWhere((call) => call.method == 'showCallkitIncoming')
                  .arguments
              as Map;
      final id = args['id'] as String;
      final service = CallNotificationService();
      service.dispose();
      await service.initialize(currentAccountId: () => account);
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_CALLBACK', id);
      await nativeEvent('ACTION_CALL_CALLBACK', id);
      expect(actions, hasLength(1));
      expect(actions.single.$1, CallAction.callback);
      expect(actions.single.$2.roomId, '!background:hs');
      expect(actions.single.$2.callerId, '@alice:hs');
    },
  );

  test(
    'queued account A call cannot be rebound to account B by native event',
    () async {
      await PushRecipientBindingStore().activate('@a:hs', 'generation-a');
      account = '@b:hs';
      await FirebasePushService.showBackgroundCallKitForTest(
        const RemoteMessage(
          data: {
            'type': 'm.call.invite',
            'room_id': '!a-room:hs',
            'sender': '@alice:hs',
            'n42_receiver_account_id': '@a:hs',
            'n42_push_binding_id': 'generation-a',
          },
        ),
      );
      final args =
          callkitCalls
                  .lastWhere((call) => call.method == 'showCallkitIncoming')
                  .arguments
              as Map;
      final id = args['id'] as String;
      final service = CallNotificationService();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent(
        'ACTION_CALL_INCOMING',
        id,
        extraBody: {'extra': args['extra']},
      );
      await nativeEvent('ACTION_CALL_CALLBACK', id);
      expect(
        actions.where((action) => action.$1 == CallAction.callback),
        isEmpty,
      );
      account = '@a:hs';
      await nativeEvent('ACTION_CALL_CALLBACK', id);
      expect(
        actions.where((action) => action.$1 == CallAction.callback),
        hasLength(1),
      );
      expect(actions.last.$2.roomId, '!a-room:hs');
    },
  );

  test(
    'same remote event for A and B gets distinct native callback IDs',
    () async {
      final bindings = PushRecipientBindingStore();
      await bindings.activate('@a:hs', 'generation-a');
      await bindings.activate('@b:hs', 'generation-b');
      for (final recipient in ['@a:hs', '@b:hs']) {
        await FirebasePushService.showBackgroundCallKitForTest(
          RemoteMessage(
            data: {
              'type': 'm.call.invite',
              'event_id': r'$same-event:hs',
              'room_id': '!shared:hs',
              'sender': '@alice:hs',
              'n42_receiver_account_id': recipient,
              'n42_push_binding_id': recipient == '@a:hs'
                  ? 'generation-a'
                  : 'generation-b',
            },
          ),
        );
      }
      final shown = callkitCalls
          .where((call) => call.method == 'showCallkitIncoming')
          .map((call) => call.arguments as Map)
          .toList();
      final aNativeId = shown[0]['id'] as String;
      final bNativeId = shown[1]['id'] as String;
      expect(aNativeId, isNot(bNativeId));
      account = '@b:hs';
      final service = CallNotificationService();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_CALLBACK', aNativeId);
      expect(actions, isEmpty);
      await nativeEvent('ACTION_CALL_CALLBACK', bNativeId);
      expect(actions, hasLength(1));
      expect(actions.single.$2.callId, bNativeId);
    },
  );

  testWidgets(
    'early callback expires if account binding takes over 90 seconds',
    (tester) async {
      final service = CallNotificationService();
      await tester.runAsync(
        () => service.showMissedCall(
          callId: 'pending-expired',
          roomId: '!room:hs',
          callerId: '@alice:hs',
          callerName: 'Alice',
        ),
      );
      service.dispose();
      await service.initialize();
      final actions = <CallAction>[];
      final sub = service.callActions.listen((event) => actions.add(event.$1));
      await nativeEvent(
        'ACTION_CALL_CALLBACK',
        'pending-expired',
        waitEventLoop: false,
      );
      await tester.pump(const Duration(seconds: 91));
      await tester.runAsync(() async {
        await service.initialize(currentAccountId: () => account);
        await Future<void>.delayed(Duration.zero);
      });
      expect(actions, isEmpty);
      service.dispose();
      await tester.runAsync(sub.cancel);
    },
  );

  test('late end event never resurrects dismissed callback storage', () async {
    final service = CallNotificationService();
    await nativeEvent('ACTION_CALL_INCOMING', 'late-ended-call');
    await service.endCall('late-ended-call');
    await nativeEvent('ACTION_CALL_ENDED', 'late-ended-call');
    final values = await const FlutterSecureStorage().readAll();
    for (final value in values.values) {
      expect(jsonDecode(value) as List, isEmpty);
    }
  });

  for (final action in ['ACTION_CALL_DECLINE', 'ACTION_CALL_ENDED']) {
    test('$action removes callback metadata', () async {
      final service = CallNotificationService();
      final actions = <(CallAction, IncomingCallInfo)>[];
      final sub = service.callActions.listen(actions.add);
      addTearDown(sub.cancel);
      await nativeEvent('ACTION_CALL_INCOMING', 'terminal-$action');
      await nativeEvent(action, 'terminal-$action');
      await nativeEvent('ACTION_CALL_CALLBACK', 'terminal-$action');
      expect(actions, hasLength(1));
      expect(actions.single.$1, isNot(CallAction.callback));
    });
  }

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
