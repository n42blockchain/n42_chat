import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/pages/chat/scheduled_messages_page.dart';

class _Prefs extends Mock implements PreferencesDataSource {}

class _Bloc extends Mock implements ChatBloc {}

void main() {
  late _Prefs prefs;
  setUpAll(
    () => registerFallbackValue(const CancelScheduledMessage('fallback')),
  );
  setUp(() async {
    await getIt.reset();
    prefs = _Prefs();
    getIt.registerSingleton<PreferencesDataSource>(prefs);
    when(() => prefs.getScheduledMessages('room')).thenAnswer(
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
      verifyNever(() => prefs.removeScheduledMessage(any(), any()));
    });
  }
  testWidgets('standalone deletion failure preserves draft and permits retry', (
    tester,
  ) async {
    final write = Completer<void>();
    when(() => prefs.removeScheduledMessage('room', 'draft'))
        .thenAnswer((_) => write.future);
    await pump(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(find.text('Keep until confirmed'), findsOneWidget);
    write.completeError(StateError('disk'));
    await tester.pumpAndSettle();
    expect(find.text('Keep until confirmed'), findsOneWidget);
    expect(find.text('Scheduled message cancelled'), findsNothing);
    when(() => prefs.removeScheduledMessage('room', 'draft'))
        .thenAnswer((_) async {});
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Keep until confirmed'), findsNothing);
  });
}
