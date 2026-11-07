import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_event_mapper.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_thread_handler.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

class _Event extends Mock implements matrix.Event {}

class _Mapper extends Mock implements MatrixEventMapper {}

void main() {
  late _Manager manager;
  late _Client client;
  late _Room room;
  late _Mapper mapper;
  late MatrixThreadHandler handler;
  final queries = <Map<String, dynamic>>[];
  Map<String, Object?> page(String id, {String? next}) => {
    'chunk': [
      {
        'event_id': id,
        'type': 'm.room.message',
        'sender': '@a:test',
        'origin_server_ts': 1000,
        'content': {'msgtype': 'm.text', 'body': id},
      },
    ],
    if (next != null) 'next_batch': next,
  };
  void response(Future<Map<String, dynamic>> Function() callback) {
    when(
      () => client.request(
        matrix.RequestType.GET,
        any(),
        query: any(named: 'query'),
      ),
    ).thenAnswer((call) {
      queries.add(
        Map<String, dynamic>.from(call.namedArguments[#query] as Map),
      );
      return callback();
    });
  }

  setUpAll(() => registerFallbackValue(_Event()));
  setUp(() {
    queries.clear();
    manager = _Manager();
    client = _Client();
    room = _Room();
    mapper = _Mapper();
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@a:test');
    when(() => client.getRoomById(any())).thenReturn(room);
    when(() => room.id).thenReturn('!room');
    when(() => room.client).thenReturn(client);
    when(() => mapper.mapEventToMessage(any(), room)).thenAnswer((call) {
      final event = call.positionalArguments[0] as matrix.Event;
      return MessageEntity(
        id: event.eventId,
        roomId: '!room',
        senderId: '@a:test',
        senderName: 'A',
        content: event.body,
        timestamp: DateTime.utc(2026),
        type: MessageType.text,
      );
    });
    handler = MatrixThreadHandler(manager, mapper);
  });
  test(
    'event anchor resolves to opaque next_batch and exhausted page stops',
    () async {
      response(() async => page('newest', next: 'opaque-1'));
      expect(
        (await handler.getThreadMessages('!room', 'root')).single.id,
        'newest',
      );
      response(() async => page('oldest'));
      expect(
        (await handler.getThreadMessages(
          '!room',
          'root',
          beforeEventId: 'newest',
        )).single.id,
        'oldest',
      );
      expect(queries.last['from'], 'opaque-1');
      expect(queries.last['dir'], 'b');
      expect(
        await handler.getThreadMessages(
          '!room',
          'root',
          beforeEventId: 'oldest',
        ),
        isEmpty,
      );
      expect(queries.length, 2);
    },
  );
  test('anchors are isolated by root and session', () async {
    response(() async => page('anchor', next: 'opaque'));
    await handler.getThreadMessages('!room', 'root');
    await expectLater(
      handler.getThreadMessages('!room', 'other', beforeEventId: 'anchor'),
      throwsStateError,
    );
    when(() => client.userID).thenReturn('@b:test');
    await expectLater(
      handler.getThreadMessages('!room', 'root', beforeEventId: 'anchor'),
      throwsStateError,
    );
    expect(queries.length, 1);
  });
  test(
    'failed continuation is reported and retains cursor for explicit retry',
    () async {
      response(() async => page('anchor', next: 'opaque'));
      await handler.getThreadMessages('!room', 'root');
      response(() async => throw StateError('network'));
      await expectLater(
        handler.getThreadMessages('!room', 'root', beforeEventId: 'anchor'),
        throwsStateError,
      );
      response(() async => page('older'));
      expect(
        (await handler.getThreadMessages(
          '!room',
          'root',
          beforeEventId: 'anchor',
        )).single.id,
        'older',
      );
      expect(queries.last['from'], 'opaque');
    },
  );
  test('late response cannot install cursors in a different session', () async {
    final pending = Completer<Map<String, dynamic>>();
    response(() => pending.future);
    final fetch = handler.getThreadMessages('!room', 'root');
    when(() => client.userID).thenReturn('@b:test');
    pending.complete(page('anchor', next: 'opaque'));
    expect(await fetch, isEmpty);
    await expectLater(
      handler.getThreadMessages('!room', 'root', beforeEventId: 'anchor'),
      throwsStateError,
    );
  });
  test('nonadvancing continuation is rejected', () async {
    response(() async => page('anchor', next: 'opaque'));
    await handler.getThreadMessages('!room', 'root');
    await expectLater(
      handler.getThreadMessages('!room', 'root', beforeEventId: 'anchor'),
      throwsStateError,
    );
  });
}
