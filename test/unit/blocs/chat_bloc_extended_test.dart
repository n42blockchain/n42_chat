// Extended tests for ChatBloc — covers handlers NOT in chat_bloc_test.dart:
//   TranslationCompleted, ClearTranslation, NavigatePinnedMessage (seed-based),
//   DisposeChat, SendTypingNotification, SendSystemNotice, SendPokeMessage,
//   DeleteFailedMessage, ReplyToMessage, LoadPinnedMessages, PinMessage, UnpinMessage

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────

class MockMessageRepository extends Mock implements IMessageRepository {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

class MockGroupRepository extends Mock implements IGroupRepository {}

// ─── Fixtures ────────────────────────────────────────────────────────────────

const _roomId = '!room:server.com';

final _msg = MessageEntity(
  id: '\$event1',
  roomId: _roomId,
  senderId: '@alice:server.com',
  senderName: 'Alice',
  content: 'Hello',
  timestamp: DateTime(2025, 6, 1, 10, 0),
  type: MessageType.text,
  status: MessageStatus.sent,
  isFromMe: false,
);

// ─── Helpers ─────────────────────────────────────────────────────────────────

void main() {
  late MockMessageRepository mockRepo;
  late MockPreferencesDataSource mockPrefs;
  late MockGroupRepository mockGroupRepo;

  /// Stub everything that InitializeChat triggers
  void stubInitDefaults() {
    when(
      () => mockRepo.getMessages(any(), limit: any(named: 'limit')),
    ).thenAnswer((_) async => [_msg]);
    when(
      () => mockRepo.watchMessages(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchPollResponses(any())).thenReturn(null);
    when(() => mockRepo.markAsRead(any(), any())).thenAnswer((_) async {});
    when(
      () => mockRepo.getLocallyDeletedMessageIds(any()),
    ).thenAnswer((_) async => <String>{});
    when(
      () => mockRepo.getPollAggregations(any(), any()),
    ).thenAnswer((_) async => null);
    when(
      () => mockRepo.getReactionAggregations(any(), any()),
    ).thenAnswer((_) async => null);
    when(
      () => mockRepo.loadMoreMessages(any(), limit: any(named: 'limit')),
    ).thenAnswer((_) async => <MessageEntity>[]);
    when(
      () => mockPrefs.getMessageDestructionTimes(any()),
    ).thenAnswer((_) async => <String, DateTime>{});
    when(
      () => mockPrefs.getScheduledMessages(any()),
    ).thenAnswer((_) async => <Map<String, dynamic>>[]);
    when(
      () => mockPrefs.shouldShowReadReceipts(),
    ).thenAnswer((_) async => true);
    when(
      () => mockPrefs.shouldShowTypingIndicator(),
    ).thenAnswer((_) async => true);
    when(
      () => mockPrefs.getDueScheduledMessages(),
    ).thenAnswer((_) async => <Map<String, dynamic>>[]);
  }

  /// Builds a basic bloc (no group repo)
  ChatBloc buildBloc() =>
      ChatBloc(messageRepository: mockRepo, secureStorage: mockPrefs);

  /// Builds a bloc with a group repository
  ChatBloc buildBlocWithGroupRepo() => ChatBloc(
    messageRepository: mockRepo,
    secureStorage: mockPrefs,
    groupRepository: mockGroupRepo,
  );

  /// Initialize the bloc with _roomId and wait for async ops to settle.
  /// Returns the bloc ready for the next event.
  Future<ChatBloc> initBloc(ChatBloc bloc) async {
    bloc.add(const InitializeChat(_roomId));
    // Allow microtasks (cached load) to complete before proceeding
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return bloc;
  }

  setUp(() {
    mockRepo = MockMessageRepository();
    mockPrefs = MockPreferencesDataSource();
    mockGroupRepo = MockGroupRepository();
    stubInitDefaults();
  });

  // ─────────────────────────────────────────────────
  // TranslationCompleted — seed-based (no init needed)
  // ─────────────────────────────────────────────────

  group('TranslationCompleted', () {
    blocTest<ChatBloc, ChatState>(
      'success — stores translated text and removes from translating set',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        translatingMessageIds: {'\$m1'},
      ),
      act: (bloc) => bloc.add(
        const TranslationCompleted(
          messageId: '\$m1',
          translatedText: '你好',
          detectedSourceLanguage: 'en',
          success: true,
        ),
      ),
      expect: () => [
        isA<ChatState>()
            .having((s) => s.translatingMessageIds, 'translating', isEmpty)
            .having((s) => s.translatedMessages['\$m1'], 'translation', '你好')
            .having((s) => s.detectedSourceLanguages['\$m1'], 'lang', 'en'),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'failure — removes from translating set and emits error',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        translatingMessageIds: {'\$m1'},
      ),
      act: (bloc) => bloc.add(
        const TranslationCompleted(
          messageId: '\$m1',
          success: false,
          error: 'quota exceeded',
        ),
      ),
      expect: () => [
        isA<ChatState>()
            .having((s) => s.translatingMessageIds, 'translating', isEmpty)
            .having((s) => s.error, 'error', isNotNull),
      ],
    );
  });

  // ─────────────────────────────────────────────────
  // ClearTranslation — seed-based
  // ─────────────────────────────────────────────────

  group('ClearTranslation', () {
    blocTest<ChatBloc, ChatState>(
      'removes translation from state',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        translatedMessages: {'\$m1': 'translated text'},
        detectedSourceLanguages: {'\$m1': 'en'},
      ),
      act: (bloc) => bloc.add(const ClearTranslation('\$m1')),
      expect: () => [
        isA<ChatState>()
            .having(
              (s) => s.translatedMessages.containsKey('\$m1'),
              'translation cleared',
              isFalse,
            )
            .having(
              (s) => s.detectedSourceLanguages.containsKey('\$m1'),
              'lang cleared',
              isFalse,
            ),
      ],
    );
  });

  // ─────────────────────────────────────────────────
  // NavigatePinnedMessage — seed-based
  // ─────────────────────────────────────────────────

  group('NavigatePinnedMessage', () {
    final msg2 = _msg.copyWith(id: '\$event2');
    final msg3 = _msg.copyWith(id: '\$event3');

    blocTest<ChatBloc, ChatState>(
      'no-op when pinnedMessages is empty',
      build: buildBloc,
      seed: () => ChatState.initial(),
      act: (bloc) => bloc.add(const NavigatePinnedMessage(1)),
      expect: () => <ChatState>[],
    );

    blocTest<ChatBloc, ChatState>(
      'forward navigation increments index',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        pinnedMessages: [_msg, msg2, msg3],
        currentPinnedIndex: 0,
      ),
      act: (bloc) => bloc.add(const NavigatePinnedMessage(1)),
      expect: () => [
        isA<ChatState>().having((s) => s.currentPinnedIndex, 'index', 1),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'wraps to 0 when past last index',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        pinnedMessages: [_msg, msg2],
        currentPinnedIndex: 1,
      ),
      act: (bloc) => bloc.add(const NavigatePinnedMessage(1)),
      expect: () => [
        isA<ChatState>().having((s) => s.currentPinnedIndex, 'index', 0),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'wraps to last when going back from 0',
      build: buildBloc,
      seed: () => ChatState.initial().copyWith(
        pinnedMessages: [_msg, msg2, msg3],
        currentPinnedIndex: 0,
      ),
      act: (bloc) => bloc.add(const NavigatePinnedMessage(-1)),
      expect: () => [
        isA<ChatState>().having((s) => s.currentPinnedIndex, 'index', 2),
      ],
    );
  });

  // ─────────────────────────────────────────────────
  // DisposeChat — resets state
  // ─────────────────────────────────────────────────

  group('DisposeChat', () {
    test('resets state to initial and clears roomId', () async {
      final bloc = buildBloc();
      await initBloc(bloc);

      // Verify roomId is set after init
      expect(bloc.state.roomId, _roomId);

      bloc.add(const DisposeChat());
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(bloc.state.roomId, isNull);
      expect(bloc.state.messages, isEmpty);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // SendTypingNotification
  // ─────────────────────────────────────────────────

  group('SendTypingNotification', () {
    test('sends notification when privacy setting allows it', () async {
      when(
        () => mockPrefs.shouldShowTypingIndicator(),
      ).thenAnswer((_) async => true);
      when(
        () => mockRepo.sendTypingNotification(any(), any()),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(const SendTypingNotification(true));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(() => mockRepo.sendTypingNotification(_roomId, true)).called(1);
      await bloc.close();
    });

    test('skips notification when privacy setting blocks it', () async {
      when(
        () => mockPrefs.shouldShowTypingIndicator(),
      ).thenAnswer((_) async => false);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(const SendTypingNotification(true));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verifyNever(() => mockRepo.sendTypingNotification(any(), any()));
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // SendSystemNotice
  // ─────────────────────────────────────────────────

  group('SendSystemNotice', () {
    test('sends notice to repository', () async {
      when(
        () => mockRepo.sendNoticeMessage(
          roomId: any(named: 'roomId'),
          notice: any(named: 'notice'),
        ),
      ).thenAnswer((_) async => null);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(const SendSystemNotice('hello'));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(
        () => mockRepo.sendNoticeMessage(roomId: _roomId, notice: 'hello'),
      ).called(1);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // SendContactCardMessage
  // ─────────────────────────────────────────────────

  group('SendContactCardMessage', () {
    test('clears reply target after success', () async {
      when(
        () => mockRepo.sendCustomMessage(
          any(),
          msgType: any(named: 'msgType'),
          content: any(named: 'content'),
          additionalData: any(named: 'additionalData'),
        ),
      ).thenAnswer((_) async => '\$contact1');

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(SetReplyTarget(_msg));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      bloc.add(
        const SendContactCardMessage(
          userId: '@bob:server.com',
          displayName: 'Bob',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.replyTarget, isNull);
      expect(bloc.state.lastMessageSentAt, isNotNull);
      verify(
        () => mockRepo.sendCustomMessage(
          _roomId,
          msgType: 'n42.contact_card',
          content: '[Contact Card] Bob',
          additionalData: {'user_id': '@bob:server.com', 'display_name': 'Bob'},
        ),
      ).called(1);

      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // SendPokeMessage
  // ─────────────────────────────────────────────────

  group('SendPokeMessage', () {
    test('sends poke message to repository', () async {
      when(
        () => mockRepo.sendNoticeMessage(
          roomId: any(named: 'roomId'),
          notice: any(named: 'notice'),
        ),
      ).thenAnswer((_) async => null);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        const SendPokeMessage(
          pokerName: 'Alice',
          targetUserId: '@bob:s',
          targetName: 'Bob',
          pokerPokeText: '的头',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // The poke text should be included in the notice message
      final captured = verify(
        () => mockRepo.sendNoticeMessage(
          roomId: _roomId,
          notice: captureAny(named: 'notice'),
        ),
      ).captured;
      expect(captured.last as String, contains('Alice'));
      expect(captured.last as String, contains('Bob'));
      await bloc.close();
    });

    test('sends poke without suffix when pokeText is null', () async {
      when(
        () => mockRepo.sendNoticeMessage(
          roomId: any(named: 'roomId'),
          notice: any(named: 'notice'),
        ),
      ).thenAnswer((_) async => null);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        const SendPokeMessage(
          pokerName: 'Alice',
          targetUserId: '@bob:s',
          targetName: 'Bob',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(
        () => mockRepo.sendNoticeMessage(
          roomId: any(named: 'roomId'),
          notice: any(named: 'notice'),
        ),
      ).called(1);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // DeleteFailedMessage
  // ─────────────────────────────────────────────────

  group('DeleteFailedMessage', () {
    test('removes message from state and calls repository', () async {
      when(
        () => mockRepo.deleteFailedMessage(any(), any()),
      ).thenAnswer((_) async => true);

      final bloc = buildBloc();
      await initBloc(bloc);

      // Wait for initial messages to load
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Initial state should have _msg
      expect(bloc.state.messages.any((m) => m.id == _msg.id), isTrue);

      bloc.add(DeleteFailedMessage(_msg.id));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Message removed from state
      expect(bloc.state.messages.any((m) => m.id == _msg.id), isFalse);

      // Repository called
      verify(() => mockRepo.deleteFailedMessage(_roomId, _msg.id)).called(1);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // ReplyToMessage
  // ─────────────────────────────────────────────────

  group('ReplyToMessage', () {
    test('success — clears isSending and reply target', () async {
      when(
        () => mockRepo.replyToMessage(any(), any(), any()),
      ).thenAnswer((_) async => _msg);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        const ReplyToMessage(
          replyToMessageId: '\$original',
          text: 'reply text',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.isSending, isFalse);
      await bloc.close();
    });

    test('failure — emits error', () async {
      when(
        () => mockRepo.replyToMessage(any(), any(), any()),
      ).thenThrow(Exception('network error'));

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        const ReplyToMessage(
          replyToMessageId: '\$original',
          text: 'reply text',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.error, isNotNull);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // LoadPinnedMessages — requires groupRepository
  // ─────────────────────────────────────────────────

  group('LoadPinnedMessages', () {
    test('emits empty pinnedMessages when no pinned events', () async {
      when(
        () => mockGroupRepo.getPinnedEventIds(any()),
      ).thenAnswer((_) async => <String>[]);
      when(() => mockGroupRepo.canPinMessages(any())).thenReturn(true);

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      bloc.add(const LoadPinnedMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.pinnedMessages, isEmpty);
      expect(bloc.state.canPinMessages, isTrue);
      await bloc.close();
    });

    test('emits pinnedMessages matched from current message list', () async {
      when(
        () => mockGroupRepo.getPinnedEventIds(any()),
      ).thenAnswer((_) async => [_msg.id]);
      when(() => mockGroupRepo.canPinMessages(any())).thenReturn(false);

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      // Wait for messages to load so _msg is in state
      await Future<void>.delayed(const Duration(milliseconds: 200));

      bloc.add(const LoadPinnedMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.pinnedMessages, isNotEmpty);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // PinMessage
  // ─────────────────────────────────────────────────

  group('PinMessage', () {
    test('success — calls groupRepository.pinMessage', () async {
      when(
        () => mockGroupRepo.pinMessage(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockGroupRepo.getPinnedEventIds(any()),
      ).thenAnswer((_) async => <String>[]);
      when(() => mockGroupRepo.canPinMessages(any())).thenReturn(true);

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      bloc.add(const PinMessage('\$eventId'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockGroupRepo.pinMessage(_roomId, '\$eventId')).called(1);
      await bloc.close();
    });

    test('failure — emits error', () async {
      when(
        () => mockGroupRepo.pinMessage(any(), any()),
      ).thenThrow(Exception('pin failed'));

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      bloc.add(const PinMessage('\$eventId'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.error, isNotNull);
      await bloc.close();
    });
  });

  // ─────────────────────────────────────────────────
  // UnpinMessage
  // ─────────────────────────────────────────────────

  group('UnpinMessage', () {
    test('success — calls groupRepository.unpinMessage', () async {
      when(
        () => mockGroupRepo.unpinMessage(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockGroupRepo.getPinnedEventIds(any()),
      ).thenAnswer((_) async => <String>[]);
      when(() => mockGroupRepo.canPinMessages(any())).thenReturn(true);

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      bloc.add(const UnpinMessage('\$eventId'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockGroupRepo.unpinMessage(_roomId, '\$eventId')).called(1);
      await bloc.close();
    });

    test('failure — emits error', () async {
      when(
        () => mockGroupRepo.unpinMessage(any(), any()),
      ).thenThrow(Exception('unpin failed'));

      final bloc = buildBlocWithGroupRepo();
      await initBloc(bloc);

      bloc.add(const UnpinMessage('\$eventId'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.error, isNotNull);
      await bloc.close();
    });
  });
}
