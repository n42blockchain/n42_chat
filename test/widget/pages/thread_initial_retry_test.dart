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
  testWidgets(
    'failed initial load can retry without losing or sending the draft',
    (tester) async {
      final repo = _Repo();
      final updates = StreamController<List<MessageEntity>>();
      await getIt.reset();
      getIt.registerSingleton<IMessageRepository>(repo);
      addTearDown(() async {
        unawaited(updates.close());
        await getIt.reset();
      });
      when(() => repo.getThreadMessages(any(), any()))
          .thenThrow(StateError('offline'));
      when(() => repo.watchThreadMessages(any(), any()))
          .thenAnswer((_) => updates.stream);
      await tester.pumpWidget(
        const MaterialApp(
          home: ThreadDetailPage(roomId: '!room', threadRootEventId: 'root'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'keep this draft');
      final retry = find.byKey(const ValueKey('thread-retry-initialization'));
      expect(retry, findsOneWidget);
      await tester.tap(retry);
      await tester.pumpAndSettle();
      expect(retry, findsOneWidget);
      expect(find.text('keep this draft'), findsOneWidget);
      MessageEntity message(String id) => MessageEntity(
        id: id,
        roomId: '!room',
        senderId: '@a',
        senderName: 'A',
        content: id,
        timestamp: DateTime(2026),
        type: MessageType.text,
      );
      final pending = Completer<List<MessageEntity>>();
      when(() => repo.getThreadMessages(any(), any()))
          .thenAnswer((_) => pending.future);
      await tester.tap(retry);
      await tester.pump();
      expect(retry, findsNothing);
      pending.complete([message('root'), message('loaded reply')]);
      await tester.pumpAndSettle();
      expect(find.textContaining('offline'), findsNothing);
      expect(find.text('loaded reply'), findsOneWidget);
      expect(find.text('keep this draft'), findsOneWidget);
      updates.add([message('live reply')]);
      await tester.pumpAndSettle();
      expect(find.text('live reply'), findsOneWidget);
      verify(() => repo.watchThreadMessages('!room', 'root')).called(1);
      verifyNever(() => repo.sendThreadTextMessage(any(), any(), any()));
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
