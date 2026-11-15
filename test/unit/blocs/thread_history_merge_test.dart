import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/domain/repositories/thread_pagination_repository.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_event.dart';

class _Repo extends Mock
    implements IMessageRepository, IThreadHistoryVisibilityRepository {}

class _PagedRepo extends Mock
    implements
        IMessageRepository,
        IThreadPaginationRepository,
        IThreadHistoryVisibilityRepository {}

void main() {
  late _Repo repo;
  late ThreadBloc bloc;
  var current = true;
  MessageEntity message(String id, {int second = 0, String? content}) =>
      MessageEntity(
        id: id,
        roomId: '!room',
        senderId: '@$id',
        senderName: id,
        content: content ?? id,
        timestamp: DateTime.utc(2026).add(Duration(seconds: second)),
        type: MessageType.text,
      );
  setUp(() async {
    current = true;
    repo = _Repo();
    when(() => repo.captureThreadSession()).thenReturn(() => current);
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) async => [message('root'), message('old')]);
    when(() => repo.watchThreadMessages(any(), any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => repo.filterThreadHistory(any(), any())).thenAnswer(
      (call) async => call.positionalArguments[1] as List<MessageEntity>,
    );
    bloc = ThreadBloc(messageRepository: repo)
      ..add(const InitializeThread(roomId: '!room', threadRootEventId: 'root'));
    await pumpEventQueue();
  });
  tearDown(() => bloc.close());
  test(
    'partial snapshot retains older replies and updates duplicates',
    () async {
      bloc.add(
        ThreadMessagesUpdated([
          message('new', second: 2),
          message('old', content: 'edited'),
        ]),
      );
      await pumpEventQueue();
      expect(bloc.state.replies.map((m) => m.id), ['old', 'new']);
      expect(bloc.state.replies.first.content, 'edited');
      expect(bloc.state.participantCount, 3);
      bloc.add(ThreadMessagesUpdated([message('new', second: 2)]));
      await pumpEventQueue();
      expect(bloc.state.replies.map((m) => m.id), ['old', 'new']);
    },
  );
  test(
    'visibility filtering can remove retained root and old replies',
    () async {
      when(() => repo.filterThreadHistory(any(), any())).thenAnswer(
        (call) async => (call.positionalArguments[1] as List<MessageEntity>)
            .where((m) => m.timestamp.isAfter(DateTime.utc(2026)))
            .toList(),
      );
      bloc.add(ThreadMessagesUpdated([message('new', second: 1)]));
      await pumpEventQueue();
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies.map((m) => m.id), ['new']);
      expect(bloc.state.participantCount, 1);
    },
  );
  test('newer snapshot wins over delayed visibility result', () async {
    final pending = Completer<List<MessageEntity>>();
    var calls = 0;
    when(() => repo.filterThreadHistory(any(), any())).thenAnswer((call) {
      calls++;
      return calls == 1
          ? pending.future
          : Future.value(call.positionalArguments[1] as List<MessageEntity>);
    });
    bloc.add(ThreadMessagesUpdated([message('new', content: 'stale')]));
    await pumpEventQueue();
    bloc.add(ThreadMessagesUpdated([message('new', content: 'fresh')]));
    await pumpEventQueue();
    pending.complete([message('new', content: 'stale')]);
    await pumpEventQueue();
    expect(
      bloc.state.replies.singleWhere((m) => m.id == 'new').content,
      'fresh',
    );
    expect(bloc.state.replies.any((m) => m.id == 'old'), isTrue);
  });
  test(
    'page completion during visibility read survives revalidation',
    () async {
      when(() => repo.getThreadMessages('!room', 'root')).thenAnswer(
        (_) async => [
          message('root'),
          ...List.generate(49, (i) => message('reply$i')),
        ],
      );
      bloc.add(
        const InitializeThread(roomId: '!room', threadRootEventId: 'root'),
      );
      await pumpEventQueue();
      final pending = Completer<List<MessageEntity>>();
      var calls = 0;
      when(() => repo.filterThreadHistory(any(), any())).thenAnswer(
        (call) => ++calls == 1
            ? pending.future
            : Future.value(call.positionalArguments[1] as List<MessageEntity>),
      );
      bloc.add(ThreadMessagesUpdated([message('live', second: 2)]));
      await pumpEventQueue();
      when(
        () => repo.getThreadMessages(
          '!room',
          'root',
          limit: 50,
          fromEventId: 'reply0',
        ),
      ).thenAnswer((_) async => [message('older', second: -1)]);
      bloc.add(const LoadMoreThreadMessages());
      await pumpEventQueue();
      expect(bloc.state.replies.first.id, 'older');
      pending.complete([message('live', second: 2)]);
      await pumpEventQueue();
      expect(bloc.state.replies.first.id, 'older');
      expect(bloc.state.replies.last.id, 'live');
      expect(bloc.state.replies.length, 51);
      expect(calls, 2);
    },
  );

  test('refresh retains older replies and applies refreshed content', () async {
    when(() => repo.getThreadMessages(any(), any())).thenAnswer(
      (_) async => [
        message('old', content: 'refreshed edit'),
        message('new', second: 2),
      ],
    );
    bloc.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(bloc.state.replies.map((m) => m.id), ['old', 'new']);
    expect(bloc.state.participantCount, 3);
    expect(bloc.state.replies.first.content, 'refreshed edit');
  });

  test('live changes during refresh win over an older response', () async {
    final pending = Completer<List<MessageEntity>>();
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) => pending.future);
    bloc.add(const LoadThreadMessages());
    await pumpEventQueue();
    bloc.add(
      ThreadMessagesUpdated([
        message('old', content: 'live edit'),
        message('live', second: 3),
      ]),
    );
    await pumpEventQueue();
    pending.complete([message('old', content: 'stale response')]);
    await pumpEventQueue();
    expect(bloc.state.replies.map((m) => m.id), ['old', 'live']);
    expect(bloc.state.replies.first.content, 'live edit');
    expect(bloc.state.isLoading, isFalse);
  });

  test('refresh revalidates retained history against clearing', () async {
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) async => [message('new', second: 2)]);
    when(() => repo.filterThreadHistory(any(), any())).thenAnswer(
      (call) async => (call.positionalArguments[1] as List<MessageEntity>)
          .where((m) => m.id == 'new')
          .toList(),
    );
    bloc.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(bloc.state.rootMessage, isNull);
    expect(bloc.state.replies.map((m) => m.id), ['new']);
    expect(bloc.state.participantCount, 1);
  });

  test('refresh keeps the oldest-page cursor and exhausted state', () async {
    final paged = _PagedRepo();
    when(() => paged.captureThreadSession()).thenReturn(() => true);
    when(() => paged.watchThreadMessages(any(), any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => paged.filterThreadHistory(any(), any())).thenAnswer(
      (call) async => call.positionalArguments[1] as List<MessageEntity>,
    );
    when(() => paged.getThreadMessagePage('!room', 'root')).thenAnswer(
      (_) async => ThreadMessagePage(
        messages: [message('root'), message('recent')],
        nextBatch: 'first',
      ),
    );
    when(() => paged.getThreadMessagePage('!room', 'root', fromToken: 'first'))
        .thenAnswer(
          (_) async => ThreadMessagePage(
            messages: [message('older', second: -2)],
            nextBatch: 'oldest',
          ),
        );
    when(() => paged.getThreadMessagePage('!room', 'root', fromToken: 'oldest'))
        .thenAnswer((_) async => const ThreadMessagePage());
    final b = ThreadBloc(messageRepository: paged);
    addTearDown(b.close);
    b.add(const InitializeThread(roomId: '!room', threadRootEventId: 'root'));
    await pumpEventQueue();
    b.add(const LoadMoreThreadMessages());
    await pumpEventQueue();
    expect(b.state.nextBatch, 'oldest');
    b.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(b.state.replies.map((m) => m.id), ['older', 'recent']);
    expect(b.state.nextBatch, 'oldest');
    b.add(const LoadMoreThreadMessages());
    await pumpEventQueue();
    expect(b.state.hasMore, isFalse);
    b.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(b.state.hasMore, isFalse);
    expect(b.state.nextBatch, isNull);
    expect(b.state.replies.map((m) => m.id), ['older', 'recent']);
    verify(
      () => paged.getThreadMessagePage('!room', 'root', fromToken: 'oldest'),
    ).called(1);
    when(() => paged.filterThreadHistory(any(), any()))
        .thenThrow(StateError('visibility unavailable'));
    b.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(b.state.replies, isEmpty);
    when(() => paged.filterThreadHistory(any(), any())).thenAnswer(
      (call) async => call.positionalArguments[1] as List<MessageEntity>,
    );
    b.add(const LoadThreadMessages());
    await pumpEventQueue();
    expect(b.state.replies.map((m) => m.id), ['recent']);
    expect(b.state.hasMore, isTrue);
    expect(b.state.nextBatch, 'first');
  });

  test('refresh repeats visibility after a concurrent live update', () async {
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) async => [message('fetched', second: 2)]);
    final pending = Completer<List<MessageEntity>>();
    var calls = 0;
    when(() => repo.filterThreadHistory(any(), any())).thenAnswer((call) {
      calls++;
      return calls == 1
          ? pending.future
          : Future.value(call.positionalArguments[1] as List<MessageEntity>);
    });
    bloc.add(const LoadThreadMessages());
    await pumpEventQueue();
    bloc.add(ThreadMessagesUpdated([message('live', second: 3)]));
    await pumpEventQueue();
    pending.complete([
      message('root'),
      message('old'),
      message('fetched', second: 2),
    ]);
    await pumpEventQueue();
    expect(bloc.state.replies.map((m) => m.id), ['old', 'fetched', 'live']);
    expect(calls, 3);
  });

  test(
    'refresh visibility failure hides history until explicit retry',
    () async {
      when(() => repo.filterThreadHistory(any(), any()))
          .thenThrow(StateError('storage unavailable'));
      bloc.add(const LoadThreadMessages());
      await pumpEventQueue();
      expect(bloc.state.replies, isEmpty);
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.error, contains('storage unavailable'));
      when(() => repo.filterThreadHistory(any(), any())).thenAnswer(
        (call) async => call.positionalArguments[1] as List<MessageEntity>,
      );
      bloc.add(const LoadThreadMessages());
      await pumpEventQueue();
      expect(bloc.state.replies.map((m) => m.id), ['old']);
      expect(bloc.state.error, isNull);
    },
  );

  test('visibility failure hides unverified retained history', () async {
    when(() => repo.filterThreadHistory(any(), any()))
        .thenThrow(StateError('storage unavailable'));
    bloc.add(ThreadMessagesUpdated([message('new')]));
    await pumpEventQueue();
    expect(bloc.state.replies, isEmpty);
    expect(bloc.state.rootMessage, isNull);
    expect(bloc.state.error, contains('storage unavailable'));
  });

  test(
    'account switch invalidates retained-session updates and sending',
    () async {
      clearInteractions(repo);
      current = false;
      bloc.add(
        const InitializeThread(
          roomId: '!room',
          threadRootEventId: 'root',
          isRetry: true,
        ),
      );
      bloc.add(ThreadMessagesUpdated([message('other-account')]));
      final completion = Completer<bool>();
      bloc.add(SendThreadTextMessage('text', completion: completion));
      await pumpEventQueue();
      expect(await completion.future, isFalse);
      expect(bloc.state.replies.map((m) => m.id), ['old']);
      verifyNever(() => repo.getThreadMessages(any(), any()));
      verifyNever(() => repo.filterThreadHistory(any(), any()));
      verifyNever(() => repo.sendThreadTextMessage(any(), any(), any()));
    },
  );
}
