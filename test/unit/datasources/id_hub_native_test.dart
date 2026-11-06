import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:n42_chat/src/data/datasources/remote/id_hub_api.dart';

void main() {
  final challenge = IdHubNativeChallenge(
    flowId: 'f' * 43,
    completionSecret: 'c' * 43,
    nonce: 'n' * 43,
  );
  Map<String, dynamic> session() => {
    'status': 'complete',
    'session': {
      'sub': 'did:plc:alice',
      'access_token': 'hub-token',
      'refresh_token': 'sid.secret',
      'token_type': 'Bearer',
    },
  };
  Map<String, dynamic> matrix() => {
    'sub': 'did:plc:alice',
    'matrix_user_id': '@alice:matrix.example',
    'matrix_access_token': 'matrix-token',
    'matrix_homeserver': 'https://matrix.example',
  };
  test(
    'starts a server nonce challenge with provider and platform only',
    () async {
      final api = IdHubApi(
        baseUrl: 'https://id.n42.world',
        client: MockClient((r) async {
          expect(jsonDecode(r.body), {'provider': 'apple', 'platform': 'ios'});
          expect(r.followRedirects, false);
          return http.Response(
            jsonEncode({
              'flow_id': challenge.flowId,
              'completion_secret': challenge.completionSecret,
              'nonce': challenge.nonce,
              'expires_in': 300,
            }),
            200,
          );
        }),
      );
      expect(
        (await api.startNativeLogin('apple', 'ios')).nonce,
        challenge.nonce,
      );
      api.close();
    },
  );
  test(
    'exchanges proof, pins Matrix DID and revokes temporary Hub session',
    () async {
      final calls = <String>[];
      final api = IdHubApi(
        baseUrl: 'https://id.n42.world',
        client: MockClient((r) async {
          calls.add(r.url.path);
          expect(r.followRedirects, false);
          if (r.url.path.endsWith('/native/complete')) {
            expect(jsonDecode(r.body), {
              'flow_id': challenge.flowId,
              'completion_secret': challenge.completionSecret,
              'identity_token': 'provider-proof',
            });
            return http.Response(jsonEncode(session()), 200);
          }
          expect(r.headers['authorization'], 'Bearer hub-token');
          if (r.url.path.endsWith('/matrix/session'))
            return http.Response(jsonEncode(matrix()), 200);
          expect(r.bodyFields, {'refresh_token': 'sid.secret'});
          return http.Response('', 204);
        }),
      );
      final result = await api.completeNativeLogin(challenge, 'provider-proof');
      expect(result.matrixAccessToken, 'matrix-token');
      expect(calls, [
        '/v1/auth/n42/native/complete',
        '/v1/auth/n42/matrix/session',
        '/v1/oauth/revoke',
      ]);
      api.close();
    },
  );
  test(
    'rejects mismatched Matrix identity and still revokes the Hub grant',
    () async {
      bool revoked = false;
      final api = IdHubApi(
        baseUrl: 'https://id.n42.world',
        client: MockClient((r) async {
          if (r.url.path.endsWith('/native/complete'))
            return http.Response(jsonEncode(session()), 200);
          if (r.url.path.endsWith('/matrix/session'))
            return http.Response(
              jsonEncode({...matrix(), 'sub': 'did:plc:other'}),
              200,
            );
          revoked = true;
          return http.Response('', 204);
        }),
      );
      await expectLater(
        api.completeNativeLogin(challenge, 'proof'),
        throwsFormatException,
      );
      expect(revoked, true);
      api.close();
    },
  );
  test('does not send a proof to a redirected endpoint', () async {
    var calls = 0;
    final api = IdHubApi(
      baseUrl: 'https://id.n42.world',
      client: MockClient((r) async {
        calls++;
        expect(r.followRedirects, false);
        return http.Response(
          '',
          302,
          headers: {'location': 'https://other.example'},
        );
      }),
    );
    await expectLater(
      api.completeNativeLogin(challenge, 'proof'),
      throwsA(isA<IdHubException>()),
    );
    expect(calls, 1);
    api.close();
  });
  test('rejects malformed server nonce', () async {
    final api = IdHubApi(
      baseUrl: 'https://id.n42.world',
      client: MockClient(
        (r) async => http.Response(
          jsonEncode({
            'flow_id': challenge.flowId,
            'completion_secret': challenge.completionSecret,
            'nonce': '',
            'expires_in': 300,
          }),
          200,
        ),
      ),
    );
    await expectLater(
      api.startNativeLogin('facebook', 'ios'),
      throwsFormatException,
    );
    api.close();
  });
  test(
    'Google sends only its server code and refuses mixed proof formats',
    () async {
      var calls = 0;
      final api = IdHubApi(
        baseUrl: 'https://id.n42.world',
        client: MockClient((r) async {
          calls++;
          expect(jsonDecode(r.body), {
            'flow_id': challenge.flowId,
            'completion_secret': challenge.completionSecret,
            'server_auth_code': 'one-use',
          });
          return http.Response('{}', 400);
        }),
      );
      await expectLater(
        api.completeNativeLogin(
          challenge,
          'id-token',
          serverAuthCode: 'one-use',
        ),
        throwsFormatException,
      );
      expect(calls, 0);
      await expectLater(
        api.completeNativeLogin(challenge, '', serverAuthCode: 'one-use'),
        throwsA(isA<IdHubException>()),
      );
      expect(calls, 1);
      api.close();
    },
  );
}
