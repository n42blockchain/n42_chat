import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';

class MockMessageRepository extends Mock implements IMessageRepository {}

void main() {
  late MockMessageRepository mockRepository;

  final testMessages = [
    MessageEntity(
      id: '\$event1',
      roomId: '!room:server.com',
      senderId: '@user1:server.com',
      senderName: 'User 1',
      content: 'Hello',
      timestamp: DateTime.now(),
      type: MessageType.text,
      status: MessageStatus.sent,
    ),
    MessageEntity(
      id: '\$event2',
      roomId: '!room:server.com',
      senderId: '@user2:server.com',
      senderName: 'User 2',
      content: 'Hi there',
      timestamp: DateTime.now(),
      type: MessageType.text,
      status: MessageStatus.sent,
    ),
  ];

  setUp(() {
    mockRepository = MockMessageRepository();
  });

  group('ChatBloc', () {
    test('initial state should be ChatState.initial', () {
      final bloc = ChatBloc(messageRepository: mockRepository);
      expect(bloc.state.roomId, isNull);
      expect(bloc.state.messages, isEmpty);
      bloc.close();
    });

    blocTest<ChatBloc, ChatState>(
      'sets reply target when SetReplyTarget is added',
      build: () => ChatBloc(messageRepository: mockRepository),
      seed: () => ChatState.initial().copyWith(
        roomId: '!room:server.com',
        messages: testMessages,
      ),
      act: (bloc) => bloc.add(SetReplyTarget(testMessages.first)),
      expect: () => [
        isA<ChatState>().having(
          (s) => s.replyTarget,
          'replyTarget',
          testMessages.first,
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'clears reply target when SetReplyTarget(null) is added',
      build: () => ChatBloc(messageRepository: mockRepository),
      seed: () => ChatState.initial().copyWith(
        roomId: '!room:server.com',
        messages: testMessages,
        replyTarget: testMessages.first,
      ),
      act: (bloc) => bloc.add(const SetReplyTarget(null)),
      expect: () => [
        isA<ChatState>().having(
          (s) => s.replyTarget,
          'replyTarget',
          isNull,
        ),
      ],
    );
  });
}
