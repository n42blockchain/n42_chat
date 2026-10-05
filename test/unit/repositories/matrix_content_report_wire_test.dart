import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:matrix/matrix_api_lite.dart';

void main() {
  test(
    'resolved Matrix SDK sends exact user and room report wire payloads',
    () async {
      final requests = <http.Request>[];
      final api = MatrixApi(
        homeserver: Uri.parse('https://hs.test/'),
        accessToken: 'fixture-token',
        httpClient: MockClient((request) async {
          requests.add(request);
          return http.Response('{}', 200);
        }),
      );

      expect(
        await api.reportUser('@subject:hs.test', 'spam\nuser detail'),
        isEmpty,
      );
      await api.reportRoom('!room:hs.test', 'harassment');

      expect(requests, hasLength(2));
      expect(requests[0].method, 'POST');
      expect(
        requests[0].url.toString(),
        'https://hs.test/_matrix/client/v3/users/%40subject%3Ahs.test/report',
      );
      expect(requests[0].headers['authorization'], 'Bearer fixture-token');
      expect(jsonDecode(requests[0].body), {'reason': 'spam\nuser detail'});
      expect(requests[1].method, 'POST');
      expect(
        requests[1].url.toString(),
        'https://hs.test/_matrix/client/v3/rooms/!room%3Ahs.test/report',
      );
      expect(requests[1].headers['authorization'], 'Bearer fixture-token');
      expect(jsonDecode(requests[1].body), {'reason': 'harassment'});
    },
  );

  test('resolved SDK rejects non-200 user-report acknowledgement', () async {
    final api = MatrixApi(
      homeserver: Uri.parse('https://hs.test/'),
      accessToken: 'fixture-token',
      httpClient: MockClient(
        (_) async => http.Response('{"errcode":"M_UNRECOGNIZED"}', 404),
      ),
    );

    await expectLater(
      api.reportUser('@subject:hs.test', 'spam'),
      throwsA(
        isA<MatrixException>().having(
          (error) => error.error,
          'error',
          MatrixError.M_UNRECOGNIZED,
        ),
      ),
    );
  });
}
