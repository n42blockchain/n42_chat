import 'dart:async';
import 'package:n42_chat/src/domain/entities/recovered_composer_text.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_darwin/file_picker_darwin.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:n42_chat/src/data/services/scheduled_draft_operation.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/domain/entities/scheduled_recovery_copy.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/pages/chat/scheduled_messages_page.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Prefs extends Mock implements PreferencesDataSource {}

class _Messages extends Mock implements IMessageRepository {}

class _Bloc extends Mock implements ChatBloc {}

void main() {
  late _Prefs prefs;
  late _Messages messages;
  late _Auth auth;
  late _Client client;
  AuthSessionInvalidation generation() => AuthSessionInvalidation(
    userId: '@me:test',
    homeserver: Uri.parse('https://test'),
    deviceId: null,
    isCurrent: () => true,
    matchesClient: (candidate) => identical(candidate, client),
  );
  setUpAll(
    () {
      registerFallbackValue(const CancelScheduledMessage('fallback'));
      registerFallbackValue(() => false);
      registerFallbackValue(Uint8List(0));
    },
  );
  setUp(() async {
    await getIt.reset();
    prefs = _Prefs();
    auth = _Auth();
    client = _Client();
    final manager = _Manager();
    when(() => manager.client).thenReturn(client);
    when(client.isLogged).thenReturn(true);
    when(() => client.userID).thenReturn('@me:test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.accessToken).thenReturn('test-token');
    when(() => auth.currentAccountGeneration).thenReturn(generation());
    when(() => auth.loginStateStream).thenAnswer((_) => const Stream.empty());
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    messages = _Messages();
    getIt.registerSingleton<IMessageRepository>(messages);
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@me:test');
    getIt.registerSingleton<PreferencesDataSource>(prefs);
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test'))
        .thenAnswer(
          (_) async => [
            ScheduledMessageDraft(
              messageId: 'draft',
              text: 'Keep until confirmed',
              type: MessageType.text,
              scheduledAt: DateTime(2030),
              createdAt: DateTime(2026),
            ),
          ],
        );
  });
  tearDown(() async => getIt.reset());
  Future<void> pump(
    WidgetTester tester, {
    void Function(RecoveredComposerText?)? onRecovered,
    ChatBloc? bloc,
    Locale? locale,
    double scale = 1,
    bool use24Hours = false,
    Future<void> Function(Uint8List)? exporter,
    Future<Uint8List?> Function()? picker,
  }) async {
    final page = ScheduledMessagesPage(roomId: 'room', roomName: 'Room', recoveryExporter: exporter, recoveryFilePicker: picker);
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(scale),
            alwaysUse24HourFormat: use24Hours,
          ),
          child: child!,
        ),
        home: onRecovered != null
            ? Builder(builder: (context) => TextButton(onPressed: () async {
                final result = await Navigator.of(context).push<RecoveredComposerText>(MaterialPageRoute(builder: (_) => page));
                onRecovered(result);
              }, child: const Text('Open queue')))
            : bloc == null
            ? page
            : BlocProvider<ChatBloc>.value(value: bloc, child: page),
      ),
    );
    await tester.pumpAndSettle();
    if (onRecovered != null) {
      await tester.tap(find.text('Open queue'));
      await tester.pumpAndSettle();
    }
  }

  Uint8List portable({String owner = '@me:test'}) {
    const raw = '{broken portable queue';
    return ScheduledRecoveryCopy(id: sha256.convert(utf8.encode(raw)).toString(),
      raw: raw, isIntact: true).exportBytes(owner);
  }
  for (final scenario in ['confirm', 'cancel', 'picker cancelled', 'foreign', 'malformed', 'write fails', 'account changes']) {
    testWidgets('recovery import: $scenario', (tester) async {
      var writes = 0;
      when(() => prefs.importScheduledRecoveryCopy(bytes: any(named: 'bytes'),
        ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((call) async {
          writes++;
          expect((call.namedArguments[#isCurrent] as bool Function())(), isTrue);
          if (scenario == 'write fails') throw StateError('disk');
          return ScheduledRecoveryCopy.fromExportBytes(call.namedArguments[#bytes] as Uint8List, ownerUserId: '@me:test');
        });
      await pump(tester, picker: () async {
        if (scenario == 'picker cancelled') return null;
        if (scenario == 'account changes') when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@other:test');
        if (scenario == 'malformed') return Uint8List.fromList([255]);
        return portable(owner: scenario == 'foreign' ? '@other:test' : '@me:test');
      });
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-import')));
      await tester.pumpAndSettle();
      final confirm = find.byKey(const ValueKey('scheduled-recovery-import-confirm'));
      if (['confirm','cancel','write fails'].contains(scenario)) {
        expect(confirm, findsOneWidget);
        expect(find.text('{broken portable queue'), findsOneWidget);
        expect(writes, 0);
        if (scenario == 'cancel') {
          await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Cancel')));
        } else {
          await tester.tap(confirm);
        }
        await tester.pumpAndSettle();
      } else {
        expect(confirm, findsNothing);
      }
      expect(writes, ['confirm','write fails'].contains(scenario) ? 1 : 0);
      if (scenario == 'confirm') expect(find.byKey(const ValueKey('scheduled-recovery-export')), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
    });
  }
  for (final scenario in ['file', 'cancel', 'missing', 'oversized metadata', 'understated size']) {
    testWidgets('real recovery file adapter: $scenario', (tester) async {
      final oldPicker = FilePickerPlatform.instance;
      FilePickerDarwin.registerWith();
      final directory = Directory.systemTemp.createTempSync('n42-recovery-fixture-');
      final file = File('${directory.path}/recovery.json');
      if (scenario == 'understated size') {
        final handle = file.openSync(mode: FileMode.write);
        handle.truncateSync(ScheduledRecoveryCopy.maxImportBytes + 1);
        handle.closeSync();
      } else if (scenario != 'missing') {
        file.writeAsBytesSync(portable());
      }
      const channel = MethodChannel('miguelruivo.flutter.plugins.filepicker');
      final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      var calls = 0;
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls++;
        expect(call.method, 'custom');
        expect(call.arguments['allowMultipleSelection'], false);
        expect(call.arguments['allowedExtensions'], ['json']);
        if (scenario == 'cancel') return null;
        return [{'path': file.path, 'name': 'recovery.json',
          'size': scenario == 'oversized metadata' ? ScheduledRecoveryCopy.maxImportBytes + 1 : 1}];
      });
      addTearDown(() {
        FilePickerPlatform.instance = oldPicker;
        messenger.setMockMethodCallHandler(channel, null);
        directory.deleteSync(recursive: true);
      });
      await pump(tester);
      await tester.runAsync(() async {
        await tester.tap(find.byKey(const ValueKey('scheduled-recovery-import')));
        // Native filesystem streams need the real event loop. Wait for the
        // import control to re-enable or the confirmation route to be queued.
        for (var i = 0; i < 100; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 10));
          await tester.pump();
          if (find.byKey(const ValueKey('scheduled-recovery-import-confirm')).evaluate().isNotEmpty ||
              tester.widget<IconButton>(find.byKey(const ValueKey('scheduled-recovery-import'))).onPressed != null) {
            break;
          }
        }
      });
      await tester.pumpAndSettle();
      expect(calls, 1);
      expect(find.byKey(const ValueKey('scheduled-recovery-import-confirm')),
        scenario == 'file' ? findsOneWidget : findsNothing);
      if (scenario == 'file') expect(find.text('{broken portable queue'), findsOneWidget);
      if (!['file','cancel'].contains(scenario)) expect(find.text('Failed to save'), findsOneWidget);
      verifyNever(() => prefs.importScheduledRecoveryCopy(bytes: any(named: 'bytes'),
        ownerUserId: any(named: 'ownerUserId'), isCurrent: any(named: 'isCurrent')));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
    });
  }
  testWidgets('import preview fits narrow RTL large-text layout', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pump(tester, locale: const Locale('ar'), scale: 2, picker: () async => portable());
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-import')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('scheduled-recovery-import-confirm')), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
  testWidgets('account change during import confirmation cannot write', (tester) async {
    await pump(tester, picker: () async => portable());
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-import')));
    await tester.pumpAndSettle();
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@other:test');
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-import-confirm')));
    await tester.pumpAndSettle();
    verifyNever(() => prefs.importScheduledRecoveryCopy(bytes: any(named: 'bytes'),
      ownerUserId: any(named: 'ownerUserId'), isCurrent: any(named: 'isCurrent')));
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets('persisted unconfirmed status remains visible after reopening', (tester) async {
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenAnswer((_) async => [
      ScheduledMessageDraft(messageId: 'failed', text: 'Retained draft', type: MessageType.text,
        scheduledAt: DateTime(2020), createdAt: DateTime(2019), deliveryUnconfirmed: true, retryAt: DateTime(2030)),
    ]);
    await pump(tester);
    expect(find.text('Delivery not confirmed'), findsOneWidget);
    expect(find.text('Retained draft'), findsOneWidget);
    expect(find.textContaining('Retry:'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await pump(tester);
    expect(find.text('Delivery not confirmed'), findsOneWidget);
  });

  testWidgets('accepted drafts show sent and cannot be cancelled', (tester) async {
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenAnswer((_) async => [
      ScheduledMessageDraft(messageId: 'accepted', text: 'Accepted', type: MessageType.text,
        scheduledAt: DateTime(2020), createdAt: DateTime(2019), acceptedEventId: r'$event', deliveryUnconfirmed: true),
    ]);
    await pump(tester);
    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('Delivery not confirmed'), findsNothing);
    final cancel = tester.widget<TextButton>(find.widgetWithText(TextButton, 'Cancel'));
    expect(cancel.onPressed, isNull);
  });

  for (final language in ['en', 'ar']) {
    for (final confirm in [false, true]) {
      testWidgets('corrupt reset requires explicit confirmation $language confirm=$confirm', (tester) async {
        var reset = false;
        when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenAnswer((_) async {
          if (!reset) throw const FormatException('damaged');
          return [];
        });
        when(() => prefs.saveScheduledRecoveryCopy(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => '{original damaged bytes');
        when(() => prefs.resetCorruptScheduledMessages(ownerUserId: '@me:test', expectedRaw: '{original damaged bytes', isCurrent: any(named: 'isCurrent'))).thenAnswer((call) async {
          expect((call.namedArguments[#isCurrent] as bool Function())(), true);
          reset = true;
        });
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await pump(tester, locale: Locale(language), scale: 2);
        final strings = S.of(tester.element(find.byType(ScheduledMessagesPage)))!;
        final resetButton = find.byKey(const ValueKey('scheduled-recovery-reset'));
        await tester.ensureVisible(resetButton);
        await tester.pumpAndSettle();
        await tester.tap(resetButton);
        await tester.pumpAndSettle();
        expect(reset, false);
        expect(find.text(strings.scheduledRecoveryResetHint), findsOneWidget);
        await tester.tap(confirm ? find.byKey(const ValueKey('scheduled-recovery-reset-confirm')) : find.text(strings.commonCancel));
        await tester.pumpAndSettle();
        expect(reset, confirm);
        expect(find.text(strings.scheduledMessagesEmpty), confirm ? findsOneWidget : findsNothing);
        expect(tester.takeException(), isNull);
      });
    }
  }
  for (final failedCopy in [false, true]) {
    testWidgets('reset never mutates on ${failedCopy ? 'copy failure' : 'account change during confirmation'}', (tester) async {
      when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenThrow(const FormatException('damaged'));
      when(() => prefs.saveScheduledRecoveryCopy(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async {
        if (failedCopy) throw StateError('disk');
        return '{damaged';
      });
      await pump(tester);
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-reset')));
      await tester.pumpAndSettle();
      if (!failedCopy) {
        when(() => auth.currentAccountGeneration).thenReturn(null);
        await tester.tap(find.byKey(const ValueKey('scheduled-recovery-reset-confirm')));
        await tester.pumpAndSettle();
      }
      verifyNever(() => prefs.resetCorruptScheduledMessages(ownerUserId: any(named: 'ownerUserId'), expectedRaw: any(named: 'expectedRaw'), isCurrent: any(named: 'isCurrent')));
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final language in ['en', 'ar']) {
    testWidgets('recovery history reopens saved content on healthy page: $language', (tester) async {
      final events = StreamController<bool>.broadcast(sync: true);
      addTearDown(events.close);
      when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
      when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => const [
        ScheduledRecoveryCopy(id: 'good', raw: 'saved previous draft', isIntact: true),
        ScheduledRecoveryCopy(id: 'bad', raw: 'damaged copy bytes', isIntact: false),
      ]);
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pump(tester, locale: Locale(language), scale: 2);
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsOneWidget);
      final scroll = find.descendant(of: find.byType(Dialog), matching: find.byType(Scrollable));
      final bad = find.byKey(const ValueKey('scheduled-recovery-bad'));
      await tester.scrollUntilVisible(bad, 80, scrollable: scroll);
      expect(tester.widget<ListTile>(bad).onTap, isNull);
      expect(find.text('damaged copy bytes'), findsNothing);
      final good = find.byKey(const ValueKey('scheduled-recovery-good'));
      await tester.scrollUntilVisible(good, -80, scrollable: scroll);
      await tester.pumpAndSettle();
      await tester.tap(good);
      await tester.pumpAndSettle();
      expect(find.byType(SelectableText), findsOneWidget);
      expect(tester.widget<SelectableText>(find.byType(SelectableText)).data, 'saved previous draft');
      when(() => auth.currentAccountGeneration).thenReturn(null);
      events.add(false);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('logout dismisses the history list before any copy is selected', (tester) async {
    final events = StreamController<bool>.broadcast(sync: true);
    addTearDown(events.close);
    when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => const [ScheduledRecoveryCopy(id: 'one', raw: 'private history', isIntact: true)]);
    await pump(tester);
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
    await tester.pumpAndSettle();
    expect(find.text('private history'), findsOneWidget);
    when(() => auth.currentAccountGeneration).thenReturn(null);
    events.add(false);
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
    expect(find.text('private history'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('failed history read unlocks retry without showing content', (tester) async {
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenThrow(StateError('unavailable'));
    await pump(tester);
    final button = find.byKey(const ValueKey('scheduled-recovery-history'));
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
    expect(tester.widget<IconButton>(button).onPressed, isNotNull);
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => []);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('No backups yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('history read arriving after account switch is hidden', (tester) async {
    final read = Completer<List<ScheduledRecoveryCopy>>();
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) => read.future);
    await pump(tester);
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
    await tester.pump();
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@b:test');
    read.complete(const [ScheduledRecoveryCopy(id: 'private', raw: 'private copy', isIntact: true)]);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('private copy'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  for (final action in ['confirm', 'cancel', 'logout', 'failure']) {
    testWidgets('copy deletion requires confirmation: $action', (tester) async {
      final events = StreamController<bool>.broadcast(sync: true);
      addTearDown(events.close);
      when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
      when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => const [ScheduledRecoveryCopy(id: 'one', raw: 'reviewed copy', isIntact: true)]);
      when(() => prefs.deleteScheduledRecoveryCopy(ownerUserId: '@me:test', expectedRaw: 'reviewed copy', isCurrent: any(named: 'isCurrent'))).thenAnswer((invocation) async {
        expect((invocation.namedArguments[#isCurrent] as bool Function())(), isTrue);
        if (action == 'failure') throw StateError('storage unavailable');
      });
      await pump(tester);
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-one')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-delete')));
      await tester.pumpAndSettle();
      verifyNever(() => prefs.deleteScheduledRecoveryCopy(ownerUserId: any(named: 'ownerUserId'), expectedRaw: any(named: 'expectedRaw'), isCurrent: any(named: 'isCurrent')));
      if (action == 'logout') {
        when(() => auth.currentAccountGeneration).thenReturn(null);
        events.add(false);
      } else if (action == 'cancel') {
        await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Cancel')));
      } else {
        await tester.tap(find.byKey(const ValueKey('scheduled-recovery-delete-confirm')));
      }
      await tester.pumpAndSettle();
      if (action == 'confirm' || action == 'failure') {
        verify(() => prefs.deleteScheduledRecoveryCopy(ownerUserId: '@me:test', expectedRaw: 'reviewed copy', isCurrent: any(named: 'isCurrent'))).called(1);
      } else {
        verifyNever(() => prefs.deleteScheduledRecoveryCopy(ownerUserId: any(named: 'ownerUserId'), expectedRaw: any(named: 'expectedRaw'), isCurrent: any(named: 'isCurrent')));
      }
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final action in ['confirm', 'cancel', 'logout', 'removed', 'changed', 'lateLogout', 'failure', 'arabic']) {
    testWidgets('recovery export protects reviewed content: $action', (tester) async {
      final events = StreamController<bool>.broadcast(sync: true);
      addTearDown(events.close);
      when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
      final raw = 'private draft ${'😀' * 9000}';
      final id = sha256.convert(utf8.encode(raw)).toString();
      final copy = ScheduledRecoveryCopy(id: id, raw: raw, isIntact: true);
      var reads = 0;
      final pending = Completer<List<ScheduledRecoveryCopy>>();
      when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async {
        reads++;
        if (reads > 1) {
          if (action == 'removed') return [];
          if (action == 'changed') return [ScheduledRecoveryCopy(id: id, raw: 'changed', isIntact: true)];
          if (action == 'lateLogout') return pending.future;
        }
        return [copy];
      });
      Uint8List? exported;
      var exports = 0;
      if (action == 'arabic') {
        await tester.binding.setSurfaceSize(const Size(320, 480));
        addTearDown(() => tester.binding.setSurfaceSize(null));
      }
      await pump(tester, locale: action == 'arabic' ? const Locale('ar') : null, scale: action == 'arabic' ? 2 : 1, exporter: (bytes) async {
        exports++;
        if (action == 'failure') throw StateError('sharing unavailable');
        exported = bytes;
      });
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey('scheduled-recovery-$id')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-export')));
      await tester.pumpAndSettle();
      expect(exports, 0);
      expect(find.textContaining(action == 'arabic' ? 'غير مشفرة' : 'unencrypted draft'), findsOneWidget);
      if (action == 'cancel') {
        await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Cancel')));
      } else if (action == 'logout') {
        when(() => auth.currentAccountGeneration).thenReturn(null);
        events.add(false);
      } else {
        await tester.tap(find.byKey(const ValueKey('scheduled-recovery-export-confirm')));
      }
      await tester.pumpAndSettle();
      if (action == 'lateLogout') {
        expect(reads, 2);
        when(() => auth.currentAccountGeneration).thenReturn(null);
        events.add(false);
        pending.complete([copy]);
        await tester.pumpAndSettle();
      }
      expect(exports, action == 'confirm' || action == 'failure' || action == 'arabic' ? 1 : 0);
      if (action == 'confirm') {
        final data = jsonDecode(utf8.decode(exported!)) as Map<String, dynamic>;
        expect(data['raw'], raw);
        expect(data['ownerUserId'], '@me:test');
        expect(data['sha256'], id);
        expect(data['attachmentsIncluded'], false);
      }
      verifyNever(() => prefs.deleteScheduledRecoveryCopy(ownerUserId: any(named: 'ownerUserId'), expectedRaw: any(named: 'expectedRaw'), isCurrent: any(named: 'isCurrent')));
      expect(tester.takeException(), isNull);
    });
  }

  for (final scenario in ['confirm', 'cancel', 'copy changed', 'account changed']) {
    testWidgets('reviewed composer recovery $scenario', (tester) async {
      final raw = jsonEncode({'room': [
        ScheduledMessageDraft(messageId: 'one', text: 'Recovered text', type: MessageType.text,
          scheduledAt: DateTime(2030), createdAt: DateTime(2026)).toJson(),
        {'messageId': 'broken'},
        ScheduledMessageDraft(messageId: 'image', text: 'Photo', type: MessageType.image,
          scheduledAt: DateTime(2030), createdAt: DateTime(2026)).toJson(),
      ], 'elsewhere': [ScheduledMessageDraft(messageId: 'foreign', text: 'Other room', type: MessageType.text,
          scheduledAt: DateTime(2030), createdAt: DateTime(2026)).toJson()]});
      final copy = ScheduledRecoveryCopy(id: sha256.convert(utf8.encode(raw)).toString(), raw: raw, isIntact: true);
      var available = true;
      when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent')))
        .thenAnswer((_) async => available ? [copy] : []);
      RecoveredComposerText? result;
      await pump(tester, onRecovered: (value) => result = value);
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey('scheduled-recovery-${copy.id}')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-inspect')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('scheduled-recovery-edit-0')), findsOneWidget);
      for (final i in [1, 2, 3]) {
        expect(find.byKey(ValueKey('scheduled-recovery-edit-$i')), findsNothing);
      }
      await tester.tap(find.byKey(const ValueKey('scheduled-recovery-edit-0')));
      await tester.pumpAndSettle();
      expect(result, isNull);
      if (scenario == 'copy changed') available = false;
      if (scenario == 'account changed') {
        when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@other:test');
      }
      await tester.tap(scenario == 'cancel' ? find.descendant(of: find.byType(AlertDialog), matching: find.text('Cancel')) : find.byKey(const ValueKey('scheduled-recovery-composer-confirm')));
      await tester.pumpAndSettle();
      if (scenario == 'confirm') {
        expect(result?.text, 'Recovered text');
        expect(result?.ownerUserId, '@me:test');
        expect(result?.roomId, 'room');
        expect(find.text('Open queue'), findsOneWidget);
      } else {
        expect(result, isNull);
      }
      verifyNever(() => prefs.importScheduledRecoveryCopy(bytes: any(named: 'bytes'),
        ownerUserId: any(named: 'ownerUserId'), isCurrent: any(named: 'isCurrent')));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('recovery details isolate malformed siblings and dismiss on logout', (tester) async {
    final events = StreamController<bool>.broadcast(sync: true);
    addTearDown(events.close);
    when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
    final raw = jsonEncode({'room':[
      ScheduledMessageDraft(messageId:'one', text:'Recover this text', type:MessageType.text,
        scheduledAt:DateTime(2030), createdAt:DateTime(2026)).toJson(),
      {'messageId':'broken'},
    ]});
    final copy=ScheduledRecoveryCopy(id:sha256.convert(utf8.encode(raw)).toString(),raw:raw,isIntact:true);
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId:'@me:test',isCurrent:any(named:'isCurrent')))
      .thenAnswer((_) async => [copy]);
    await pump(tester);
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('scheduled-recovery-${copy.id}')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-inspect')));
    await tester.pumpAndSettle();
    expect(find.text('Recover this text'),findsOneWidget);
    expect(find.byKey(const ValueKey('scheduled-recovery-entry-1')),findsOneWidget);
    expect(find.text('Failed to load'),findsOneWidget);
    verifyNever(() => prefs.importScheduledRecoveryCopy(bytes:any(named:'bytes'),
      ownerUserId:any(named:'ownerUserId'),isCurrent:any(named:'isCurrent')));
    when(() => auth.currentAccountGeneration).thenReturn(null);
    events.add(false);
    await tester.pumpAndSettle();
    expect(find.text('Recover this text'),findsNothing);
    expect(tester.takeException(),isNull);
  });
  testWidgets('empty recovery history does not create a backup', (tester) async {
    when(() => prefs.getScheduledRecoveryCopies(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => []);
    await pump(tester);
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-history')));
    await tester.pumpAndSettle();
    expect(find.text('No backups yet'), findsOneWidget);
    verifyNever(() => prefs.saveScheduledRecoveryCopy(ownerUserId: any(named: 'ownerUserId'), isCurrent: any(named: 'isCurrent')));
    expect(tester.takeException(), isNull);
  });

  testWidgets('late recovery copy never exposes the previous account', (tester) async {
    final pending = Completer<String?>();
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenThrow(const FormatException('damaged'));
    when(() => prefs.saveScheduledRecoveryCopy(ownerUserId: '@me:test', isCurrent: any(named: 'isCurrent'))).thenAnswer((_) => pending.future);
    await pump(tester);
    await tester.tap(find.byKey(const ValueKey('scheduled-recovery-copy')));
    await tester.pump();
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@b:test');
    pending.complete('private previous account copy');
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('private previous account copy'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final language in ['en', 'ar']) {
    testWidgets(
      'recovery copy opens a bounded preview and closes on logout: $language',
      (tester) async {
        final events = StreamController<bool>.broadcast(sync: true);
        addTearDown(events.close);
        when(() => auth.loginStateStream).thenAnswer((_) => events.stream);
        when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test'))
            .thenThrow(const FormatException('damaged'));
        when(
          () => prefs.saveScheduledRecoveryCopy(
            ownerUserId: '@me:test',
            isCurrent: any(named: 'isCurrent'),
          ),
        ).thenAnswer((call) async {
          expect((call.namedArguments[#isCurrent] as bool Function())(), true);
          return 'private recovery ${'😀' * 9000}';
        });
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await pump(tester, locale: Locale(language), scale: 2);
        final button = find.byKey(const ValueKey('scheduled-recovery-copy'));
        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        final preview = tester
            .widget<SelectableText>(find.byType(SelectableText))
            .data!;
        expect(preview.startsWith('private recovery'), true);
        expect(preview.runes.length, lessThanOrEqualTo(8001));
        expect(preview.contains('�'), false);
        when(() => auth.currentAccountGeneration).thenReturn(null);
        events.add(false);
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsNothing);
        expect(find.byType(SelectableText), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets('failed recovery copy shows no content and permits retry', (
    tester,
  ) async {
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test'))
        .thenThrow(const FormatException('damaged'));
    when(
      () => prefs.saveScheduledRecoveryCopy(
        ownerUserId: '@me:test',
        isCurrent: any(named: 'isCurrent'),
      ),
    ).thenThrow(StateError('disk'));
    await pump(tester);
    final button = find.byKey(const ValueKey('scheduled-recovery-copy'));
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.widget<TextButton>(button).onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });

  for (final language in ['en', 'ar']) {
    testWidgets(
      'load failure is retryable without a false empty state: $language',
      (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final draft = ScheduledMessageDraft(
          messageId: 'retained',
          text: 'Recovered draft',
          type: MessageType.text,
          scheduledAt: DateTime(2030),
          createdAt: DateTime(2026),
        );
        var attempts = 0;
        when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test'))
            .thenAnswer((_) async {
              if (++attempts == 1) throw StateError('storage unavailable');
              return [draft];
            });
        await pump(tester, locale: Locale(language), scale: 2);
        final strings = S.of(
          tester.element(find.byType(ScheduledMessagesPage)),
        )!;
        expect(find.text(strings.commonLoadFailed), findsOneWidget);
        expect(find.text(strings.scheduledMessagesEmpty), findsNothing);
        await tester.tap(find.text(strings.commonRetry));
        await tester.pumpAndSettle();
        expect(find.text('Recovered draft'), findsOneWidget);
        expect(find.text(strings.commonLoadFailed), findsNothing);
        expect(attempts, 2);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final success in [true, false]) {
    testWidgets('bloc cancellation waits for acknowledgement: $success', (
      tester,
    ) async {
      final bloc = _Bloc();
      when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
      CancelScheduledMessage? event;
      when(() => bloc.add(any())).thenAnswer((invocation) {
        event = invocation.positionalArguments.first as CancelScheduledMessage;
      });
      await pump(tester, bloc: bloc);
      await tester.tap(find.text('Cancel'));
      await tester.pump();
      expect(find.text('Keep until confirmed'), findsOneWidget);
      expect(find.text('Scheduled message cancelled'), findsNothing);
      expect(
        tester.widget<TextButton>(find.byType(TextButton)).onPressed,
        isNull,
      );
      expect(event!.roomId, 'room');
      event!.completion!.complete(success);
      await tester.pumpAndSettle();
      expect(
        find.text('Keep until confirmed'),
        success ? findsNothing : findsOneWidget,
      );
      expect(
        find.text(success ? 'Scheduled message cancelled' : 'Failed to save'),
        findsOneWidget,
      );
      verifyNever(
        () => prefs.removeScheduledMessage(
          any(),
          any(),
          ownerUserId: any(named: 'ownerUserId'),
        ),
      );
    });
  }
  testWidgets('standalone deletion failure preserves draft and permits retry', (
    tester,
  ) async {
    final write = Completer<void>();
    when(
      () => prefs.removeScheduledMessage(
        'room',
        'draft',
        ownerUserId: '@me:test',
      ),
    ).thenAnswer((_) => write.future);
    await pump(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(find.text('Keep until confirmed'), findsOneWidget);
    write.completeError(StateError('disk'));
    await tester.pumpAndSettle();
    expect(find.text('Keep until confirmed'), findsOneWidget);
    expect(find.text('Scheduled message cancelled'), findsNothing);
    when(
      () => prefs.removeScheduledMessage(
        'room',
        'draft',
        ownerUserId: '@me:test',
      ),
    ).thenAnswer((_) async {});
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Keep until confirmed'), findsNothing);
  });
  testWidgets('late account A load is hidden after switching to B', (
    tester,
  ) async {
    final pending = Completer<List<ScheduledMessageDraft>>();
    var owner = '@me:test';
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => owner);
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test'))
        .thenAnswer((_) => pending.future);
    await tester.pumpWidget(
      const MaterialApp(
        home: ScheduledMessagesPage(roomId: 'room', roomName: 'Room'),
      ),
    );
    await tester.pump();
    owner = '@b:test';
    pending.complete([
      ScheduledMessageDraft(
        messageId: 'private',
        type: MessageType.text,
        createdAt: DateTime(2026),
        text: 'A private draft',
        scheduledAt: DateTime(2030),
      ),
    ]);
    await tester.pumpAndSettle();
    expect(find.text('A private draft'), findsNothing);
  });

  testWidgets('stale page cannot cancel previous account draft', (
    tester,
  ) async {
    await pump(tester);
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => '@b:test');
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@b:test'))
        .thenAnswer((_) async => []);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(
      () => prefs.removeScheduledMessage(
        any(),
        any(),
        ownerUserId: any(named: 'ownerUserId'),
      ),
    );
    expect(find.text('Keep until confirmed'), findsNothing);
    expect(find.text('Scheduled message cancelled'), findsNothing);
  });

  testWidgets('logged-out page never reads unattributed legacy drafts', (
    tester,
  ) async {
    when(() => messages.getCurrentUserId()).thenAnswer((_) async => null);
    await pump(tester);
    verifyNever(
      () => prefs.getScheduledMessages(
        any(),
        ownerUserId: any(named: 'ownerUserId'),
      ),
    );
  });
  testWidgets('same-account relogin invalidates old cancellation controls', (
    tester,
  ) async {
    await pump(tester);
    when(() => auth.currentAccountGeneration).thenReturn(generation());
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(
      () => prefs.removeScheduledMessage(
        any(),
        any(),
        ownerUserId: any(named: 'ownerUserId'),
      ),
    );
    expect(find.text('Keep until confirmed'), findsNothing);
    expect(find.text('Scheduled message cancelled'), findsNothing);
  });
  for (final language in ['en', 'zh', 'de', 'ar']) {
    testWidgets(
      'localized narrow large-text draft and cancellation: $language',
      (tester) async {
        tester.view.physicalSize = const Size(320, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        when(
          () => prefs.removeScheduledMessage(
            'room',
            'draft',
            ownerUserId: '@me:test',
          ),
        ).thenAnswer((_) async {});
        await pump(
          tester,
          locale: Locale(language),
          scale: 2,
          use24Hours: true,
        );
        final context = tester.element(find.byType(ScheduledMessagesPage));
        final l10n = S.of(context)!;
        expect(find.text(l10n.scheduledMessagesTitle), findsOneWidget);
        expect(find.text(l10n.searchMessageLabel), findsOneWidget);
        expect(find.textContaining('00:00'), findsWidgets);
        expect(
          Directionality.of(context),
          language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        );
        expect(tester.takeException(), isNull);
        await tester.tap(find.text(l10n.commonCancel));
        await tester.pumpAndSettle();
        expect(find.text(l10n.scheduledMessageCancelled), findsOneWidget);
        expect(find.text(l10n.scheduledMessagesEmpty), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text(l10n.scheduledMessagesHint),
          100,
        );
        expect(find.text(l10n.scheduledMessagesHint), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('English clock honors 12-hour preference', (tester) async {
    await pump(tester, locale: const Locale('en'));
    expect(find.textContaining('12:00 AM'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('standalone cancellation rechecks shared acceptance after rendering', (tester) async {
    await pump(tester);
    final sending = ScheduledDraftOperation.tryAcquire(ownerUserId: '@me:test', roomId: 'room', messageId: 'draft')!;
    sending.rememberAcceptance('shared-event');
    sending.release();
    addTearDown(() {
      final cleanup = ScheduledDraftOperation.tryAcquire(ownerUserId: '@me:test', roomId: 'room', messageId: 'draft')!;
      cleanup.confirmCleanup();
      cleanup.release();
    });
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Scheduled message cancelled'), findsNothing);
    expect(find.text('Sent'), findsOneWidget);
    expect(tester.widget<TextButton>(find.widgetWithText(TextButton, 'Cancel')).onPressed, isNull);
    verifyNever(() => prefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
    await tester.pumpWidget(const SizedBox());
    await pump(tester);
    expect(find.text('Sent'), findsOneWidget);
  });

  testWidgets('standalone cancellation cannot race an active sender', (tester) async {
    final sending = ScheduledDraftOperation.tryAcquire(ownerUserId: '@me:test', roomId: 'room', messageId: 'draft')!;
    addTearDown(sending.release);
    await pump(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Keep until confirmed'), findsOneWidget);
    expect(find.text('Scheduled message cancelled'), findsNothing);
    verifyNever(() => prefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
    sending.release();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    when(() => prefs.removeScheduledMessage('room', 'draft', ownerUserId: '@me:test')).thenAnswer((_) async {});
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Scheduled message cancelled'), findsOneWidget);
  });

  testWidgets('stale draft already removed by a sender is not cancelled again', (tester) async {
    await pump(tester);
    when(() => prefs.getScheduledMessages('room', ownerUserId: '@me:test')).thenAnswer((_) async => []);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(() => prefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
    expect(find.text('Scheduled message cancelled'), findsNothing);
    expect(find.text('Keep until confirmed'), findsNothing);
  });

  testWidgets('late cancellation rejection after leaving the page is ignored', (tester) async {
    final bloc = _Bloc();
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
    CancelScheduledMessage? event;
    when(() => bloc.add(any())).thenAnswer((invocation) {
      event = invocation.positionalArguments.first as CancelScheduledMessage;
    });
    await pump(tester, bloc: bloc);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    event!.completion!.complete(false);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

}
