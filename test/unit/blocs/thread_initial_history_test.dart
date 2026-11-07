import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/domain/repositories/thread_pagination_repository.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_event.dart';

class _Repo extends Mock
    implements
        IMessageRepository,
        IThreadHistoryVisibilityRepository,
        IThreadHistoryChangesRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final boundary = DateTime.utc(2026, 11, 6);
  MessageEntity message(String id, int seconds) => MessageEntity(
    id: id,
    roomId: '!room',
    senderId: '@alice',
    senderName: 'Alice',
    content: id,
    timestamp: boundary.add(Duration(seconds: seconds)),
    type: MessageType.text,
  );
  late _Repo repo;
  late ThreadBloc bloc;
  late Completer<MessageEntity?> root;
  late ChatHistoryClearStore store;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    store = ChatHistoryClearStore();
    root = Completer<MessageEntity?>();
    repo = _Repo();
    when(() => repo.captureThreadSession()).thenReturn(() => true);
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) async => [message('old', -1), message('new', 1)]);
    when(() => repo.watchMessage(any(), any()))
        .thenAnswer((_) => Stream.fromFuture(root.future));
    when(() => repo.watchThreadMessages(any(), any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => repo.watchThreadHistoryChanges(any()))
        .thenAnswer((_) => store.watch(ownerUserId: '@alice', roomId: '!room'));
    when(() => repo.filterThreadHistory(any(), any())).thenAnswer((call) async {
      final cutoff = await store.read(
        ownerUserId: '@alice',
        roomId: '!room',
        isCurrent: () => true,
      );
      return (call.positionalArguments[1] as List<MessageEntity>)
          .where((m) => cutoff == null || m.timestamp.isAfter(cutoff))
          .toList();
    });
    bloc = ThreadBloc(messageRepository: repo);
  });
  tearDown(() => bloc.close());

  test(
    'clear while root loads also removes previously loaded replies',
    () async {
      bloc.add(
        const InitializeThread(roomId: '!room', threadRootEventId: 'root'),
      );
      await pumpEventQueue();
      expect(bloc.state.isLoading, isTrue);
      verify(() => repo.watchMessage('!room', 'root')).called(1);
      await store.clearThrough(
        ownerUserId: '@alice',
        roomId: '!room',
        boundary: boundary,
        isCurrent: () => true,
      );
      await pumpEventQueue();
      root.complete(null);
      await pumpEventQueue();
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies.map((m) => m.id), ['new']);
      expect(bloc.state.participantCount, 1);
    },
  );

  test(
    'failed final visibility read does not display unvalidated history',
    () async {
      when(() => repo.filterThreadHistory(any(), any()))
          .thenThrow(StateError('storage unavailable'));
      bloc.add(
        const InitializeThread(roomId: '!room', threadRootEventId: 'root'),
      );
      await pumpEventQueue();
      root.complete(message('root', -2));
      await pumpEventQueue();
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies, isEmpty);
      expect(bloc.state.error, contains('storage unavailable'));
    },
  );
  test(
    'clear during final visibility read invalidates its stale result',
    () async {
      final pending = Completer<List<MessageEntity>>();
      List<MessageEntity>? captured;
      when(() => repo.filterThreadHistory(any(), any()))
          .thenAnswer((call) async {
            final messages = call.positionalArguments[1] as List<MessageEntity>;
            if (messages.isNotEmpty && captured == null) {
              captured = List.of(messages);
              return pending.future;
            }
            final cutoff = await store.read(
              ownerUserId: '@alice',
              roomId: '!room',
              isCurrent: () => true,
            );
            return messages
                .where((m) => cutoff == null || m.timestamp.isAfter(cutoff))
                .toList();
          });
      bloc.add(
        const InitializeThread(roomId: '!room', threadRootEventId: 'root'),
      );
      root.complete(message('root', -2));
      await pumpEventQueue();
      expect(captured, isNotNull);
      await store.clearThrough(
        ownerUserId: '@alice',
        roomId: '!room',
        boundary: boundary,
        isCurrent: () => true,
      );
      await pumpEventQueue();
      pending.complete(captured!);
      await pumpEventQueue();
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies.map((m) => m.id), ['new']);
    },
  );
}
