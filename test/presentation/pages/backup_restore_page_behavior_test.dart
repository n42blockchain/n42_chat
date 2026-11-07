import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/presentation/pages/settings/backup_restore_page.dart';

class _Service extends Mock implements ChatBackupService {}

class _FilePicker extends FilePickerPlatform {
  PlatformFile? result;
  Object? error;
  FileType? lastType;
  int calls = 0;

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
    lastType = type;
    if (error != null) throw error!;
    return result;
  }
}


void main() {
  testWidgets('restore page refuses file selection without an account lifecycle', (tester) async {
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
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      locale: Locale('en'),
      home: BackupRestorePage(),
    ));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Choose Backup File'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose Backup File'));
    await tester.pumpAndSettle();
    expect(picker.calls, 0);
    expect(tester.takeException(), isNull);
  });
}
