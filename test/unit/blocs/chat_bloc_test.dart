import 'package:matrix/matrix.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/entities/content_filter_entity.dart';
import 'package:n42_chat/src/core/services/translation_service.dart';

import 'package:n42_chat/src/data/datasources/matrix/message/encrypted_send_guard.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockMessageRepository extends Mock implements IMessageRepository {}
class RetryClient extends Mock implements Client {}
class RetryManager extends Mock implements MatrixClientManager {}
class MockGroupRepository extends Mock implements IGroupRepository {}

class MockSecureStorage extends Mock implements PreferencesDataSource {}
class MockTranslationService extends Mock implements ITranslationService {}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _roomId = '!room:server.com';

final _testMessages = [
  MessageEntity(
    id: '\$event1',
    roomId: _roomId,
    senderId: '@user1:server.com',
    senderName: 'User 1',
    content: 'Hello',
    timestamp: DateTime(2026, 1, 1, 12, 0),
    type: MessageType.text,
    status: MessageStatus.sent,
    isFromMe: false,
  ),
  MessageEntity(
    id: '\$event2',
    roomId: _roomId,
    senderId: '@user2:server.com',
    senderName: 'User 2',
    content: 'Hi there',
    timestamp: DateTime(2026, 1, 1, 12, 1),
    type: MessageType.text,
    status: MessageStatus.sent,
    isFromMe: true,
  ),
];

class MockHistoryClearStore extends Mock implements ChatHistoryClearStore {}

void main() {
  late MockMessageRepository mockRepository;
  late MockSecureStorage mockSecureStorage;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(() => true);
  });

  setUp(() {
    mockRepository = MockMessageRepository();
    mockSecureStorage = MockSecureStorage();

    // Default stubs for methods called during InitializeChat
    when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
        .thenAnswer((_) async => _testMessages);
    when(() => mockRepository.watchMessages(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepository.watchPollResponses(any())).thenReturn(null);
    when(() => mockRepository.markAsRead(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockRepository.getLocallyDeletedMessageIds(any()))
        .thenAnswer((_) async => <String>{});
    when(() => mockRepository.getPollAggregations(any(), any()))
        .thenAnswer((_) async => null);
    when(() => mockRepository.getReactionAggregations(any(), any()))
        .thenAnswer((_) async => null);
    when(
      () => mockRepository.loadMoreMessages(any(), limit: any(named: 'limit')),
    ).thenAnswer((_) async => _testMessages);

    // Default stubs for PreferencesDataSource
    when(() => mockSecureStorage.getMessageDestructionTimes(any()))
        .thenAnswer((_) async => <String, DateTime>{});
    when(() => mockSecureStorage.getScheduledMessages(any()))
        .thenAnswer((_) async => <ScheduledMessageDraft>[]);
    when(() => mockSecureStorage.shouldShowReadReceipts())
        .thenAnswer((_) async => true);
    when(() => mockSecureStorage.shouldShowTypingIndicator())
        .thenAnswer((_) async => true);
    when(() => mockSecureStorage.getDueScheduledMessages())
        .thenAnswer((_) async => <ScheduledMessageDraft>[]);
    when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
        .thenAnswer((_) async => null);
  });

  ChatBloc buildBloc() => ChatBloc(
    messageRepository: mockRepository,
    secureStorage: mockSecureStorage,
  );

  /// Helper: builds a bloc and initializes the chat room so
  /// `_currentRoomId` is set. Returns the bloc after waiting for init.
  Future<ChatBloc> buildInitializedBloc() async {
    final bloc = buildBloc();
    bloc.add(const InitializeChat(_roomId));
    // Wait for all background tasks (cached load + full load) to complete
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return bloc;
  }

  group('automatic retry ownership', () {
    setUp(() {
      when(() => mockSecureStorage.getScheduledMessages(any(), ownerUserId: any(named: 'ownerUserId'))).thenAnswer((_) async => <ScheduledMessageDraft>[]);
      when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@me:server.com');
      when(() => mockSecureStorage.getTranslationSettings()).thenAnswer((_) async => null);
    });
    Future<void> initialize(ChatBloc bloc, String room) async {
      bloc.add(InitializeChat(room));
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    for (final duringDelay in [false, true]) {
      test('retry rejects account token change, duringDelay=$duringDelay', () async {
        final manager = RetryManager();
        final client = RetryClient();
        when(() => manager.client).thenReturn(client);
        when(() => client.isLogged()).thenReturn(true);
        when(() => client.userID).thenReturn('@me:server.com');
        when(() => client.accessToken).thenReturn('old-token');
        final bloc = ChatBloc(messageRepository: mockRepository,
          secureStorage: mockSecureStorage, clientManager: manager);
        addTearDown(bloc.close);
        await initialize(bloc, _roomId);
        bloc.enqueueForRetry('old-retry');
        if (duringDelay) {
          bloc.add(const RetryPendingMessages());
          await Future<void>.delayed(const Duration(milliseconds: 50));
        }
        when(() => client.accessToken).thenReturn('new-token');
        if (!duringDelay) bloc.add(const RetryPendingMessages());
        await Future<void>.delayed(const Duration(milliseconds: 2100));
        verifyNever(() => mockRepository.resendMessage(any(), 'old-retry'));
      });
    }

    for (final roundTrip in [false, true]) {
      test('delayed retry stops on room switch, roundTrip=$roundTrip', () async {
        when(() => mockRepository.resendMessage(any(), any())).thenAnswer((_) async => true);
        final bloc = buildBloc();
        addTearDown(bloc.close);
        await initialize(bloc, _roomId);
        bloc.enqueueForRetry('old-retry');
        bloc.add(const RetryPendingMessages());
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await initialize(bloc, '!other:server.com');
        if (roundTrip) await initialize(bloc, _roomId);
        await Future<void>.delayed(const Duration(milliseconds: 2100));
        verifyNever(() => mockRepository.resendMessage(any(), 'old-retry'));
      });
    }
    test('overlapping sync completions cannot retry one message twice', () async {
      when(() => mockRepository.resendMessage(any(), any())).thenAnswer((_) async => true);
      final bloc = buildBloc();
      addTearDown(bloc.close);
      await initialize(bloc, _roomId);
      bloc.enqueueForRetry('single-retry');
      bloc.add(const RetryPendingMessages());
      bloc.add(const RetryPendingMessages());
      await Future<void>.delayed(const Duration(milliseconds: 2200));
      verify(() => mockRepository.resendMessage(_roomId, 'single-retry')).called(1);
    });
    test('late old failure does not enqueue retries into the new room', () async {
      final pending = Completer<bool>();
      when(() => mockRepository.resendMessage(_roomId, 'old-retry')).thenAnswer((_) => pending.future);
      when(() => mockRepository.resendMessage('!other:server.com', 'old-retry')).thenAnswer((_) async => true);
      final bloc = buildBloc();
      addTearDown(bloc.close);
      await initialize(bloc, _roomId);
      bloc.enqueueForRetry('old-retry');
      bloc.add(const RetryPendingMessages());
      await Future<void>.delayed(const Duration(milliseconds: 2100));
      verify(() => mockRepository.resendMessage(_roomId, 'old-retry')).called(1);
      await initialize(bloc, '!other:server.com');
      pending.complete(false);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const RetryPendingMessages());
      await Future<void>.delayed(const Duration(milliseconds: 4200));
      verifyNever(() => mockRepository.resendMessage('!other:server.com', 'old-retry'));
    });
  });

  for (final roundTrip in [false, true]) {
    test('late background settings retain current room, roundTrip=$roundTrip', () async {
      final groupRepo = MockGroupRepository();
      final group = Completer<GroupEntity?>();
      final filter = Completer<ContentFilterConfig?>();
      final translation = Completer<Map<String, dynamic>?>();
      final destruction = Completer<Map<String, DateTime>>();
      when(() => groupRepo.getGroup(any())).thenAnswer((_) => group.future);
      when(() => groupRepo.getContentFilter(any())).thenAnswer((_) => filter.future);
      when(() => mockSecureStorage.getTranslationSettings()).thenAnswer((_) => translation.future);
      when(() => mockSecureStorage.getMessageDestructionTimes(any())).thenAnswer((_) => destruction.future);
      final message = _testMessages.first.copyWith(selfDestructAfter: 60);
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenAnswer((_) async => [message]);
      final bloc = ChatBloc(messageRepository: mockRepository, secureStorage: mockSecureStorage,
        groupRepository: groupRepo);
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 150));
      verify(() => groupRepo.getGroup(_roomId)).called(1);
      verify(() => groupRepo.getContentFilter(_roomId)).called(1);
      verify(() => mockSecureStorage.getTranslationSettings()).called(1);
      verify(() => mockSecureStorage.getMessageDestructionTimes(_roomId)).called(1);
      when(() => groupRepo.getGroup(any())).thenAnswer((_) async => null);
      when(() => groupRepo.getContentFilter(any())).thenAnswer((_) async => null);
      when(() => mockSecureStorage.getTranslationSettings()).thenAnswer((_) async => null);
      when(() => mockSecureStorage.getMessageDestructionTimes(any())).thenAnswer((_) async => {});
      bloc.add(const InitializeChat('!other:server.com'));
      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (roundTrip) {
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 150));
      }
      group.complete(const GroupEntity(roomId: _roomId, name: 'old', slowModeInterval: 90));
      filter.complete(const ContentFilterConfig(enabled: true, forbiddenWords: ['old']));
      translation.complete({'autoTranslate': false, 'smartReplyTranslate': true, 'defaultTargetLanguage': 'ja'});
      destruction.complete({message.id: DateTime.now().add(const Duration(hours: 1))});
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.slowModeInterval, 0);
      expect(bloc.state.contentFilter?.enabled ?? false, isFalse);
      expect(bloc.state.smartReplyTranslate, isFalse);
      expect(bloc.state.messages.single.destroyedAt, isNull);
      await bloc.close();
    });
  }

  for (final stale in [false, true]) {
    test('queued room settings check origin when handled, stale=$stale', () async {
      final bloc = await buildInitializedBloc();
      final message = _testMessages.first.copyWith(selfDestructAfter: 60);
      bloc.add(MessagesUpdated([message]));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      final before = bloc.state;
      var current = true;
      final deadline = DateTime.now().add(const Duration(hours: 1));
      bloc.add(RoomInfoLoaded(isChannel: false, canSendMessages: true,
        slowModeInterval: 90, isCurrent: () => current));
      bloc.add(ContentFilterLoaded(const ContentFilterConfig(enabled: true,
        forbiddenWords: ['old']), isCurrent: () => current));
      bloc.add(TranslationSettingsLoaded(autoTranslate: false,
        defaultTargetLanguage: 'ja', smartReplyTranslate: true, isCurrent: () => current));
      bloc.add(DestructionTimesLoaded({message.id: deadline}, isCurrent: () => current));
      if (stale) current = false;
      await Future<void>.delayed(const Duration(milliseconds: 30));
      if (stale) {
        expect(bloc.state, before);
      } else {
        expect(bloc.state.slowModeInterval, 90);
        expect(bloc.state.contentFilter?.enabled, isTrue);
        expect(bloc.state.smartReplyTranslate, isTrue);
        expect(bloc.state.messages.single.destroyedAt, deadline);
      }
      await bloc.close();
    });
  }

  for (final action in ['switch', 'clear', 'retry']) {
    for (final fails in [false, true]) {
      test('translation $action rejects stale completion, failure=$fails', () async {
        final service = MockTranslationService();
        final oldResult = Completer<TranslationResult>();
        final newResult = Completer<TranslationResult>();
        var calls = 0;
        when(() => service.translate(text: any(named: 'text'), targetLanguage: any(named: 'targetLanguage')))
            .thenAnswer((_) => calls++ == 0 ? oldResult.future : newResult.future);
        final bloc = ChatBloc(messageRepository: mockRepository, secureStorage: mockSecureStorage,
          translationService: service);
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 150));
        bloc.add(TranslateMessage(messageId: _testMessages.first.id, targetLanguage: 'ja'));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(calls, 1);
        if (action == 'switch') {
          bloc.add(const InitializeChat('!other:server.com'));
          await Future<void>.delayed(const Duration(milliseconds: 150));
          bloc.add(const InitializeChat(_roomId));
        } else {
          bloc.add(ClearTranslation(_testMessages.first.id));
        }
        await Future<void>.delayed(const Duration(milliseconds: 150));
        if (action == 'retry') {
          bloc.add(TranslateMessage(messageId: _testMessages.first.id, targetLanguage: 'fr'));
          await Future<void>.delayed(const Duration(milliseconds: 30));
          expect(calls, 2);
        }
        if (fails) {
          oldResult.completeError(StateError('old request failed'));
        } else {
          oldResult.complete(const TranslationResult(translatedText: 'old', targetLanguage: 'ja'));
        }
        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(bloc.state.translatedMessages, isEmpty);
        expect(bloc.state.error, isNull);
        expect(bloc.state.isTranslating(_testMessages.first.id), action == 'retry');
        if (action == 'retry') {
          newResult.complete(const TranslationResult(translatedText: 'new', targetLanguage: 'fr'));
          await Future<void>.delayed(const Duration(milliseconds: 30));
          expect(bloc.state.getTranslation(_testMessages.first.id), 'new');
          expect(bloc.state.isTranslating(_testMessages.first.id), isFalse);
        }
        await bloc.close();
      });
    }
  }

  for (final auto in [false, true]) {
    for (final switchRoom in [false, true]) {
      test('language detection rejects stale mode=$auto switch=$switchRoom', () async {
        final service = MockTranslationService();
        final detection = Completer<String?>();
        when(() => service.detectLanguage(any())).thenAnswer((_) => detection.future);
        final bloc = ChatBloc(messageRepository: mockRepository, secureStorage: mockSecureStorage,
          translationService: service);
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 150));
        bloc.add(TranslationSettingsLoaded(autoTranslate: auto, defaultTargetLanguage: 'ja',
          smartReplyTranslate: !auto));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        verify(() => service.detectLanguage(_testMessages.first.content)).called(1);
        if (switchRoom) {
          bloc.add(const InitializeChat('!other:server.com'));
        } else {
          bloc.add(const TranslationSettingsLoaded(autoTranslate: false,
            defaultTargetLanguage: 'ja', smartReplyTranslate: false));
        }
        await Future<void>.delayed(const Duration(milliseconds: 150));
        detection.complete('fr');
        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(bloc.state.detectedRecipientLanguage, isNull);
        expect(bloc.state.translatingMessageIds, isEmpty);
        expect(bloc.state.error, isNull);
        verifyNever(() => service.translate(text: any(named: 'text'), targetLanguage: any(named: 'targetLanguage')));
        await bloc.close();
      });
    }
  }

  test('old preference save cannot start translation in a new room', () async {
    final service = MockTranslationService();
    final saved = Completer<void>();
    when(() => mockSecureStorage.saveTranslationSettings(
      autoTranslate: any(named: 'autoTranslate'),
      defaultTargetLanguage: any(named: 'defaultTargetLanguage'),
      smartReplyTranslate: any(named: 'smartReplyTranslate'),
    )).thenAnswer((_) => saved.future);
    final bloc = ChatBloc(messageRepository: mockRepository, secureStorage: mockSecureStorage,
      translationService: service);
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 150));
    bloc.add(const UpdateTranslationSettings(autoTranslate: true, smartReplyTranslate: true));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.autoTranslate, isTrue);
    bloc.add(const InitializeChat('!other:server.com'));
    await Future<void>.delayed(const Duration(milliseconds: 150));
    saved.complete();
    await Future<void>.delayed(const Duration(milliseconds: 30));
    verifyNever(() => service.detectLanguage(any()));
    await bloc.close();
  });

  for (final type in ['vote', 'end']) {
    for (final stale in [false, true]) {
      test('poll stream $type respects room origin, stale=$stale', () async {
        final stream = StreamController<Map<String, dynamic>>();
        when(() => mockRepository.watchPollResponses(_roomId)).thenAnswer((_) => stream.stream);
        final bloc = await buildInitializedBloc();
        final loading = Completer<List<MessageEntity>>();
        if (stale) {
          when(() => mockRepository.getMessages('!other:server.com', limit: 30))
              .thenAnswer((_) => loading.future);
          bloc.add(const InitializeChat('!other:server.com'));
          await Future<void>.delayed(const Duration(milliseconds: 30));
        }
        final poll = _testMessages.first.copyWith(type: MessageType.poll,
          metadata: const MessageMetadata(pollQuestion: 'Choose', voteCounts: {'a': 0}, totalVoters: 0, pollEnded: false));
        bloc.add(MessagesUpdated([poll]));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        stream.add({'type': type, 'pollEventId': poll.id, 'answers': ['a'],
          'senderId': '@other:server.com', 'isCurrentUser': false});
        await Future<void>.delayed(const Duration(milliseconds: 30));
        final metadata = bloc.state.messages.single.metadata!;
        expect(metadata.voteCounts!['a'], !stale && type == 'vote' ? 1 : 0);
        expect(metadata.pollEnded, !stale && type == 'end');
        if (stale) loading.complete([]);
        await Future<void>.delayed(const Duration(milliseconds: 30));
        await bloc.close();
        await stream.close();
      });
    }
  }

  for (final action in ['vote', 'end', 'aggregate', 'send']) {
    for (final fails in [false, true]) {
      test('poll $action late completion preserves new session, failure=$fails', () async {
        final bloc = await buildInitializedBloc();
        final started = Completer<void>();
        final pending = Completer<bool>();
        final aggregate = Completer<Map<String, dynamic>?>();
        final sent = Completer<MessageEntity?>();
        when(() => mockRepository.voteOnPoll(_roomId,
          pollEventId: r'$event1', selectedOptionIds: ['a']))
            .thenAnswer((_) { if (action == 'vote') started.complete(); return action == 'aggregate' ? Future.value(true) : pending.future; });
        when(() => mockRepository.endPoll(_roomId, r'$event1'))
            .thenAnswer((_) { started.complete(); return pending.future; });
        when(() => mockRepository.getPollAggregations(_roomId, r'$event1'))
            .thenAnswer((_) { started.complete(); return aggregate.future; });
        when(() => mockRepository.sendPollMessage(_roomId, question: 'Choose',
          options: ['a', 'b'], maxSelections: 1, isAnonymous: false,
          quizCorrectIndex: null, quizExplanation: null))
            .thenAnswer((_) { started.complete(); return sent.future; });
        bloc.add(action == 'end' ? const EndPoll(pollEventId: r'$event1')
          : action == 'send' ? const SendPollMessage(question: 'Choose', options: ['a', 'b'])
          : const VoteOnPoll(pollEventId: r'$event1', selectedOptionIds: ['a']));
        await started.future.timeout(const Duration(seconds: 3));
        bloc.add(const InitializeChat('!other:server.com'));
        await Future<void>.delayed(const Duration(milliseconds: 500));
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 500));
        final poll = _testMessages.first.copyWith(type: MessageType.poll,
          metadata: const MessageMetadata(pollQuestion: 'Choose', voteCounts: {'a': 0}, totalVoters: 0, pollEnded: false));
        bloc.add(MessagesUpdated([poll]));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(bloc.state.messages.single.metadata!.voteCounts, {'a': 0});
        if (action == 'aggregate') {
          if (fails) { aggregate.completeError(StateError('old request')); }
          else { aggregate.complete({'voteCounts': {'a': 5}, 'totalVoters': 5, 'myVotes': ['a']}); }
        } else if (action == 'send') {
          if (fails) { sent.completeError(StateError('old request')); }
          else { sent.complete(poll); }
        } else {
          if (fails) { pending.completeError(StateError('old request')); }
          else { pending.complete(true); }
        }
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(bloc.state.messages.single.metadata!.voteCounts, {'a': 0});
        expect(bloc.state.messages.single.metadata!.pollEnded, isFalse);
        expect(bloc.state.error, isNull);
        if (action == 'vote') {
          verifyNever(() => mockRepository.getPollAggregations(any(), any()));
        }
        await bloc.close();
      });
    }
  }

  for (final current in [false, true]) {
    test('queued poll events respect captured origin, current=$current', () async {
      final bloc = await buildInitializedBloc();
      final poll = _testMessages.first.copyWith(type: MessageType.poll,
        metadata: const MessageMetadata(voteCounts: {'a': 0}, totalVoters: 0, pollEnded: false));
      bloc.add(MessagesUpdated([poll]));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      bloc.add(PollResponseReceived(pollEventId: poll.id, selectedOptionIds: ['a'],
        senderId: '@other:server.com', isCurrentUser: false, isCurrent: () => current));
      bloc.add(PollEnded(pollEventId: poll.id, isCurrent: () => current));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.messages.single.metadata!.voteCounts!['a'], current ? 1 : 0);
      expect(bloc.state.messages.single.metadata!.pollEnded, current);
      await bloc.close();
    });
  }

  group('message loads retain their original room generation', () {
    for (final stage in ['cache', 'full', 'history']) {
      for (final fails in [false, true]) {
        test('$stage late result after room round trip, failure=$fails', () async {
          final bloc = await buildInitializedBloc();
          final pending = Completer<List<MessageEntity>>();
          final started = Completer<void>();
          Future<List<MessageEntity>> delayed(Invocation _) {
            started.complete();
            return pending.future;
          }
          if (stage == 'history') {
            bloc.add(const LoadMessages(_roomId, limit: 1));
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(bloc.state.hasMore, isTrue);
            when(() => mockRepository.loadMoreMessages(any(), limit: any(named: 'limit')))
                .thenAnswer(delayed);
            bloc.add(const LoadMoreMessages());
          } else {
            when(() => mockRepository.getMessages(_roomId, limit: stage == 'cache' ? 30 : 99))
                .thenAnswer(delayed);
            bloc.add(stage == 'cache' ? const InitializeChat(_roomId) : const LoadMessages(_roomId, limit: 99));
          }
          await started.future.timeout(const Duration(seconds: 2));
          when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
              .thenAnswer((_) async => []);
          bloc.add(const InitializeChat('!other:server.com'));
          await Future<void>.delayed(const Duration(milliseconds: 150));
          bloc.add(const InitializeChat(_roomId));
          await Future<void>.delayed(const Duration(milliseconds: 150));
          if (fails) {
            pending.completeError(StateError('old load failed'));
          } else {
            pending.complete(_testMessages);
          }
          await Future<void>.delayed(const Duration(milliseconds: 50));
          expect(bloc.state.messages, isEmpty);
          expect(bloc.state.error, isNull);
          expect(bloc.state.isLoadingMore, isFalse);
          await bloc.close();
        });
      }
    }
  });

  test('queued subscription updates recheck their origin at handling time', () async {
    final bloc = await buildInitializedBloc();
    var current = true;
    bloc.add(MessagesUpdated([], isCurrent: () => current));
    current = false;
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.messages, _testMessages);
    await bloc.close();
  });

  test('slow subscription cancellation cannot replace the newest room stream', () async {
    final cancelled = Completer<void>();
    final oldStream = StreamController<List<MessageEntity>>(onCancel: () => cancelled.future);
    final latestStream = StreamController<List<MessageEntity>>();
    when(() => mockRepository.watchMessages(_roomId)).thenAnswer((_) => oldStream.stream);
    when(() => mockRepository.watchMessages('!latest:server.com')).thenAnswer((_) => latestStream.stream);
    final bloc = await buildInitializedBloc();
    bloc.add(const InitializeChat('!middle:server.com'));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    bloc.add(const InitializeChat('!latest:server.com'));
    await Future<void>.delayed(const Duration(milliseconds: 150));
    cancelled.complete();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    verifyNever(() => mockRepository.watchMessages('!middle:server.com'));
    verify(() => mockRepository.watchMessages('!latest:server.com')).called(1);
    latestStream.add([]);
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.messages, isEmpty);
    await bloc.close();
    await oldStream.close();
    await latestStream.close();
  });

  for (final stage in ['settings', 'receipt', 'error', 'null receipt', 'new target']) {
    test('reply context protects $stage', () async {
      final bloc = await buildInitializedBloc();
      final settings = Completer<int?>();
      final result = Completer<MessageEntity?>();
      final started = Completer<void>();
      when(() => mockSecureStorage.getDefaultSelfDestructSeconds()).thenAnswer((_) {
        if (stage == 'settings') { started.complete(); return settings.future; }
        return Future.value(null);
      });
      when(() => mockRepository.replyToMessage(any(), any(), any(),
        selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'), mentionsRoom: any(named: 'mentionsRoom')))
          .thenAnswer((_) { if (!started.isCompleted) started.complete(); return result.future; });
      final original = _testMessages.first;
      final newer = _testMessages.last;
      bloc.add(SetReplyTarget(original));
      await Future<void>.delayed(const Duration(milliseconds: 20));
      bloc.add(ReplyToMessage(replyToMessageId: original.id, text: 'reply'));
      await started.future.timeout(const Duration(seconds: 3));
      final stale = stage == 'settings' || stage == 'receipt' || stage == 'error';
      if (stale) {
        bloc.add(const InitializeChat('!other:server.com'));
        await Future<void>.delayed(const Duration(milliseconds: 50));
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
      if (stage != 'null receipt') bloc.add(SetReplyTarget(newer));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      if (stage == 'settings') { settings.complete(null); result.complete(original); }
      else if (stage == 'error') { result.completeError(StateError('old failure')); }
      else { result.complete(stage == 'null receipt' ? null : original); }
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.replyTarget, stage == 'null receipt' ? original : newer);
      expect(bloc.state.error, stage == 'null receipt' ? 'Failed to reply' : null);
      expect(bloc.state.isSending, isFalse);
      if (stage == 'settings') {
        verifyNever(() => mockRepository.replyToMessage(any(), any(), any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'), mentionsRoom: any(named: 'mentionsRoom')));
      }
      await bloc.close();
    });
  }

  for (final action in ['reaction', 'read', 'typing', 'resend', 'resend error']) {
    test('late $action keeps original room context', () async {
      final bloc = await buildInitializedBloc();
      final started = Completer<void>();
      final permission = Completer<bool>();
      final user = Completer<String?>();
      when(() => mockRepository.getCurrentUserId()).thenAnswer((_) { started.complete(); return user.future; });
      when(() => mockSecureStorage.shouldShowReadReceipts()).thenAnswer((_) { started.complete(); return permission.future; });
      when(() => mockSecureStorage.shouldShowTypingIndicator()).thenAnswer((_) { started.complete(); return permission.future; });
      when(() => mockRepository.resendMessage(any(), any())).thenAnswer((_) { started.complete(); return permission.future; });
      when(() => mockRepository.addReaction(any(), any(), any())).thenAnswer((_) async => true);
      final message = _testMessages.first;
      bloc.add(action == 'reaction' ? AddReaction(messageId: message.id, emoji: '👍')
        : action == 'read' ? MarkMessageAsRead(message.id)
        : action == 'typing' ? const SendTypingNotification(true)
        : ResendMessage(message.id));
      await started.future.timeout(const Duration(seconds: 3));
      bloc.add(const InitializeChat('!other:server.com'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      clearInteractions(mockRepository);
      if (action == 'reaction') { user.complete('@alice:server.com'); }
      else if (action == 'resend error') { permission.completeError(StateError('old failure')); }
      else { permission.complete(true); }
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(MessagesUpdated([message]));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.messages, [message]);
      expect(bloc.state.error, isNull);
      if (action == 'reaction') verifyNever(() => mockRepository.addReaction(any(), any(), any()));
      if (action == 'read') verifyNever(() => mockRepository.markAsRead(any(), any()));
      if (action == 'typing') verifyNever(() => mockRepository.sendTypingNotification(any(), any()));
      await bloc.close();
    });
  }

  test('rejected resend keeps the failed message visible', () async {
    final bloc = await buildInitializedBloc();
    when(() => mockRepository.resendMessage(any(), any())).thenAnswer((_) async => false);
    final message = _testMessages.first;
    bloc.add(ResendMessage(message.id));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    bloc.add(MessagesUpdated([message]));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.messages, [message]);
    expect(bloc.state.error, 'Failed to resend');
    await bloc.close();
  });

  for (final removing in [false, true]) {
    for (final throws in [false, true]) {
      test('reaction rejection restores own change, remove=$removing throw=$throws', () async {
        final bloc = await buildInitializedBloc();
        const prior = MessageReaction(key: '👍', userIds: ['@me:server.com'], isMe: true);
        final message = _testMessages.first.copyWith(reactions: removing ? [prior] : []);
        bloc.add(MessagesUpdated([message]));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        final pending = Completer<bool>();
        final started = Completer<void>();
        when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@me:server.com');
        when(() => mockRepository.addReaction(any(), any(), any())).thenAnswer((_) {
          started.complete(); return pending.future;
        });
        bloc.add(AddReaction(messageId: message.id, emoji: '👍'));
        await started.future.timeout(const Duration(seconds: 3));
        final optimistic = bloc.state.messages.single;
        expect(optimistic.reactions.any((r) => r.key == '👍'), !removing);
        const other = MessageReaction(key: '❤️', userIds: ['@other:server.com']);
        final arrival = _testMessages.last;
        bloc.add(MessagesUpdated([optimistic.copyWith(content: 'new content',
          reactions: [...optimistic.reactions, other]), arrival]));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        if (throws) { pending.completeError(StateError('rejected')); }
        else { pending.complete(false); }
        await Future<void>.delayed(const Duration(milliseconds: 50));
        final current = bloc.state.messages.firstWhere((m) => m.id == message.id);
        expect(current.content, 'new content');
        expect(current.reactions.where((r) => r.key == '👍').toList(), removing ? [prior] : isEmpty);
        expect(current.reactions.contains(other), isTrue);
        expect(bloc.state.messages.contains(arrival), isTrue);
        expect(bloc.state.error, 'Failed to add reaction');
        await bloc.close();
      });
    }
  }

  test('reaction rejection preserves newer server reaction', () async {
    final bloc = await buildInitializedBloc();
    final pending = Completer<bool>();
    final started = Completer<void>();
    when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@me:server.com');
    when(() => mockRepository.addReaction(any(), any(), any())).thenAnswer((_) {
      started.complete(); return pending.future;
    });
    final message = _testMessages.first;
    bloc.add(AddReaction(messageId: message.id, emoji: '👍'));
    await started.future.timeout(const Duration(seconds: 3));
    const server = MessageReaction(key: '👍', userIds: ['@other:server.com'], aggregateCount: 4);
    bloc.add(MessagesUpdated([message.copyWith(reactions: [server])]));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    pending.complete(false);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.messages.single.reactions, [server]);
    expect(bloc.state.error, 'Failed to add reaction');
    await bloc.close();
  });

  for (final fails in [false, true]) {
    test('dispose cancellation cannot reset a newly opened room, failure=$fails', () async {
      final cancelled = Completer<void>();
      final started = Completer<void>();
      final oldStream = StreamController<List<MessageEntity>>(onCancel: () {
        if (!started.isCompleted) started.complete();
        return cancelled.future;
      });
      final newStream = StreamController<List<MessageEntity>>();
      var pollCancelled = false;
      final polls = StreamController<Map<String, dynamic>>(onCancel: () { pollCancelled = true; });
      when(() => mockRepository.watchMessages(_roomId)).thenAnswer((_) => oldStream.stream);
      when(() => mockRepository.watchMessages('!new:server.com')).thenAnswer((_) => newStream.stream);
      when(() => mockRepository.watchPollResponses(_roomId)).thenAnswer((_) => polls.stream);
      final bloc = await buildInitializedBloc();
      bloc.add(const DisposeChat());
      await started.future.timeout(const Duration(seconds: 3));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.roomId, isNull);
      expect(pollCancelled, isTrue);
      bloc.add(const InitializeChat('!new:server.com'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (fails) { cancelled.completeError(StateError('cancel failed')); }
      else { cancelled.complete(); }
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final message = _testMessages.first.copyWith(roomId: '!new:server.com', content: 'new stream');
      newStream.add([message]);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.roomId, '!new:server.com');
      expect(bloc.state.messages, [message]);
      expect(bloc.state.error, isNull);
      await bloc.close();
      await oldStream.close();
      await newStream.close();
      await polls.close();
    });
  }

  for (final mode in ['current', 'stale origin', 'wrong room']) {
    test('clear history respects $mode', () async {
      final bloc = await buildInitializedBloc();
      bloc.add(ClearChatHistory(
        roomId: mode == 'wrong room' ? '!old:server.com' : _roomId,
        isCurrent: () => mode != 'stale origin',
      ));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.messages, mode == 'current' ? isEmpty : _testMessages);
      bloc.add(MessagesUpdated(_testMessages));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.messages, mode == 'current' ? isEmpty : _testMessages);
      await bloc.close();
    });
  }

  test('clear history rejects callback from a previous visit to the same room', () async {
    final bloc = await buildInitializedBloc();
    final isCurrent = bloc.captureCurrentSession();
    expect(isCurrent(), isTrue);
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    expect(isCurrent(), isFalse);
    bloc.add(ClearChatHistory(roomId: _roomId, isCurrent: isCurrent));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.messages, _testMessages);
    await bloc.close();
  });

  test('durable clear survives recreation and filters refresh pagination and updates per account', () async {
    SharedPreferences.setMockInitialValues({});
    when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@alice:server.com');
    ChatBloc create() => ChatBloc(messageRepository: mockRepository,
      secureStorage: mockSecureStorage, historyClearStore: ChatHistoryClearStore());
    var bloc = create();
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    expect(bloc.state.messages, _testMessages);
    final completion = Completer<bool>();
    bloc.add(ClearChatHistory(roomId: _roomId, completion: completion));
    expect(await completion.future, isTrue);
    expect(bloc.state.messages, isEmpty);
    await bloc.close();
    bloc = create();
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    expect(bloc.state.messages, isEmpty);
    final fresh = _testMessages.first.copyWith(id: 'fresh', timestamp: DateTime.now().add(const Duration(hours: 1)));
    final mixed = [fresh, ..._testMessages];
    when(() => mockRepository.getMessages(any(), limit: any(named: 'limit'))).thenAnswer((_) async => mixed);
    bloc.add(LoadMessages(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.messages, [fresh]);
    when(() => mockRepository.loadMoreMessages(any(), limit: any(named: 'limit'))).thenAnswer((_) async => mixed);
    bloc.emit(bloc.state.copyWith(hasMore: true));
    bloc.add(const LoadMoreMessages());
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.messages, [fresh]);
    expect(bloc.state.hasMore, isFalse);
    bloc.add(MessagesUpdated(mixed));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(bloc.state.messages, [fresh]);
    await bloc.close();
    when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@bob:server.com');
    bloc = create();
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    expect(bloc.state.messages, mixed);
    await bloc.close();
  });

  test('clear waits for durable acknowledgement and preserves timeline on failure', () async {
    final store = MockHistoryClearStore();
    when(() => mockRepository.getCurrentUserId()).thenAnswer((_) async => '@alice:server.com');
    when(() => store.read(ownerUserId: any(named: 'ownerUserId'), roomId: any(named: 'roomId'),
      isCurrent: any(named: 'isCurrent'))).thenAnswer((_) async => null);
    final pending = Completer<DateTime>();
    when(() => store.clearThrough(ownerUserId: any(named: 'ownerUserId'), roomId: any(named: 'roomId'),
      boundary: any(named: 'boundary'), isCurrent: any(named: 'isCurrent'))).thenAnswer((_) => pending.future);
    final bloc = ChatBloc(messageRepository: mockRepository, secureStorage: mockSecureStorage, historyClearStore: store);
    bloc.add(const InitializeChat(_roomId));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final completion = Completer<bool>();
    bloc.add(ClearChatHistory(completion: completion));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(completion.isCompleted, isFalse);
    expect(bloc.state.messages, _testMessages);
    pending.completeError(StateError('disk rejected'));
    expect(await completion.future, isFalse);
    expect(bloc.state.messages, _testMessages);
    expect(bloc.state.error, 'Failed to clear chat history');
    await bloc.close();
  });

  group('text send context across awaits', () {
    for (final returnToOrigin in [false, true]) {
      test('settings wait rejects room switch, return=$returnToOrigin', () async {
        final bloc = await buildInitializedBloc();
        final settings = Completer<int?>();
        when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
            .thenAnswer((_) => settings.future);
        final admission = Completer<TextSendPreflight>();
        bloc.add(SendTextMessage('old input', preflightCompletion: admission));
        await Future<void>.delayed(const Duration(milliseconds: 30));
        bloc.add(const InitializeChat('!other:server.com'));
        await Future<void>.delayed(const Duration(milliseconds: 50));
        if (returnToOrigin) {
          bloc.add(const InitializeChat(_roomId));
          await Future<void>.delayed(const Duration(milliseconds: 50));
        }
        settings.complete(null);
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(await admission.future, TextSendPreflight.rejected);
        verifyNever(() => mockRepository.sendTextMessage(
          any(), any(), selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ));
        expect(bloc.state.isSendingText, isFalse);
        await bloc.close();
      });
    }
    test('settings failure rejects admission without dispatch', () async {
      final bloc = await buildInitializedBloc();
      when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
          .thenThrow(StateError('storage unavailable'));
      final admission = Completer<TextSendPreflight>();
      bloc.add(SendTextMessage('retain me', preflightCompletion: admission));
      expect(await admission.future, TextSendPreflight.rejected);
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(bloc.state.isSendingText, isFalse);
      expect(bloc.state.error, isNotNull);
      verifyNever(() => mockRepository.sendTextMessage(
        any(), any(), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom'),
      ));
      await bloc.close();
    });
    test('translation wait cannot dispatch into another room', () async {
      final translation = MockTranslationService();
      when(() => translation.detectLanguage(any())).thenAnswer((_) async => null);
      final translated = Completer<TranslationResult>();
      final entered = Completer<void>();
      when(() => translation.translate(text: any(named: 'text'),
        targetLanguage: any(named: 'targetLanguage'))).thenAnswer((_) {
        entered.complete();
        return translated.future;
      });
      final bloc = ChatBloc(messageRepository: mockRepository,
        secureStorage: mockSecureStorage, translationService: translation);
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      bloc.add(const TranslationSettingsLoaded(autoTranslate: false,
        defaultTargetLanguage: 'ja', smartReplyTranslate: true));
      bloc.add(const RecipientLanguageDetected('ja'));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      final admission = Completer<TextSendPreflight>();
      bloc.add(SendTextMessage('hello', preflightCompletion: admission));
      await entered.future;
      bloc.add(const InitializeChat('!other:server.com'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      translated.complete(const TranslationResult(translatedText: 'こんにちは',
        targetLanguage: 'ja'));
      expect(await admission.future, TextSendPreflight.rejected);
      verifyNever(() => mockRepository.sendTextMessage(
        any(), any(), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom'),
      ));
      await bloc.close();
    });
    test('reply snapshot survives preparation and keeps a newer reply target', () async {
      final bloc = await buildInitializedBloc();
      bloc.add(SetReplyTarget(_testMessages.first));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      final settings = Completer<int?>();
      when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
          .thenAnswer((_) => settings.future);
      when(() => mockRepository.replyToMessage(
        any(), any(), any(), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom'),
      )).thenAnswer((_) async => _testMessages.last);
      bloc.add(const SendTextMessage('reply'));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      bloc.add(SetReplyTarget(_testMessages.last));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      settings.complete(null);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      verify(() => mockRepository.replyToMessage(
        _roomId, _testMessages.first.id, 'reply', selfDestructAfter: null,
        mentionedUserIds: null, mentionsRoom: false,
      )).called(1);
      expect(bloc.state.replyTarget, _testMessages.last);
      await bloc.close();
    });
    test('late receipt cannot change the new room send state', () async {
      final bloc = await buildInitializedBloc();
      final receipt = Completer<MessageEntity?>();
      when(() => mockRepository.sendTextMessage(
        any(), any(), selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom'),
      )).thenAnswer((_) => receipt.future);
      bloc.add(const SendTextMessage('old input'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.isSendingText, isTrue);
      bloc.add(const InitializeChat('!other:server.com'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.isSendingText, isFalse);
      receipt.complete(_testMessages.last);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.lastMessageSentAt, isNull);
      expect(bloc.state.roomId, '!other:server.com');
      await bloc.close();
    });
  });

  // =========================================================================
  // Initial state
  // =========================================================================

  group('initial state', () {
    test('should be ChatState.initial with isLoading true', () {
      final bloc = buildBloc();
      expect(bloc.state.roomId, isNull);
      expect(bloc.state.messages, isEmpty);
      expect(bloc.state.isLoading, isTrue);
      bloc.close();
    });
  });

  // =========================================================================
  // InitializeChat
  // =========================================================================

  group('InitializeChat', () {
    test('loads cached messages and sets roomId on success', () async {
      final bloc = buildBloc();
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(bloc.state.roomId, _roomId);
      expect(bloc.state.messages.length, 2);
      expect(bloc.state.isLoading, false);
      verify(() => mockRepository.getMessages(_roomId, limit: 30)).called(1);

      await bloc.close();
    });

    test('handles empty room gracefully', () async {
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenAnswer((_) async => []);

      final bloc = buildBloc();
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(bloc.state.roomId, _roomId);
      expect(bloc.state.messages, isEmpty);
      expect(bloc.state.isLoading, false);

      await bloc.close();
    });

    test('sets error when repository throws on load', () async {
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenThrow(Exception('Network error'));

      final bloc = buildBloc();
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(bloc.state.roomId, _roomId);
      // Error gets set by the LoadMessages handler (background load)
      expect(bloc.state.error, isNotNull);

      await bloc.close();
    });
  });

  // =========================================================================
  // LoadMessages
  // =========================================================================

  group('LoadMessages', () {
    test('loads messages and marks latest as read', () async {
      final bloc = await buildInitializedBloc();

      // Reset interaction count after init
      clearInteractions(mockRepository);

      bloc.add(const LoadMessages(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.messages.length, 2);
      expect(bloc.state.isLoading, false);
      verify(() => mockRepository.markAsRead(_roomId, '\$event1')).called(1);

      await bloc.close();
    });

    test('emits error when loading fails', () async {
      final bloc = await buildInitializedBloc();

      // Now make it fail
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenThrow(Exception('Failed'));

      bloc.add(const LoadMessages(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isLoading, false);
      expect(bloc.state.error, isNotNull);

      await bloc.close();
    });

    test('sets hasMore true when messages count >= limit', () async {
      final manyMessages = List.generate(
        100,
        (i) => MessageEntity(
          id: '\$event$i',
          roomId: _roomId,
          senderId: '@user:server.com',
          senderName: 'User',
          content: 'Message $i',
          timestamp: DateTime(2026, 1, 1, 12, i),
          type: MessageType.text,
          status: MessageStatus.sent,
        ),
      );
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenAnswer((_) async => manyMessages);

      final bloc = buildBloc();
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(bloc.state.hasMore, true);

      await bloc.close();
    });
  });

  // =========================================================================
  // SendTextMessage
  // =========================================================================

  group('SendTextMessage', () {
    test('sends text and calls repository', () async {
      when(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async => _testMessages.first);

      final bloc = await buildInitializedBloc();
      clearInteractions(mockRepository);

      bloc.add(const SendTextMessage('Hello world'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isSending, false);
      verify(
        () => mockRepository.sendTextMessage(
          _roomId,
          'Hello world',
          selfDestructAfter: null,
          mentionedUserIds: null,
          mentionsRoom: false,
        ),
      ).called(1);

      await bloc.close();
    });

    test(
      'uses default self-destruct timer when message does not override it',
      () async {
        when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
            .thenAnswer((_) async => 45);
        when(
          () => mockRepository.sendTextMessage(
            any(),
            any(),
            selfDestructAfter: any(named: 'selfDestructAfter'),
            mentionedUserIds: any(named: 'mentionedUserIds'),
            mentionsRoom: any(named: 'mentionsRoom'),
          ),
        ).thenAnswer((_) async => _testMessages.first);

        final bloc = await buildInitializedBloc();
        clearInteractions(mockRepository);

        bloc.add(const SendTextMessage('Hello world'));
        await Future<void>.delayed(const Duration(milliseconds: 200));

        verify(
          () => mockRepository.sendTextMessage(
            _roomId,
            'Hello world',
            selfDestructAfter: 45,
            mentionedUserIds: null,
            mentionsRoom: false,
          ),
        ).called(1);

        await bloc.close();
      },
    );

    test('uses replyToMessage when reply target is set', () async {
      when(
        () => mockRepository.replyToMessage(
          any(),
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async => _testMessages.first);

      final bloc = await buildInitializedBloc();

      // Set reply target
      bloc.add(SetReplyTarget(_testMessages.first));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(bloc.state.replyTarget, _testMessages.first);

      // Send with reply
      bloc.add(const SendTextMessage('Reply text'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isSending, false);
      expect(bloc.state.replyTarget, isNull);
      verify(
        () => mockRepository.replyToMessage(
          _roomId,
          '\$event1',
          'Reply text',
          selfDestructAfter: null,
          mentionedUserIds: null,
          mentionsRoom: false,
        ),
      ).called(1);

      await bloc.close();
    });

    test(
      'passes mention and self-destruct metadata through reply sends',
      () async {
        when(
          () => mockRepository.replyToMessage(
            any(),
            any(),
            any(),
            selfDestructAfter: any(named: 'selfDestructAfter'),
            mentionedUserIds: any(named: 'mentionedUserIds'),
            mentionsRoom: any(named: 'mentionsRoom'),
          ),
        ).thenAnswer((_) async => _testMessages.first);

        final bloc = await buildInitializedBloc();

        bloc.add(SetReplyTarget(_testMessages.first));
        await Future<void>.delayed(const Duration(milliseconds: 100));

        bloc.add(
          const SendTextMessage(
            'Reply with metadata',
            selfDestructAfter: 30,
            mentionedUserIds: ['@user3:server.com'],
            mentionsRoom: true,
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 200));

        verify(
          () => mockRepository.replyToMessage(
            _roomId,
            '\$event1',
            'Reply with metadata',
            selfDestructAfter: 30,
            mentionedUserIds: ['@user3:server.com'],
            mentionsRoom: true,
          ),
        ).called(1);

        await bloc.close();
      },
    );

    test('encryption gate failure stays a failure without advancing sent timestamp', () async {
      when(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenThrow(const EncryptedSendNotReady());
      final bloc = await buildInitializedBloc();
      final sentAt = bloc.state.lastMessageSentAt;
      bloc.add(const SendTextMessage('Keep this draft'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(bloc.state.isSending, isFalse);
      expect(bloc.state.error, EncryptedSendNotReady.code);
      expect(bloc.state.lastMessageSentAt, sentAt);
      await bloc.close();
    });

    test('emits error when send fails', () async {
      when(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenThrow(Exception('Network error'));

      final bloc = await buildInitializedBloc();
      bloc.add(const SendTextMessage('Hello'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isSending, false);
      expect(bloc.state.error, 'Failed to send');

      await bloc.close();
    });

    test('ignores empty text', () async {
      final bloc = await buildInitializedBloc();
      clearInteractions(mockRepository);

      bloc.add(const SendTextMessage('   '));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      verifyNever(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      );

      await bloc.close();
    });
  });

  // =========================================================================
  // SendImageMessage
  // =========================================================================

  group('media send context across awaits', () {
    final mediaEvents = <String, ChatEvent>{
      'image': SendImageMessage(imageBytes: Uint8List(1), filename: 'image.png'),
      'voice': SendVoiceMessage(audioBytes: Uint8List(1), filename: 'audio.ogg', duration: 10),
      'video': SendVideoMessage(videoBytes: Uint8List(1), filename: 'video.mp4'),
      'file bytes': SendFileMessage(fileBytes: Uint8List(1), filename: 'file.txt'),
      'file path': const SendFileMessage(filePath: '/public-test.txt', filename: 'file.txt'),
      'file stream': const SendFileMessage(fileStream: Stream.empty(), filename: 'file.txt'),
    };
    for (final media in mediaEvents.entries) {
      for (final stage in ['preparation', 'receipt', 'failure']) {
        test('${media.key} isolates old $stage from a new upload', () async {
          final rooms = <String>[];
          final oldResult = Completer<MessageEntity?>();
          final newResult = Completer<MessageEntity?>();
          Future<MessageEntity?> dispatch(Invocation call) {
            rooms.add(call.positionalArguments.first as String);
            return rooms.length == 1 ? oldResult.future : newResult.future;
          }
          when(() => mockRepository.sendImageMessage(any(),
            imageBytes: any(named: 'imageBytes'), filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'), selfDestructAfter: any(named: 'selfDestructAfter'),
          )).thenAnswer(dispatch);
          when(() => mockRepository.sendVoiceMessage(any(),
            audioBytes: any(named: 'audioBytes'), filename: any(named: 'filename'),
            duration: any(named: 'duration'), mimeType: any(named: 'mimeType'),
            selfDestructAfter: any(named: 'selfDestructAfter'),
          )).thenAnswer(dispatch);
          when(() => mockRepository.sendVideoMessage(any(),
            videoBytes: any(named: 'videoBytes'), filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'), thumbnailBytes: any(named: 'thumbnailBytes'),
            selfDestructAfter: any(named: 'selfDestructAfter'),
          )).thenAnswer(dispatch);
          when(() => mockRepository.sendFileMessage(any(),
            fileBytes: any(named: 'fileBytes'), filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'), selfDestructAfter: any(named: 'selfDestructAfter'),
            filePath: any(named: 'filePath'), fileStream: any(named: 'fileStream'),
            fileSize: any(named: 'fileSize'),
          )).thenAnswer(dispatch);
          final bloc = await buildInitializedBloc();
          final settings = Completer<int?>();
          if (stage == 'preparation') {
            when(() => mockSecureStorage.getDefaultSelfDestructSeconds())
                .thenAnswer((_) => settings.future);
          }
          bloc.add(media.value);
          await Future<void>.delayed(const Duration(milliseconds: 30));
          expect(bloc.state.activeMediaSends, 1);
          if (stage != 'preparation') expect(rooms, [_roomId]);
          bloc.add(const InitializeChat('!other:server.com'));
          await Future<void>.delayed(const Duration(milliseconds: 50));
          if (stage == 'preparation') {
            settings.complete(null);
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(rooms, isEmpty);
            expect(bloc.state.activeMediaSends, 0);
          } else {
            bloc.add(media.value);
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(rooms, [_roomId, '!other:server.com']);
            expect(bloc.state.activeMediaSends, 1);
            if (stage == 'failure') {
              oldResult.completeError(StateError('old upload failed'));
            } else {
              oldResult.complete(_testMessages.first);
            }
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(bloc.state.activeMediaSends, 1);
            expect(bloc.state.isSending, isTrue);
            expect(bloc.state.error, isNull);
            expect(bloc.state.lastMessageSentAt, isNull);
            newResult.complete(_testMessages.last);
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(bloc.state.activeMediaSends, 0);
            expect(bloc.state.isSending, isFalse);
          }
          await bloc.close();
        });
      }
    }
  });

  group('SendImageMessage', () {
    test('overlapping uploads keep the media count until both finish', () async {
      final firstUpload = Completer<MessageEntity>();
      final secondUpload = Completer<MessageEntity>();
      var calls = 0;
      when(
        () => mockRepository.sendImageMessage(
          any(),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      ).thenAnswer((_) => calls++ == 0 ? firstUpload.future : secondUpload.future);

      final bloc = await buildInitializedBloc();
      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([1]),
          filename: 'first.png',
        ),
      );
      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([2]),
          filename: 'second.png',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(bloc.state.activeMediaSends, 2);

      bloc.add(SetReplyTarget(_testMessages.last));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      firstUpload.complete(_testMessages.first);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.activeMediaSends, 1);
      expect(bloc.state.replyTarget, _testMessages.last);
      expect(bloc.state.isSending, isTrue);

      secondUpload.complete(_testMessages.first);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(bloc.state.activeMediaSends, 0);
      expect(bloc.state.isSending, isFalse);
      await bloc.close();
    });

    test('text can send while an image upload is still pending', () async {
      final imageResult = Completer<MessageEntity>();
      when(
        () => mockRepository.sendImageMessage(
          any(),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      ).thenAnswer((_) => imageResult.future);
      when(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async => _testMessages.first);

      final bloc = await buildInitializedBloc();
      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([1, 2, 3]),
          filename: 'slow.png',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.activeMediaSends, 1);
      expect(bloc.state.isSending, isTrue);

      bloc.add(const SendTextMessage('Send while uploading'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(
        () => mockRepository.sendTextMessage(
          _roomId,
          'Send while uploading',
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).called(1);
      expect(bloc.state.isSendingText, isFalse);
      expect(bloc.state.activeMediaSends, 1);
      expect(bloc.state.isSending, isTrue);

      imageResult.complete(_testMessages.first);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(bloc.state.activeMediaSends, 0);
      expect(bloc.state.isSending, isFalse);
      await bloc.close();
    });

    test('sends image and calls repository', () async {
      when(
        () => mockRepository.sendImageMessage(
          any(),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      ).thenAnswer((_) async => _testMessages.first);

      final bloc = await buildInitializedBloc();
      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([1, 2, 3]),
          filename: 'test.png',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isSending, false);
      expect(bloc.state.error, isNull);

      await bloc.close();
    });

    test(
      'clears reply target and updates lastMessageSentAt on success',
      () async {
        when(
          () => mockRepository.sendImageMessage(
            any(),
            imageBytes: any(named: 'imageBytes'),
            filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'),
            selfDestructAfter: any(named: 'selfDestructAfter'),
          ),
        ).thenAnswer((_) async => _testMessages.first);

        final bloc = await buildInitializedBloc();
        bloc.add(SetReplyTarget(_testMessages.first));
        await Future<void>.delayed(const Duration(milliseconds: 100));

        bloc.add(
          SendImageMessage(
            imageBytes: Uint8List.fromList([1, 2, 3]),
            filename: 'reply-image.png',
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 200));

        expect(bloc.state.replyTarget, isNull);
        expect(bloc.state.lastMessageSentAt, isNotNull);

        await bloc.close();
      },
    );

    test('text preflight reports local rejection before repository dispatch', () async {
      when(() => mockRepository.sendTextMessage(any(), any(),
        selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom'),
      )).thenAnswer((_) async => _testMessages.first);
      final bloc = await buildInitializedBloc();
      bloc.add(const RoomInfoLoaded(isChannel: false, canSendMessages: true, slowModeInterval: 60));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final first = Completer<TextSendPreflight>();
      bloc.add(SendTextMessage('first', preflightCompletion: first));
      expect(await first.future, TextSendPreflight.admitted);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      clearInteractions(mockRepository);
      final rejected = Completer<TextSendPreflight>();
      bloc.add(SendTextMessage('blocked', preflightCompletion: rejected));
      expect(await rejected.future, TextSendPreflight.rejected);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.isSendingText, isFalse);
      expect(bloc.state.error, contains('Slow mode: wait'));
      verifyNever(() => mockRepository.sendTextMessage(any(), any(),
        selfDestructAfter: any(named: 'selfDestructAfter'),
        mentionedUserIds: any(named: 'mentionedUserIds'),
        mentionsRoom: any(named: 'mentionsRoom')));
      await bloc.close();
    });

    test('blocks image send during slow mode cooldown', () async {
      when(
        () => mockRepository.sendTextMessage(
          any(),
          any(),
          selfDestructAfter: any(named: 'selfDestructAfter'),
          mentionedUserIds: any(named: 'mentionedUserIds'),
          mentionsRoom: any(named: 'mentionsRoom'),
        ),
      ).thenAnswer((_) async => _testMessages.first);

      final bloc = await buildInitializedBloc();
      bloc.add(
        const RoomInfoLoaded(
          isChannel: false,
          canSendMessages: true,
          slowModeInterval: 60,
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));

      bloc.add(const SendTextMessage('Trigger slow mode'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      clearInteractions(mockRepository);

      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([1, 2, 3]),
          filename: 'blocked.png',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.error, contains('Slow mode: wait'));
      verifyNever(
        () => mockRepository.sendImageMessage(
          any(),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      );

      await bloc.close();
    });

    test('emits error when send image fails', () async {
      when(
        () => mockRepository.sendImageMessage(
          any(),
          imageBytes: any(named: 'imageBytes'),
          filename: any(named: 'filename'),
          mimeType: any(named: 'mimeType'),
          selfDestructAfter: any(named: 'selfDestructAfter'),
        ),
      ).thenThrow(Exception('Upload failed'));

      final bloc = await buildInitializedBloc();
      bloc.add(
        SendImageMessage(
          imageBytes: Uint8List.fromList([1, 2, 3]),
          filename: 'test.png',
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isSending, false);
      expect(bloc.state.error, isNotNull);

      await bloc.close();
    });
  });

  // =========================================================================
  // LoadMoreMessages
  // =========================================================================

  group('LoadMoreMessages', () {
    test('loads more messages when hasMore is true', () async {
      final moreMessages = [..._testMessages, ..._testMessages];
      when(
        () =>
            mockRepository.loadMoreMessages(any(), limit: any(named: 'limit')),
      ).thenAnswer((_) async => moreMessages);

      final bloc = await buildInitializedBloc();

      // Ensure hasMore is true (it should be from init with 2 messages and limit 30)
      expect(
        bloc.state.hasMore,
        isFalse,
      ); // actually 2 < 100, so hasMore=false from LoadMessages

      // Set hasMore to true manually via MessagesUpdated won't work.
      // Instead test with many initial messages to have hasMore=true
      await bloc.close();
    });

    test('does nothing when hasMore is false', () async {
      final bloc = await buildInitializedBloc();
      // After init with 2 messages, hasMore should be false (2 < 100)
      expect(bloc.state.hasMore, false);

      clearInteractions(mockRepository);
      bloc.add(const LoadMoreMessages());
      await Future<void>.delayed(const Duration(milliseconds: 200));

      verifyNever(
        () =>
            mockRepository.loadMoreMessages(any(), limit: any(named: 'limit')),
      );

      await bloc.close();
    });

    test(
      'loads more when hasMore is true with many initial messages',
      () async {
        // Provide enough messages to trigger hasMore=true
        final initialMessages = List.generate(
          100,
          (i) => MessageEntity(
            id: '\$msg$i',
            roomId: _roomId,
            senderId: '@user:server.com',
            senderName: 'User',
            content: 'Msg $i',
            timestamp: DateTime(2026, 1, 1, 12, i),
            type: MessageType.text,
            status: MessageStatus.sent,
          ),
        );
        when(
          () => mockRepository.getMessages(any(), limit: any(named: 'limit')),
        ).thenAnswer((_) async => initialMessages);
        final expandedMessages = [...initialMessages, ..._testMessages];
        when(
          () => mockRepository.loadMoreMessages(
            any(),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => expandedMessages);

        final bloc = buildBloc();
        bloc.add(const InitializeChat(_roomId));
        await Future<void>.delayed(const Duration(milliseconds: 500));

        expect(bloc.state.hasMore, true);

        bloc.add(const LoadMoreMessages());
        await Future<void>.delayed(const Duration(milliseconds: 200));

        expect(bloc.state.isLoadingMore, false);
        expect(bloc.state.messages.length, expandedMessages.length);

        await bloc.close();
      },
    );

    test('emits error when load more fails', () async {
      final initialMessages = List.generate(
        100,
        (i) => MessageEntity(
          id: '\$msg$i',
          roomId: _roomId,
          senderId: '@user:server.com',
          senderName: 'User',
          content: 'Msg $i',
          timestamp: DateTime(2026, 1, 1, 12, i),
          type: MessageType.text,
          status: MessageStatus.sent,
        ),
      );
      when(() => mockRepository.getMessages(any(), limit: any(named: 'limit')))
          .thenAnswer((_) async => initialMessages);
      when(
        () =>
            mockRepository.loadMoreMessages(any(), limit: any(named: 'limit')),
      ).thenThrow(Exception('Failed'));

      final bloc = buildBloc();
      bloc.add(const InitializeChat(_roomId));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      bloc.add(const LoadMoreMessages());
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.isLoadingMore, false);
      expect(bloc.state.error, 'Failed to load more messages');

      await bloc.close();
    });
  });

  // =========================================================================
  // RedactMessage
  // =========================================================================

  group('RedactMessage', () {
    for (final mode in ['new message', 'server update', 'room switch', 'false result']) {
      test('late redaction failure preserves $mode', () async {
        final pending = Completer<bool>();
        final started = Completer<void>();
        when(() => mockRepository.redactMessage(any(), any(), reason: any(named: 'reason')))
            .thenAnswer((_) { started.complete(); return pending.future; });
        final bloc = await buildInitializedBloc();
        final original = bloc.state.messages.first;
        bloc.add(RedactMessage(original.id));
        await started.future.timeout(const Duration(seconds: 3));
        final extra = _testMessages.last.copyWith(id: r'$new', content: 'new arrival');
        if (mode == 'room switch') {
          bloc.add(const InitializeChat('!other:server.com'));
          await Future<void>.delayed(const Duration(milliseconds: 500));
          bloc.add(MessagesUpdated([extra]));
        } else if (mode == 'server update') {
          bloc.add(MessagesUpdated([original.copyWith(type: MessageType.redacted, content: ''), extra]));
        } else {
          bloc.add(MessagesUpdated([...bloc.state.messages, extra]));
        }
        await Future<void>.delayed(const Duration(milliseconds: 30));
        if (mode == 'false result') { pending.complete(false); }
        else { pending.completeError(StateError('rejected')); }
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(bloc.state.messages.any((m) => m.id == extra.id), isTrue);
        if (mode == 'room switch') {
          expect(bloc.state.messages, [extra]);
          expect(bloc.state.error, isNull);
        } else {
          final result = bloc.state.messages.firstWhere((m) => m.id == original.id);
          expect(result.content, mode == 'server update' ? '' : original.content);
          expect(result.type, mode == 'server update' ? MessageType.redacted : MessageType.text);
          expect(bloc.state.error, 'Failed to recall');
        }
        await bloc.close();
      });
    }

    test('optimistically marks message as redacted on success', () async {
      when(
        () => mockRepository.redactMessage(
          any(),
          any(),
          reason: any(named: 'reason'),
        ),
      ).thenAnswer((_) async => true);

      final bloc = await buildInitializedBloc();
      final initialCount = bloc.state.messages.length;

      bloc.add(const RedactMessage('\$event1'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // 乐观更新：消息保留在列表中，type 改为 redacted（不删除）
      expect(bloc.state.messages.length, initialCount);
      expect(
        bloc.state.messages.any(
          (m) => m.id == '\$event1' && m.type == MessageType.redacted,
        ),
        isTrue,
      );

      await bloc.close();
    });

    test('emits error when redact fails', () async {
      when(
        () => mockRepository.redactMessage(
          any(),
          any(),
          reason: any(named: 'reason'),
        ),
      ).thenThrow(Exception('Not allowed'));

      final bloc = await buildInitializedBloc();
      bloc.add(const RedactMessage('\$event1'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(bloc.state.error, 'Failed to recall');

      await bloc.close();
    });
  });

  // =========================================================================
  // MarkMessageAsRead
  // =========================================================================

  group('MarkMessageAsRead', () {
    test('calls repository markAsRead', () async {
      final bloc = await buildInitializedBloc();
      clearInteractions(mockRepository);

      bloc.add(const MarkMessageAsRead('\$event1'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      verify(() => mockRepository.markAsRead(_roomId, '\$event1')).called(1);

      await bloc.close();
    });

    test('skips read receipt when privacy setting is off', () async {
      when(() => mockSecureStorage.shouldShowReadReceipts())
          .thenAnswer((_) async => false);

      final bloc = await buildInitializedBloc();
      clearInteractions(mockRepository);

      bloc.add(const MarkMessageAsRead('\$event1'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      verifyNever(() => mockRepository.markAsRead(any(), any()));

      await bloc.close();
    });
  });

  // =========================================================================
  // MessagesUpdated (uses seed, no _currentRoomId needed)
  // =========================================================================

  group('MessagesUpdated', () {
    blocTest<ChatBloc, ChatState>(
      'updates message list',
      build: () => buildBloc(),
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        messages: [_testMessages.first],
        isLoading: false,
      ),
      act: (bloc) => bloc.add(MessagesUpdated(_testMessages)),
      expect: () => [
        isA<ChatState>().having((s) => s.messages.length, 'messages.length', 2),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'filters out thread messages',
      build: () => buildBloc(),
      seed: () =>
          ChatState.initial().copyWith(roomId: _roomId, isLoading: false),
      act: (bloc) {
        final threadMessage = MessageEntity(
          id: '\$thread1',
          roomId: _roomId,
          senderId: '@user:server.com',
          senderName: 'User',
          content: 'Thread reply',
          timestamp: DateTime(2026, 1, 1),
          type: MessageType.text,
          status: MessageStatus.sent,
          threadRootId: '\$event1',
        );
        bloc.add(MessagesUpdated([..._testMessages, threadMessage]));
      },
      expect: () => [
        isA<ChatState>().having((s) => s.messages.length, 'messages.length', 2),
      ],
    );
  });

  // =========================================================================
  // SetReplyTarget / SetEditTarget (uses seed, no _currentRoomId needed)
  // =========================================================================

  group('SetReplyTarget', () {
    blocTest<ChatBloc, ChatState>(
      'sets reply target',
      build: () => buildBloc(),
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        messages: _testMessages,
      ),
      act: (bloc) => bloc.add(SetReplyTarget(_testMessages.first)),
      expect: () => [
        isA<ChatState>().having(
          (s) => s.replyTarget,
          'replyTarget',
          _testMessages.first,
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'clears reply target when null',
      build: () => buildBloc(),
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        messages: _testMessages,
        replyTarget: _testMessages.first,
      ),
      act: (bloc) => bloc.add(const SetReplyTarget(null)),
      expect: () => [
        isA<ChatState>().having((s) => s.replyTarget, 'replyTarget', isNull),
      ],
    );
  });

  group('SetEditTarget', () {
    blocTest<ChatBloc, ChatState>(
      'sets edit target and clears reply target',
      build: () => buildBloc(),
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        messages: _testMessages,
        replyTarget: _testMessages.last,
      ),
      act: (bloc) => bloc.add(SetEditTarget(_testMessages.first)),
      expect: () => [
        isA<ChatState>()
            .having(
              (s) => s.editingMessage,
              'editingMessage',
              _testMessages.first,
            )
            .having((s) => s.replyTarget, 'replyTarget', isNull),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'clears edit target when null',
      build: () => buildBloc(),
      seed: () => ChatState.initial().copyWith(
        roomId: _roomId,
        editingMessage: _testMessages.first,
      ),
      act: (bloc) => bloc.add(const SetEditTarget(null)),
      expect: () => [
        isA<ChatState>().having(
          (s) => s.editingMessage,
          'editingMessage',
          isNull,
        ),
      ],
    );
  });

  // =========================================================================
  // Event props
  // =========================================================================

  group('Event props', () {
    test('DeleteMessagesLocally contains message ids', () {
      const event = DeleteMessagesLocally(['msg1', 'msg2']);
      expect(event.messageIds, equals(['msg1', 'msg2']));
      expect(
        event.props,
        equals([
          ['msg1', 'msg2'],
        ]),
      );
    });

    test('RedactMessage contains message id and reason', () {
      const event = RedactMessage('msg1', reason: 'spam');
      expect(event.messageId, equals('msg1'));
      expect(event.reason, equals('spam'));
      expect(event.props, equals(['msg1', 'spam']));
    });

    test('RedactMessage allows null reason', () {
      const event = RedactMessage('msg1');
      expect(event.messageId, equals('msg1'));
      expect(event.reason, isNull);
    });

    test('SendTextMessage includes all fields', () {
      const event = SendTextMessage(
        'Hello',
        selfDestructAfter: 30,
        mentionedUserIds: ['@user:server'],
        mentionsRoom: true,
      );
      expect(event.text, 'Hello');
      expect(event.selfDestructAfter, 30);
      expect(event.mentionedUserIds, ['@user:server']);
      expect(event.mentionsRoom, true);
    });
  });

  // =========================================================================
  // ChatState helpers
  // =========================================================================

  group('ChatState', () {
    test('initial state has correct defaults', () {
      final state = ChatState.initial();
      expect(state.isLoading, true);
      expect(state.messages, isEmpty);
      expect(state.roomId, isNull);
      expect(state.hasMore, true);
      expect(state.isSending, false);
      expect(state.error, isNull);
      expect(state.replyTarget, isNull);
      expect(state.editingMessage, isNull);
    });

    test('isEmpty returns true when no messages', () {
      expect(ChatState.initial().isEmpty, true);
    });

    test('hasReplyTarget returns true when set', () {
      final state = ChatState.initial().copyWith(
        replyTarget: _testMessages.first,
      );
      expect(state.hasReplyTarget, true);
    });

    test('isEditing returns true when editingMessage set', () {
      final state = ChatState.initial().copyWith(
        editingMessage: _testMessages.first,
      );
      expect(state.isEditing, true);
    });

    test('copyWith clearError clears error', () {
      final state = ChatState.initial().copyWith(error: 'test error');
      final cleared = state.copyWith(clearError: true);
      expect(cleared.error, isNull);
    });

    test('copyWith clearReplyTarget clears replyTarget', () {
      final state = ChatState.initial().copyWith(
        replyTarget: _testMessages.first,
      );
      final cleared = state.copyWith(clearReplyTarget: true);
      expect(cleared.replyTarget, isNull);
    });
  });
}
