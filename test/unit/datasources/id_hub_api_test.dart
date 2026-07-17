import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:n42_chat/src/data/datasources/remote/id_hub_api.dart';

void main() {
  group('IdHubApi.createWalletChallenge', () {
    test('returns the challenge id and message on 200', () async {
      final client = MockClient((req) async {
        expect(req.url.path, '/v1/auth/wallet/challenge');
        expect(jsonDecode(req.body)['aud'], 'chat');
        return http.Response(
          jsonEncode({
            'challenge_id': 'ch1',
            'message': 'N42 ID v1 ...',
            'expires_at': '2099-01-01T00:00:00Z',
          }),
          200,
        );
      });
      final api = IdHubApi(baseUrl: 'https://id-test.n42.ai/', client: client);
      final ch = await api.createWalletChallenge(address: '0xABC');
      expect(ch.challengeId, 'ch1');
      expect(ch.message, 'N42 ID v1 ...');
    });

    test('throws IdHubException on non-200', () async {
      final client = MockClient((req) async => http.Response(
            jsonEncode({'type': 'x/rate-limited', 'detail': 'slow down'}),
            429,
          ));
      final api = IdHubApi(baseUrl: 'https://id-test.n42.ai', client: client);
      expect(
        () => api.createWalletChallenge(address: '0xABC'),
        throwsA(isA<IdHubException>()),
      );
    });
  });

  group('IdHubApi.verifyWalletLogin', () {
    test('exposes Matrix credentials when the hub returns them', () async {
      final client = MockClient((req) async => http.Response(
            jsonEncode({
              'access_token': 'n42-id-token',
              'token_type': 'Bearer',
              'expires_in': 900,
              'sub': 'did:plc:aaaa',
              'matrix_user_id': '@u_x:m.si46.world',
              'matrix_access_token': 'mx-token',
              'matrix_device_id': 'DEV1',
              'matrix_homeserver': 'https://m.si46.world',
            }),
            200,
          ));
      final api = IdHubApi(baseUrl: 'https://id-test.n42.ai', client: client);
      final resp = await api.verifyWalletLogin(
        challengeId: 'ch1',
        signature: '0xsig',
      );
      expect(resp.success, isTrue);
      expect(resp.hasMatrixCredentials, isTrue);
      expect(resp.matrixUserId, '@u_x:m.si46.world');
      expect(resp.did, 'did:plc:aaaa');
    });

    test('reports no Matrix credentials when the bridge is not live yet', () async {
      // Hub reachable, DID minted, but no matrix_* fields -> caller falls back.
      final client = MockClient((req) async => http.Response(
            jsonEncode({
              'access_token': 'n42-id-token',
              'token_type': 'Bearer',
              'expires_in': 900,
              'sub': 'did:plc:aaaa',
            }),
            200,
          ));
      final api = IdHubApi(baseUrl: 'https://id-test.n42.ai', client: client);
      final resp = await api.verifyWalletLogin(
        challengeId: 'ch1',
        signature: '0xsig',
      );
      expect(resp.success, isTrue);
      expect(resp.hasMatrixCredentials, isFalse);
    });

    test('returns failure on a non-200 verify', () async {
      final client = MockClient((req) async => http.Response(
            jsonEncode({'type': 'x/challenge-expired', 'detail': 'expired'}),
            401,
          ));
      final api = IdHubApi(baseUrl: 'https://id-test.n42.ai', client: client);
      final resp = await api.verifyWalletLogin(
        challengeId: 'ch1',
        signature: '0xsig',
      );
      expect(resp.success, isFalse);
      expect(resp.hasMatrixCredentials, isFalse);
      expect(resp.error, 'expired');
    });
  });
}
