import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/repositories/matrix_content_report_repository.dart';
import 'package:n42_chat/src/domain/repositories/content_report_repository.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements Client {}

void main() {
  late _Manager manager;
  late _Client client;
  late MatrixContentReportRepository repository;
  String? user;
  Uri? homeserver;
  String? token;

  setUp(() {
    manager = _Manager();
    client = _Client();
    user = '@reporter:hs.test';
    homeserver = Uri.parse('https://hs.test');
    token = 'session-A';
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenAnswer((_) => user);
    when(() => client.homeserver).thenAnswer((_) => homeserver);
    when(() => client.accessToken).thenAnswer((_) => token);
    when(client.isLogged).thenReturn(true);
    when(
      client.getVersions,
    ).thenAnswer((_) async => GetVersionsResponse(versions: ['v1.14']));
    when(
      () => client.reportUser(any(), any()),
    ).thenAnswer((_) async => <String, Object?>{});
    when(() => client.reportRoom(any(), any())).thenAnswer((_) async {});
    repository = MatrixContentReportRepository(manager);
  });

  for (final (versions, allowed) in <(List<String>, bool)>[
    (['v1.14'], true),
    (['v1.15'], true),
    (['v2.0'], true),
    (['v1.9'], false),
    (['v1.13'], false),
    (['r0.6.1'], false),
    (['v1.14-preview'], false),
  ]) {
    test('user report stable versions $versions allowed=$allowed', () async {
      when(
        client.getVersions,
      ).thenAnswer((_) async => GetVersionsResponse(versions: versions));
      final report = repository.reportUser(
        userId: '@subject:hs.test',
        reason: 'spam',
      );
      if (allowed) {
        await report;
        verify(() => client.reportUser('@subject:hs.test', 'spam')).called(1);
      } else {
        await expectLater(
          report,
          throwsA(
            isA<ContentReportException>().having(
              (error) => error.kind,
              'kind',
              ContentReportFailure.unsupported,
            ),
          ),
        );
        verifyNever(() => client.reportUser(any(), any()));
      }
    });
  }

  for (final (versions, allowed) in <(List<String>, bool)>[
    (['v1.13'], true),
    (['v1.14'], true),
    (['v1.9'], false),
    (['v1.12'], false),
    (['r0.6.1'], false),
  ]) {
    test('room report stable versions $versions allowed=$allowed', () async {
      when(
        client.getVersions,
      ).thenAnswer((_) async => GetVersionsResponse(versions: versions));
      final report = repository.reportRoom(
        roomId: '!group:hs.test',
        reason: 'harassment',
      );
      if (allowed) {
        await report;
        verify(
          () => client.reportRoom('!group:hs.test', 'harassment'),
        ).called(1);
      } else {
        await expectLater(
          report,
          throwsA(
            isA<ContentReportException>().having(
              (error) => error.kind,
              'kind',
              ContentReportFailure.unsupported,
            ),
          ),
        );
        verifyNever(() => client.reportRoom(any(), any()));
      }
    });
  }

  test(
    'user report preserves exact subject and reason and awaits HTTP ack',
    () async {
      final ack = Completer<Map<String, Object?>>();
      when(
        () => client.reportUser('@subject:other.test', 'reason\nuser detail'),
      ).thenAnswer((_) => ack.future);
      var completed = false;
      final report = repository
          .reportUser(
            userId: '@subject:other.test',
            reason: 'reason\nuser detail',
          )
          .then((_) => completed = true);
      await Future<void>.delayed(Duration.zero);
      expect(completed, isFalse);
      verify(
        () => client.reportUser('@subject:other.test', 'reason\nuser detail'),
      ).called(1);
      ack.complete(<String, Object?>{});
      await report;
      expect(completed, isTrue);
    },
  );

  test(
    'client switch while versions load prevents report submission',
    () async {
      final versions = Completer<GetVersionsResponse>();
      when(client.getVersions).thenAnswer((_) => versions.future);
      final report = repository.reportRoom(
        roomId: '!room:hs.test',
        reason: 'spam',
      );
      await Future<void>.delayed(Duration.zero);
      when(() => manager.client).thenReturn(_Client());
      versions.complete(GetVersionsResponse(versions: ['v1.14']));
      await expectLater(
        report,
        throwsA(
          isA<ContentReportException>().having(
            (error) => error.kind,
            'kind',
            ContentReportFailure.accountChanged,
          ),
        ),
      );
      verifyNever(() => client.reportRoom(any(), any()));
    },
  );

  test('same client with a replaced token cannot submit', () async {
    final versions = Completer<GetVersionsResponse>();
    when(client.getVersions).thenAnswer((_) => versions.future);
    final report = repository.reportUser(userId: '@a:hs.test', reason: 'spam');
    await Future<void>.delayed(Duration.zero);
    token = 'session-B';
    versions.complete(GetVersionsResponse(versions: ['v1.14']));
    await expectLater(
      report,
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.accountChanged,
        ),
      ),
    );
    verifyNever(() => client.reportUser(any(), any()));
  });

  test('server ack for A after switch is not presented as B success', () async {
    final ack = Completer<Map<String, Object?>>();
    when(
      () => client.reportUser('@a:hs.test', 'spam'),
    ).thenAnswer((_) => ack.future);
    final report = repository.reportUser(userId: '@a:hs.test', reason: 'spam');
    await Future<void>.delayed(Duration.zero);
    when(() => manager.client).thenReturn(_Client());
    ack.complete(<String, Object?>{});
    await expectLater(
      report,
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.accountChanged,
        ),
      ),
    );
    verify(() => client.reportUser('@a:hs.test', 'spam')).called(1);
  });

  for (final (code, kind) in <(String, ContentReportFailure)>[
    ('M_UNRECOGNIZED', ContentReportFailure.unsupported),
    ('M_NOT_FOUND', ContentReportFailure.subjectNotFound),
    ('M_FORBIDDEN', ContentReportFailure.forbidden),
    ('M_UNAUTHORIZED', ContentReportFailure.unauthorized),
    ('M_UNKNOWN_TOKEN', ContentReportFailure.unauthorized),
    ('M_LIMIT_EXCEEDED', ContentReportFailure.rateLimited),
  ]) {
    test('Matrix $code remains a distinct report error', () async {
      when(() => client.reportRoom('!group:hs.test', 'spam')).thenThrow(
        MatrixException.fromJson({
          'errcode': code,
          if (code == 'M_LIMIT_EXCEEDED') 'retry_after_ms': 1200,
        }),
      );
      await expectLater(
        repository.reportRoom(roomId: '!group:hs.test', reason: 'spam'),
        throwsA(
          isA<ContentReportException>()
              .having((error) => error.kind, 'kind', kind)
              .having(
                (error) => error.retryAfter,
                'retryAfter',
                code == 'M_LIMIT_EXCEEDED'
                    ? const Duration(milliseconds: 1200)
                    : null,
              ),
        ),
      );
    });
  }

  test('offline transport failure is not called unsupported', () async {
    when(
      () => client.reportUser('@a:hs.test', 'spam'),
    ).thenThrow(const SocketException('offline'));
    await expectLater(
      repository.reportUser(userId: '@a:hs.test', reason: 'spam'),
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.transport,
        ),
      ),
    );
  });

  for (final (label, failure) in <(String, Object)>[
    ('timeout', TimeoutException('late timeout')),
    ('I/O', const SocketException('late disconnect')),
    ('HTTP client', http.ClientException('late disconnect')),
  ]) {
    test(
      '$label failure after client switch during versions is account changed',
      () async {
        final versions = Completer<GetVersionsResponse>();
        when(client.getVersions).thenAnswer((_) => versions.future);
        final report = repository.reportUser(
          userId: '@a:hs.test',
          reason: 'spam',
        );
        await Future<void>.delayed(Duration.zero);

        when(() => manager.client).thenReturn(_Client());
        final result = expectLater(
          report,
          throwsA(
            isA<ContentReportException>().having(
              (error) => error.kind,
              'kind',
              ContentReportFailure.accountChanged,
            ),
          ),
        );
        versions.completeError(failure);
        await result;
        verifyNever(() => client.reportUser(any(), any()));
      },
    );

    test(
      '$label failure after token switch during report is account changed',
      () async {
        final ack = Completer<Map<String, Object?>>();
        when(
          () => client.reportUser('@a:hs.test', 'spam'),
        ).thenAnswer((_) => ack.future);
        final report = repository.reportUser(
          userId: '@a:hs.test',
          reason: 'spam',
        );
        await Future<void>.delayed(Duration.zero);
        verify(() => client.reportUser('@a:hs.test', 'spam')).called(1);

        token = 'session-B';
        final result = expectLater(
          report,
          throwsA(
            isA<ContentReportException>().having(
              (error) => error.kind,
              'kind',
              ContentReportFailure.accountChanged,
            ),
          ),
        );
        ack.completeError(failure);
        await result;
      },
    );
  }

  test(
    'missing versions endpoint is distinct from missing report subject',
    () async {
      when(
        client.getVersions,
      ).thenThrow(MatrixException.fromJson({'errcode': 'M_NOT_FOUND'}));
      await expectLater(
        repository.reportUser(userId: '@a:hs.test', reason: 'spam'),
        throwsA(
          isA<ContentReportException>().having(
            (error) => error.kind,
            'kind',
            ContentReportFailure.unsupported,
          ),
        ),
      );
      verifyNever(() => client.reportUser(any(), any()));
    },
  );
}
