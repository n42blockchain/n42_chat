import 'package:n42_chat/src/domain/repositories/thread_pagination_repository.dart';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'package:n42_chat/src/data/repositories/message_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

import 'message_repository_impl_test.dart'
    show
        MockMatrixMessageDataSource,
        MockMatrixClientManager,
        MockPreferencesDataSource,
        MockClient;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMatrixMessageDataSource source;
  late MockMatrixClientManager manager;
  late MockClient client;
  late MessageRepositoryImpl repository;
  late ChatHistoryClearStore store;
  final time = DateTime.utc(2026, 11, 6);
  const room = '!room:test';
  MessageEntity message(String id, int seconds) => MessageEntity(
    id: id,
    roomId: room,
    senderId: '@alice:test',
    senderName: 'Alice',
    content: id,
    timestamp: time.add(Duration(seconds: seconds)),
    type: MessageType.text,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    source = MockMatrixMessageDataSource();
    manager = MockMatrixClientManager();
    client = MockClient();
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice:test');
    store = ChatHistoryClearStore();
    await store.clearThrough(
      ownerUserId: '@alice:test',
      roomId: room,
      boundary: time,
      isCurrent: () => true,
    );
    repository = MessageRepositoryImpl(
      source,
      manager,
      MockPreferencesDataSource(),
      historyClearStore: ChatHistoryClearStore(),
    );
    when(
      () => source.getThreadMessages(
        room,
        'root',
        limit: any(named: 'limit'),
        beforeEventId: any(named: 'beforeEventId'),
      ),
    ).thenAnswer(
      (_) async => [message('old', -1), message('root', 0), message('new', 1)],
    );
    when(() => source.getRoomThreadRoots(room))
        .thenAnswer((_) async => [message('old', -1), message('new', 1)]);
  });

  test(
    'thread fetch and pagination exclude cleared root and old replies',
    () async {
      expect(
        (await repository.getThreadMessages(room, 'root')).map((m) => m.id),
        ['new'],
      );
      expect(
        (await repository.getThreadMessages(
          room,
          'root',
          fromEventId: 'cursor',
        )).map((m) => m.id),
        ['new'],
      );
      verify(
        () => source.getThreadMessages(
          room,
          'root',
          limit: 50,
          beforeEventId: 'cursor',
        ),
      ).called(1);
    },
  );

  test('typed page filters cleared events and preserves continuation', () async {
    when(() => source.getThreadMessagePage(room, 'root', limit: 50, fromToken: 'first'))
      .thenAnswer((_) async => ThreadMessagePage(messages: [message('old', -1), message('new', 1)], nextBatch: 'second'));
    final page = await repository.getThreadMessagePage(room, 'root', fromToken: 'first');
    expect(page.messages.map((m) => m.id), ['new']);
    expect(page.nextBatch, 'second');
  });

  test('thread root list retains new roots only', () async {
    expect((await repository.getRoomThreadRoots(room)).map((m) => m.id), [
      'new',
    ]);
  });

  test('clearing does not affect another account', () async {
    when(() => client.userID).thenReturn('@bob:test');
    expect(
      (await repository.getThreadMessages(room, 'root')).map((m) => m.id),
      ['old', 'root', 'new'],
    );
  });

  test('pending fetch cannot disclose results after account change', () async {
    final pending = Completer<List<MessageEntity>>();
    when(() => source.getRoomThreadRoots(room))
        .thenAnswer((_) => pending.future);
    final result = repository.getRoomThreadRoots(room);
    when(() => client.userID).thenReturn('@bob:test');
    pending.complete([message('new', 1)]);
    expect(await result, isEmpty);
  });

  test('stream rereads boundary and drops old-session updates', () async {
    final controller = StreamController<List<MessageEntity>>();
    when(() => source.watchThreadMessages(room, 'root'))
        .thenAnswer((_) => controller.stream);
    final iterator = StreamIterator(
      repository.watchThreadMessages(room, 'root'),
    );
    controller.add([message('root', 0), message('new', 1)]);
    expect(await iterator.moveNext(), isTrue);
    expect(iterator.current.map((m) => m.id), ['new']);
    await store.clearThrough(
      ownerUserId: '@alice:test',
      roomId: room,
      boundary: time.add(const Duration(seconds: 2)),
      isCurrent: () => true,
    );
    controller.add([message('new', 1), message('newest', 3)]);
    expect(await iterator.moveNext(), isTrue);
    expect(iterator.current.map((m) => m.id), ['newest']);
    when(() => client.userID).thenReturn('@bob:test');
    controller.add([message('newest', 3)]);
    expect(await iterator.moveNext(), isTrue);
    expect(iterator.current, isEmpty);
    await iterator.cancel();
    await controller.close();
  });

  test(
    'corrupt boundary fails closed for thread fetch and root list',
    () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefs.getKeys().single, 'broken');
      expect(await repository.getThreadMessages(room, 'root'), isEmpty);
      expect(await repository.getRoomThreadRoots(room), isEmpty);
    },
  );
}
