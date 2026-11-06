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
    () => registerFallbackValue(const CancelScheduledMessage('fallback')),
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
