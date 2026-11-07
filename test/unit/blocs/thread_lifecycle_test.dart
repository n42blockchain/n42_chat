import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_event.dart';

class _Repository extends Mock implements IMessageRepository {}

void main() {
  late _Repository repository;
  late ThreadBloc bloc;
  MessageEntity message(String id) => MessageEntity(
    id: id,
    roomId: '!room',
    senderId: '@alice',
    senderName: 'Alice',
    content: id,
    timestamp: DateTime.utc(2026),
    type: MessageType.text,
  );
  Future<void> initialize(String root) async {
    bloc.add(InitializeThread(roomId: '!room', threadRootEventId: root));
    await pumpEventQueue();
  }

  setUp(() {
    repository = _Repository();
    when(() => repository.getThreadMessages(any(), any())).thenAnswer(
      (call) async => [message(call.positionalArguments[1] as String)],
    );
    when(() => repository.watchThreadMessages(any(), any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => repository.watchMessage(any(), any()))
        .thenAnswer((_) => Stream.value(null));
    bloc = ThreadBloc(messageRepository: repository);
  });
  tearDown(() async => bloc.close());

  test(
    'fresh initialization removes old root and replies before loading',
    () async {
      await initialize('old');
      final pending = Completer<List<MessageEntity>>();
      when(() => repository.getThreadMessages('!room', 'new'))
          .thenAnswer((_) => pending.future);
      await initialize('new');
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies, isEmpty);
      pending.complete([]);
      await pumpEventQueue();
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.threadRootEventId, 'new');
    },
  );

  for (final failure in [false, true]) {
    test(
      'late initialization cannot replace newer thread, failure=$failure',
      () async {
        final pending = Completer<List<MessageEntity>>();
        when(() => repository.getThreadMessages('!room', 'old'))
            .thenAnswer((_) => pending.future);
        await initialize('old');
        await initialize('new');
        if (failure) {
          pending.completeError(StateError('old failure'));
        } else {
          pending.complete([message('old')]);
        }
        await pumpEventQueue();
        expect(bloc.state.rootMessage?.id, 'new');
        expect(bloc.state.error, isNull);
        verifyNever(() => repository.watchThreadMessages('!room', 'old'));
      },
    );
  }

  test('same-thread reinitialization invalidates a pending refresh', () async {
    await initialize('root');
    final pending = Completer<List<MessageEntity>>();
    when(() => repository.getThreadMessages('!room', 'root'))
        .thenAnswer((_) => pending.future);
    bloc.add(const LoadThreadMessages());
    await pumpEventQueue();
    when(() => repository.getThreadMessages('!room', 'root'))
        .thenAnswer((_) async => [message('root'), message('fresh')]);
    await initialize('root');
    pending.complete([message('stale')]);
    await pumpEventQueue();
    expect(bloc.state.replies.map((m) => m.id), ['fresh']);
  });

  test('dispose clears state and invalidates pending initialization', () async {
    final pending = Completer<List<MessageEntity>>();
    when(() => repository.getThreadMessages('!room', 'root'))
        .thenAnswer((_) => pending.future);
    await initialize('root');
    bloc.add(const DisposeThread());
    await pumpEventQueue();
    expect(bloc.state.roomId, isNull);
    pending.complete([message('root')]);
    await pumpEventQueue();
    expect(bloc.state.roomId, isNull);
    expect(bloc.state.rootMessage, isNull);
    verifyNever(() => repository.watchThreadMessages(any(), any()));
  });

  test('queued stream update rejects its expired origin', () async {
    await initialize('root');
    bloc.add(ThreadMessagesUpdated([message('stale')], isCurrent: () => false));
    await pumpEventQueue();
    expect(bloc.state.replies, isEmpty);
  });

  test(
    'pagination is single-flight and preserves newer overlapping content',
    () async {
      when(() => repository.getThreadMessages('!room', 'root')).thenAnswer(
        (_) async => [
          message('root'),
          ...List.generate(49, (i) => message('reply$i')),
        ],
      );
      await initialize('root');
      final pending = Completer<List<MessageEntity>>();
      when(
        () => repository.getThreadMessages(
          '!room',
          'root',
          limit: 50,
          fromEventId: 'reply0',
        ),
      ).thenAnswer((_) => pending.future);
      bloc.add(const LoadMoreThreadMessages());
      await pumpEventQueue();
      bloc.add(const LoadMoreThreadMessages());
      bloc.add(const LoadThreadMessages());
      final fresh = message('reply0')
          .copyWith(content: 'updated during paging');
      bloc.add(ThreadMessagesUpdated([fresh, message('live')]));
      await pumpEventQueue();
      pending.complete([message('older'), message('reply0'), message('older')]);
      await pumpEventQueue();
      expect(bloc.state.replies.map((m) => m.id), [
        'older',
        ...List.generate(49, (i) => 'reply$i'),
        'live',
      ]);
      expect(bloc.state.replies[1].content, 'updated during paging');
      verify(
        () => repository.getThreadMessages(
          '!room',
          'root',
          limit: 50,
          fromEventId: 'reply0',
        ),
      ).called(1);
      verify(() => repository.getThreadMessages('!room', 'root')).called(1);
    },
  );

  test('old send failure does not write error to new thread', () async {
    await initialize('old');
    final pending = Completer<MessageEntity?>();
    when(() => repository.sendThreadTextMessage('!room', 'old', 'text'))
        .thenAnswer((_) => pending.future);
    bloc.add(const SendThreadTextMessage('text'));
    await pumpEventQueue();
    await initialize('new');
    pending.completeError(StateError('old send failure'));
    await pumpEventQueue();
    expect(bloc.state.rootMessage?.id, 'new');
    expect(bloc.state.error, isNull);
    expect(bloc.state.isSending, isFalse);
  });
}
