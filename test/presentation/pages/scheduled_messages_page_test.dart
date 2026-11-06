import 'dart:async';

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
    ChatBloc? bloc,
    Locale? locale,
    double scale = 1,
    bool use24Hours = false,
  }) async {
    const page = ScheduledMessagesPage(roomId: 'room', roomName: 'Room');
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
        home: bloc == null
            ? page
            : BlocProvider<ChatBloc>.value(value: bloc, child: page),
      ),
    );
    await tester.pumpAndSettle();
  }

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
