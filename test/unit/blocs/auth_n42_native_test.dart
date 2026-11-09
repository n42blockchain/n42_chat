import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/services/biometric_service.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/remote/id_hub_api.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/n42_chat_config.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';
import 'package:n42_chat/src/services/auth/auth_methods_service.dart';

class Repo extends Mock implements IAuthRepository {}

class Bio extends Mock implements BiometricService {}

class Storage extends Mock implements SecureStorageDataSource {}

class Api extends IdHubApi {
  Api() : super(baseUrl: 'https://id.n42.world');
  final closed = Completer<void>();
  @override
  void close() {
    super.close();
    if (!closed.isCompleted) closed.complete();
  }

  bool fail = false;
  int completed = 0;
  String? receivedToken;
  int browserPolls = 0;
  String? browserProvider;
  @override
  Future<IdHubBrowserChallenge> startBrowserLogin(String provider) async {
    browserProvider = provider;
    return IdHubBrowserChallenge(
      flowId: 'f' * 43,
      completionSecret: 's' * 43,
      browserUrl: Uri.parse(
        'https://n42.world/v1/auth/n42/browser/login?ticket=' + 't' * 43,
      ),
      expiresIn: const Duration(seconds: 10),
    );
  }

  @override
  Future<IdHubWalletResponse?> pollBrowserLogin(
    IdHubBrowserChallenge flow,
  ) async {
    browserPolls++;
    return IdHubWalletResponse.success(
      did: 'did:plc:alice',
      matrixHomeserver: 'https://matrix.example',
      matrixUserId: '@alice:matrix.example',
      matrixAccessToken: 'matrix-token',
    );
  }

  @override
  Future<IdHubNativeChallenge> startNativeLogin(
    String provider,
    String platform,
  ) async {
    if (fail) throw IdHubException('unavailable');
    return IdHubNativeChallenge(
      flowId: 'f' * 43,
      completionSecret: 'c' * 43,
      nonce: 'n' * 43,
    );
  }

  @override
  Future<IdHubWalletResponse> completeNativeLogin(
    IdHubNativeChallenge c,
    String token, {
    String? serverAuthCode,
  }) async {
    completed++;
    receivedToken = serverAuthCode ?? token;
    return IdHubWalletResponse.success(
      did: 'did:plc:alice',
      matrixHomeserver: 'https://matrix.example',
      matrixUserId: '@alice:matrix.example',
      matrixAccessToken: 'matrix-token',
    );
  }
}

void main() {
  late Repo repo;
  late Api api;
  setUp(() async {
    await getIt.reset();
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    getIt.registerSingleton(
      const N42ChatConfig(n42NativeAuthUrl: 'https://id.n42.world'),
    );
    repo = Repo();
    api = Api();
    when(() => repo.loginStateStream).thenAnswer((_) => const Stream.empty());
    when(() => repo.isLoggedIn).thenReturn(false);
    when(() => repo.currentUser).thenReturn(null);
  });
  tearDown(() async {
    debugDefaultTargetPlatformOverride = null;
    await getIt.reset();
  });
  AuthBloc build(Future<SocialLoginResult?> Function(String, String) proof) =>
      AuthBloc(
        authRepository: repo,
        biometricService: Bio(),
        secureStorage: Storage(),
        idHubApiFactory: (_) => api,
        nativeSocialProof: proof,
      );
  Future<void> wait(AuthBloc bloc) => bloc.stream
      .firstWhere((s) => s.status != AuthStatus.loading)
      .timeout(const Duration(seconds: 3));
  test(
    'server challenge failure stops without legacy login or SDK call',
    () async {
      api.fail = true;
      var proofCalls = 0;
      final bloc = build((_, _) async {
        proofCalls++;
        return null;
      });
      final done = wait(bloc);
      bloc.add(
        const AuthAppleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await done;
      expect(bloc.state.status, AuthStatus.error);
      expect(proofCalls, 0);
      verifyNever(
        () => repo.loginWithSocialToken(
          homeserver: any(named: 'homeserver'),
          provider: any(named: 'provider'),
          idToken: any(named: 'idToken'),
          accessToken: any(named: 'accessToken'),
          email: any(named: 'email'),
          displayName: any(named: 'displayName'),
          extra: any(named: 'extra'),
        ),
      );
      await bloc.close();
    },
  );
  test(
    'passes server nonce to SDK and cancellation stops before completion',
    () async {
      final bloc = build((p, nonce) async {
        expect(p, 'apple');
        expect(nonce, 'n' * 43);
        return null;
      });
      final done = wait(bloc);
      bloc.add(
        const AuthAppleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await done;
      expect(bloc.state.status, AuthStatus.unauthenticated);
      expect(api.completed, 0);
      await bloc.close();
    },
  );
  test(
    'never substitutes Facebook classic access token for an OIDC proof',
    () async {
      final bloc = build(
        (_, _) async => SocialLoginResult(
          provider: 'facebook',
          accessToken: 'classic-token',
        ),
      );
      final done = wait(bloc);
      bloc.add(
        const AuthFacebookLoginRequested(homeserver: 'https://legacy.example'),
      );
      await done;
      expect(bloc.state.status, AuthStatus.error);
      expect(api.completed, 0);
      await bloc.close();
    },
  );
  test('verified Matrix credentials reach repository without legacy identity lookup', () async {
    when(
      () => repo.loginWithToken(
        homeserver: 'https://matrix.example',
        accessToken: 'matrix-token',
        userId: '@alice:matrix.example',
        deviceId: '',
      ),
    ).thenAnswer((_) async {
      const user = UserEntity(
        userId: '@alice:matrix.example',
        displayName: 'Alice',
      );
      when(() => repo.currentUser).thenReturn(user);
      return AuthResult.success(user);
    });
    final bloc = build(
      (_, _) async =>
          SocialLoginResult(provider: 'apple', idToken: 'oidc-proof'),
    );
    final done = wait(bloc);
    bloc.add(
      const AuthAppleLoginRequested(homeserver: 'https://legacy.example'),
    );
    await done;
    expect(api.receivedToken, 'oidc-proof');
    verify(
      () => repo.loginWithToken(
        homeserver: 'https://matrix.example',
        accessToken: 'matrix-token',
        userId: '@alice:matrix.example',
        deviceId: '',
      ),
    ).called(1);
    await bloc.close();
  });
  test(
    'late native proof failure does not replace another account state',
    () async {
      final entered = Completer<void>();
      final proof = Completer<SocialLoginResult?>();
      final bloc = build((_, _) {
        entered.complete();
        return proof.future;
      });
      bloc.add(
        const AuthAppleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await entered.future;
      const other = UserEntity(
        userId: '@bob:matrix.example',
        displayName: 'Bob',
      );
      when(() => repo.currentUser).thenReturn(other);
      when(() => repo.isLoggedIn).thenReturn(true);
      final authenticated = bloc.stream.firstWhere(
        (s) => s.status == AuthStatus.authenticated,
      );
      bloc.add(const AuthCheckRequested());
      await authenticated;
      proof.completeError(StateError('provider unavailable'));
      await api.closed.future;
      expect(bloc.state.status, AuthStatus.authenticated);
      expect(bloc.state.user?.userId, other.userId);
      expect(bloc.state.errorMessage, isNull);
      expect(api.completed, 0);
      await bloc.close();
    },
  );
  for (final success in [false, true]) {
    test('late Matrix login $success keeps the current account', () async {
      final entered = Completer<void>();
      final pending = Completer<AuthResult>();
      when(
        () => repo.loginWithToken(
          homeserver: 'https://matrix.example',
          accessToken: 'matrix-token',
          userId: '@alice:matrix.example',
          deviceId: '',
        ),
      ).thenAnswer((_) {
        entered.complete();
        return pending.future;
      });
      final bloc = build(
        (_, _) async => SocialLoginResult(provider: 'apple', idToken: 'proof'),
      );
      bloc.add(
        const AuthAppleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await entered.future;
      const other = UserEntity(
        userId: '@bob:matrix.example',
        displayName: 'Bob',
      );
      when(() => repo.currentUser).thenReturn(other);
      when(() => repo.isLoggedIn).thenReturn(true);
      final authenticated = bloc.stream.firstWhere(
        (s) => s.status == AuthStatus.authenticated,
      );
      bloc.add(const AuthCheckRequested());
      await authenticated;
      pending.complete(
        success
            ? AuthResult.success(
                const UserEntity(
                  userId: '@alice:matrix.example',
                  displayName: 'Alice',
                ),
              )
            : AuthResult.failure('old Matrix login failed'),
      );
      await api.closed.future;
      expect(bloc.state.status, AuthStatus.authenticated);
      expect(bloc.state.user?.userId, other.userId);
      expect(bloc.state.errorMessage, isNull);
      await bloc.close();
    });
  }
  for (final platform in [TargetPlatform.iOS, TargetPlatform.android]) {
    test('Google server code reaches isolated login on $platform', () async {
      debugDefaultTargetPlatformOverride = platform;
      when(
        () => repo.loginWithToken(
          homeserver: 'https://matrix.example',
          accessToken: 'matrix-token',
          userId: '@alice:matrix.example',
          deviceId: '',
        ),
      ).thenAnswer((_) async => AuthResult.failure('test-only'));
      final bloc = build((provider, _) async {
        expect(provider, 'google');
        return SocialLoginResult(
          provider: 'google',
          extra: {'serverAuthCode': 'one-use-code'},
        );
      });
      final done = wait(bloc);
      bloc.add(
        const AuthGoogleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await done;
      expect(api.receivedToken, 'one-use-code');
      expect(api.completed, 1);
      await bloc.close();
    });
  }
  test(
    'Google never downgrades a missing server code to an ID token',
    () async {
      final bloc = build(
        (_, _) async =>
            SocialLoginResult(provider: 'google', idToken: 'id-token-only'),
      );
      final done = wait(bloc);
      bloc.add(
        const AuthGoogleLoginRequested(homeserver: 'https://legacy.example'),
      );
      await done;
      expect(bloc.state.status, AuthStatus.error);
      expect(api.completed, 0);
      await bloc.close();
    },
  );
  for (final provider in ['apple', 'facebook']) {
    test(
      'Android $provider uses browser handoff without native OIDC SDK',
      () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        when(
          () => repo.loginWithToken(
            homeserver: 'https://matrix.example',
            accessToken: 'matrix-token',
            userId: '@alice:matrix.example',
            deviceId: '',
          ),
        ).thenAnswer((_) async => AuthResult.failure('test-only'));
        var opened = false;
        final bloc = AuthBloc(
          authRepository: repo,
          biometricService: Bio(),
          secureStorage: Storage(),
          idHubApiFactory: (_) => api,
          nativeSocialProof: (_, _) async =>
              throw StateError('Native SDK must not run'),
          browserLoginLauncher: (uri) async {
            expect(uri.host, 'n42.world');
            opened = true;
            return true;
          },
        );
        final done = wait(bloc);
        bloc.add(
          provider == 'apple'
              ? const AuthAppleLoginRequested(
                  homeserver: 'https://legacy.example',
                )
              : const AuthFacebookLoginRequested(
                  homeserver: 'https://legacy.example',
                ),
        );
        await done;
        expect(opened, true);
        expect(api.browserProvider, provider);
        expect(api.browserPolls, 1);
        expect(api.completed, 0);
        await bloc.close();
      },
    );
  }
}
