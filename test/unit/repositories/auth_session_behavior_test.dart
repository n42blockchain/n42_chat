import 'package:n42_chat/src/core/encryption/local_room_key_store.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/remote/social_auth_api.dart';
import 'package:n42_chat/src/data/repositories/auth_repository_impl.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class MockAuth extends Mock implements MatrixAuthDataSource {}

class MockStorage extends Mock implements SecureStorageDataSource {}

class MockManager extends Mock implements MatrixClientManager {}

class MockSocial extends Mock implements SocialAuthApi {}

class MockClient extends Mock implements Client {}

void main() {
  late MockAuth auth;
  late MockStorage storage;
  late MockManager manager;
  late AuthRepositoryImpl repository;
  late StreamController<LoginState> sdk;
  const session = {
    'homeserver': 'https://hs.test',
    'accessToken': 'fixture-token',
    'userId': '@alice:hs.test',
    'deviceId': 'device',
  };
  LoginResponse response({
    String token = 'fixture-token',
    String user = '@alice:hs.test',
  }) => LoginResponse.fromJson({
    'access_token': token,
    'user_id': user,
    'device_id': 'device',
  });
  MatrixException error(String code) => MatrixException(
    http.Response(
      jsonEncode({'errcode': code, 'error': 'Request rejected'}),
      403,
    ),
  );
  Future<AuthResult> login({bool remember = true}) => repository.login(
    homeserver: 'https://hs.test',
    username: 'alice',
    password: 'fixture-password',
    rememberMe: remember,
  );
  Future<AuthResult> tokenLogin() => repository.loginWithToken(
    homeserver: session['homeserver']!,
    accessToken: session['accessToken']!,
    userId: session['userId']!,
    deviceId: session['deviceId']!,
  );
  for (final anonymous in [false, true]) {
    for (final message in [
      'M_FORBIDDEN: Registration has been disabled',
      'Registration is disabled',
    ]) {
      test(
        'disabled registration is explicit (anonymous: $anonymous, $message)',
        () async {
          when(
            () => auth.isUsernameAvailable(any(), any()),
          ).thenAnswer((_) async => true);
          when(
            () => auth.register(
              homeserver: any(named: 'homeserver'),
              username: any(named: 'username'),
              password: any(named: 'password'),
              email: any(named: 'email'),
              registrationToken: any(named: 'registrationToken'),
            ),
          ).thenThrow(
            MatrixException(
              http.Response(
                jsonEncode({'errcode': 'M_FORBIDDEN', 'error': message}),
                403,
              ),
            ),
          );
          final result = anonymous
              ? await repository.registerAnonymously(
                  homeserver: 'https://hs.test',
                  password: 'fixture-password',
                )
              : await repository.register(
                  homeserver: 'https://hs.test',
                  username: 'alice',
                  password: 'fixture-password',
                );
          expect(result.success, isFalse);
          expect(result.errorType, AuthErrorType.registrationDisabled);
          expect(result.errorMessage, message);
        },
      );
    }
  }
  test(
    'registration rejection is not reported as a login password error',
    () async {
      when(
        () => auth.register(
          homeserver: any(named: 'homeserver'),
          username: any(named: 'username'),
          password: any(named: 'password'),
          email: any(named: 'email'),
          registrationToken: any(named: 'registrationToken'),
        ),
      ).thenThrow(error('M_FORBIDDEN'));
      final result = await repository.register(
        homeserver: 'https://hs.test',
        username: 'alice',
        password: 'Password123!',
      );
      expect(result.success, isFalse);
      expect(result.errorType, AuthErrorType.serverError);
      expect(result.errorMessage, 'Request rejected');
    },
  );

  setUpAll(() => registerFallbackValue(Uint8List(0)));
  setUp(() {
    auth = MockAuth();
    storage = MockStorage();
    manager = MockManager();
    sdk = StreamController<LoginState>.broadcast();
    when(() => auth.clientManager).thenReturn(manager);
    when(() => auth.isLoggedIn).thenReturn(false);
    when(() => manager.client).thenReturn(null);
    when(() => manager.onLoginStateChanged).thenAnswer((_) => sdk.stream);
    when(manager.startSync).thenAnswer((_) async {});
    when(storage.getSession).thenAnswer((_) async => null);
    when(storage.getAccounts).thenAnswer((_) async => {});
    when(
      () => storage.saveSession(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => storage.addAccount(
        userId: any(named: 'userId'),
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        deviceId: any(named: 'deviceId'),
        displayName: any(named: 'displayName'),
        avatarUrl: any(named: 'avatarUrl'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => storage.saveCredentials(
        homeserver: any(named: 'homeserver'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) async => true);
    when(storage.clearCredentials).thenAnswer((_) async {});
    when(storage.clearSession).thenAnswer((_) async {});
    when(storage.isBiometricEnabled).thenAnswer((_) async => false);
    when(
      () => auth.loginWithPassword(
        homeserver: any(named: 'homeserver'),
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => response());
    when(
      () => auth.loginWithToken(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => auth.loginWithLoginToken(
        homeserver: any(named: 'homeserver'),
        loginToken: any(named: 'loginToken'),
      ),
    ).thenAnswer((_) async => response());
    when(auth.logout).thenAnswer((_) async {});
    when(() => manager.userId).thenReturn(session['userId']);
    when(() => storage.removeAccount(any())).thenAnswer((_) async {});
    repository = AuthRepositoryImpl(
      authDataSource: auth,
      secureStorage: storage,
      socialAuthApi: MockSocial(),
    );
  });
  tearDown(() async {
    repository.dispose();
    await sdk.close();
  });

  test(
    'password login persists a session, emits login and starts sync',
    () async {
      final event = repository.loginStateStream.first;
      final result = await login();
      expect(result.success, isTrue);
      expect(result.user!.userId, '@alice:hs.test');
      expect(await event, isTrue);
      verify(
        () => storage.saveSession(
          homeserver: 'https://hs.test',
          accessToken: 'fixture-token',
          userId: '@alice:hs.test',
          deviceId: 'device',
        ),
      ).called(1);
      verify(
        () => storage.saveCredentials(
          homeserver: 'https://hs.test',
          username: 'alice',
        ),
      ).called(1);
      verify(manager.startSync).called(1);
    },
  );
  test('login without remember-me clears older credentials', () async {
    expect((await login(remember: false)).success, isTrue);
    verify(storage.clearCredentials).called(1);
    verifyNever(
      () => storage.saveCredentials(
        homeserver: any(named: 'homeserver'),
        username: any(named: 'username'),
      ),
    );
  });
  for (final invalid in [response(token: ''), response(user: '')]) {
    test(
      'incomplete login response does not persist credentials (${invalid.userId})',
      () async {
        when(
          () => auth.loginWithPassword(
            homeserver: any(named: 'homeserver'),
            username: any(named: 'username'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => invalid);
        expect((await login()).errorType, AuthErrorType.serverError);
        verifyNever(
          () => storage.saveSession(
            homeserver: any(named: 'homeserver'),
            accessToken: any(named: 'accessToken'),
            userId: any(named: 'userId'),
            deviceId: any(named: 'deviceId'),
          ),
        );
      },
    );
  }
  for (final entry in {
    'M_FORBIDDEN': AuthErrorType.invalidCredentials,
    'M_UNAUTHORIZED': AuthErrorType.invalidCredentials,
    'M_USER_IN_USE': AuthErrorType.usernameExists,
    'M_INVALID_USERNAME': AuthErrorType.usernameUnavailable,
    'M_LIMIT_EXCEEDED': AuthErrorType.rateLimited,
    'M_UNKNOWN_TOKEN': AuthErrorType.tokenExpired,
    'M_UNKNOWN': AuthErrorType.serverError,
  }.entries) {
    test(
      'maps Matrix ${entry.key} independently of human error wording',
      () async {
        when(
          () => auth.loginWithPassword(
            homeserver: any(named: 'homeserver'),
            username: any(named: 'username'),
            password: any(named: 'password'),
          ),
        ).thenThrow(error(entry.key));
        expect((await login()).errorType, entry.value);
      },
    );
  }
  test(
    'a pending password login rejects concurrent auth but releases the lock',
    () async {
      final pending = Completer<LoginResponse>();
      when(
        () => auth.loginWithPassword(
          homeserver: any(named: 'homeserver'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => pending.future);
      final first = login();
      expect((await tokenLogin()).errorType, AuthErrorType.rateLimited);
      expect(
        (await repository.restoreSession()).errorType,
        AuthErrorType.rateLimited,
      );
      pending.completeError(StateError('offline'));
      expect((await first).errorType, AuthErrorType.unknown);
      expect((await tokenLogin()).success, isTrue);
    },
  );
  test('temporary token restoration failure remains retryable', () async {
    when(
      () => auth.loginWithToken(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenThrow(TimeoutException('offline'));
    expect((await tokenLogin()).errorType, AuthErrorType.unknown);
    verifyNever(() => storage.removeAccount(any()));
  });
  test(
    'restore uses saved token while holding its own authentication lock',
    () async {
      when(storage.getSession).thenAnswer((_) async => session);
      final result = await repository.restoreSession();
      expect(result.success, isTrue);
      verify(
        () => auth.loginWithToken(
          homeserver: 'https://hs.test',
          accessToken: 'fixture-token',
          userId: '@alice:hs.test',
          deviceId: 'device',
        ),
      ).called(1);
    },
  );
  test(
    'absent or incomplete stored session requires reauthentication',
    () async {
      expect(
        (await repository.restoreSession()).errorType,
        AuthErrorType.notLoggedIn,
      );
      when(
        storage.getSession,
      ).thenAnswer((_) async => {'userId': '@alice:hs.test'});
      expect(
        (await repository.restoreSession()).errorType,
        AuthErrorType.notLoggedIn,
      );
      verifyNever(
        () => auth.loginWithPassword(
          homeserver: any(named: 'homeserver'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      );
    },
  );
  test(
    'SDK fast restore skips token login and emits authenticated state',
    () async {
      when(() => auth.isLoggedIn).thenReturn(true);
      when(() => auth.userId).thenReturn('@alice:hs.test');
      expect((await repository.restoreSession()).user!.displayName, 'alice');
      verifyNever(
        () => auth.loginWithToken(
          homeserver: any(named: 'homeserver'),
          accessToken: any(named: 'accessToken'),
          userId: any(named: 'userId'),
          deviceId: any(named: 'deviceId'),
        ),
      );
    },
  );
  test(
    'storage read failure becomes a recoverable expired-session result',
    () async {
      when(storage.getSession).thenThrow(StateError('keychain unavailable'));
      expect(
        (await repository.restoreSession()).errorType,
        AuthErrorType.tokenExpired,
      );
      when(storage.getSession).thenAnswer((_) async => null);
      expect((await tokenLogin()).success, isTrue);
    },
  );
  for (final biometric in [true, false]) {
    test(
      'logout clears session and preserves credentials only for biometric=$biometric',
      () async {
        when(storage.isBiometricEnabled).thenAnswer((_) async => biometric);
        final event = repository.loginStateStream.first;
        await repository.logout();
        expect(await event, isFalse);
        verify(storage.clearSession).called(1);
        verify(() => storage.removeAccount(session['userId']!)).called(1);
        if (biometric) {
          verifyNever(storage.clearCredentials);
        } else {
          verify(storage.clearCredentials).called(1);
        }
      },
    );
  }
  test(
    'key preservation failure keeps login credentials and resumes sync',
    () async {
      when(auth.logout).thenThrow(LocalRoomKeyPreservationException());
      await expectLater(
        repository.logout(),
        throwsA(isA<LocalRoomKeyPreservationException>()),
      );
      verifyNever(storage.clearSession);
      verifyNever(storage.clearCredentials);
      verify(() => manager.startSync()).called(1);
    },
  );
  test('server logout failure still clears the local session', () async {
    when(auth.logout).thenThrow(StateError('offline'));
    final event = repository.loginStateStream.first;
    await repository.logout();
    expect(await event, isFalse);
    verify(storage.clearSession).called(1);
  });
  for (final state in [LoginState.loggedOut, LoginState.softLoggedOut]) {
    test('SDK $state invalidates the local session after login', () async {
      final currentClient = MockClient();
      when(() => currentClient.userID).thenReturn(session['userId']);
      when(
        () => currentClient.homeserver,
      ).thenReturn(Uri.parse(session['homeserver']!));
      when(() => currentClient.deviceID).thenReturn(session['deviceId']);
      when(() => manager.client).thenReturn(currentClient);
      when(
        () => storage.clearSessionIfMatches(
          session['userId']!,
          Uri.parse(session['homeserver']!),
        ),
      ).thenAnswer((_) async {});
      await tokenLogin();
      final loggedOut = repository.loginStateStream.firstWhere(
        (value) => !value,
      );
      final invalidation = repository.accountInvalidationStream.first;
      sdk.add(state);
      expect(await loggedOut, isFalse);
      expect((await invalidation).userId, session['userId']);
      verify(
        () => storage.clearSessionIfMatches(
          session['userId']!,
          Uri.parse(session['homeserver']!),
        ),
      ).called(1);
    });
  }

  test('SDK expiry invalidates a token session without a device ID', () async {
    final client = MockClient();
    when(() => client.userID).thenReturn(session['userId']);
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.deviceID).thenReturn(null);
    when(() => client.accessToken).thenReturn(session['accessToken']);
    when(() => manager.client).thenReturn(client);
    when(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).thenAnswer((_) async {});
    await tokenLogin();
    final notice = repository.accountInvalidationStream.first;
    sdk.add(LoginState.softLoggedOut);
    expect((await notice.timeout(const Duration(seconds: 1))).deviceId, isNull);
    verify(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).called(1);
  });

  test('pending SDK expiry survives same-account auth finalization', () async {
    final client = MockClient();
    when(() => client.userID).thenReturn(session['userId']);
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.deviceID).thenReturn('device');
    when(() => manager.client).thenReturn(client);
    when(() => auth.isLoggedIn).thenReturn(true);
    when(
      () => client.getAccountData(session['userId']!, 'n42.user.profile'),
    ).thenAnswer((_) async => <String, Object?>{});
    final profileEntered = Completer<void>();
    final profileRelease = Completer<Profile>();
    when(() => manager.getUserProfile(session['userId']!)).thenAnswer((_) {
      profileEntered.complete();
      return profileRelease.future;
    });
    final clearEntered = Completer<void>();
    final clearRelease = Completer<void>();
    when(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).thenAnswer((_) async {
      clearEntered.complete();
      await clearRelease.future;
    });
    final notice = repository.accountInvalidationStream.first;
    final loginFuture = login();
    await profileEntered.future;
    sdk.add(LoginState.loggedOut);
    await Future<void>.delayed(Duration.zero);
    profileRelease.complete(Profile(userId: session['userId']!));
    expect((await loginFuture).success, isTrue);
    await clearEntered.future;
    clearRelease.complete();
    expect(
      (await notice.timeout(const Duration(seconds: 1))).userId,
      session['userId'],
    );
  });

  test('pending SDK expiry cannot invalidate a switched account', () async {
    final a = MockClient();
    final b = MockClient();
    when(() => a.userID).thenReturn(session['userId']);
    when(() => a.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => a.deviceID).thenReturn('device');
    when(() => b.userID).thenReturn('@bob:hs.test');
    when(() => b.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => b.deviceID).thenReturn('B-device');
    when(() => manager.client).thenReturn(a);
    when(() => auth.isLoggedIn).thenReturn(true);
    when(
      () => a.getAccountData(session['userId']!, 'n42.user.profile'),
    ).thenAnswer((_) async => <String, Object?>{});
    final profileEntered = Completer<void>();
    final profileRelease = Completer<Profile>();
    when(() => manager.getUserProfile(session['userId']!)).thenAnswer((_) {
      profileEntered.complete();
      return profileRelease.future;
    });
    final clearEntered = Completer<void>();
    final clearRelease = Completer<void>();
    when(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).thenAnswer((_) async {
      clearEntered.complete();
      await clearRelease.future;
    });
    final notices = <AuthSessionInvalidation>[];
    final subscription = repository.accountInvalidationStream.listen(
      notices.add,
    );
    addTearDown(subscription.cancel);
    final boolEvents = <bool>[];
    final boolSubscription = repository.loginStateStream.listen(boolEvents.add);
    addTearDown(boolSubscription.cancel);
    final loginFuture = login();
    await profileEntered.future;
    sdk.add(LoginState.loggedOut);
    await Future<void>.delayed(Duration.zero);
    profileRelease.complete(Profile(userId: session['userId']!));
    expect((await loginFuture).success, isTrue);
    await clearEntered.future;
    when(() => manager.client).thenReturn(b);
    clearRelease.complete();
    await Future<void>.delayed(Duration.zero);
    expect(notices, isEmpty);
    expect(boolEvents, isNot(contains(false)));
  });

  test('SDK A logout paused during storage cannot invalidate B', () async {
    final a = MockClient();
    final b = MockClient();
    when(() => a.userID).thenReturn(session['userId']);
    when(() => a.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => a.deviceID).thenReturn('device');
    when(() => b.userID).thenReturn('@bob:hs.test');
    when(() => b.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => b.deviceID).thenReturn('B-device');
    when(() => b.accessToken).thenReturn('B-token');
    when(() => manager.client).thenReturn(a);
    final entered = Completer<void>();
    final release = Completer<void>();
    when(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).thenAnswer((_) async {
      entered.complete();
      await release.future;
    });
    final notices = <AuthSessionInvalidation>[];
    final subscription = repository.accountInvalidationStream.listen(
      notices.add,
    );
    addTearDown(subscription.cancel);
    final boolEvents = <bool>[];
    final boolSubscription = repository.loginStateStream.listen(boolEvents.add);
    addTearDown(boolSubscription.cancel);
    await tokenLogin();
    sdk.add(LoginState.loggedOut);
    await entered.future;
    when(() => manager.client).thenReturn(b);
    final switched = await repository.loginWithToken(
      homeserver: 'https://hs.test',
      accessToken: 'B-token',
      userId: '@bob:hs.test',
      deviceId: 'B-device',
    );
    expect(switched.success, isTrue);
    release.complete();
    await Future<void>.delayed(Duration.zero);
    expect(notices, isEmpty);
    expect(boolEvents, isNot(contains(false)));
    verifyNever(storage.clearSession);
  });

  test('SDK A logout is stale after A to B to A monitor generation', () async {
    final a = MockClient();
    final b = MockClient();
    when(() => a.userID).thenReturn(session['userId']);
    when(() => a.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => a.deviceID).thenReturn('device');
    when(() => a.accessToken).thenReturn('A-token');
    when(() => b.userID).thenReturn('@bob:hs.test');
    when(() => b.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => b.deviceID).thenReturn('B-device');
    when(() => b.accessToken).thenReturn('B-token');
    when(() => manager.client).thenReturn(a);
    final entered = Completer<void>();
    final release = Completer<void>();
    when(
      () => storage.clearSessionIfMatches(
        session['userId']!,
        Uri.parse('https://hs.test'),
      ),
    ).thenAnswer((_) async {
      entered.complete();
      await release.future;
    });
    final notices = <AuthSessionInvalidation>[];
    final subscription = repository.accountInvalidationStream.listen(
      notices.add,
    );
    addTearDown(subscription.cancel);
    final boolEvents = <bool>[];
    final boolSubscription = repository.loginStateStream.listen(boolEvents.add);
    addTearDown(boolSubscription.cancel);
    await tokenLogin();
    sdk.add(LoginState.loggedOut);
    await entered.future;
    when(() => manager.client).thenReturn(b);
    await repository.loginWithToken(
      homeserver: 'https://hs.test',
      accessToken: 'B-token',
      userId: '@bob:hs.test',
      deviceId: 'B-device',
    );
    when(() => manager.client).thenReturn(a);
    await tokenLogin();
    release.complete();
    await Future<void>.delayed(Duration.zero);
    expect(notices, isEmpty);
    expect(boolEvents, isNot(contains(false)));
  });

  test(
    'SDK clear can null client identity before same-generation event',
    () async {
      final a = MockClient();
      String? user = session['userId'];
      Uri? homeserver = Uri.parse('https://hs.test');
      String? device = 'device';
      when(() => a.userID).thenAnswer((_) => user);
      when(() => a.homeserver).thenAnswer((_) => homeserver);
      when(() => a.deviceID).thenAnswer((_) => device);
      when(() => manager.client).thenReturn(a);
      when(
        () => storage.clearSessionIfMatches(
          session['userId']!,
          Uri.parse('https://hs.test'),
        ),
      ).thenAnswer((_) async {});
      await tokenLogin();
      final notice = repository.accountInvalidationStream.first;
      user = null;
      homeserver = null;
      device = null;
      sdk.add(LoginState.loggedOut);
      expect((await notice).userId, session['userId']);
      verify(
        () => storage.clearSessionIfMatches(
          session['userId']!,
          Uri.parse('https://hs.test'),
        ),
      ).called(1);
    },
  );
  test(
    'logout from replaced client cannot clear the switched account session',
    () async {
      final oldClient = MockClient();
      final newClient = MockClient();
      when(() => oldClient.userID).thenReturn(session['userId']);
      when(() => oldClient.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => oldClient.deviceID).thenReturn('device');
      when(() => newClient.userID).thenReturn('@bob:hs.test');
      when(() => newClient.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => newClient.deviceID).thenReturn('B-device');
      when(() => newClient.accessToken).thenReturn('B-token');
      when(
        () => storage.clearSessionIfMatches(
          '@bob:hs.test',
          Uri.parse('https://hs.test'),
        ),
      ).thenAnswer((_) async {});
      when(() => manager.client).thenReturn(oldClient);
      expect((await tokenLogin()).success, isTrue);

      final replacement = Completer<void>();
      when(
        () => auth.loginWithToken(
          homeserver: any(named: 'homeserver'),
          accessToken: any(named: 'accessToken'),
          userId: any(named: 'userId'),
          deviceId: any(named: 'deviceId'),
        ),
      ).thenAnswer((_) => replacement.future);
      final switching = repository.loginWithToken(
        homeserver: 'https://hs.test',
        accessToken: 'B-token',
        userId: '@bob:hs.test',
        deviceId: 'B-device',
      );
      sdk.add(LoginState.loggedOut);
      await Future<void>.delayed(Duration.zero);
      when(() => manager.client).thenReturn(newClient);
      replacement.complete();
      expect((await switching).success, isTrue);
      await Future<void>.delayed(Duration.zero);
      verifyNever(storage.clearSession);

      final loggedOut = repository.loginStateStream.firstWhere(
        (value) => !value,
      );
      sdk.add(LoginState.loggedOut);
      expect(await loggedOut, isFalse);
      verify(
        () => storage.clearSessionIfMatches(
          '@bob:hs.test',
          Uri.parse('https://hs.test'),
        ),
      ).called(1);
    },
  );
  test(
    'background sync rejection does not turn a saved login into failure',
    () async {
      when(
        manager.startSync,
      ).thenAnswer((_) async => throw StateError('offline sync'));
      expect((await tokenLogin()).success, isTrue);
      await Future<void>.delayed(Duration.zero);
    },
  );
  test('stored accounts put current first, then newest valid dates', () async {
    when(() => manager.userId).thenReturn('@current:hs.test');
    when(storage.getAccounts).thenAnswer(
      (_) async => {
        '@old:hs.test': {'addedAt': '2025-01-01'},
        '@new:hs.test': {'addedAt': '2026-01-01'},
        '@current:hs.test': {'addedAt': '2024-01-01'},
        '@z:hs.test': {'addedAt': 'invalid'},
        '@a:hs.test': {},
      },
    );
    final accounts = await repository.getStoredAccounts();
    expect(accounts.map((a) => a.userId), [
      '@current:hs.test',
      '@new:hs.test',
      '@old:hs.test',
      '@a:hs.test',
      '@z:hs.test',
    ]);
    expect(accounts.first.isCurrent, isTrue);
    expect(accounts.last.addedAt, isNull);
  });
  test('account switching rejects missing and incomplete sessions', () async {
    expect(
      (await repository.switchStoredAccount('@none:hs.test')).errorType,
      AuthErrorType.notLoggedIn,
    );
    when(storage.getAccounts).thenAnswer(
      (_) async => {
        '@alice:hs.test': {'homeserver': 'https://hs.test'},
      },
    );
    expect(
      (await repository.switchStoredAccount('@alice:hs.test')).errorType,
      AuthErrorType.tokenExpired,
    );
  });
  test('account switching uses stored token and profile identity', () async {
    when(
      storage.getAccounts,
    ).thenAnswer((_) async => {'@alice:hs.test': session});
    expect(
      (await repository.switchStoredAccount('@alice:hs.test')).success,
      isTrue,
    );
    verify(
      () => auth.loginWithToken(
        homeserver: 'https://hs.test',
        accessToken: 'fixture-token',
        userId: '@alice:hs.test',
        deviceId: 'device',
      ),
    ).called(1);
  });
  for (final success in [true, false]) {
    test(
      'password change clears credentials only after server success=$success',
      () async {
        when(() => auth.isLoggedIn).thenReturn(true);
        when(
          () => auth.changeUserPassword(oldPassword: 'old', newPassword: 'new'),
        ).thenAnswer((_) async => success);
        expect(
          await repository.changePassword(
            oldPassword: 'old',
            newPassword: 'new',
          ),
          success,
        );
        if (success) {
          verify(storage.clearCredentials).called(1);
        } else {
          verifyNever(storage.clearCredentials);
        }
      },
    );
  }
  test('sensitive profile operations reject unauthenticated calls', () async {
    await expectLater(
      repository.changePassword(oldPassword: 'old', newPassword: 'new'),
      throwsStateError,
    );
    await expectLater(
      repository.requestChangeEmail(
        password: 'password',
        newEmail: 'test@example.org',
      ),
      throwsStateError,
    );
    await expectLater(
      repository.confirmChangeEmail(newEmail: 'test@example.org', code: '123'),
      throwsStateError,
    );
    expect(await repository.getBoundEmail(), isNull);
    expect(await repository.getBoundPhone(), isNull);
    expect(await repository.getCurrentUserProfile(), isNull);
    expect(await repository.getUserProfileData(), isNull);
    expect(await repository.updateUserProfileData(signature: 'hello'), isFalse);
  });
  test('SSO login token preserves identity and emits authentication', () async {
    expect(
      (await repository.loginWithLoginToken(
        homeserver: 'https://hs.test',
        loginToken: 'single-use',
      )).user!.userId,
      '@alice:hs.test',
    );
    verify(
      () => auth.loginWithLoginToken(
        homeserver: 'https://hs.test',
        loginToken: 'single-use',
      ),
    ).called(1);
  });
  test('SSO invalid response does not save a session', () async {
    when(
      () => auth.loginWithLoginToken(
        homeserver: any(named: 'homeserver'),
        loginToken: any(named: 'loginToken'),
      ),
    ).thenAnswer((_) async => response(token: ''));
    expect(
      (await repository.loginWithLoginToken(
        homeserver: 'https://hs.test',
        loginToken: 'single-use',
      )).errorType,
      AuthErrorType.serverError,
    );
  });
}
