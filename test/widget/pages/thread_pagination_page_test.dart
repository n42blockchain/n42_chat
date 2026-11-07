import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/domain/repositories/thread_pagination_repository.dart';
import 'package:n42_chat/src/presentation/pages/chat/thread_detail_page.dart';

class _Repo extends Mock
    implements IMessageRepository, IThreadPaginationRepository {}

void main() {
  testWidgets(
    'empty and short thread pages remain navigable until token exhaustion',
    (tester) async {
      final repo = _Repo();
      await getIt.reset();
      getIt.registerSingleton<IMessageRepository>(repo);
      addTearDown(() => getIt.reset());
      when(() => repo.watchMessage(any(), any()))
          .thenAnswer((_) => Stream.value(null));
      when(() => repo.watchThreadMessages(any(), any()))
          .thenAnswer((_) => const Stream.empty());
      final tokens = <String?>[];
      when(
        () => repo.getThreadMessagePage(
          any(),
          any(),
          fromToken: any(named: 'fromToken'),
        ),
      ).thenAnswer((call) async {
        final token = call.namedArguments[#fromToken] as String?;
        tokens.add(token);
        return switch (token) {
          null => const ThreadMessagePage(nextBatch: 'after-empty'),
          'after-empty' => ThreadMessagePage(
            messages: [
              MessageEntity(
                id: 'one',
                roomId: '!room',
                senderId: '@a',
                senderName: 'A',
                content: 'older reply',
                timestamp: DateTime(2026),
                type: MessageType.text,
              ),
            ],
            nextBatch: 'after-short',
          ),
          _ => const ThreadMessagePage(),
        };
      });
      await tester.pumpWidget(
        const MaterialApp(
          home: ThreadDetailPage(roomId: '!room', threadRootEventId: 'root'),
        ),
      );
      await tester.pumpAndSettle();
      final button = find.byKey(const ValueKey('thread-load-more'));
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text('older reply'), findsOneWidget);
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(button, findsNothing);
      expect(find.text('older reply'), findsOneWidget);
      expect(tokens, [null, 'after-empty', 'after-short']);
      verifyNever(() => repo.getThreadMessages(any(), any()));
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
