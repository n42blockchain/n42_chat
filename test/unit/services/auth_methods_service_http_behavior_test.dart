import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:n42_chat/src/services/auth/auth_methods_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthMethodsService Matrix HTTP behavior', () {
    late AuthMethodsService service;
    const passkeyChannel = MethodChannel('n42.chat/passkey');

    setUp(() async {
      service = AuthMethodsService();
      await service.initialize(passkeyRpId: 'chat.example.org');
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(passkeyChannel, null);
    });

    test(
      'requests a registration challenge with the account token and RP',
      () async {
        final observed = <String, Object?>{};
        final result = await _withServer(
          (request) async {
            observed['method'] = request.method;
            observed['path'] = request.uri.path;
            observed['authorization'] = request.headers.value('authorization');
            observed['body'] = jsonDecode(
              await utf8.decoder.bind(request).join(),
            );
            await _respond(request, 200, '{"challenge":"challenge-1"}');
          },
          (baseUrl) {
            return service.requestPasskeyRegistrationChallenge(
              homeserver: baseUrl,
              userId: '@alice:example.org',
              accessToken: 'access-token',
            );
          },
        );

        expect(observed['method'], 'POST');
        expect(
          observed['path'],
          '/_matrix/client/unstable/org.matrix.msc3824/auth/webauthn/register/challenge',
        );
        expect(observed['authorization'], 'Bearer access-token');
        expect(observed['body'], {
          'user_id': '@alice:example.org',
          'rp_id': 'chat.example.org',
          'rp_name': 'N42 Chat',
        });
        expect(result, {'challenge': 'challenge-1'});
      },
    );

    test(
      'returns null when the registration challenge endpoint rejects it',
      () async {
        final result = await _withServer(
          (request) => _respond(request, 403, '{"errcode":"M_FORBIDDEN"}'),
          (baseUrl) => service.requestPasskeyRegistrationChallenge(
            homeserver: baseUrl,
            userId: '@alice:example.org',
          ),
        );

        expect(result, isNull);
      },
    );

    test('registers a platform credential with the homeserver', () async {
      MethodCall? platformCall;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(passkeyChannel, (call) async {
            platformCall = call;
            return {'credentialId': 'credential-2', 'publicKey': 'key-2'};
          });
      Map<String, Object?>? submitted;
      String? authorization;

      final credential = await _withServer(
        (request) async {
          authorization = request.headers.value('authorization');
          submitted =
              jsonDecode(await utf8.decoder.bind(request).join())
                  as Map<String, Object?>;
          await _respond(request, 200, '{}');
        },
        (baseUrl) {
          return service.registerPasskey(
            userId: '@alice:example.org',
            username: 'alice',
            displayName: 'Laptop',
            challenge: 'registration-challenge',
            homeserver: baseUrl,
            accessToken: 'registration-token',
          );
        },
      );

      expect(platformCall?.method, 'createCredential');
      expect(platformCall?.arguments, {
        'rpId': 'chat.example.org',
        'rpName': 'N42 Chat',
        'userId': '@alice:example.org',
        'userName': 'alice',
        'displayName': 'Laptop',
        'challenge': 'registration-challenge',
      });
      expect(authorization, 'Bearer registration-token');
      expect(submitted, {
        'credential_id': 'credential-2',
        'public_key': 'key-2',
        'user_id': '@alice:example.org',
        'display_name': 'Laptop',
      });
      expect(credential?.credentialId, 'credential-2');
      expect(credential?.displayName, 'Laptop');
    });

    test(
      'does not report registration as complete when the server rejects it',
      () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              passkeyChannel,
              (_) async => {
                'credentialId': 'credential-3',
                'publicKey': 'key-3',
              },
            );

        final credential = await _withServer(
          (request) => _respond(request, 409, '{"errcode":"M_CONFLICT"}'),
          (baseUrl) => service.registerPasskey(
            userId: '@alice:example.org',
            username: 'alice',
            challenge: 'registration-challenge',
            homeserver: baseUrl,
          ),
        );

        expect(credential, isNull);
      },
    );

    test('loads registered passkeys with bearer authentication', () async {
      String? authorization;
      final credentials = await _withServer(
        (request) async {
          authorization = request.headers.value('authorization');
          await _respond(
            request,
            200,
            jsonEncode({
              'credentials': [
                {
                  'credentialId': 'credential-1',
                  'publicKey': 'public-key',
                  'userId': '@alice:example.org',
                  'displayName': 'MacBook',
                },
              ],
            }),
          );
        },
        (baseUrl) {
          return service.getRegisteredPasskeys(
            homeserver: baseUrl,
            accessToken: 'list-token',
          );
        },
      );

      expect(authorization, 'Bearer list-token');
      expect(credentials, hasLength(1));
      expect(credentials.single.credentialId, 'credential-1');
      expect(credentials.single.displayName, 'MacBook');
    });

    test(
      'returns an empty passkey list for rejected or malformed responses',
      () async {
        final rejected = await _withServer(
          (request) => _respond(request, 401, '{}'),
          (baseUrl) => service.getRegisteredPasskeys(
            homeserver: baseUrl,
            accessToken: 'token',
          ),
        );
        final malformed = await _withServer(
          (request) => _respond(request, 200, '{bad json'),
          (baseUrl) => service.getRegisteredPasskeys(
            homeserver: baseUrl,
            accessToken: 'token',
          ),
        );

        expect(rejected, isEmpty);
        expect(malformed, isEmpty);
      },
    );

    test('deletes a credential and reports the server response', () async {
      final requestDetails = <String, String?>{};
      final deleted = await _withServer(
        (request) async {
          requestDetails['method'] = request.method;
          requestDetails['path'] = request.uri.path;
          requestDetails['authorization'] = request.headers.value(
            'authorization',
          );
          await _respond(request, 200, '{}');
        },
        (baseUrl) {
          return service.deletePasskey(
            homeserver: baseUrl,
            accessToken: 'delete-token',
            credentialId: 'credential-1',
          );
        },
      );

      expect(requestDetails, {
        'method': 'DELETE',
        'path':
            '/_matrix/client/unstable/org.matrix.msc3824/auth/webauthn/credentials/credential-1',
        'authorization': 'Bearer delete-token',
      });
      expect(deleted, isTrue);
    });

    test('returns false when credential deletion fails', () async {
      final deleted = await _withServer(
        (request) => _respond(request, 404, '{}'),
        (baseUrl) => service.deletePasskey(
          homeserver: baseUrl,
          accessToken: 'token',
          credentialId: 'missing',
        ),
      );

      expect(deleted, isFalse);
    });

    test(
      'requests an email OTP and returns its generated client secret',
      () async {
        Map<String, Object?>? body;
        final result = await _withServer(
          (request) async {
            body =
                jsonDecode(await utf8.decoder.bind(request).join())
                    as Map<String, Object?>;
            await _respond(request, 200, '{"sid":"email-session"}');
          },
          (baseUrl) {
            return service.requestEmailOtp(
              email: 'alice@example.org',
              homeserver: baseUrl,
            );
          },
        );

        expect(result, isNotNull);
        final secret = result!['clientSecret']!;
        expect(secret, matches(RegExp(r'^n42_[A-Za-z0-9_-]{43}=$')));
        expect(base64Url.decode(secret.substring(4)), hasLength(32));
        expect(body, {
          'client_secret': secret,
          'email': 'alice@example.org',
          'send_attempt': 1,
        });
        expect(result['sid'], 'email-session');
      },
    );

    test('rejects email OTP responses without a session id', () async {
      final result = await _withServer(
        (request) => _respond(request, 200, '{}'),
        (baseUrl) => service.requestEmailOtp(
          email: 'alice@example.org',
          homeserver: baseUrl,
        ),
      );

      expect(result, isNull);
    });

    test('verifies an email OTP and returns the verified identity', () async {
      Map<String, Object?>? body;
      final result = await _withServer(
        (request) async {
          body =
              jsonDecode(await utf8.decoder.bind(request).join())
                  as Map<String, Object?>;
          await _respond(request, 200, '{"success":true,"sid":"verified"}');
        },
        (baseUrl) {
          return service.verifyEmailOtp(
            email: 'alice@example.org',
            otp: '123456',
            sid: 'session-1',
            clientSecret: 'secret-1',
            homeserver: baseUrl,
          );
        },
      );

      expect(body, {
        'token': '123456',
        'client_secret': 'secret-1',
        'sid': 'session-1',
      });
      expect(result, {
        'verified': true,
        'email': 'alice@example.org',
        'sid': 'verified',
      });
    });

    test('returns null when the server does not verify an email OTP', () async {
      final result = await _withServer(
        (request) => _respond(request, 200, '{"success":false}'),
        (baseUrl) => service.verifyEmailOtp(
          email: 'alice@example.org',
          otp: 'wrong',
          sid: 'session-1',
          clientSecret: 'secret-1',
          homeserver: baseUrl,
        ),
      );

      expect(result, isNull);
    });

    test('loads SSO identities from the Matrix login flows endpoint', () async {
      String? path;
      final providers = await _withServer((request) async {
        path = request.uri.path;
        await _respond(
          request,
          200,
          jsonEncode({
            'flows': [
              {'type': 'm.login.password'},
              {
                'type': 'm.login.sso',
                'identity_providers': [
                  {'id': 'oidc-google', 'name': 'Google', 'brand': 'google'},
                ],
              },
            ],
          }),
        );
      }, service.getSsoProviders);

      expect(path, '/_matrix/client/v3/login');
      expect(providers, hasLength(1));
      expect(providers.single.id, 'oidc-google');
      expect(providers.single.isGoogle, isTrue);
    });

    test('returns no SSO providers for a failed login-flow request', () async {
      final providers = await _withServer(
        (request) => _respond(request, 503, '{}'),
        service.getSsoProviders,
      );

      expect(providers, isEmpty);
    });
  });
}

Future<T> _withServer<T>(
  Future<void> Function(HttpRequest request) handler,
  Future<T> Function(String homeserver) action,
) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final subscription = server.listen((request) {
    unawaited(
      handler(request).catchError((Object error, StackTrace stackTrace) {
        request.response
          ..statusCode = HttpStatus.internalServerError
          ..close();
      }),
    );
  });
  try {
    return await HttpOverrides.runWithHttpOverrides(
      () => action('http://${server.address.address}:${server.port}'),
      _NativeHttpOverrides(),
    );
  } finally {
    await subscription.cancel();
    await server.close(force: true);
  }
}

class _NativeHttpOverrides extends HttpOverrides {}

Future<void> _respond(HttpRequest request, int statusCode, String body) async {
  request.response
    ..statusCode = statusCode
    ..headers.contentType = ContentType.json
    ..write(body);
  await request.response.close();
}
