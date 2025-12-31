import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/presentation/blocs/conversation/conversation_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/conversation/conversation_event.dart';
import 'package:n42_chat/src/presentation/blocs/conversation/conversation_state.dart';

class MockConversationRepository extends Mock implements IConversationRepository {}

void main() {
  late MockConversationRepository mockRepository;

  final testConversations = [
    const ConversationEntity(
      id: '!room1:server.com',
      name: 'Room 1',
      unreadCount: 5,
    ),
    const ConversationEntity(
      id: '!room2:server.com',
      name: 'Room 2',
      isPinned: true,
    ),
    const ConversationEntity(
      id: '!room3:server.com',
      name: 'Room 3',
      isMuted: true,
    ),
  ];

  setUp(() {
    mockRepository = MockConversationRepository();
  });

  group('ConversationBloc', () {
    test('initial state should be ConversationState.initial', () {
      final bloc = ConversationBloc(conversationRepository: mockRepository);
      expect(bloc.state.conversations, isEmpty);
      bloc.close();
    });

    blocTest<ConversationBloc, ConversationState>(
      'emits [loading, loaded] when LoadConversations succeeds',
      build: () {
        when(() => mockRepository.getConversations())
            .thenAnswer((_) async => testConversations);
        when(() => mockRepository.getTotalUnreadCount())
            .thenAnswer((_) async => 5);
        return ConversationBloc(conversationRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadConversations()),
      expect: () => [
        isA<ConversationState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ConversationState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.conversations.length, 'conversations.length', 3),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'calls repository.markAsRead when MarkConversationAsRead is added',
      build: () {
        when(() => mockRepository.markAsRead(any()))
            .thenAnswer((_) async {});
        return ConversationBloc(conversationRepository: mockRepository);
      },
      seed: () => ConversationState.initial().copyWith(
        conversations: testConversations,
      ),
      act: (bloc) => bloc.add(const MarkConversationAsRead('!room1:server.com')),
      verify: (_) {
        verify(() => mockRepository.markAsRead('!room1:server.com'))
            .called(1);
      },
    );
  });
}
