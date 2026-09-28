import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:n42_chat/src/core/utils/matrix_deletion_uia_coordinator.dart';

MatrixException challenge({
  String session = 'session 1',
  List<List<String>> flows = const [
    ['m.login.password'],
  ],
  List<String> completed = const [],
}) => MatrixException.fromJson({
  'session': session,
  'flows': [
    for (final stages in flows) {'stages': stages},
  ],
  'completed': completed,
});

void main() {
  const userId = '@alice:example.org';
  final homeserver = Uri.parse('https://matrix.example.org/base');

  test(
    'decoded UIA without HTTP response preserves exact password and session',
    () async {
      final sent = <AuthenticationData?>[];
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (auth) async {
          sent.add(auth);
          if (auth == null) throw challenge();
        },
      );

      expect(
        await coordinator.start(),
        DeletionUiaStatus.awaitingAuthentication,
      );
      expect(coordinator.nextStages, ['m.login.password']);
      expect(
        await coordinator.submitPassword(' secret '),
        DeletionUiaStatus.deactivated,
      );
      expect(sent, hasLength(2));
      expect(sent.first, isNull);
      expect(sent.last, isA<AuthenticationPassword>());
      expect(sent.last!.toJson(), {
        'type': 'm.login.password',
        'session': 'session 1',
        'password': ' secret ',
        'identifier': {'type': 'm.id.user', 'user': userId},
      });
    },
  );

  test('server success without UIA is the only success signal', () async {
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      request: (_) async {},
    );
    expect(await coordinator.start(), DeletionUiaStatus.deactivated);
    expect(coordinator.confirmedDeletion?.userId, userId);
    expect(coordinator.confirmedDeletion?.requiresDeferredCleanup, isFalse);
    expect(() => coordinator.start(), throwsA(isA<DeletionUiaException>()));
  });

  test('completed stages are an ordered prefix of an offered flow', () async {
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      request: (_) async => throw challenge(
        flows: [
          ['m.login.sso', 'm.login.password'],
          ['m.login.password'],
          ['m.login.sso', 'm.login.email.identity'],
        ],
        completed: ['m.login.sso'],
      ),
    );
    expect(await coordinator.start(), DeletionUiaStatus.awaitingAuthentication);
    expect(coordinator.nextStages, [
      'm.login.password',
      'm.login.email.identity',
    ]);
  });

  test('alternative first stages are retained in server order', () async {
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      request: (_) async => throw challenge(
        flows: [
          ['m.login.sso'],
          ['m.login.password'],
          ['m.login.sso'],
        ],
      ),
    );
    expect(await coordinator.start(), DeletionUiaStatus.awaitingAuthentication);
    expect(coordinator.nextStages, ['m.login.sso', 'm.login.password']);
  });

  test('malformed session and flows fail closed', () async {
    for (final error in [
      challenge(session: ''),
      challenge(flows: []),
      challenge(
        flows: [
          [],
          [''],
        ],
      ),
      challenge(
        flows: [
          ['m.login.password', 'm.login.sso'],
        ],
        completed: ['m.login.sso'],
      ),
    ]) {
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (_) async => throw error,
      );
      await expectLater(
        coordinator.start(),
        throwsA(isA<DeletionUiaException>()),
      );
    }
  });

  test('wrong password can retry with refreshed server session', () async {
    final sent = <AuthenticationData?>[];
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      request: (auth) async {
        sent.add(auth);
        if (sent.length == 1) throw challenge();
        if (sent.length == 2) throw challenge(session: 'session 2');
      },
    );
    expect(await coordinator.start(), DeletionUiaStatus.awaitingAuthentication);
    expect(
      await coordinator.submitPassword('wrong'),
      DeletionUiaStatus.awaitingAuthentication,
    );
    expect(coordinator.session, 'session 2');
    expect(
      await coordinator.submitPassword(' correct '),
      DeletionUiaStatus.deactivated,
    );
    expect(sent[1]!.session, 'session 1');
    expect(sent[2]!.session, 'session 2');
  });

  test(
    'trusted fallback requires matching stage, origin and current session',
    () async {
      final sent = <AuthenticationData?>[];
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (auth) async {
          sent.add(auth);
          if (auth == null) {
            throw challenge(
              session: 'a/b ?&',
              flows: [
                ['m.login.sso'],
              ],
            );
          }
        },
      );
      expect(
        await coordinator.start(),
        DeletionUiaStatus.awaitingAuthentication,
      );
      final url = coordinator.fallbackUri('m.login.sso');
      expect(url.path, '/base/_matrix/client/v3/auth/m.login.sso/fallback/web');
      expect(url.queryParameters['session'], 'a/b ?&');
      for (final attempt in [
        () => coordinator.retryAfterFallback(
          stage: 'm.login.password',
          session: 'a/b ?&',
          origin: Uri.parse('https://matrix.example.org'),
        ),
        () => coordinator.retryAfterFallback(
          stage: 'm.login.sso',
          session: 'stale',
          origin: Uri.parse('https://matrix.example.org'),
        ),
        () => coordinator.retryAfterFallback(
          stage: 'm.login.sso',
          session: 'a/b ?&',
          origin: Uri.parse('https://evil.example.org'),
        ),
      ]) {
        await expectLater(attempt(), throwsA(isA<DeletionUiaException>()));
      }
      expect(sent, hasLength(1));
      expect(
        await coordinator.retryAfterFallback(
          stage: 'm.login.sso',
          session: 'a/b ?&',
          origin: Uri.parse('https://matrix.example.org'),
        ),
        DeletionUiaStatus.deactivated,
      );
      expect(sent.last!.toJson(), {'session': 'a/b ?&'});
    },
  );

  test(
    'browser completion followed by server rejection is not success',
    () async {
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (auth) async {
          if (auth == null) {
            throw challenge(
              flows: [
                ['m.login.sso'],
              ],
            );
          }
          throw MatrixException.fromJson({'errcode': 'M_FORBIDDEN'});
        },
      );
      expect(
        await coordinator.start(),
        DeletionUiaStatus.awaitingAuthentication,
      );
      coordinator.fallbackUri('m.login.sso');
      await expectLater(
        coordinator.retryAfterFallback(
          stage: 'm.login.sso',
          session: 'session 1',
          origin: Uri.parse('https://matrix.example.org'),
        ),
        throwsA(isA<MatrixException>()),
      );
      expect(coordinator.status, isNot(DeletionUiaStatus.deactivated));
    },
  );

  test('refreshed session invalidates an older browser callback', () async {
    var calls = 0;
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      request: (_) async {
        calls++;
        throw challenge(
          session: calls == 1 ? 'old' : 'new',
          flows: [
            ['m.login.sso'],
            ['m.login.password'],
          ],
        );
      },
    );
    expect(await coordinator.start(), DeletionUiaStatus.awaitingAuthentication);
    coordinator.fallbackUri('m.login.sso');
    expect(
      await coordinator.submitPassword('wrong'),
      DeletionUiaStatus.awaitingAuthentication,
    );
    await expectLater(
      coordinator.retryAfterFallback(
        stage: 'm.login.sso',
        session: 'old',
        origin: Uri.parse('https://matrix.example.org'),
      ),
      throwsA(isA<DeletionUiaException>()),
    );
    expect(calls, 2);
  });

  test(
    'malformed replacement challenge invalidates an opened fallback',
    () async {
      for (final replacement in [
        challenge(session: ''),
        challenge(flows: []),
      ]) {
        var calls = 0;
        final coordinator = MatrixDeletionUiaCoordinator(
          userId: userId,
          homeserver: homeserver,
          isCurrentAccount: () => true,
          request: (_) async {
            calls++;
            if (calls == 1) {
              throw challenge(
                session: 'old',
                flows: [
                  ['m.login.sso'],
                  ['m.login.password'],
                ],
              );
            }
            throw replacement;
          },
        );
        expect(
          await coordinator.start(),
          DeletionUiaStatus.awaitingAuthentication,
        );
        coordinator.fallbackUri('m.login.sso');
        await expectLater(
          coordinator.submitPassword('wrong'),
          throwsA(isA<DeletionUiaException>()),
        );
        expect(coordinator.session, isNull);
        expect(coordinator.nextStages, isEmpty);
        expect(coordinator.status, DeletionUiaStatus.failed);
        await expectLater(
          coordinator.retryAfterFallback(
            stage: 'm.login.sso',
            session: 'old',
            origin: Uri.parse('https://matrix.example.org'),
          ),
          throwsA(isA<DeletionUiaException>()),
        );
        expect(calls, 2);
      }
    },
  );

  test('attempt limit prevents unbounded password retries', () async {
    var calls = 0;
    final coordinator = MatrixDeletionUiaCoordinator(
      userId: userId,
      homeserver: homeserver,
      isCurrentAccount: () => true,
      maxAttempts: 2,
      request: (_) async {
        calls++;
        throw challenge();
      },
    );
    expect(await coordinator.start(), DeletionUiaStatus.awaitingAuthentication);
    expect(
      await coordinator.submitPassword('wrong'),
      DeletionUiaStatus.awaitingAuthentication,
    );
    await expectLater(
      coordinator.submitPassword('again'),
      throwsA(
        isA<DeletionUiaException>().having(
          (error) => error.reason,
          'reason',
          DeletionUiaFailure.attemptLimit,
        ),
      ),
    );
    expect(calls, 2);
  });

  test(
    'cancellation after dispatch preserves confirmed deletion receipt',
    () async {
      final wait = Completer<void>();
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (_) => wait.future,
      );
      final pending = coordinator.start();
      coordinator.cancel();
      wait.complete();
      expect(await pending, DeletionUiaStatus.deactivatedNeedsScopedCleanup);
      expect(coordinator.confirmedDeletion?.userId, userId);
      expect(coordinator.confirmedDeletion?.homeserver, homeserver);
      expect(coordinator.confirmedDeletion?.requiresDeferredCleanup, isTrue);
      coordinator.cancel();
      expect(
        coordinator.status,
        DeletionUiaStatus.deactivatedNeedsScopedCleanup,
      );
    },
  );

  test(
    'network errors propagate and cancellation blocks later requests',
    () async {
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => true,
        request: (_) async => throw TimeoutException('network'),
      );
      await expectLater(coordinator.start(), throwsA(isA<TimeoutException>()));
      coordinator.cancel();
      await expectLater(
        coordinator.submitPassword('secret'),
        throwsA(isA<DeletionUiaException>()),
      );
    },
  );

  test(
    'account switch and concurrent submit cannot send new requests',
    () async {
      var current = true;
      final wait = Completer<void>();
      var calls = 0;
      final coordinator = MatrixDeletionUiaCoordinator(
        userId: userId,
        homeserver: homeserver,
        isCurrentAccount: () => current,
        request: (auth) async {
          calls++;
          if (auth == null) throw challenge();
          await wait.future;
        },
      );
      expect(
        await coordinator.start(),
        DeletionUiaStatus.awaitingAuthentication,
      );
      final first = coordinator.submitPassword('secret');
      await expectLater(
        coordinator.submitPassword('again'),
        throwsA(isA<DeletionUiaException>()),
      );
      current = false;
      wait.complete();
      expect(await first, DeletionUiaStatus.deactivatedNeedsScopedCleanup);
      expect(calls, 2);
      expect(coordinator.confirmedDeletion?.userId, userId);
      expect(coordinator.confirmedDeletion?.requiresDeferredCleanup, isTrue);
      await expectLater(
        coordinator.submitPassword('after switch'),
        throwsA(isA<DeletionUiaException>()),
      );
    },
  );
}
