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

class _Timeline extends Mock implements matrix.Timeline {}

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
  test('short and empty pages retain their explicit continuation', () async {
    response(() async => {'chunk': <Object?>[], 'next_batch': 'after-empty'});
    final empty = await handler.getThreadMessagePage('!room', 'root');
    expect(empty.messages, isEmpty);
    expect(empty.hasMore, isTrue);
    response(() async => page('one', next: 'after-one'));
    final short = await handler.getThreadMessagePage(
      '!room',
      'root',
      fromToken: empty.nextBatch,
    );
    expect(short.messages.length, 1);
    expect(short.hasMore, isTrue);
    expect(queries.last['from'], 'after-empty');
    response(() async => {'chunk': <Object?>[]});
    final end = await handler.getThreadMessagePage(
      '!room',
      'root',
      fromToken: short.nextBatch,
    );
    expect(end.hasMore, isFalse);
  });

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
  test(
    'multi-page cycle is rejected without poisoning a valid retry',
    () async {
      response(() async => page('first', next: 'a'));
      await handler.getThreadMessagePage('!room', 'root');
      response(() async => page('second', next: 'b'));
      await handler.getThreadMessagePage('!room', 'root', fromToken: 'a');
      response(() async => page('third', next: 'a'));
      await expectLater(
        handler.getThreadMessagePage('!room', 'root', fromToken: 'b'),
        throwsStateError,
      );
      response(() async => page('third', next: 'c'));
      expect(
        (await handler.getThreadMessagePage(
          '!room',
          'root',
          fromToken: 'b',
        )).nextBatch,
        'c',
      );
    },
  );

  for (final malformed in <Map<String, dynamic>>[
    {},
    {'chunk': 'bad'},
    {
      'chunk': [42],
    },
    {
      'chunk': [
        {'event_id': ''},
      ],
    },
    {'chunk': <Object?>[], 'next_batch': 42},
    {'chunk': <Object?>[], 'next_batch': ''},
  ]) {
    test(
      'malformed first page does not become an empty fallback: $malformed',
      () async {
        response(() async => malformed);
        await expectLater(
          handler.getThreadMessagePage('!room', 'root'),
          throwsFormatException,
        );
        verifyNever(() => room.getTimeline());
      },
    );
  }

  test(
    'initial network or permission failures are not hidden by fallback',
    () async {
      response(() async => throw StateError('network'));
      await expectLater(
        handler.getThreadMessagePage('!room', 'root'),
        throwsStateError,
      );
      response(
        () async =>
            throw matrix.MatrixException.fromJson({'errcode': 'M_FORBIDDEN'}),
      );
      await expectLater(
        handler.getThreadMessagePage('!room', 'root'),
        throwsA(isA<matrix.MatrixException>()),
      );
      verifyNever(() => room.getTimeline());
    },
  );

  test('explicit unsupported endpoint retains the local fallback', () async {
    final timeline = _Timeline();
    when(() => timeline.events).thenReturn([]);
    when(() => room.getTimeline()).thenAnswer((_) async => timeline);
    response(
      () async =>
          throw matrix.MatrixException.fromJson({'errcode': 'M_UNRECOGNIZED'}),
    );
    final result = await handler.getThreadMessagePage('!room', 'root');
    expect(result.messages, isEmpty);
    expect(result.hasMore, isFalse);
    verify(() => room.getTimeline()).called(1);
  });

  test('invalid request bounds fail before network access', () async {
    await expectLater(
      handler.getThreadMessagePage('!room', 'root', limit: 0),
      throwsArgumentError,
    );
    await expectLater(
      handler.getThreadMessagePage('!room', 'root', fromToken: ''),
      throwsArgumentError,
    );
    expect(queries, isEmpty);
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
