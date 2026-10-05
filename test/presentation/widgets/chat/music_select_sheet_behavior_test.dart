import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/music_select_sheet.dart';

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

base class _PickedFile extends PlatformFile {
  _PickedFile({required this.name, required String path})
    : uri = Uri.file(path);

  @override
  final String name;

  @override
  final Uri uri;

  @override
  @override
  int? lengthSync() => 1;

  @override
  Future<int?> length() async => 1;

  @override
  Future<Uint8List> readAsBytes() async => Uint8List(0);

  @override
  Stream<Uint8List> readAsByteStream() => Stream.value(Uint8List(0));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FilePickerPlatform originalPicker;

  setUp(() => originalPicker = FilePickerPlatform.instance);
  tearDown(() => FilePickerPlatform.instance = originalPicker);

  Future<Completer<Map<String, dynamic>?>> openSheet(
    WidgetTester tester,
  ) async {
    final result = Completer<Map<String, dynamic>?>();
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result.complete(
                  await showModalBottomSheet<Map<String, dynamic>>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const MusicSelectSheet(isDark: false),
                  ),
                );
              },
              child: const Text('Open music sheet'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open music sheet'));
    await tester.pumpAndSettle();
    return result;
  }

  Future<void> selectTab(WidgetTester tester, String label) async {
    await tester.tap(find.text(label).last);
    await tester.pumpAndSettle();
  }

  Future<void> tapNetworkShare(WidgetTester tester) async {
    final button = find.widgetWithText(ElevatedButton, 'Share Music');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  testWidgets('recent song selection returns its shared song details', (
    tester,
  ) async {
    final result = await openSheet(tester);

    expect(find.text('晴天'), findsOneWidget);
    await tester.tap(find.text('晴天'));
    await tester.pumpAndSettle();

    expect(result.isCompleted, isTrue);
    expect(await result.future, {
      'name': '晴天',
      'artist': '周杰伦',
      'url': 'https://music.163.com/#/song?id=186016',
    });
  });

  testWidgets('favorite list searches across artist names', (tester) async {
    final result = await openSheet(tester);
    await selectTab(tester, 'Favorites');
    await tester.enterText(find.byType(TextField), 'G.E.M');
    await tester.pumpAndSettle();

    expect(find.text('光年之外'), findsOneWidget);
    expect(find.text('起风了'), findsNothing);
    await tester.tap(find.text('光年之外'));
    await tester.pumpAndSettle();

    expect(result.isCompleted, isTrue);
    final selected = (await result.future)!;
    expect(selected['name'], '光年之外');
    expect(selected['artist'], 'G.E.M.邓紫棋');
  });

  testWidgets('song search shows an empty state when nothing matches', (
    tester,
  ) async {
    final result = await openSheet(tester);
    await tester.enterText(find.byType(TextField), 'no matching song');
    await tester.pumpAndSettle();

    expect(find.text('No songs found'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(await result.future, isNull);
  });

  testWidgets('network link validation rejects empty links', (tester) async {
    final result = await openSheet(tester);
    await selectTab(tester, 'Link');
    await tapNetworkShare(tester);
    expect(find.text('Please enter music link'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(await result.future, isNull);
  });

  testWidgets('network link validation rejects non-http links', (tester) async {
    final result = await openSheet(tester);
    await selectTab(tester, 'Link');
    await tester.enterText(find.byType(TextField).first, 'music.example/song');
    await tapNetworkShare(tester);
    expect(find.text('Please enter a valid URL'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(await result.future, isNull);
  });

  testWidgets('network links trim fields and use defaults when omitted', (
    tester,
  ) async {
    final result = await openSheet(tester);
    await selectTab(tester, 'Link');
    await tester.enterText(
      find.byType(TextField).first,
      '  https://music.example/song  ',
    );
    await tapNetworkShare(tester);

    expect(result.isCompleted, isTrue);
    expect(await result.future, {
      'name': 'Shared Song',
      'artist': 'Unknown Artist',
      'url': 'https://music.example/song',
      'isNetwork': true,
    });
  });

  testWidgets('network link keeps supplied title and artist after trimming', (
    tester,
  ) async {
    final result = await openSheet(tester);
    await selectTab(tester, 'Link');
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'https://music.example/song');
    await tester.enterText(fields.at(1), '  Song Title  ');
    await tester.enterText(fields.at(2), '  Singer  ');
    await tapNetworkShare(tester);

    expect(result.isCompleted, isTrue);
    expect(await result.future, {
      'name': 'Song Title',
      'artist': 'Singer',
      'url': 'https://music.example/song',
      'isNetwork': true,
    });
  });

  testWidgets('local file name is split into artist and song', (tester) async {
    final picker = _FilePicker()
      ..result = _PickedFile(
        name: 'Aimer - Ref:rain.mp3',
        path: '/music/ref-rain.mp3',
      );
    FilePickerPlatform.instance = picker;
    final result = await openSheet(tester);
    await selectTab(tester, 'Local');
    await tester.tap(find.text('Select File'));
    await tester.pumpAndSettle();

    expect(picker.calls, 1);
    expect(picker.lastType, FileType.audio);
    expect(result.isCompleted, isTrue);
    expect(await result.future, {
      'name': 'Ref:rain',
      'artist': 'Aimer',
      'url': '/music/ref-rain.mp3',
      'isLocal': true,
    });
  });

  testWidgets('local file without artist uses the unknown-artist fallback', (
    tester,
  ) async {
    final picker = _FilePicker()
      ..result = _PickedFile(name: 'Recording.m4a', path: '/music/recording');
    FilePickerPlatform.instance = picker;
    final result = await openSheet(tester);
    await selectTab(tester, 'Local');
    await tester.tap(find.text('Select File'));
    await tester.pumpAndSettle();

    expect(result.isCompleted, isTrue);
    expect(await result.future, {
      'name': 'Recording',
      'artist': '未知歌手',
      'url': '/music/recording',
      'isLocal': true,
    });
  });

  testWidgets('local file picker cancellation keeps the sheet open', (
    tester,
  ) async {
    final picker = _FilePicker();
    FilePickerPlatform.instance = picker;
    final result = await openSheet(tester);
    await selectTab(tester, 'Local');
    await tester.tap(find.text('Select File'));
    await tester.pumpAndSettle();

    expect(picker.calls, 1);
    expect(find.byType(MusicSelectSheet), findsOneWidget);
    expect(result.isCompleted, isFalse);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(await result.future, isNull);
  });

  testWidgets('local file picker failure shows feedback and keeps the sheet', (
    tester,
  ) async {
    final picker = _FilePicker()..error = StateError('picker unavailable');
    FilePickerPlatform.instance = picker;
    final result = await openSheet(tester);
    await selectTab(tester, 'Local');
    await tester.tap(find.text('Select File'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed to select file'), findsOneWidget);
    expect(find.byType(MusicSelectSheet), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(await result.future, isNull);
  });
}
