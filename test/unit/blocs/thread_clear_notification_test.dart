import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'package:n42_chat/src/data/repositories/message_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/thread_pagination_repository.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_event.dart';

import '../repositories/message_repository_impl_test.dart'
    show
        MockMatrixMessageDataSource,
        MockMatrixClientManager,
        MockPreferencesDataSource,
        MockClient;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ThreadBloc bloc;
  late MockClient client;
  final time = DateTime.utc(2026, 11, 6);
  MessageEntity message(String id, int offset) => MessageEntity(
    id: id,
    roomId: '!room',
    senderId: '@alice',
    senderName: 'Alice',
    content: id,
    timestamp: time.add(Duration(seconds: offset)),
    type: MessageType.text,
  );
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final source = MockMatrixMessageDataSource();
    final manager = MockMatrixClientManager();
    client = MockClient();
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice');
    when(
      () => source.getThreadMessagePage(
        '!room',
        'root',
        limit: 50,
        fromToken: null,
      ),
    ).thenAnswer(
      (_) async => ThreadMessagePage(
        messages: [message('root', -2), message('old', -1), message('new', 1)],
      ),
    );
    when(() => source.watchThreadMessages('!room', 'root'))
        .thenAnswer((_) => const Stream.empty());
    final repo = MessageRepositoryImpl(
      source,
      manager,
      MockPreferencesDataSource(),
      historyClearStore: ChatHistoryClearStore(),
    );
    bloc = ThreadBloc(messageRepository: repo)
      ..add(const InitializeThread(roomId: '!room', threadRootEventId: 'root'));
    await pumpEventQueue();
    expect(bloc.state.replies.map((m) => m.id), ['old', 'new']);
  });
  tearDown(() => bloc.close());
  test(
    'successful clearing from another store immediately updates open thread',
    () async {
      await ChatHistoryClearStore().clearThrough(
        ownerUserId: '@alice',
        roomId: '!room',
        boundary: time,
        isCurrent: () => true,
      );
      await pumpEventQueue();
      expect(bloc.state.rootMessage, isNull);
      expect(bloc.state.replies.map((m) => m.id), ['new']);
      expect(bloc.state.participantCount, 1);
    },
  );
  test(
    'other owner and other room notifications do not change thread',
    () async {
      await ChatHistoryClearStore().clearThrough(
        ownerUserId: '@bob',
        roomId: '!room',
        boundary: time,
        isCurrent: () => true,
      );
      await ChatHistoryClearStore().clearThrough(
        ownerUserId: '@alice',
        roomId: '!other',
        boundary: time,
        isCurrent: () => true,
      );
      await pumpEventQueue();
      expect(bloc.state.rootMessage?.id, 'root');
      expect(bloc.state.replies.map((m) => m.id), ['old', 'new']);
    },
  );
  test('disposed thread does not reappear on a later notification', () async {
    bloc.add(const DisposeThread());
    await pumpEventQueue();
    await ChatHistoryClearStore().clearThrough(
      ownerUserId: '@alice',
      roomId: '!room',
      boundary: time,
      isCurrent: () => true,
    );
    await pumpEventQueue();
    expect(bloc.state.roomId, isNull);
    expect(bloc.state.rootMessage, isNull);
    expect(bloc.state.replies, isEmpty);
  });
}
