import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:n42_chat/src/services/auth/auth_methods_service.dart';
import 'package:n42_chat/src/data/datasources/remote/social_auth_api.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('app.meedu/flutter_facebook_auth');
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null),
  );
  for (final validNonce in [true, false]) {
    test(
      'Limited Login checks nonce: $validNonce and never calls Graph',
      () async {
        final calls = <String>[];
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (call) async {
              calls.add(call.method);
              expect(call.method, 'login');
              final args = call.arguments as Map;
              expect(args['permissions'], ['public_profile']);
              expect(args['tracking'], 'limited');
              return {
                'type': 'limited',
                'token': 'signed-id-token',
                'userId': 'user',
                'userName': 'Test',
                'userEmail': null,
                'nonce': validNonce ? args['nonce'] : 'wrong',
              };
            });
        final login = AuthMethodsService().signInWithFacebook();
        if (!validNonce) {
          await expectLater(login, throwsException);
        } else {
          final result = await login;
          expect(result?.idToken, 'signed-id-token');
          expect(result?.accessToken, isNull);
          expect(result?.extra?['token_type'], 'limited');
          expect(result?.extra?['rawNonce'], isNotEmpty);
        }
        expect(calls, ['login']);
      },
    );
  }
  test(
    'Limited Login transports proof and nonce without access_token',
    () async {
      final api = SocialAuthApi(
        client: MockClient((request) async {
          final body = jsonDecode(request.body) as Map;
          expect(body['token_type'], 'limited');
          expect(body['nonce'], 'nonce');
          expect(body['id_token'], 'proof');
          expect(body.containsKey('access_token'), false);
          return http.Response('{"code":200,"data":{}}', 200);
        }),
      );
      expect(
        (await api.loginWithFacebook(
          accessToken: 'proof',
          limitedLogin: true,
          nonce: 'nonce',
        )).success,
        true,
      );
    },
  );
  test(
    'Limited Login rejects missing nonce before a network request',
    () async {
      final api = SocialAuthApi(
        client: MockClient((_) async => throw StateError('must not send')),
      );
      expect(
        (await api.loginWithFacebook(
          accessToken: 'proof',
          limitedLogin: true,
        )).success,
        false,
      );
    },
  );
}
