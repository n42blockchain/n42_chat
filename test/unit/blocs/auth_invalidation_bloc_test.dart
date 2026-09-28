import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class _BoundRepository extends Mock
    implements IAuthRepository, IAccountBoundAuthInvalidation {}

class _DeletionRepository extends Mock
    implements
        IAuthRepository,
        IAccountBoundAuthInvalidation,
        IConfirmedAccountDeletionGeneration {}

void main() {
  const a = UserEntity(userId: '@alice:hs.test', displayName: 'Alice');
  late _BoundRepository repository;
  late _DeletionRepository deletionRepository;
  late StreamController<AuthSessionInvalidation> invalidations;
  late AuthSessionInvalidation origin;
  var current = true;

  AuthSessionInvalidation notice() => AuthSessionInvalidation(
    userId: a.userId,
    homeserver: Uri.parse('https://hs.test'),
    deviceId: 'A-device',
    isCurrent: () => current,
  );

  setUp(() {
    current = true;
    origin = notice();
    repository = _BoundRepository();
    invalidations = StreamController<AuthSessionInvalidation>.broadcast(
      sync: true,
    );
    when(
      () => repository.accountInvalidationStream,
    ).thenAnswer((_) => invalidations.stream);
    when(
      () => repository.loginStateStream,
    ).thenAnswer((_) => const Stream<bool>.empty());
    when(() => repository.logout()).thenAnswer((_) async {});
  });
  tearDown(() async => invalidations.close());

  blocTest<AuthBloc, AuthState>(
    'stale queued A invalidation does not log out B',
    build: () => AuthBloc(authRepository: repository),
    seed: () => const AuthState(status: AuthStatus.authenticated, user: a),
    act: (_) async {
      invalidations.add(notice());
      current = false;
      await Future<void>.delayed(Duration.zero);
    },
    expect: () => <AuthState>[],
    verify: (_) => verifyNever(() => repository.logout()),
  );

  blocTest<AuthBloc, AuthState>(
    'current generation SDK invalidation retains ordinary logout behavior',
    build: () => AuthBloc(authRepository: repository),
    seed: () => const AuthState(status: AuthStatus.authenticated, user: a),
    act: (_) async {
      invalidations.add(notice());
      await Future<void>.delayed(Duration.zero);
    },
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
      isA<AuthState>().having(
        (s) => s.status,
        'status',
        AuthStatus.unauthenticated,
      ),
    ],
    verify: (_) => verify(() => repository.logout()).called(1),
  );

  for (final confirmed in [false, true]) {
    blocTest<AuthBloc, AuthState>(
      'deletion transition ${confirmed ? 'requires' : 'rejects absent'} server confirmation',
      build: () {
        deletionRepository = _DeletionRepository();
        when(
          () => deletionRepository.accountInvalidationStream,
        ).thenAnswer((_) => invalidations.stream);
        when(
          () => deletionRepository.loginStateStream,
        ).thenAnswer((_) => const Stream<bool>.empty());
        when(
          () => deletionRepository.isConfirmedDeletionGeneration(origin),
        ).thenReturn(confirmed);
        return AuthBloc(authRepository: deletionRepository);
      },
      seed: () => const AuthState(status: AuthStatus.authenticated, user: a),
      act: (bloc) => bloc.add(AuthAccountDeletionConfirmed(origin)),
      expect: () => confirmed
          ? [
              isA<AuthState>().having(
                (state) => state.status,
                'status',
                AuthStatus.unauthenticated,
              ),
            ]
          : <AuthState>[],
      verify: (_) => verifyNever(() => deletionRepository.logout()),
    );
  }

  blocTest<AuthBloc, AuthState>(
    'stale confirmed A deletion does not transition current B',
    build: () {
      deletionRepository = _DeletionRepository();
      when(
        () => deletionRepository.accountInvalidationStream,
      ).thenAnswer((_) => invalidations.stream);
      when(
        () => deletionRepository.loginStateStream,
      ).thenAnswer((_) => const Stream<bool>.empty());
      when(
        () => deletionRepository.isConfirmedDeletionGeneration(origin),
      ).thenReturn(true);
      return AuthBloc(authRepository: deletionRepository);
    },
    seed: () => const AuthState(status: AuthStatus.authenticated, user: a),
    act: (bloc) {
      current = false;
      bloc.add(AuthAccountDeletionConfirmed(origin));
    },
    expect: () => <AuthState>[],
    verify: (_) => verifyNever(() => deletionRepository.logout()),
  );
}
