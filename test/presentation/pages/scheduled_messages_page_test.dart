import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/pages/chat/scheduled_messages_page.dart';

class _Prefs extends Mock implements PreferencesDataSource {}

class _Messages extends Mock implements IMessageRepository {}

class _Bloc extends Mock implements ChatBloc {}

void main() {
  late _Prefs prefs;
  late _Messages messages;
  setUpAll(
    () => registerFallbackValue(const CancelScheduledMessage('fallback')),
  );
  setUp(() async {
    await getIt.reset();
    prefs = _Prefs();
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
  Future<void> pump(WidgetTester tester, {ChatBloc? bloc}) async {
    const page = ScheduledMessagesPage(roomId: 'room', roomName: 'Room');
    await tester.pumpWidget(
      MaterialApp(
        home: bloc == null
            ? page
            : BlocProvider<ChatBloc>.value(value: bloc, child: page),
      ),
    );
    await tester.pumpAndSettle();
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
        messageId: 'private', type: MessageType.text, createdAt: DateTime(2026),
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
}
