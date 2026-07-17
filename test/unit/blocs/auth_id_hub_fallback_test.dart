import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/services/biometric_service.dart';
import 'package:n42_chat/src/core/utils/wallet_login_credentials.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/remote/id_hub_api.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/n42_chat_config.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class _MockAuthRepository extends Mock implements IAuthRepository {}

class _MockBiometricService extends Mock implements BiometricService {}

class _MockSecureStorageDataSource extends Mock
    implements SecureStorageDataSource {}

class _MockWalletBridge extends Mock implements IWalletBridge {}

class _FakeIdHubApi extends IdHubApi {
  _FakeIdHubApi({required this.challenge, required this.response})
    : super(baseUrl: 'https://id-test.n42.ai');

  final IdHubChallenge challenge;
  final IdHubWalletResponse response;

  @override
  Future<IdHubChallenge> createWalletChallenge({
    required String address,
    String chain = 'eip155:1142',
  }) async => challenge;

  @override
  Future<IdHubWalletResponse> verifyWalletLogin({
    required String challengeId,
    required String signature,
    String signerType = 'eoa',
  }) async => response;
}

class _ThrowingIdHubApi extends IdHubApi {
  _ThrowingIdHubApi() : super(baseUrl: 'https://id-test.n42.ai');

  @override
  Future<IdHubChallenge> createWalletChallenge({
    required String address,
    String chain = 'eip155:1142',
  }) => throw IdHubException('hub unavailable', 503);
}

void main() {
  const event = AuthWalletAuthRequested(
    homeserver: 'https://matrix.example',
    address: '0xAABB',
  );
  // Signing is deferred to the bloc: the legacy path signs the canonical message
  // via the wallet bridge, so tests stub that message -> legacySignature.
  const legacySignature = '0xlegacy-signature';
  final canonicalMessage =
      WalletLoginCredentials.canonicalLoginMessage(event.address);
  final legacyCredentials = WalletLoginCredentials.derive(
    address: event.address,
    signature: legacySignature,
  );

  late _MockAuthRepository repository;
  late _MockBiometricService biometricService;
  late _MockSecureStorageDataSource secureStorage;

  setUp(() async {
    await getIt.reset();
    repository = _MockAuthRepository();
    biometricService = _MockBiometricService();
    secureStorage = _MockSecureStorageDataSource();
    when(
      () => repository.loginStateStream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => repository.isLoggedIn).thenReturn(false);
    when(() => repository.currentUser).thenReturn(null);
    when(
      () => repository.login(
        homeserver: event.homeserver,
        username: legacyCredentials.username,
        password: legacyCredentials.password,
        rememberMe: true,
      ),
    ).thenAnswer(
      (_) async => AuthResult.failure(
        'legacy unavailable',
        type: AuthErrorType.networkError,
      ),
    );
  });

  tearDown(() => getIt.reset());

  AuthBloc buildBloc({IdHubApi Function(String baseUrl)? idHubApiFactory}) =>
      AuthBloc(
        authRepository: repository,
        biometricService: biometricService,
        secureStorage: secureStorage,
        idHubApiFactory: idHubApiFactory,
      );

  blocTest<AuthBloc, AuthState>(
    'feature flag off skips ID Hub and preserves legacy wallet login',
    setUp: () {
      getIt.registerSingleton(const N42ChatConfig(enableIdHubLogin: false));
      final wallet = _MockWalletBridge();
      when(
        () => wallet.signMessage(canonicalMessage),
      ).thenAnswer((_) async => legacySignature);
      getIt.registerSingleton<IWalletBridge>(wallet);
    },
    build: () => buildBloc(
      idHubApiFactory: (_) => throw StateError('ID Hub must stay disabled'),
    ),
    act: (bloc) => bloc.add(event),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.loading,
      ),
      isA<AuthState>()
          .having((state) => state.status, 'status', AuthStatus.error)
          .having(
            (state) => state.errorMessage,
            'error message',
            'legacy unavailable',
          ),
    ],
    verify: (_) {
      verify(
        () => repository.login(
          homeserver: event.homeserver,
          username: legacyCredentials.username,
          password: legacyCredentials.password,
          rememberMe: true,
        ),
      ).called(1);
      verifyNever(
        () => repository.loginWithToken(
          homeserver: any(named: 'homeserver'),
          accessToken: any(named: 'accessToken'),
          userId: any(named: 'userId'),
          deviceId: any(named: 'deviceId'),
        ),
      );
    },
  );

  blocTest<AuthBloc, AuthState>(
    'Hub response without Matrix credentials falls back to legacy login',
    setUp: () {
      getIt.registerSingleton(
        const N42ChatConfig(
          idHubUrl: 'https://id-test.n42.ai',
          enableIdHubLogin: true,
        ),
      );
      final wallet = _MockWalletBridge();
      when(
        () => wallet.signMessage('N42 ID challenge'),
      ).thenAnswer((_) async => '0xhub-signature');
      when(
        () => wallet.signMessage(canonicalMessage),
      ).thenAnswer((_) async => legacySignature);
      getIt.registerSingleton<IWalletBridge>(wallet);
    },
    build: () => buildBloc(
      idHubApiFactory: (_) => _FakeIdHubApi(
        challenge: const IdHubChallenge(
          challengeId: 'challenge-1',
          message: 'N42 ID challenge',
        ),
        response: IdHubWalletResponse.success(did: 'did:plc:test'),
      ),
    ),
    act: (bloc) => bloc.add(event),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.loading,
      ),
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.error,
      ),
    ],
    verify: (_) {
      verify(
        () => getIt<IWalletBridge>().signMessage('N42 ID challenge'),
      ).called(1);
      verifyNever(
        () => repository.loginWithToken(
          homeserver: any(named: 'homeserver'),
          accessToken: any(named: 'accessToken'),
          userId: any(named: 'userId'),
          deviceId: any(named: 'deviceId'),
        ),
      );
      verify(
        () => repository.login(
          homeserver: event.homeserver,
          username: legacyCredentials.username,
          password: legacyCredentials.password,
          rememberMe: true,
        ),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'Matrix token rejection still falls back to the legacy account',
    setUp: () {
      getIt.registerSingleton(
        const N42ChatConfig(
          idHubUrl: 'https://id-test.n42.ai',
          enableIdHubLogin: true,
        ),
      );
      final wallet = _MockWalletBridge();
      when(
        () => wallet.signMessage('N42 ID challenge'),
      ).thenAnswer((_) async => '0xhub-signature');
      when(
        () => wallet.signMessage(canonicalMessage),
      ).thenAnswer((_) async => legacySignature);
      getIt.registerSingleton<IWalletBridge>(wallet);
      when(
        () => repository.loginWithToken(
          homeserver: 'https://matrix.hub.example',
          accessToken: 'matrix-token',
          userId: '@did_test:matrix.hub.example',
          deviceId: 'DEVICE1',
        ),
      ).thenAnswer(
        (_) async => AuthResult.failure(
          'token rejected',
          type: AuthErrorType.invalidCredentials,
        ),
      );
    },
    build: () => buildBloc(
      idHubApiFactory: (_) => _FakeIdHubApi(
        challenge: const IdHubChallenge(
          challengeId: 'challenge-1',
          message: 'N42 ID challenge',
        ),
        response: IdHubWalletResponse.success(
          did: 'did:plc:test',
          matrixUserId: '@did_test:matrix.hub.example',
          matrixAccessToken: 'matrix-token',
          matrixDeviceId: 'DEVICE1',
          matrixHomeserver: 'https://matrix.hub.example',
        ),
      ),
    ),
    act: (bloc) => bloc.add(event),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.loading,
      ),
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.error,
      ),
    ],
    verify: (_) {
      verify(
        () => repository.loginWithToken(
          homeserver: 'https://matrix.hub.example',
          accessToken: 'matrix-token',
          userId: '@did_test:matrix.hub.example',
          deviceId: 'DEVICE1',
        ),
      ).called(1);
      verify(
        () => repository.login(
          homeserver: event.homeserver,
          username: legacyCredentials.username,
          password: legacyCredentials.password,
          rememberMe: true,
        ),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'Hub transport failure falls back to legacy login without surfacing Hub error',
    setUp: () {
      getIt.registerSingleton(
        const N42ChatConfig(
          idHubUrl: 'https://id-test.n42.ai',
          enableIdHubLogin: true,
        ),
      );
      final wallet = _MockWalletBridge();
      when(
        () => wallet.signMessage(canonicalMessage),
      ).thenAnswer((_) async => legacySignature);
      getIt.registerSingleton<IWalletBridge>(wallet);
    },
    build: () => buildBloc(idHubApiFactory: (_) => _ThrowingIdHubApi()),
    act: (bloc) => bloc.add(event),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.loading,
      ),
      isA<AuthState>()
          .having((state) => state.status, 'status', AuthStatus.error)
          .having(
            (state) => state.errorMessage,
            'error message',
            'legacy unavailable',
          ),
    ],
    verify: (_) {
      verify(
        () => repository.login(
          homeserver: event.homeserver,
          username: legacyCredentials.username,
          password: legacyCredentials.password,
          rememberMe: true,
        ),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'Hub success establishes the Matrix session with exactly one signature '
    'and never touches the legacy path',
    setUp: () {
      getIt.registerSingleton(
        const N42ChatConfig(
          idHubUrl: 'https://id-test.n42.ai',
          enableIdHubLogin: true,
        ),
      );
      final wallet = _MockWalletBridge();
      when(
        () => wallet.signMessage('N42 ID challenge'),
      ).thenAnswer((_) async => '0xhub-signature');
      getIt.registerSingleton<IWalletBridge>(wallet);
      when(
        () => repository.loginWithToken(
          homeserver: 'https://matrix.hub.example',
          accessToken: 'matrix-token',
          userId: '@did_test:matrix.hub.example',
          deviceId: 'DEVICE1',
        ),
      ).thenAnswer(
        (_) async => AuthResult.success(
          const UserEntity(
            userId: '@did_test:matrix.hub.example',
            displayName: 'did_test',
          ),
        ),
      );
      // _completeAuthenticatedFlow kicks off a profile refresh; keep it inert.
      when(
        () => repository.getCurrentUserProfile(),
      ).thenAnswer((_) async => null);
    },
    build: () => buildBloc(
      idHubApiFactory: (_) => _FakeIdHubApi(
        challenge: const IdHubChallenge(
          challengeId: 'challenge-1',
          message: 'N42 ID challenge',
        ),
        response: IdHubWalletResponse.success(
          did: 'did:plc:test',
          matrixUserId: '@did_test:matrix.hub.example',
          matrixAccessToken: 'matrix-token',
          matrixDeviceId: 'DEVICE1',
          matrixHomeserver: 'https://matrix.hub.example',
        ),
      ),
    ),
    act: (bloc) => bloc.add(event),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.loading,
      ),
      isA<AuthState>().having(
        (state) => state.status,
        'status',
        AuthStatus.authenticated,
      ),
    ],
    verify: (_) {
      // Exactly one signature: the hub challenge; never the legacy canonical.
      verify(
        () => getIt<IWalletBridge>().signMessage('N42 ID challenge'),
      ).called(1);
      verifyNever(() => getIt<IWalletBridge>().signMessage(canonicalMessage));
      // Legacy password login is never attempted on hub success.
      verifyNever(
        () => repository.login(
          homeserver: any(named: 'homeserver'),
          username: any(named: 'username'),
          password: any(named: 'password'),
          rememberMe: any(named: 'rememberMe'),
        ),
      );
    },
  );
}
