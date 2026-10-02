import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:n42_chat/src/core/encryption/key_backup_service.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/presentation/pages/settings/security_settings_page.dart';

class _Manager extends Mock implements E2EEManager {}

class _Backup extends Mock implements KeyBackupService {}

class _Client extends Mock implements Client {}

void main() {
  late _Manager manager;
  late _Backup backup;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    manager = _Manager();
    backup = _Backup();
    when(() => manager.client).thenReturn(_Client());
    when(() => manager.status).thenReturn(E2EEStatus.notSupported);
    when(() => manager.isCrossSigningEnabled).thenReturn(false);
    when(() => backup.getBackupInfo()).thenAnswer((_) async => null);
  });

  Future<S> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: SecuritySettingsPage(
          e2eeManager: manager,
          keyBackupService: backup,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(SecuritySettingsPage)))!;
  }

  testWidgets('logged-out state shows unsupported encryption and no devices', (
    tester,
  ) async {
    final l10n = await open(tester);

    expect(find.text(l10n.settingsEncryptionNotSupported), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.settingsLoggedInDevices),
      240,
    );
    expect(find.text(l10n.settingsNoOtherDevices), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('biometric enable requires a stored Matrix session', (
    tester,
  ) async {
    const localAuthChannel = MethodChannel('plugins.flutter.io/local_auth');
    var authenticationCalls = 0;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      localAuthChannel,
      (call) async {
        switch (call.method) {
          case 'getAvailableBiometrics':
            return <String>['fingerprint'];
          case 'isDeviceSupported':
            return true;
          case 'authenticate':
            authenticationCalls++;
            return true;
          case 'stopAuthentication':
            return false;
          default:
            throw MissingPluginException('Unexpected method ${call.method}');
        }
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        localAuthChannel,
        null,
      ),
    );

    final l10n = await open(tester);
    await tester.ensureVisible(find.byType(Switch));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text(l10n.blocAuthSessionExpired), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    expect(await SecureStorageDataSource().isBiometricEnabled(), isFalse);
    expect(await SecureStorageDataSource().getCredentials(), isNull);
    expect(authenticationCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failure to create a recovery key returns to settings', (
    tester,
  ) async {
    when(() => manager.getRecoveryKey()).thenAnswer((_) async => null);
    when(
      () => manager.createRecoveryKey(),
    ).thenThrow(StateError('device keys unavailable'));
    await open(tester);
    await tester.scrollUntilVisible(find.text('Show Recovery Key'), 240);
    await tester.ensureVisible(find.text('Show Recovery Key'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show Recovery Key'));
    await tester.pumpAndSettle();

    expect(
      find.text('Error: Bad state: device keys unavailable'),
      findsOneWidget,
    );
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(find.text('Show Recovery Key'), findsOneWidget);
    verify(() => manager.getRecoveryKey()).called(1);
    verify(() => manager.createRecoveryKey()).called(1);
    expect(tester.takeException(), isNull);
  });
}
