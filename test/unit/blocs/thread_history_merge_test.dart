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
