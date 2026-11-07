import 'dart:async';
import 'dart:io';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/presentation/pages/settings/backup_restore_page.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Service extends Mock implements ChatBackupService {}

base class _PickedFile extends PlatformFile {
  _PickedFile() : uri = Uri.file('/tmp/fixture.n42backup');
  @override
  final String name = 'fixture.n42backup';
  @override
  final Uri uri;
  @override
  int? lengthSync() => 1;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FilePicker extends FilePickerPlatform {
  PlatformFile? result;
  Future<PlatformFile?>? pending;
  Object? error;
  FileType? lastType;
  int calls = 0;
  void Function()? onPick;

  @override
  Future<PlatformFile?> pickFile({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    void Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    calls++;
    onPick?.call();
    lastType = type;
    if (error != null) throw error!;
    if (pending != null) return pending;
    return result;
  }
}

void main() {
  testWidgets(
    'restore page refuses file selection without an account lifecycle',
    (tester) async {
      final service = _Service();
      when(() => service.listBackups()).thenAnswer((_) async => []);
      final previous = FilePickerPlatform.instance;
      final picker = _FilePicker();
      FilePickerPlatform.instance = picker;
      GetIt.instance.registerSingleton<ChatBackupService>(service);
      addTearDown(() async {
        FilePickerPlatform.instance = previous;
        await GetIt.instance.reset();
      });
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: BackupRestorePage(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Choose Backup File'));
      await tester.pumpAndSettle();
      clearInteractions(service);
      await tester.tap(find.text('Choose Backup File'));
      await tester.pumpAndSettle();
      expect(picker.calls, 0);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('pending file selection blocks duplicate and legacy restore entry', (tester) async {
    final service = _Service();
    final manager = _Manager();
    final client = _Client();
    final auth = _Auth();
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('fixture-token');
    when(() => client.deviceID).thenReturn('fixture-device');
    when(client.isLogged).thenReturn(true);
    final generation = AuthSessionInvalidation(userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'), deviceId: 'fixture-device',
      isCurrent: () => true, matchesClient: (candidate) => identical(candidate, client));
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => service.listBackups()).thenAnswer((_) async => []);
    final gate = Completer<PlatformFile?>();
    final previous = FilePickerPlatform.instance;
    final picker = _FilePicker()..pending = gate.future;
    FilePickerPlatform.instance = picker;
    GetIt.instance.registerSingleton<ChatBackupService>(service);
    GetIt.instance.registerSingleton<MatrixClientManager>(manager);
    GetIt.instance.registerSingleton<IAuthRepository>(auth);
    addTearDown(() async { FilePickerPlatform.instance = previous; await GetIt.instance.reset(); });
    await tester.pumpWidget(const MaterialApp(localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales, locale: Locale('en'), home: BackupRestorePage()));
    await tester.pumpAndSettle();
    for (final label in ['Choose Backup File', 'Choose Backup File', 'Older backup files']) {
      await tester.ensureVisible(find.text(label));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }
    expect(picker.calls, 1);
    verifyNever(() => service.listLegacyBackupFiles());
    gate.complete(null);
    await tester.pumpAndSettle();
    picker.pending = null;
    await tester.ensureVisible(find.text('Choose Backup File'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose Backup File'));
    await tester.pumpAndSettle();
    expect(picker.calls, 2);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final outcome in ['cancel', 'confirm', 'stale']) {
    testWidgets('backup deletion confirmation belongs to opening account: $outcome', (tester) async {
      final service = _Service();
      final manager = _Manager();
      final client = _Client();
      final auth = _Auth();
      var current = true;
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@me:hs.test');
      when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => client.accessToken).thenReturn('fixture-token');
      when(() => client.deviceID).thenReturn('fixture-device');
      when(client.isLogged).thenReturn(true);
      final generation = AuthSessionInvalidation(userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'), deviceId: 'fixture-device',
        isCurrent: () => current, matchesClient: (candidate) => identical(candidate, client));
      when(() => auth.currentAccountGeneration).thenReturn(generation);
      when(() => service.listBackups()).thenAnswer((_) async => [BackupInfo(
        backupId: 'delete-fixture', filePath: '/tmp/delete.n42backup', fileSizeBytes: 10,
        createdAt: DateTime(2026), roomCount: 1, includesMedia: false, includesKeys: false)]);
      when(() => service.deleteBackup('delete-fixture', isCurrent: any(named: 'isCurrent')))
        .thenAnswer((invocation) async {
          final guard = invocation.namedArguments[#isCurrent] as bool Function();
          expect(guard(), isTrue);
        });
      GetIt.instance.registerSingleton<ChatBackupService>(service);
      GetIt.instance.registerSingleton<MatrixClientManager>(manager);
      GetIt.instance.registerSingleton<IAuthRepository>(auth);
      addTearDown(() => GetIt.instance.reset());
      await tester.pumpWidget(const MaterialApp(localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales, locale: Locale('en'), home: BackupRestorePage()));
      await tester.pumpAndSettle();
      final menu = find.byType(PopupMenuButton<String>);
      await tester.ensureVisible(menu);
      await tester.pumpAndSettle();
      await tester.tap(menu);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      if (outcome == 'stale') current = false;
      await tester.tap(find.widgetWithText(TextButton, outcome == 'cancel' ? 'Cancel' : 'Delete'));
      await tester.pumpAndSettle();
      final call = () => service.deleteBackup('delete-fixture', isCurrent: any(named: 'isCurrent'));
      if (outcome == 'confirm') { verify(call).called(1); }
      else { verifyNever(call); }
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final outcome in ['cancel', 'stale-selection', 'stale-list', 'empty']) {
    testWidgets('legacy file selector is guarded: $outcome', (tester) async {
      final service = _Service();
      final manager = _Manager();
      final client = _Client();
      final auth = _Auth();
      var current = true;
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@me:hs.test');
      when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => client.accessToken).thenReturn('fixture-token');
      when(() => client.deviceID).thenReturn('fixture-device');
      when(client.isLogged).thenReturn(true);
      final generation = AuthSessionInvalidation(userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'), deviceId: 'fixture-device',
        isCurrent: () => current, matchesClient: (candidate) => identical(candidate, client));
      when(() => auth.currentAccountGeneration).thenReturn(generation);
      when(() => service.listBackups()).thenAnswer((_) async => []);
      when(() => service.listLegacyBackupFiles()).thenAnswer((_) async {
        if (outcome == 'stale-list') current = false;
        return outcome == 'empty' ? [] : [File('/tmp/fixture.n42backup')];
      });
      GetIt.instance.registerSingleton<ChatBackupService>(service);
      GetIt.instance.registerSingleton<MatrixClientManager>(manager);
      GetIt.instance.registerSingleton<IAuthRepository>(auth);
      addTearDown(() => GetIt.instance.reset());
      await tester.pumpWidget(const MaterialApp(localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales, locale: Locale('en'), home: BackupRestorePage()));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Older backup files'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Older backup files'));
      await tester.pumpAndSettle();
      verify(() => service.listLegacyBackupFiles()).called(1);
      if (outcome == 'stale-list') {
        expect(find.byType(AlertDialog), findsNothing);
      } else if (outcome == 'stale-selection') {
        current = false;
        await tester.tap(find.text('fixture.n42backup'));
      } else {
        if (outcome == 'empty') expect(find.text('No backups yet'), findsWidgets);
        await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      }
      await tester.pumpAndSettle();
      verifyNever(() => service.previewBackup(any()));
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final mode in [
    'cancel',
    'active-error',
    'stale-error',
    'preview-cancel',
    'confirm',
    'stale-confirm',
    'password-cancel',
    'password-confirm',
    'password-stale',
    'password-wrong',
  ]) {
    for (final source in ['picker', if (!['cancel', 'active-error', 'stale-error'].contains(mode)) ...['history', 'legacy']]) {
    final fromHistory = source == 'history';
    final fromLegacy = source == 'legacy';
    testWidgets('valid account restore outcome: $mode source=$source', (tester) async {
      final service = _Service();
      final manager = _Manager();
      final client = _Client();
      final auth = _Auth();
      var current = true;
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@me:hs.test');
      when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => client.accessToken).thenReturn('fixture-token');
      when(() => client.deviceID).thenReturn('fixture-device');
      when(client.isLogged).thenReturn(true);
      final generation = AuthSessionInvalidation(
        userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'),
        deviceId: 'fixture-device',
        isCurrent: () => current,
        matchesClient: (candidate) => identical(candidate, client),
      );
      when(() => auth.currentAccountGeneration).thenReturn(generation);
      when(() => service.listBackups()).thenAnswer((_) async => fromHistory ? [BackupInfo(
        backupId: 'fixture', filePath: '/tmp/fixture.n42backup', fileSizeBytes: 1024,
        createdAt: DateTime(2026), roomCount: 1, includesMedia: false, includesKeys: false,
      )] : []);
      when(() => service.listLegacyBackupFiles()).thenAnswer((_) async => [File('/tmp/fixture.n42backup')]);
      final previous = FilePickerPlatform.instance;
      final picker = _FilePicker();
      final protected = mode.startsWith('password-');
      final selected =
          protected ||
          ['preview-cancel', 'confirm', 'stale-confirm'].contains(mode);
      if (selected) {
        picker.result = _PickedFile();
        when(() => service.previewBackup('/tmp/fixture.n42backup')).thenAnswer(
          (_) async => BackupPreview(
            backupId: 'fixture',
            createdAt: DateTime(2026),
            roomCount: 1,
            roomNames: ['Fixture room'],
            hasMedia: false,
            hasKeys: false,
            hasSettings: false,
            warnings: ['Fixture incomplete backup'],
          ),
        );
        when(
          () => service.restoreFromBackup(
            backupFilePath: '/tmp/fixture.n42backup',
            restoreMessages: true,
            isCurrent: any(named: 'isCurrent'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => const RestoreResult());
      }
      if (protected) {
        when(() => service.previewBackup('/tmp/fixture.n42backup'))
            .thenThrow(BackupPasswordRequired());
        when(
          () => service.previewBackup(
            '/tmp/fixture.n42backup',
            password: 'fixture-password',
          ),
        ).thenAnswer(
          (_) async => BackupPreview(
            backupId: 'protected',
            createdAt: DateTime(2026),
            roomCount: 1,
            roomNames: ['Fixture room'],
            hasMedia: false,
            hasKeys: false,
            hasSettings: false,
            warnings: ['Fixture incomplete backup'],
          ),
        );
        when(
          () => service.restoreFromBackup(
            backupFilePath: '/tmp/fixture.n42backup',
            restoreMessages: true,
            password: 'fixture-password',
            isCurrent: any(named: 'isCurrent'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => const RestoreResult());
      }
      if (mode == 'password-wrong') {
        when(
          () => service.previewBackup(
            '/tmp/fixture.n42backup',
            password: 'fixture-password',
          ),
        ).thenThrow(const FormatException('fixture-invalid-password'));
      }
      if (!selected && mode != 'cancel')
        picker.error = StateError('picker-fixture-error');
      if (mode == 'stale-error') picker.onPick = () => current = false;
      FilePickerPlatform.instance = picker;
      GetIt.instance.registerSingleton<ChatBackupService>(service);
      GetIt.instance.registerSingleton<MatrixClientManager>(manager);
      GetIt.instance.registerSingleton<IAuthRepository>(auth);
      addTearDown(() async {
        FilePickerPlatform.instance = previous;
        await GetIt.instance.reset();
      });
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: BackupRestorePage(),
        ),
      );
      await tester.pumpAndSettle();
      clearInteractions(service);
      if (fromHistory) {
        final menu = find.byType(PopupMenuButton<String>);
        await tester.ensureVisible(menu);
        await tester.tap(menu);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Restore').last);
      } else if (fromLegacy) {
        await tester.ensureVisible(find.text('Older backup files'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Older backup files'));
        await tester.pumpAndSettle();
        expect(find.textContaining('may belong to another account'), findsOneWidget);
        await tester.tap(find.text('fixture.n42backup'));
      } else {
        await tester.ensureVisible(find.text('Choose Backup File'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Choose Backup File'));
      }
      await tester.pumpAndSettle();
      expect(picker.calls, fromHistory || fromLegacy ? 0 : 1);
      if (protected) {
        final input = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextField),
        );
        expect(tester.widget<TextField>(input).obscureText, isTrue);
        if (mode == 'password-cancel') {
          clearInteractions(service);
          await tester.tap(find.widgetWithText(TextButton, 'Cancel').last);
          await tester.pumpAndSettle();
          verifyNever(
            () => service.previewBackup(
              '/tmp/fixture.n42backup',
              password: any(named: 'password'),
            ),
          );
          expect(find.byType(AlertDialog), findsNothing);
          return;
        }
        await tester.enterText(input, 'fixture-password');
        if (mode == 'password-stale') {
          clearInteractions(service);
          current = false;
          await tester.tap(find.widgetWithText(FilledButton, 'Confirm').last);
          await tester.pumpAndSettle();
          verifyZeroInteractions(service);
          expect(find.byType(AlertDialog), findsNothing);
          expect(tester.takeException(), isNull);
          return;
        }
        await tester.tap(find.widgetWithText(FilledButton, 'Confirm').last);
        await tester.pumpAndSettle();
        if (mode == 'password-wrong') {
          expect(
            find.textContaining('fixture-invalid-password'),
            findsOneWidget,
          );
          verifyNever(
            () => service.restoreFromBackup(
              backupFilePath: '/tmp/fixture.n42backup',
            restoreMessages: true,
              password: 'fixture-password',
              isCurrent: any(named: 'isCurrent'),
              onProgress: any(named: 'onProgress'),
            ),
          );
          expect(find.byType(AlertDialog), findsNothing);
          return;
        }
        expect(find.text('Fixture incomplete backup'), findsOneWidget);
        await tester.tap(find.widgetWithText(FilledButton, 'Confirm').last);
        await tester.pumpAndSettle();
        verify(
          () => service.restoreFromBackup(
            backupFilePath: '/tmp/fixture.n42backup',
            restoreMessages: true,
            password: 'fixture-password',
            isCurrent: any(named: 'isCurrent'),
            onProgress: any(named: 'onProgress'),
          ),
        ).called(1);
        expect(tester.takeException(), isNull);
        return;
      }
      if (selected) {
        expect(find.text('Fixture incomplete backup'), findsOneWidget);
        expect(find.text('Fixture room'), findsOneWidget);
        if (mode == 'stale-confirm') current = false;
        await tester.tap(
          find.widgetWithText(TextButton, 'Cancel').last,
          warnIfMissed: true,
        );
        if (mode == 'confirm' || mode == 'stale-confirm') {
          // Re-open to exercise explicit confirmation independently of cancel.
          if (mode == 'stale-confirm') current = true;
          await tester.pumpAndSettle();
          await tester.tap(find.text('Choose Backup File'));
          await tester.pumpAndSettle();
          if (mode == 'stale-confirm') current = false;
          await tester.tap(find.widgetWithText(FilledButton, 'Confirm').last);
        }
        await tester.pumpAndSettle();
        final verification = () => service.restoreFromBackup(
          backupFilePath: '/tmp/fixture.n42backup',
            restoreMessages: true,
          isCurrent: any(named: 'isCurrent'),
          onProgress: any(named: 'onProgress'),
        );
        if (mode == 'confirm') {
          verify(verification).called(1);
        } else {
          verifyNever(verification);
        }
      } else {
        verifyZeroInteractions(service);
      }
      expect(
        find.textContaining('picker-fixture-error'),
        mode == 'active-error' ? findsOneWidget : findsNothing,
      );
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
    }
  }
}
