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

class _FilePicker extends FilePickerPlatform {
  PlatformFile? result;
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
  for (final mode in ['cancel', 'active-error', 'stale-error']) {
    testWidgets('valid account picker outcome: $mode', (tester) async {
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
      when(() => service.listBackups()).thenAnswer((_) async => []);
      final previous = FilePickerPlatform.instance;
      final picker = _FilePicker();
      if (mode != 'cancel') picker.error = StateError('picker-fixture-error');
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
      await tester.ensureVisible(find.text('Choose Backup File'));
      await tester.pumpAndSettle();
      clearInteractions(service);
      await tester.tap(find.text('Choose Backup File'));
      await tester.pumpAndSettle();
      expect(picker.calls, 1);
      verifyZeroInteractions(service);
      expect(
        find.textContaining('picker-fixture-error'),
        mode == 'active-error' ? findsOneWidget : findsNothing,
      );
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
