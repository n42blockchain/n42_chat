import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class _BoundRepository extends Mock
    implements IAuthRepository, IAccountBoundAuthInvalidation {}

void main() {
  const a = UserEntity(userId: '@alice:hs.test', displayName: 'Alice');
  late _BoundRepository repository;
  late StreamController<AuthSessionInvalidation> invalidations;
  var current = true;

  setUp(() {
    current = true;
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

  AuthSessionInvalidation notice() => AuthSessionInvalidation(
    userId: a.userId,
    homeserver: Uri.parse('https://hs.test'),
    deviceId: 'A-device',
    isCurrent: () => current,
  );

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
}
