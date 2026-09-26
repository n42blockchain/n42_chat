import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/notifications/firebase_push_service.dart';
import 'package:n42_chat/src/core/notifications/push_recipient_binding_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Client extends Mock implements matrix.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(
      matrix.Pusher(
        appId: 'fallback',
        pushkey: 'fallback',
        appDisplayName: 'fallback',
        data: matrix.PusherData(),
        deviceDisplayName: 'fallback',
        kind: 'http',
        lang: 'en',
      ),
    );
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  test(
    'registration posts flat default payload and persists server echo',
    () async {
      final client = _Client();
      when(() => client.isLogged()).thenReturn(true);
      when(() => client.userID).thenReturn('@recipient:hs');
      when(() => client.deviceID).thenReturn('device');
      when(() => client.deviceName).thenReturn('Device');
      matrix.Pusher? posted;
      when(() => client.postPusher(any(), append: false)).thenAnswer((
        call,
      ) async {
        posted = call.positionalArguments.first as matrix.Pusher;
      });
      when(() => client.getPushers()).thenAnswer((_) async => [posted!]);
      final service = FirebasePushService(
        client,
        pushGatewayUrl: 'https://push.example.org/_matrix/push/v1/notify',
        tokenLoader: () async => 'fcm-token',
      );
      await service.registerForPush();
      final json = posted!.toJson();
      final data = json['data'] as Map<String, Object?>;
      final payload = data['default_payload'] as Map;
      expect(payload.keys.toSet(), {
        'n42_receiver_account_id',
        'n42_push_binding_id',
      });
      expect(payload['n42_receiver_account_id'], '@recipient:hs');
      expect(payload['n42_push_binding_id'], isA<String>());
      expect((payload['n42_push_binding_id'] as String).isNotEmpty, isTrue);
      expect(payload.values.every((value) => value is String), isTrue);
      // Sygnal gcmpushkin.py at d96899f _build_data begins with
      // data.update(device.data['default_payload']) and then overlays the
      // fields actually present in the Matrix notification. This fixed
      // event_id_only fixture intentionally has no type or sender.
      final forwardedData = <String, Object?>{
        ...Map<String, Object?>.from(payload),
        'event_id': r'$event:hs',
        'room_id': '!room:hs',
      };
      expect(forwardedData['n42_receiver_account_id'], '@recipient:hs');
      expect(
        forwardedData['n42_push_binding_id'],
        payload['n42_push_binding_id'],
      );
      expect(forwardedData.containsKey('type'), isFalse);
      expect(forwardedData.containsKey('sender'), isFalse);
      expect(service.isPusherVerified, isTrue);
      expect(
        await PushRecipientBindingStore().matches(
          '@recipient:hs',
          payload['n42_push_binding_id'] as String,
        ),
        isTrue,
      );
      await service.dispose();
    },
  );

  test('missing server echo never activates local generation', () async {
    final client = _Client();
    when(() => client.isLogged()).thenReturn(true);
    when(() => client.userID).thenReturn('@recipient:hs');
    when(() => client.deviceID).thenReturn('device');
    when(() => client.deviceName).thenReturn('Device');
    matrix.Pusher? posted;
    when(() => client.postPusher(any(), append: false)).thenAnswer((
      call,
    ) async {
      posted = call.positionalArguments.first as matrix.Pusher;
    });
    when(() => client.getPushers()).thenAnswer(
      (_) async => [
        matrix.Pusher(
          appId: posted!.appId,
          pushkey: posted!.pushkey,
          appDisplayName: posted!.appDisplayName,
          data: matrix.PusherData(url: posted!.data.url),
          deviceDisplayName: posted!.deviceDisplayName,
          kind: posted!.kind,
          lang: posted!.lang,
        ),
      ],
    );
    final service = FirebasePushService(
      client,
      pushGatewayUrl: 'https://push.example.org/_matrix/push/v1/notify',
      tokenLoader: () async => 'fcm-token',
    );
    await service.registerForPush();
    final payload = posted!.data.toJson()['default_payload'] as Map;
    expect(service.isPusherVerified, isFalse);
    expect(
      await PushRecipientBindingStore().matches(
        '@recipient:hs',
        payload['n42_push_binding_id'] as String,
      ),
      isFalse,
    );
    await service.dispose();
  });

  test(
    'account switch during post cannot activate old account binding',
    () async {
      final client = _Client();
      var account = '@a:hs';
      final postStarted = Completer<void>();
      final finishPost = Completer<void>();
      when(() => client.isLogged()).thenReturn(true);
      when(() => client.userID).thenAnswer((_) => account);
      when(() => client.deviceID).thenReturn('device');
      when(() => client.deviceName).thenReturn('Device');
      matrix.Pusher? posted;
      when(() => client.postPusher(any(), append: false)).thenAnswer((
        call,
      ) async {
        posted = call.positionalArguments.first as matrix.Pusher;
        postStarted.complete();
        await finishPost.future;
      });
      when(() => client.getPushers()).thenAnswer((_) async => [posted!]);
      final service = FirebasePushService(
        client,
        pushGatewayUrl: 'https://push.example.org/_matrix/push/v1/notify',
        tokenLoader: () async => 'fcm-token',
      );
      final registration = service.registerForPush();
      await postStarted.future;
      account = '@b:hs';
      finishPost.complete();
      await registration;
      final payload = posted!.data.toJson()['default_payload'] as Map;
      expect(service.isPusherVerified, isFalse);
      expect(
        await PushRecipientBindingStore().matches(
          '@a:hs',
          payload['n42_push_binding_id'] as String,
        ),
        isFalse,
      );
      await service.dispose();
    },
  );

  test('account switch during token lookup never posts a pusher', () async {
    final client = _Client();
    var account = '@a:hs';
    final tokenStarted = Completer<void>();
    final finishToken = Completer<String?>();
    when(() => client.isLogged()).thenReturn(true);
    when(() => client.userID).thenAnswer((_) => account);
    when(() => client.deviceID).thenReturn('device');
    when(() => client.deviceName).thenReturn('Device');
    when(
      () => client.postPusher(any(), append: false),
    ).thenAnswer((_) async {});
    final service = FirebasePushService(
      client,
      pushGatewayUrl: 'https://push.example.org/_matrix/push/v1/notify',
      tokenLoader: () {
        tokenStarted.complete();
        return finishToken.future;
      },
    );
    final registration = service.registerForPush();
    await tokenStarted.future;
    account = '@b:hs';
    finishToken.complete('fcm-token');
    await registration;
    verifyNever(() => client.postPusher(any(), append: false));
    expect(service.isPusherVerified, isFalse);
    await service.dispose();
  });
}
