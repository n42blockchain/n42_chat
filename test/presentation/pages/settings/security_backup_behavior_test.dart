import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:n42_chat/src/core/encryption/key_backup_service.dart';
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
    when(() => backup.backupAllKeys()).thenAnswer((_) async {});
    when(() => backup.deleteKeyBackup()).thenAnswer((_) async {});
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

  Future<void> openBackupDialog(WidgetTester tester, S l10n) async {
    await tester.scrollUntilVisible(find.text(l10n.settingsBackupNotSet), 200);
    await tester.tap(find.text(l10n.settingsBackupEncryptionKeys));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsBackup));
    await tester.pumpAndSettle();
  }

  testWidgets('successful backup asks the user to save its recovery key', (
    tester,
  ) async {
    when(
      () => manager.createRecoveryKey(),
    ).thenAnswer((_) async => 'RECOVERY-KEY-123');
    final l10n = await open(tester);

    await openBackupDialog(tester, l10n);

    expect(find.text('RECOVERY-KEY-123'), findsOneWidget);
    expect(find.byType(SelectableText), findsOneWidget);
    expect(find.text(l10n.settingsRecoveryKeySaveWarning), findsOneWidget);
    verify(() => manager.createRecoveryKey()).called(1);
    verify(() => backup.backupAllKeys()).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('backup without a recovery key reports completed upload', (
    tester,
  ) async {
    when(() => manager.createRecoveryKey()).thenAnswer((_) async => null);
    final l10n = await open(tester);

    await openBackupDialog(tester, l10n);

    expect(find.text(l10n.settingsBackupSuccess), findsOneWidget);
    expect(find.byType(SelectableText), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('restore with a recovery key reports restored sessions', (
    tester,
  ) async {
    when(
      () => manager.unlockWithRecoveryKey('RECOVERY-KEY'),
    ).thenAnswer((_) async => 2);
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text(l10n.settingsRestoreKeys), 200);
    await tester.ensureVisible(find.text(l10n.settingsRestoreKeys).last);
    await tester.tap(find.text(l10n.settingsRestoreKeys).last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'RECOVERY-KEY');
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsRestore));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsRestoreSessions(2)), findsOneWidget);
    verify(() => manager.unlockWithRecoveryKey('RECOVERY-KEY')).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('password restore reports an empty backup', (tester) async {
    when(
      () => manager.unlockWithPassphrase('backup password'),
    ).thenAnswer((_) async => 0);
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text(l10n.settingsRestoreKeys), 200);
    await tester.ensureVisible(find.text(l10n.settingsRestoreKeys).last);
    await tester.tap(find.text(l10n.settingsRestoreKeys).last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, l10n.settingsPassword));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'backup password');
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsRestore));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsRestoreEmpty), findsOneWidget);
    verify(() => manager.unlockWithPassphrase('backup password')).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed backup reports an error and returns to settings', (
    tester,
  ) async {
    when(
      () => manager.createRecoveryKey(),
    ).thenAnswer((_) async => 'RECOVERY-KEY-123');
    when(
      () => backup.backupAllKeys(),
    ).thenThrow(KeyBackupException('server unavailable'));
    final l10n = await open(tester);

    await openBackupDialog(tester, l10n);

    expect(find.textContaining(l10n.settingsBackupFailed), findsOneWidget);
    expect(find.text('RECOVERY-KEY-123'), findsNothing);
    expect(find.text(l10n.settingsBackupEncryptionKeys), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('export without a saved recovery key explains backup setup', (
    tester,
  ) async {
    when(() => manager.getRecoveryKey()).thenAnswer((_) async => null);
    when(() => manager.hasSsssDefaultKey).thenReturn(false);
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text(l10n.settingsExportKeys), 200);
    await tester.ensureVisible(find.text(l10n.settingsExportKeys));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsExportKeys));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsExport));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsExportNeedBackupFirst), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('account deletion dialog defaults to local-only and can cancel', (
    tester,
  ) async {
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text('Delete Account'), 240);
    await tester.ensureVisible(find.text('Delete Account').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Account').last);
    await tester.pumpAndSettle();

    final localErase = find.widgetWithText(
      CheckboxListTile,
      'Also erase local chat data on this device',
    );
    final remoteErase = find.widgetWithText(
      CheckboxListTile,
      'Request homeserver data erasure',
    );
    expect(tester.widget<CheckboxListTile>(localErase).value, isTrue);
    expect(tester.widget<CheckboxListTile>(remoteErase).value, isFalse);

    await tester.tap(remoteErase);
    await tester.pumpAndSettle();
    expect(tester.widget<CheckboxListTile>(remoteErase).value, isTrue);
    await tester.tap(find.text(l10n.commonCancel).last);
    await tester.pumpAndSettle();

    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling encryption reset preserves the current backup', (
    tester,
  ) async {
    final l10n = await open(tester);
    await tester.scrollUntilVisible(
      find.text(l10n.settingsResetEncryption),
      240,
    );
    await tester.ensureVisible(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsResetEncryptionWarning), findsOneWidget);
    await tester.tap(find.text(l10n.commonCancel).last);
    await tester.pumpAndSettle();

    verifyNever(() => backup.deleteKeyBackup());
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('confirmed encryption reset deletes backup and reports success', (
    tester,
  ) async {
    final l10n = await open(tester);
    await tester.scrollUntilVisible(
      find.text(l10n.settingsResetEncryption),
      240,
    );
    await tester.ensureVisible(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsReset));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    verify(() => backup.deleteKeyBackup()).called(1);
    expect(find.text(l10n.settingsResetSuccess), findsOneWidget);
    verify(() => backup.getBackupInfo()).called(greaterThanOrEqualTo(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed encryption reset reports the service error', (
    tester,
  ) async {
    when(
      () => backup.deleteKeyBackup(),
    ).thenThrow(KeyBackupException('server unavailable'));
    final l10n = await open(tester);
    await tester.scrollUntilVisible(
      find.text(l10n.settingsResetEncryption),
      240,
    );
    await tester.ensureVisible(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsResetEncryption).last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsReset));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    verify(() => backup.deleteKeyBackup()).called(1);
    expect(
      find.textContaining(
        '${l10n.settingsResetFailed}: KeyBackupException: server unavailable',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('enabled cross-signing does not initialize a second time', (
    tester,
  ) async {
    when(() => manager.isCrossSigningEnabled).thenReturn(true);
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text(l10n.settingsAdvanced), 240);
    await tester.ensureVisible(find.text(l10n.settingsCrossSigning).last);
    await tester.tap(find.text(l10n.settingsCrossSigning).last);
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsCrossSigningAlreadyEnabled), findsOneWidget);
    verifyNever(() => manager.initializeCrossSigning());
    expect(tester.takeException(), isNull);
  });

  testWidgets('cross-signing setup reports initialization failures', (
    tester,
  ) async {
    when(
      () => manager.initializeCrossSigning(),
    ).thenThrow(StateError('device key unavailable'));
    final l10n = await open(tester);
    await tester.scrollUntilVisible(find.text(l10n.settingsAdvanced), 240);
    await tester.ensureVisible(find.text(l10n.settingsCrossSigning).last);
    await tester.tap(find.text(l10n.settingsCrossSigning).last);
    await tester.pumpAndSettle();

    expect(
      find.text(l10n.settingsSetupFailed('Bad state: device key unavailable')),
      findsOneWidget,
    );
    verify(() => manager.initializeCrossSigning()).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('show recovery key creates one when none is stored', (
    tester,
  ) async {
    when(() => manager.getRecoveryKey()).thenAnswer((_) async => null);
    when(
      () => manager.createRecoveryKey(),
    ).thenAnswer((_) async => 'NEW-RECOVERY-KEY');
    await open(tester);
    await tester.scrollUntilVisible(find.text('Show Recovery Key'), 240);
    await tester.ensureVisible(find.text('Show Recovery Key'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show Recovery Key'));
    await tester.pumpAndSettle();

    expect(find.text('NEW-RECOVERY-KEY'), findsOneWidget);
    verify(() => manager.getRecoveryKey()).called(1);
    verify(() => manager.createRecoveryKey()).called(1);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
