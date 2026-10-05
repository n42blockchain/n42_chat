import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:n42_chat/src/core/encryption/key_backup_service.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/presentation/pages/settings/security_settings_page.dart';

class _Manager extends Mock implements E2EEManager {}

class _Backup extends Mock implements KeyBackupService {}

class _AuthDataSource extends Mock implements MatrixAuthDataSource {}

class _Client extends Mock implements Client {}

void main() {
  late _Manager manager;
  late _Backup backup;
  late _AuthDataSource authDataSource;
  late _Client client;
  late List<Device> devices;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    manager = _Manager();
    backup = _Backup();
    authDataSource = _AuthDataSource();
    client = _Client();
    final now = DateTime.now().millisecondsSinceEpoch;
    devices = [
      Device(
        deviceId: 'OLD_DEVICE',
        displayName: 'Old tablet',
        lastSeenTs: now - const Duration(days: 40).inMilliseconds,
      ),
      Device(
        deviceId: 'RECENT_DEVICE',
        displayName: 'Recent phone',
        lastSeenTs: now - const Duration(hours: 2).inMilliseconds,
        lastSeenIp: '192.0.2.15',
      ),
      Device(
        deviceId: 'CURRENT_DEVICE',
        displayName: 'Current phone',
        lastSeenTs: now - const Duration(minutes: 10).inMilliseconds,
      ),
    ];
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice:example.org');
    when(() => manager.currentDeviceId).thenReturn('CURRENT_DEVICE');
    when(() => manager.status).thenReturn(E2EEStatus.notSupported);
    when(() => manager.isCrossSigningEnabled).thenReturn(false);
    when(
      () => manager.isDeviceVerified('@alice:example.org', any()),
    ).thenReturn(true);
    when(() => backup.getBackupInfo()).thenAnswer((_) async => null);
    when(() => authDataSource.getDevices()).thenAnswer((_) async => devices);
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
          authDataSource: authDataSource,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(SecuritySettingsPage)))!;
  }

  Future<void> revealDevices(WidgetTester tester, S l10n) async {
    await tester.scrollUntilVisible(
      find.text(l10n.settingsLoggedInDevices),
      240,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('current device sorts ahead of more recently active devices', (
    tester,
  ) async {
    final l10n = await open(tester);
    await revealDevices(tester, l10n);

    final current = tester.getCenter(find.text('Current phone'));
    final recent = tester.getCenter(find.text('Recent phone'));
    final old = tester.getCenter(find.text('Old tablet'));
    expect(current.dy, lessThan(recent.dy));
    expect(recent.dy, lessThan(old.dy));
    expect(find.textContaining(l10n.settingsThisDevice), findsOneWidget);
    expect(find.textContaining(l10n.settingsVerified), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });

  testWidgets('device details show metadata and save a renamed device', (
    tester,
  ) async {
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();

    expect(find.text('RECENT_DEVICE'), findsOneWidget);
    expect(find.text('192.0.2.15'), findsOneWidget);
    await tester.tap(find.text(l10n.settingsRenameDevice));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).last,
      '  Living room tablet  ',
    );
    when(
      () => authDataSource.updateDeviceName(any(), any()),
    ).thenAnswer((_) async {});
    await tester.tap(find.widgetWithText(TextButton, l10n.commonSave));
    await tester.pumpAndSettle();

    verify(
      () => authDataSource.updateDeviceName(
        'RECENT_DEVICE',
        'Living room tablet',
      ),
    ).called(1);
    expect(find.text(l10n.settingsDeviceRenamed), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('blank and unchanged device names do not call the server', (
    tester,
  ) async {
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRenameDevice));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '   ');
    await tester.tap(find.widgetWithText(TextButton, l10n.commonSave));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRenameDevice));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Recent phone');
    await tester.tap(find.widgetWithText(TextButton, l10n.commonSave));
    await tester.pumpAndSettle();

    verifyNever(() => authDataSource.updateDeviceName(any(), any()));
    expect(find.text('Recent phone'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'failed device rename reports the error and keeps settings open',
    (tester) async {
      final l10n = await open(tester);
      await revealDevices(tester, l10n);
      await tester.tap(find.text('Recent phone'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.settingsRenameDevice));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'New device name');
      when(
        () => authDataSource.updateDeviceName(any(), any()),
      ).thenThrow(StateError('network unavailable'));
      await tester.tap(find.widgetWithText(TextButton, l10n.commonSave));
      await tester.pumpAndSettle();

      expect(
        find.text(
          '${l10n.settingsRenameFailed}: Bad state: network unavailable',
        ),
        findsOneWidget,
      );
      expect(find.byType(SecuritySettingsPage), findsOneWidget);
      expect(find.text('Recent phone'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('confirmed remote logout removes the device and refreshes list', (
    tester,
  ) async {
    var activeDevices = List<Device>.of(devices);
    when(
      () => authDataSource.getDevices(),
    ).thenAnswer((_) async => activeDevices);
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    when(() => authDataSource.deleteDevice('RECENT_DEVICE')).thenAnswer((
      _,
    ) async {
      activeDevices = devices
          .where((d) => d.deviceId != 'RECENT_DEVICE')
          .toList();
    });
    await tester.tap(find.text(l10n.settingsLogout));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    verify(() => authDataSource.deleteDevice('RECENT_DEVICE')).called(1);
    expect(find.text(l10n.settingsDeviceLoggedOut), findsOneWidget);
    expect(find.text('Recent phone'), findsNothing);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('password UIA completes remote logout after an auth challenge', (
    tester,
  ) async {
    var activeDevices = List<Device>.of(devices);
    final authAttempts = <Object?>[];
    when(
      () => authDataSource.getDevices(),
    ).thenAnswer((_) async => activeDevices);
    when(
      () => authDataSource.deleteDevice(any(), auth: any(named: 'auth')),
    ).thenAnswer((invocation) async {
      final auth = invocation.namedArguments[#auth];
      authAttempts.add(auth);
      if (auth == null) {
        throw MatrixException(
          http.Response(
            '{"flows":[{"stages":["m.login.password"]}],"session":"test"}',
            401,
          ),
        );
      }
      activeDevices = devices
          .where((device) => device.deviceId != 'RECENT_DEVICE')
          .toList();
    });
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsLogout));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsVerifyIdentity), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'account password');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    expect(authAttempts, hasLength(2));
    expect(authAttempts.first, isNull);
    expect(authAttempts.last, isA<AuthenticationPassword>());
    final passwordAuth = authAttempts.last as AuthenticationPassword;
    expect(passwordAuth.password, 'account password');
    expect(
      (passwordAuth.identifier as AuthenticationUserIdentifier).user,
      '@alice:example.org',
    );
    expect(find.text(l10n.settingsDeviceLoggedOut), findsOneWidget);
    expect(find.text('Recent phone'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling password UIA leaves the remote device active', (
    tester,
  ) async {
    var activeDevices = List<Device>.of(devices);
    final authAttempts = <Object?>[];
    when(
      () => authDataSource.getDevices(),
    ).thenAnswer((_) async => activeDevices);
    when(
      () => authDataSource.deleteDevice(any(), auth: any(named: 'auth')),
    ).thenAnswer((invocation) async {
      final auth = invocation.namedArguments[#auth];
      authAttempts.add(auth);
      if (auth == null) {
        throw MatrixException(
          http.Response(
            '{"flows":[{"stages":["m.login.password"]}],"session":"test"}',
            401,
          ),
        );
      }
      activeDevices = devices
          .where((device) => device.deviceId != 'RECENT_DEVICE')
          .toList();
    });
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsLogout));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();

    expect(authAttempts, hasLength(1));
    expect(authAttempts.single, isNull);
    expect(find.text('Recent phone'), findsOneWidget);
    expect(find.text(l10n.settingsVerifyIdentity), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('blank password UIA does not retry remote logout', (
    tester,
  ) async {
    final authAttempts = <Object?>[];
    when(() => authDataSource.getDevices()).thenAnswer((_) async => devices);
    when(
      () => authDataSource.deleteDevice(any(), auth: any(named: 'auth')),
    ).thenAnswer((invocation) async {
      final auth = invocation.namedArguments[#auth];
      authAttempts.add(auth);
      throw MatrixException(
        http.Response(
          '{"flows":[{"stages":["m.login.password"]}],"session":"test"}',
          401,
        ),
      );
    });
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsLogout));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    expect(authAttempts, hasLength(1));
    expect(authAttempts.single, isNull);
    expect(find.text('Recent phone'), findsOneWidget);
    expect(find.text(l10n.settingsVerifyIdentity), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed remote logout keeps settings open and reports failure', (
    tester,
  ) async {
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    when(
      () => authDataSource.deleteDevice('RECENT_DEVICE'),
    ).thenThrow(StateError('network unavailable'));
    await tester.tap(find.text(l10n.settingsLogout));
    await tester.pumpAndSettle();

    expect(
      find.text('${l10n.settingsLogoutFailed}: Bad state: network unavailable'),
      findsOneWidget,
    );
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling remote logout leaves the session untouched', (
    tester,
  ) async {
    final l10n = await open(tester);
    await revealDevices(tester, l10n);
    await tester.tap(find.text('Recent phone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsRemoteLogout));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonCancel).last);
    await tester.pumpAndSettle();

    verifyNever(
      () => authDataSource.deleteDevice(any(), auth: any(named: 'auth')),
    );
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
