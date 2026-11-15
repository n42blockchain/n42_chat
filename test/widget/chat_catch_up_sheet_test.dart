import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_catch_up_sheet.dart';

class MockChatBloc extends Mock implements ChatBloc {}

MessageEntity message(
  String id, {
  String sender = '@peer:hs',
  String? reply,
  bool mention = false,
}) => MessageEntity(
  id: id,
  roomId: '!r:hs',
  senderId: sender,
  senderName: 'Peer',
  content: id,
  type: MessageType.text,
  timestamp: DateTime.utc(2026),
  replyToId: reply,
  mentionsRoom: mention,
);

void main() {
  testWidgets(
    'small screen filters loaded messages and requests older history',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final bloc = MockChatBloc();
      when(() => bloc.stream)
          .thenAnswer((_) => const Stream<ChatState>.empty());
      when(() => bloc.state).thenReturn(
        ChatState(
          roomId: '!r:hs',
          messages: [
            message('Own original', sender: '@me:hs'),
            message('Direct reply', reply: 'Own original'),
            message('Room mention', mention: true),
          ],
          pinnedMessages: [message('Permanent pin')],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            body: BlocProvider<ChatBloc>.value(
              value: bloc,
              child: const ChatCatchUpSheet(roomId: '!r:hs', userId: '@me:hs'),
            ),
          ),
        ),
      );
      expect(find.text('Permanent pin'), findsOneWidget);
      await tester.tap(find.text('Mentions'));
      await tester.pumpAndSettle();
      expect(find.text('Room mention'), findsOneWidget);
      expect(find.text('Permanent pin'), findsNothing);
      await tester.tap(find.text('Replies to me'));
      await tester.pumpAndSettle();
      expect(find.text('Direct reply'), findsOneWidget);
      expect(find.text('Room mention'), findsNothing);
      await tester.tap(find.text('Load older messages'));
      verify(() => bloc.add(const LoadMoreMessages())).called(1);
      expect(tester.takeException(), isNull);
    },
  );
}
