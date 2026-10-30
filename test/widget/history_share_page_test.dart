import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/chat_catch_up_repository.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/presentation/pages/chat/history_share_page.dart';

class Repository extends Mock implements IChatCatchUpRepository {}

class Conversations extends Mock implements IConversationRepository {}

void main() {
  testWidgets(
    'history selection requires canonical preview and explicit confirmation',
    (tester) async {
      final repo = Repository(), conversations = Conversations();
      final message = MessageEntity(
        id: 'selected',
        roomId: 'group',
        senderId: 'sender',
        senderName: 'Sender',
        content: 'Decision to share',
        type: MessageType.text,
        timestamp: DateTime.utc(2026),
      );
      final draft = HistoryShareDraft(
        id: 'batch',
        roomId: 'group',
        targetRoomId: 'direct',
        recipient: '@new:hs',
        fingerprint: 'fp',
        messages: [message],
        expiresAt: DateTime.now().add(const Duration(minutes: 5)),
      );
      when(() => repo.pendingHistory('group')).thenAnswer((_) async => []);
      when(() => conversations.getConversations()).thenAnswer(
        (_) async => [
          const ConversationEntity(
            id: 'direct',
            name: 'Recipient',
            isEncrypted: true,
            directUserId: '@new:hs',
          ),
        ],
      );
      when(
        () => repo.previewHistory(
          roomId: 'group',
          targetRoomId: 'direct',
          recipient: '@new:hs',
          eventIds: ['selected'],
        ),
      ).thenAnswer((_) async => draft);
      when(() => repo.shareHistory(draft))
          .thenAnswer((_) async => HistoryShareStatus.completed);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: HistorySharePage(
            roomId: 'group',
            messages: [message],
            repository: repo,
            conversations: conversations,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButton<ConversationEntity>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recipient (@new:hs)').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();
      verifyNever(() => repo.shareHistory(draft));
      await tester.tap(find.text('Review selected messages'));
      await tester.pumpAndSettle();
      expect(find.text('Decision to share'), findsOneWidget);
      verifyNever(() => repo.shareHistory(draft));
      await tester.ensureVisible(find.text('Confirm'));
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      verify(() => repo.shareHistory(draft)).called(1);
      expect(
        find.text('Selected history sent and group audit confirmed'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
