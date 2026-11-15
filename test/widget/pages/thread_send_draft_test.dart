import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/pages/chat/thread_detail_page.dart';

class _Repo extends Mock implements IMessageRepository {}

void main() {
  MessageEntity message(String id) => MessageEntity(
    id: id,
    roomId: '!room',
    senderId: '@a',
    senderName: 'A',
    content: id,
    timestamp: DateTime(2026),
    type: MessageType.text,
  );
  for (final scenario in ['failure', 'success', 'edited']) {
    testWidgets('thread composer preserves draft: $scenario', (tester) async {
      final repo = _Repo();
      await getIt.reset();
      getIt.registerSingleton<IMessageRepository>(repo);
      addTearDown(() => getIt.reset());
      when(() => repo.getThreadMessages(any(), any()))
          .thenAnswer((_) async => [message('root')]);
      when(() => repo.watchThreadMessages(any(), any()))
          .thenAnswer((_) => const Stream.empty());
      final pending = Completer<MessageEntity?>();
      when(() => repo.sendThreadTextMessage(any(), any(), any()))
          .thenAnswer((_) => pending.future);
      await tester.pumpWidget(
        const MaterialApp(
          home: ThreadDetailPage(roomId: '!room', threadRootEventId: 'root'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'draft');
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pump();
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'draft',
      );
      await tester.testTextInput.receiveAction(TextInputAction.send);
      if (scenario == 'edited')
        await tester.enterText(find.byType(TextField), 'new draft');
      pending.complete(scenario == 'failure' ? null : message('accepted'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        scenario == 'failure'
            ? 'draft'
            : scenario == 'edited'
            ? 'new draft'
            : '',
      );
      if (scenario == 'failure')
        expect(find.textContaining('not acknowledged'), findsOneWidget);
      verify(() => repo.sendThreadTextMessage('!room', 'root', 'draft'))
          .called(1);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
