import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  final testUser = UserEntity(
    userId: '@user:server.com',
    displayName: 'Test User',
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    
    // 设置默认行为
    when(() => mockAuthRepository.loginStateStream)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockAuthRepository.isLoggedIn).thenReturn(false);
    when(() => mockAuthRepository.currentUser).thenReturn(null);
    
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state should be AuthState.initial', () {
      expect(authBloc.state.status, AuthStatus.initial);
      expect(authBloc.state.user, isNull);
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when login succeeds',
      build: () {
        when(() => mockAuthRepository.login(
              homeserver: any(named: 'homeserver'),
              username: any(named: 'username'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => AuthResult.success(testUser));
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        homeserver: 'https://server.com',
        username: 'user',
        password: 'password',
      )),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.authenticated)
            .having((s) => s.user, 'user', testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when login fails',
      build: () {
        when(() => mockAuthRepository.login(
              homeserver: any(named: 'homeserver'),
              username: any(named: 'username'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => AuthResult.failure(
              '用户名或密码错误',
              type: AuthErrorType.invalidCredentials,
            ));
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        homeserver: 'https://server.com',
        username: 'user',
        password: 'wrong',
      )),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.error)
            .having((s) => s.errorType, 'errorType', AuthErrorType.invalidCredentials),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when register succeeds',
      build: () {
        when(() => mockAuthRepository.register(
              homeserver: any(named: 'homeserver'),
              username: any(named: 'username'),
              password: any(named: 'password'),
              email: any(named: 'email'),
            )).thenAnswer((_) async => AuthResult.success(testUser));
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthRegisterRequested(
        homeserver: 'https://server.com',
        username: 'newuser',
        password: 'password',
      )),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.authenticated)
            .having((s) => s.user, 'user', testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when logout succeeds',
      build: () {
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async {});
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.unauthenticated),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [checking, authenticated] when session restore succeeds',
      build: () {
        when(() => mockAuthRepository.restoreSession())
            .thenAnswer((_) async => AuthResult.success(testUser));
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthRestoreSessionRequested()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.checking),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.authenticated)
            .having((s) => s.user, 'user', testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [checking, unauthenticated] when session restore fails',
      build: () {
        when(() => mockAuthRepository.restoreSession())
            .thenAnswer((_) async => AuthResult.notLoggedIn());
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) => bloc.add(const AuthRestoreSessionRequested()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.checking),
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.unauthenticated),
      ],
    );
  });
}
