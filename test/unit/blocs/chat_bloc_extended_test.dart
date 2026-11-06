// Extended tests for ChatBloc — covers handlers NOT in chat_bloc_test.dart:
//   TranslationCompleted, ClearTranslation, NavigatePinnedMessage (seed-based),
//   DisposeChat, SendTypingNotification, SendSystemNotice, SendPokeMessage,
//   DeleteFailedMessage, ReplyToMessage, LoadPinnedMessages, PinMessage, UnpinMessage

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';

import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/chat/message_report_origin.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────

class MockMessageRepository extends Mock implements IMessageRepository {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

class MockGroupRepository extends Mock implements IGroupRepository {}

class MockMatrixClientManager extends Mock implements MatrixClientManager {}

class MockClient extends Mock implements matrix.Client {}

class MockReportAuth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class MockRoom extends Mock implements matrix.Room {}

class MockUser extends Mock implements matrix.User {}

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
  late MockMatrixClientManager mockClientManager;
  late MockClient mockClient;
  late MockRoom mockRoom;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  /// Stub everything that InitializeChat triggers
  void stubInitDefaults() {
    when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => mockClient.userID);
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
      () => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId')),
    ).thenAnswer((_) async => <ScheduledMessageDraft>[]);
    when(
      () => mockPrefs.shouldShowReadReceipts(),
    ).thenAnswer((_) async => true);
    when(
      () => mockPrefs.shouldShowTypingIndicator(),
    ).thenAnswer((_) async => true);
    when(
      () => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId')),
    ).thenAnswer((_) async => <ScheduledMessageDraft>[]);
    when(
      () => mockPrefs.getDefaultSelfDestructSeconds(),
    ).thenAnswer((_) async => null);
    when(
      () => mockPrefs.getTranslationSettings(),
    ).thenAnswer((_) async => null);
  }

  /// Builds a basic bloc (no group repo)
  ChatBloc buildBloc() =>
      ChatBloc(messageRepository: mockRepo, secureStorage: mockPrefs);

  ChatBloc buildBlocWithClientManager() => ChatBloc(
    messageRepository: mockRepo,
    secureStorage: mockPrefs,
    clientManager: mockClientManager,
  );

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
    mockClientManager = MockMatrixClientManager();
    mockClient = MockClient();
    mockRoom = MockRoom();
    stubInitDefaults();

    when(() => mockClientManager.client).thenReturn(mockClient);
    when(() => mockClient.getRoomById(_roomId)).thenReturn(mockRoom);
    when(() => mockClient.userID).thenReturn('@me:server.com');
    when(mockClient.isLogged).thenReturn(true);
    when(
      () => mockClient.typingIndicatorTimeout,
    ).thenReturn(const Duration(milliseconds: 20));
    when(() => mockRoom.typingUsers).thenReturn(const <matrix.User>[]);
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

  group('Inbound typing users', () {
    test(
      'syncs room typing users into state and filters current user',
      () async {
        final alice = MockUser();
        final me = MockUser();

        when(() => alice.id).thenReturn('@alice:server.com');
        when(() => alice.calcDisplayname()).thenReturn('Alice');
        when(() => me.id).thenReturn('@me:server.com');
        when(() => me.calcDisplayname()).thenReturn('Me');
        when(() => mockRoom.typingUsers).thenReturn(<matrix.User>[alice, me]);

        final bloc = buildBlocWithClientManager();
        await initBloc(bloc);

        bloc.add(MessagesUpdated([_msg]));
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(bloc.state.typingUsers, ['Alice']);
        await bloc.close();
      },
    );

    test('clears typing users after local timeout refresh', () async {
      final alice = MockUser();
      var currentTypingUsers = <matrix.User>[alice];

      when(() => alice.id).thenReturn('@alice:server.com');
      when(() => alice.calcDisplayname()).thenReturn('Alice');
      when(() => mockRoom.typingUsers).thenAnswer((_) => currentTypingUsers);

      final bloc = buildBlocWithClientManager();
      await initBloc(bloc);

      bloc.add(MessagesUpdated([_msg]));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.typingUsers, ['Alice']);

      currentTypingUsers = <matrix.User>[];
      await Future<void>.delayed(const Duration(milliseconds: 350));

      expect(bloc.state.typingUsers, isEmpty);
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
        () => mockRepo.replyToMessage(
          any(),
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
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
        () => mockRepo.replyToMessage(
          any(),
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
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

    test('passes optional metadata to repository', () async {
      when(
        () => mockRepo.replyToMessage(
          any(),
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async => _msg);

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        const ReplyToMessage(
          replyToMessageId: '\$original',
          text: 'reply text',
          selfDestructAfter: 10,
          mentionedUserIds: ['@bob:server.com'],
          mentionsRoom: true,
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepo.replyToMessage(
          _roomId,
          '\$original',
          'reply text',
          selfDestructAfter: 10,
          mentionedUserIds: ['@bob:server.com'],
          mentionsRoom: true,
        ),
      ).called(1);

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

  group('Scheduled rich messages', () {
    for (final relogin in [true, false]) {
      test(
        'in-flight due queue respects login generation: relogin=$relogin',
        () async {
          final auth = MockReportAuth();
          final client = mockClient;
          when(() => client.homeserver)
              .thenReturn(Uri.parse('https://server.com'));
          when(() => client.accessToken).thenReturn('same-token');
          AuthSessionInvalidation generation() => AuthSessionInvalidation(
            userId: '@me:server.com',
            homeserver: Uri.parse('https://server.com'),
            deviceId: null,
            isCurrent: () => true,
            matchesClient: (candidate) => identical(candidate, client),
          );
          when(() => auth.currentAccountGeneration).thenReturn(generation());
          final pending = Completer<List<ScheduledMessageDraft>>();
          final started = Completer<void>();
          when(
            () =>
                mockPrefs.getDueScheduledMessages(ownerUserId: '@me:server.com'),
          ).thenAnswer((_) {
            started.complete();
            return pending.future;
          });
          final bloc = ChatBloc(
            messageRepository: mockRepo,
            secureStorage: mockPrefs,
            clientManager: mockClientManager,
            authRepository: auth,
          );
          await initBloc(bloc);
          bloc.add(const SendDueScheduledMessages());
          await started.future;
          // Same client, ID, device and token. Only the login generation changes.
          if (relogin)
            when(() => auth.currentAccountGeneration).thenReturn(generation());
          final draft = ScheduledMessageDraft(
            messageId: 'old-session',
            roomId: _roomId,
            text: 'Private',
            type: MessageType.text,
            createdAt: DateTime(2026),
            scheduledAt: DateTime(2020),
          );
          when(
            () => mockPrefs.getScheduledMessages(
              _roomId,
              ownerUserId: '@me:server.com',
            ),
          ).thenAnswer((_) async => [draft]);
          when(
            () => mockPrefs.removeScheduledMessage(
              _roomId,
              'old-session',
              ownerUserId: '@me:server.com',
            ),
          ).thenAnswer((_) async {});
          when(
            () => mockRepo.sendTextMessage(
              _roomId,
              'Private',
              transactionId: any(named: 'transactionId'),
              selfDestructAfter: null,
              mentionedUserIds: const [],
              mentionsRoom: false,
            ),
          ).thenAnswer((_) async => _msg);
          pending.complete([draft]);
          await Future<void>.delayed(const Duration(milliseconds: 30));
          if (relogin) {
            verifyNever(
              () => mockPrefs.removeScheduledMessage(
                any(),
                any(),
                ownerUserId: any(named: 'ownerUserId'),
              ),
            );
            verifyNever(
              () => mockRepo.sendTextMessage(
                any(),
                any(),
                transactionId: any(named: 'transactionId'),
                selfDestructAfter: any(named: 'selfDestructAfter'),
                mentionedUserIds: any(named: 'mentionedUserIds'),
                mentionsRoom: any(named: 'mentionsRoom'),
              ),
            );
          } else {
            verify(
              () => mockPrefs.removeScheduledMessage(
                _roomId,
                'old-session',
                ownerUserId: '@me:server.com',
              ),
            ).called(1);
            verify(
              () => mockRepo.sendTextMessage(
                _roomId,
                'Private',
                transactionId: any(named: 'transactionId'),
                selfDestructAfter: null,
                mentionedUserIds: const [],
                mentionsRoom: false,
              ),
            ).called(1);
          }
          await bloc.close();
        },
      );
    }
    test('account switch discards a pending due queue without removing drafts', () async {
      final pending = Completer<List<ScheduledMessageDraft>>();
      var owner = '@a:test';
      when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => owner);
      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: '@a:test'))
          .thenAnswer((_) => pending.future);
      final bloc = buildBloc();
      await initBloc(bloc);
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 20));
      owner = '@b:test';
      pending.complete([ScheduledMessageDraft(
        messageId: 'private', type: MessageType.text, createdAt: DateTime(2026), roomId: _roomId, text: 'A private draft', scheduledAt: DateTime(2020),
      )]);
      await Future<void>.delayed(const Duration(milliseconds: 30));
      verifyNever(() => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
      verifyNever(() => mockRepo.sendTextMessage(any(), any(),
        transactionId: any(named: 'transactionId'), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'), mentionsRoom: any(named: 'mentionsRoom')));
      await bloc.close();
    });

    test('queued schedule cannot be claimed by a different account or room', () async {
      final bloc = buildBloc();
      await initBloc(bloc);
      bloc.add(SendScheduledMessage(
        text: 'Private draft', ownerUserId: '@other:test', roomId: _roomId,
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      ));
      bloc.add(SendScheduledMessage(
        text: 'Other room', ownerUserId: mockClient.userID, roomId: '!other:test',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      ));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.messages.map((m) => m.id), [_msg.id]);
      verifyNever(() => mockPrefs.saveScheduledMessage(
        ownerUserId: any(named: 'ownerUserId'),
        roomId: any(named: 'roomId'), messageId: any(named: 'messageId'),
        text: any(named: 'text'), scheduledAt: any(named: 'scheduledAt'),
        payload: any(named: 'payload'), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'), mentionsRoom: any(named: 'mentionsRoom'),
      ));
      await bloc.close();
    });

    test('unconfirmed scheduled delivery retains the draft', () async {
      final draft = ScheduledMessageDraft(messageId: 'unconfirmed', roomId: _roomId, text: 'Keep me', type: MessageType.text, scheduledAt: DateTime(2020), createdAt: DateTime(2019));
      final bloc = buildBloc();
      await initBloc(bloc);
      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async => [draft]);
      when(() => mockPrefs.getScheduledMessages(_roomId, ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async => [draft]);
      when(() => mockRepo.sendTextMessage(_roomId, draft.text, transactionId: draft.transactionId, mentionedUserIds: const [], mentionsRoom: false, selfDestructAfter: null)).thenAnswer((_) async => null);
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      verify(() => mockRepo.sendTextMessage(_roomId, draft.text, transactionId: draft.transactionId, mentionedUserIds: const [], mentionsRoom: false, selfDestructAfter: null)).called(1);
      verifyNever(() => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
      await bloc.close();
    });

    test('recreated bloc reuses transaction ID after accepted send and failed cleanup', () async {
      final draft = ScheduledMessageDraft(messageId: 'cleanup-failed', roomId: _roomId, text: 'Once', type: MessageType.text, scheduledAt: DateTime(2020), createdAt: DateTime(2019));
      var removed = false;
      var removalAttempts = 0;
      final sentIds = <String?>[];
      when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => '@me:test');
      when(() => mockPrefs.removeScheduledMessage(_roomId, draft.messageId, ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async { if (++removalAttempts == 1) throw StateError('disk'); removed = true; });
      when(() => mockRepo.sendTextMessage(_roomId, draft.text, transactionId: any(named: 'transactionId'), mentionedUserIds: const [], mentionsRoom: false, selfDestructAfter: null)).thenAnswer((invocation) async { sentIds.add(invocation.namedArguments[#transactionId] as String?); return _msg; });
      for (var attempt = 0; attempt < 2; attempt++) {
        final bloc = buildBloc();
        await initBloc(bloc);
        when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async => removed ? [] : [draft]);
        when(() => mockPrefs.getScheduledMessages(_roomId, ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async => removed ? [] : [ScheduledMessageDraft.fromJson(draft.toJson())]);
        bloc.add(const SendDueScheduledMessages());
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await bloc.close();
      }
      expect(removed, isTrue);
      expect(sentIds, [draft.transactionId, draft.transactionId]);
    });

    test(
      'cancellation completion waits for storage and reports failure',
      () async {
        final write = Completer<void>();
        when(() => mockPrefs.removeScheduledMessage(_roomId, 'pending', ownerUserId: any(named: 'ownerUserId')))
            .thenAnswer((_) => write.future);
        final bloc = buildBloc();
        await initBloc(bloc);
        final completion = Completer<bool>();
        bloc.add(
          CancelScheduledMessage(
            'pending',
            roomId: _roomId,
            completion: completion,
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(completion.isCompleted, isFalse);
        write.completeError(StateError('disk failure'));
        expect(await completion.future, isFalse);
        await bloc.close();
      },
    );

    test(
      'cancellation uses the explicit draft room, not the open room',
      () async {
        when(() => mockPrefs.removeScheduledMessage('!other:test', 'pending', ownerUserId: any(named: 'ownerUserId')))
            .thenAnswer((_) async {});
        final bloc = buildBloc();
        await initBloc(bloc);
        final completion = Completer<bool>();
        bloc.add(
          CancelScheduledMessage(
            'pending',
            roomId: '!other:test',
            completion: completion,
          ),
        );
        expect(await completion.future, isTrue);
        verify(() => mockPrefs.removeScheduledMessage('!other:test', 'pending', ownerUserId: any(named: 'ownerUserId')))
            .called(1);
        verifyNever(() => mockPrefs.removeScheduledMessage(_roomId, 'pending', ownerUserId: any(named: 'ownerUserId')));
        expect(bloc.state.messages.map((m) => m.id), contains(_msg.id));
        await bloc.close();
      },
    );

    test('cancellation without a room completes with failure', () async {
      final bloc = buildBloc();
      final completion = Completer<bool>();
      bloc.add(CancelScheduledMessage('pending', completion: completion));
      expect(await completion.future, isFalse);
      await bloc.close();
    });

    test(
      'cancellation cannot report success while the draft is sending',
      () async {
        final draft = ScheduledMessageDraft(
          messageId: 'sending',
          roomId: _roomId,
          text: 'Question?',
          type: MessageType.poll,
          scheduledAt: DateTime(2020),
          createdAt: DateTime(2019),
          payload: {
            'options': ['A', 'B'],
          },
        );
        final sending = Completer<MessageEntity>();
        final started = Completer<void>();
        when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId')))
            .thenAnswer((_) async => [draft]);
        when(() => mockPrefs.removeScheduledMessage(_roomId, 'sending', ownerUserId: any(named: 'ownerUserId')))
            .thenAnswer((_) async {});
        when(
          () => mockRepo.sendPollMessage(
            any(),
          transactionId: any(named: 'transactionId'),
            question: any(named: 'question'),
            options: any(named: 'options'),
            maxSelections: any(named: 'maxSelections'),
            isAnonymous: any(named: 'isAnonymous'),
          ),
        ).thenAnswer((_) {
          started.complete();
          return sending.future;
        });
        final bloc = buildBloc();
        await initBloc(bloc);
        when(() => mockPrefs.getScheduledMessages(_roomId, ownerUserId: any(named: 'ownerUserId')))
            .thenAnswer((_) async => [draft]);
        bloc.add(const SendDueScheduledMessages());
        await started.future;
        final completion = Completer<bool>();
        bloc.add(
          CancelScheduledMessage(
            'sending',
            roomId: _roomId,
            completion: completion,
          ),
        );
        expect(await completion.future, isFalse);
        verifyNever(() => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
        sending.complete(_msg);
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await bloc.close();
        verify(() => mockPrefs.removeScheduledMessage(_roomId, 'sending', ownerUserId: any(named: 'ownerUserId')))
            .called(1);
      },
    );

    test('stale due queue cannot send a draft after cancellation', () async {
      final draft = ScheduledMessageDraft(
        messageId: 'stale',
        roomId: _roomId,
        text: 'Cancelled',
        type: MessageType.text,
        scheduledAt: DateTime(2020),
        createdAt: DateTime(2019),
      );
      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId')))
          .thenAnswer((_) async => [draft]);
      when(() => mockPrefs.removeScheduledMessage(_roomId, 'stale', ownerUserId: any(named: 'ownerUserId')))
          .thenAnswer((_) async {});
      final bloc = buildBloc();
      await initBloc(bloc);
      final completion = Completer<bool>();
      bloc.add(
        CancelScheduledMessage('stale', roomId: _roomId, completion: completion),
      );
      expect(await completion.future, isTrue);
      clearInteractions(mockPrefs);
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      verify(() => mockPrefs.getScheduledMessages(_roomId, ownerUserId: any(named: 'ownerUserId'))).called(1);
      verifyNever(() => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')));
      verifyNever(() => mockRepo.sendTextMessage(
        _roomId, draft.text,
          transactionId: any(named: 'transactionId'), selfDestructAfter: draft.selfDestructAfter,
        mentionedUserIds: draft.mentionedUserIds, mentionsRoom: draft.mentionsRoom,
      ));
      expect(bloc.state.messages.map((m) => m.id), [_msg.id]);
      await bloc.close();
    });
    test('failed scheduled save reports error without a phantom preview', () async {
      when(
        () => mockRepo.getCurrentUserId(),
      ).thenAnswer((_) async => '@me:test');
      when(
        () => mockPrefs.saveScheduledMessage(
          ownerUserId: any(named: 'ownerUserId'),
          roomId: any(named: 'roomId'),
          messageId: any(named: 'messageId'),
          text: any(named: 'text'),
          type: MessageType.poll,
          payload: any(named: 'payload'),
          scheduledAt: any(named: 'scheduledAt'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenThrow(StateError('disk full'));

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        SendScheduledMessage(
          text: 'Lunch?',
          type: MessageType.poll,
          payload: {
            'options': ['Sushi', 'Pizza'],
            'maxSelections': 1,
            'isAnonymous': true,
          },
          scheduledAt: DateTime.now().add(const Duration(hours: 1)),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(bloc.state.error, 'Failed to schedule message');
      expect(bloc.state.messages.map((message) => message.id), [_msg.id]);
      await bloc.close();
    });

    test('saves scheduled poll payload and adds preview message', () async {
      when(
        () => mockRepo.getCurrentUserId(),
      ).thenAnswer((_) async => '@me:test');
      when(
        () => mockPrefs.saveScheduledMessage(
          ownerUserId: any(named: 'ownerUserId'),
          roomId: any(named: 'roomId'),
          messageId: any(named: 'messageId'),
          text: any(named: 'text'),
          type: MessageType.poll,
          payload: any(named: 'payload'),
          scheduledAt: any(named: 'scheduledAt'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      bloc.add(
        SendScheduledMessage(
          text: 'Lunch?',
          type: MessageType.poll,
          payload: {
            'options': ['Sushi', 'Pizza'],
            'maxSelections': 1,
            'isAnonymous': true,
          },
          scheduledAt: DateTime.now().add(const Duration(hours: 1)),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockPrefs.saveScheduledMessage(
          ownerUserId: any(named: 'ownerUserId'),
          roomId: _roomId,
          messageId: any(named: 'messageId'),
          text: 'Lunch?',
          type: MessageType.poll,
          payload: {
            'options': ['Sushi', 'Pizza'],
            'maxSelections': 1,
            'isAnonymous': true,
          },
          scheduledAt: any(named: 'scheduledAt'),
          selfDestructAfter: null,
          mentionedUserIds: const <String>[],
          mentionsRoom: false,
        ),
      ).called(1);

      await bloc.close();
    });

    test('sends due scheduled poll through repository', () async {
      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer(
        (_) async => [
          ScheduledMessageDraft(
            messageId: 'scheduled_poll',
            roomId: _roomId,
            text: 'Lunch?',
            type: MessageType.poll,
            scheduledAt: DateTime.now().subtract(const Duration(minutes: 1)),
            createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
            payload: {
              'options': ['Sushi', 'Pizza'],
              'maxSelections': 1,
              'isAnonymous': true,
            },
          ),
        ],
      );
      when(
        () => mockRepo.sendPollMessage(
          any(),
          transactionId: any(named: 'transactionId'),
          question: any(named: 'question'),
          options: any(named: 'options'),
          maxSelections: any(named: 'maxSelections'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      ).thenAnswer((_) async => _msg.copyWith(type: MessageType.poll));
      when(
        () => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      when(() => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((invocation) async =>
        (await mockPrefs.getDueScheduledMessages(ownerUserId: invocation.namedArguments[#ownerUserId] as String?)).where((draft) => draft.roomId == invocation.positionalArguments.first).toList());
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepo.sendPollMessage(
          _roomId,
          transactionId: any(named: 'transactionId'),
          question: 'Lunch?',
          options: ['Sushi', 'Pizza'],
          maxSelections: 1,
          isAnonymous: true,
        ),
      ).called(1);
      verify(
        () => mockPrefs.removeScheduledMessage(_roomId, 'scheduled_poll', ownerUserId: any(named: 'ownerUserId')),
      ).called(1);

      await bloc.close();
    });

    test('sends due scheduled gif through repository', () async {
      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer(
        (_) async => [
          ScheduledMessageDraft(
            messageId: 'scheduled_gif',
            roomId: _roomId,
            text: 'Celebrate',
            type: MessageType.image,
            scheduledAt: DateTime.now().subtract(const Duration(minutes: 1)),
            createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
            payload: {
              'gifUrl': 'https://media.giphy.com/media/abc/giphy.gif',
              'previewUrl': 'https://media.giphy.com/media/abc/preview.gif',
              'width': 320,
              'height': 240,
            },
          ),
        ],
      );
      when(
        () => mockRepo.sendGifMessage(
          any(),
          transactionId: any(named: 'transactionId'),
          gifUrl: any(named: 'gifUrl'),
          previewUrl: any(named: 'previewUrl'),
          width: any(named: 'width'),
          height: any(named: 'height'),
          title: any(named: 'title'),
        ),
      ).thenAnswer((_) async => _msg.copyWith(type: MessageType.image));
      when(
        () => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      when(() => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((invocation) async =>
        (await mockPrefs.getDueScheduledMessages(ownerUserId: invocation.namedArguments[#ownerUserId] as String?)).where((draft) => draft.roomId == invocation.positionalArguments.first).toList());
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepo.sendGifMessage(
          _roomId,
          transactionId: any(named: 'transactionId'),
          gifUrl: 'https://media.giphy.com/media/abc/giphy.gif',
          previewUrl: 'https://media.giphy.com/media/abc/preview.gif',
          width: 320,
          height: 240,
          title: 'Celebrate',
        ),
      ).called(1);
      verify(
        () => mockPrefs.removeScheduledMessage(_roomId, 'scheduled_gif', ownerUserId: any(named: 'ownerUserId')),
      ).called(1);

      await bloc.close();
    });

    test('sends due scheduled local image through repository', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'n42_scheduled_image_test',
      );
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final imageFile = File('${tempDir.path}/photo.jpg');
      await imageFile.writeAsBytes(const [0xFF, 0xD8, 0xFF, 0xDB]);

      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer(
        (_) async => [
          ScheduledMessageDraft(
            messageId: 'scheduled_photo',
            roomId: _roomId,
            text: 'photo.jpg',
            type: MessageType.image,
            scheduledAt: DateTime.now().subtract(const Duration(minutes: 1)),
            createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
            payload: {
              'localPath': imageFile.path,
              'filename': 'photo.jpg',
              'mimeType': 'image/jpeg',
              'fileSize': 4,
            },
          ),
        ],
      );
      when(
        () => mockRepo.sendImageMessage(
          any(),
          transactionId: any(named: 'transactionId'),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      ).thenAnswer((_) async => _msg.copyWith(type: MessageType.image));
      when(
        () => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      when(() => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((invocation) async =>
        (await mockPrefs.getDueScheduledMessages(ownerUserId: invocation.namedArguments[#ownerUserId] as String?)).where((draft) => draft.roomId == invocation.positionalArguments.first).toList());
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepo.sendImageMessage(
          _roomId,
          transactionId: any(named: 'transactionId'),
          imageBytes: any(named: 'imageBytes'),
          filename: 'photo.jpg',
          mimeType: 'image/jpeg',
          selfDestructAfter: null,
        ),
      ).called(1);
      verify(
        () => mockPrefs.removeScheduledMessage(_roomId, 'scheduled_photo', ownerUserId: any(named: 'ownerUserId')),
      ).called(1);

      await bloc.close();
    });

    test('sends due scheduled local file through repository', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'n42_scheduled_file_test',
      );
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final documentFile = File('${tempDir.path}/doc.pdf');
      await documentFile.writeAsBytes(const [1, 2, 3, 4, 5]);

      when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer(
        (_) async => [
          ScheduledMessageDraft(
            messageId: 'scheduled_file',
            roomId: _roomId,
            text: 'doc.pdf',
            type: MessageType.file,
            scheduledAt: DateTime.now().subtract(const Duration(minutes: 1)),
            createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
            payload: {
              'localPath': documentFile.path,
              'filename': 'doc.pdf',
              'mimeType': 'application/pdf',
              'fileSize': 5,
            },
          ),
        ],
      );
      when(
        () => mockRepo.sendFileMessage(
          any(),
          transactionId: any(named: 'transactionId'),
          fileBytes: any(named: 'fileBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          filePath: any(named: 'filePath'),
          fileStream: any(named: 'fileStream'),
          fileSize: any(named: 'fileSize'),
        ),
      ).thenAnswer((_) async => _msg.copyWith(type: MessageType.file));
      when(
        () => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')),
      ).thenAnswer((_) async {});

      final bloc = buildBloc();
      await initBloc(bloc);

      when(() => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((invocation) async =>
        (await mockPrefs.getDueScheduledMessages(ownerUserId: invocation.namedArguments[#ownerUserId] as String?)).where((draft) => draft.roomId == invocation.positionalArguments.first).toList());
      bloc.add(const SendDueScheduledMessages());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepo.sendFileMessage(
          _roomId,
          transactionId: any(named: 'transactionId'),
          fileBytes: any(named: 'fileBytes'),
          filename: 'doc.pdf',
          mimeType: 'application/pdf',
          selfDestructAfter: null,
          fileSize: 5,
        ),
      ).called(1);
      verify(
        () => mockPrefs.removeScheduledMessage(_roomId, 'scheduled_file', ownerUserId: any(named: 'ownerUserId')),
      ).called(1);

      await bloc.close();
    });

    test(
      'sends due scheduled local file via filePath when room is not encrypted',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'n42_scheduled_file_stream_test',
        );
        addTearDown(() async {
          if (await tempDir.exists()) {
            await tempDir.delete(recursive: true);
          }
        });
        final documentFile = File('${tempDir.path}/doc.pdf');
        await documentFile.writeAsBytes(const [1, 2, 3, 4, 5]);

        when(() => mockRoom.encrypted).thenReturn(false);
        when(() => mockClient.fileEncryptionEnabled).thenReturn(true);
        when(() => mockPrefs.getDueScheduledMessages(ownerUserId: any(named: 'ownerUserId'))).thenAnswer(
          (_) async => [
            ScheduledMessageDraft(
              messageId: 'scheduled_file_path',
              roomId: _roomId,
              text: 'doc.pdf',
              type: MessageType.file,
              scheduledAt: DateTime.now().subtract(const Duration(minutes: 1)),
              createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
              payload: {
                'localPath': documentFile.path,
                'filename': 'doc.pdf',
                'mimeType': 'application/pdf',
                'fileSize': 5,
              },
            ),
          ],
        );
        when(
          () => mockRepo.sendFileMessage(
            any(),
          transactionId: any(named: 'transactionId'),
            fileBytes: any(named: 'fileBytes'),
            filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'),
            selfDestructAfter: any(named: 'selfDestructAfter'),
            filePath: any(named: 'filePath'),
            fileStream: any(named: 'fileStream'),
            fileSize: any(named: 'fileSize'),
          ),
        ).thenAnswer((_) async => _msg.copyWith(type: MessageType.file));
        when(
          () => mockPrefs.removeScheduledMessage(any(), any(), ownerUserId: any(named: 'ownerUserId')),
        ).thenAnswer((_) async {});

        final bloc = buildBlocWithClientManager();
        await initBloc(bloc);

        when(() => mockPrefs.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((invocation) async =>
        (await mockPrefs.getDueScheduledMessages(ownerUserId: invocation.namedArguments[#ownerUserId] as String?)).where((draft) => draft.roomId == invocation.positionalArguments.first).toList());
      bloc.add(const SendDueScheduledMessages());
        await Future<void>.delayed(const Duration(milliseconds: 100));

        verify(
          () => mockRepo.sendFileMessage(
            _roomId,
          transactionId: any(named: 'transactionId'),
            filename: 'doc.pdf',
            mimeType: 'application/pdf',
            selfDestructAfter: null,
            filePath: documentFile.path,
            fileSize: 5,
          ),
        ).called(1);
        verifyNever(
          () => mockRepo.sendFileMessage(
            _roomId,
          transactionId: any(named: 'transactionId'),
            fileBytes: any(named: 'fileBytes'),
            filename: 'doc.pdf',
            mimeType: 'application/pdf',
            selfDestructAfter: null,
            filePath: any(named: 'filePath'),
            fileSize: 5,
          ),
        );
        verify(
          () =>
              mockPrefs.removeScheduledMessage(_roomId, 'scheduled_file_path', ownerUserId: any(named: 'ownerUserId')),
        ).called(1);

        await bloc.close();
      },
    );
  });

  group('ReportMessage account-bound acknowledgement', () {
    test('queued A room report never uses newly selected B room', () async {
      const roomB = '!other:server.com';
      const report = ReportMessage(r'$event1', 'Spam', roomId: _roomId);
      final bloc = buildBlocWithClientManager();
      await initBloc(bloc);
      bloc.add(const InitializeChat(roomB));
      await Future<void>.delayed(const Duration(milliseconds: 20));
      bloc.add(report);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      verifyNever(
        () => mockRepo.reportMessage(roomB, r'$event1', reason: 'Spam'),
      );
      verifyNever(
        () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
      );
      await bloc.close();
    });

    for (final fails in [false, true]) {
      test(
        'room change while report is pending does not show old ${fails ? 'error' : 'success'}',
        () async {
          const roomB = '!other:server.com';
          final pending = Completer<void>();
          when(
            () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
          ).thenAnswer((_) async {
            await pending.future;
            if (fails) throw StateError('Transport failed');
          });
          final bloc = buildBlocWithClientManager();
          await initBloc(bloc);
          final results = <String>[];
          final subscription = bloc.stream.listen((state) {
            if (state.error != null) results.add(state.error!);
          });
          bloc.add(const ReportMessage(r'$event1', 'Spam', roomId: _roomId));
          await Future<void>.delayed(const Duration(milliseconds: 10));
          verify(
            () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
          ).called(1);
          bloc.add(const InitializeChat(roomB));
          await Future<void>.delayed(const Duration(milliseconds: 20));
          pending.complete();
          await Future<void>.delayed(const Duration(milliseconds: 10));
          expect(results, isNot(contains('success:report')));
          expect(results, isNot(contains('Failed to report message')));
          await subscription.cancel();
          await bloc.close();
        },
      );
    }

    for (final replacementA in [false, true]) {
      test(
        'queued report from A cannot reach ${replacementA ? 'new A' : 'B'}',
        () async {
          final auth = MockReportAuth();
          final a = mockClient;
          final replacement = MockClient();
          var active = true;
          final generation = AuthSessionInvalidation(
            userId: '@me:server.com',
            homeserver: Uri.parse('https://server.com'),
            deviceId: null,
            isCurrent: () => active,
            matchesClient: (candidate) => identical(candidate, a),
          );
          when(() => a.homeserver).thenReturn(Uri.parse('https://server.com'));
          when(() => a.accessToken).thenReturn('token-A');
          when(() => a.deviceID).thenReturn(null);
          when(a.isLogged).thenReturn(true);
          when(() => auth.currentAccountGeneration).thenReturn(generation);
          getIt.pushNewScope();
          getIt.registerSingleton<MatrixClientManager>(mockClientManager);
          getIt.registerSingleton<IAuthRepository>(auth);
          addTearDown(getIt.popScope);
          final origin = MessageReportOrigin.capture();
          expect(origin, isNotNull);
          final bloc = buildBlocWithClientManager();
          await initBloc(bloc);
          active = false;
          if (replacementA) {
            when(() => auth.currentAccountGeneration).thenReturn(
              AuthSessionInvalidation(
                userId: '@me:server.com',
                homeserver: Uri.parse('https://server.com'),
                deviceId: null,
                isCurrent: () => true,
                matchesClient: (candidate) => identical(candidate, a),
              ),
            );
          } else {
            when(() => mockClientManager.client).thenReturn(replacement);
          }
          bloc.add(ReportMessage(r'$event1', 'Spam', origin: origin));
          await Future<void>.delayed(const Duration(milliseconds: 10));
          verifyNever(
            () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
          );
          await bloc.close();
        },
      );
    }

    test('waits for exact room and event acknowledgement', () async {
      final pending = Completer<void>();
      when(
        () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
      ).thenAnswer((_) => pending.future);
      final bloc = buildBlocWithClientManager();
      await initBloc(bloc);
      final results = <String>[];
      final subscription = bloc.stream.listen((state) {
        if (state.error != null) results.add(state.error!);
      });
      bloc.add(const ReportMessage(r'$event1', 'Spam'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
      verify(
        () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
      ).called(1);
      expect(results, isNot(contains('success:report')));
      pending.complete();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(results, contains('success:report'));
      await subscription.cancel();
      await bloc.close();
    });

    test('late A success after client switch is not B success', () async {
      final pending = Completer<void>();
      when(
        () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
      ).thenAnswer((_) => pending.future);
      final bloc = buildBlocWithClientManager();
      await initBloc(bloc);
      final results = <String>[];
      final subscription = bloc.stream.listen((state) {
        if (state.error != null) results.add(state.error!);
      });
      bloc.add(const ReportMessage(r'$event1', 'Spam'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
      when(() => mockClientManager.client).thenReturn(MockClient());
      pending.complete();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(results, isNot(contains('success:report')));
      await subscription.cancel();
      await bloc.close();
    });

    test('late A failure after client switch is not B error', () async {
      final pending = Completer<void>();
      when(
        () => mockRepo.reportMessage(_roomId, r'$event1', reason: 'Spam'),
      ).thenAnswer((_) async {
        await pending.future;
        throw StateError('Account changed');
      });
      final bloc = buildBlocWithClientManager();
      await initBloc(bloc);
      final results = <String>[];
      final subscription = bloc.stream.listen((state) {
        if (state.error != null) results.add(state.error!);
      });
      bloc.add(const ReportMessage(r'$event1', 'Spam'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
      when(() => mockClientManager.client).thenReturn(MockClient());
      pending.complete();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(results, isNot(contains('Failed to report message')));
      await subscription.cancel();
      await bloc.close();
    });
  });
}
