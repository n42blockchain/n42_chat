import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:n42_chat/src/core/encryption/account_session_index.dart';
import 'package:n42_chat/src/core/encryption/key_backup_service.dart';
import 'package:n42_chat/src/core/encryption/local_room_key_store.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/remote/social_auth_api.dart';
import 'package:n42_chat/src/data/repositories/auth_repository_impl.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_session.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_store.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';
import 'package:n42_chat/src/presentation/pages/settings/security_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _E2ee extends Mock implements E2EEManager {}

class _Backup extends Mock implements KeyBackupService {}

class _Client extends Mock implements Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _AuthDataSource extends Mock implements MatrixAuthDataSource {}

class _AuthStorage extends Mock implements SecureStorageDataSource {}

class _Social extends Mock implements SocialAuthApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _E2ee e2ee;
  late _Backup backup;
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
    e2ee = _E2ee();
    backup = _Backup();
    when(() => e2ee.client).thenReturn(_Client());
    when(() => e2ee.status).thenReturn(E2EEStatus.ready);
    when(() => e2ee.isCrossSigningEnabled).thenReturn(false);
    when(() => backup.getBackupInfo()).thenAnswer((_) async => null);
  });

  Future<void> tapDelete(WidgetTester tester) async {
    final target = find.byKey(const ValueKey('delete_account'));
    await tester.scrollUntilVisible(target, 300);
    await tester.ensureVisible(target);
    await tester.drag(find.byType(ListView).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets('visible page uses real bound repository and SDK logout guard', (
    tester,
  ) async {
    final sdk = StreamController<LoginState>.broadcast();
    final manager = _Manager();
    final auth = _AuthDataSource();
    final authStorage = _AuthStorage();
    final client = _Client();
    String? user = '@a:hs';
    Uri? server = Uri.parse('https://hs.test');
    String? device = 'device-A';
    when(() => client.userID).thenAnswer((_) => user);
    when(() => client.homeserver).thenAnswer((_) => server);
    when(() => client.deviceID).thenAnswer((_) => device);
    when(() => client.accessToken).thenReturn('fixture-token');
    when(() => client.isLogged()).thenReturn(true);
    when(() => manager.client).thenReturn(client);
    when(() => manager.isLoggedIn).thenReturn(true);
    when(() => manager.onLoginStateChanged).thenAnswer((_) => sdk.stream);
    when(manager.startSync).thenAnswer((_) async {});
    when(() => auth.clientManager).thenReturn(manager);
    when(() => auth.isLoggedIn).thenReturn(false);
    when(
      () => auth.loginWithToken(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => authStorage.saveSession(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => authStorage.addAccount(
        userId: any(named: 'userId'),
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        deviceId: any(named: 'deviceId'),
        displayName: any(named: 'displayName'),
        avatarUrl: any(named: 'avatarUrl'),
      ),
    ).thenAnswer((_) async {});
    when(authStorage.clearSession).thenAnswer((_) async {});
    when(auth.logout).thenAnswer((_) async {});
    when(
      () => client.deactivateAccount(auth: null, erase: false),
    ).thenAnswer((_) async => IdServerUnbindResult.success);
    final clearCalled = Completer<void>();
    when(() => client.clear(reason: SessionClearReason.logout)).thenAnswer((
      _,
    ) async {
      clearCalled.complete();
      user = null;
      server = null;
      device = null;
      sdk.add(LoginState.loggedOut);
    });
    when(
      () => manager.clearCapturedClientForDeletion(client, any()),
    ).thenAnswer((call) async {
      final owns = call.positionalArguments[1] as bool Function();
      if (!owns()) return false;
      await client.clear(reason: SessionClearReason.logout);
      return true;
    });
    final repository = AuthRepositoryImpl(
      authDataSource: auth,
      secureStorage: authStorage,
      socialAuthApi: _Social(),
    );
    final notices = <AuthSessionInvalidation>[];
    final subscription = repository.accountInvalidationStream.listen(
      notices.add,
    );
    addTearDown(() async {
      await subscription.cancel();
      repository.dispose();
      await sdk.close();
    });
    expect(
      (await repository.loginWithToken(
        homeserver: 'https://hs.test',
        accessToken: 'fixture-token',
        userId: '@a:hs',
        deviceId: 'device-A',
      )).success,
      isTrue,
    );
    final bloc = AuthBloc(authRepository: repository);
    bloc.emit(
      const AuthState(
        status: AuthStatus.authenticated,
        user: UserEntity(userId: '@a:hs', displayName: 'A'),
      ),
    );
    addTearDown(bloc.close);
    String snapshotKey(String userId) =>
        'n42_chat_history_keys_${sha256.convert(utf8.encode(jsonEncode(['https://hs.test', userId])))}';
    const keyStorage = FlutterSecureStorage();
    await keyStorage.write(key: snapshotKey('@a:hs'), value: 'old-A-keys');
    await keyStorage.write(key: snapshotKey('@b:hs'), value: 'B-keys');
    when(() => e2ee.client).thenReturn(client);
    MatrixAccountDeletionSession? capturedFlow;
    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: Scaffold(body: Text('Account root')),
        ),
      ),
    );
    tester
        .state<NavigatorState>(find.byType(Navigator))
        .push(
          MaterialPageRoute<void>(
            builder: (_) => SecuritySettingsPage(
              e2eeManager: e2ee,
              keyBackupService: backup,
              deletionSessionFactory: (erase) =>
                  capturedFlow = MatrixAccountDeletionSession.capture(
                    lifecycle: repository,
                    manager: manager,
                    storage: SecureStorageDataSource(),
                    roomKeys: LocalRoomKeyStore(),
                    accountSessions: AccountSessionIndex(),
                    journal: MatrixPendingDeletionStore(),
                    erase: erase,
                  ),
              resolveDeletionManagement: (_) async => null,
            ),
          ),
        );
    await tester.pumpAndSettle();
    await tapDelete(tester);
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pumpAndSettle();
    expect(capturedFlow?.operation.serverConfirmed, isTrue);
    expect(capturedFlow?.confirmedDeletion, isNotNull);
    for (var i = 0; i < 20 && !clearCalled.isCompleted; i++) {
      await tester.pump(const Duration(milliseconds: 1));
    }
    expect(
      clearCalled.isCompleted,
      isTrue,
      reason:
          'status=${capturedFlow?.status} pending=${(await MatrixPendingDeletionStore().list()).length}',
    );
    expect(notices, isEmpty);
    verify(() => client.deactivateAccount(auth: null, erase: false)).called(1);
    verify(() => client.clear(reason: SessionClearReason.logout)).called(1);
    expect(await MatrixPendingDeletionStore().list(), isEmpty);
    await tester.pumpAndSettle();
    verifyNever(auth.logout);
    expect(bloc.state.status, AuthStatus.unauthenticated);
    expect(find.text('Account root'), findsOneWidget);
    expect(find.byType(SecuritySettingsPage), findsNothing);
    expect(await keyStorage.read(key: snapshotKey('@a:hs')), isNull);
    expect(await keyStorage.read(key: snapshotKey('@b:hs')), 'B-keys');
  });
}
