import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_reaction_datasource.dart';

class _MockClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

class _MockRoom extends Mock implements matrix.Room {}

class _MockEvent extends Mock implements matrix.Event {}

class _FakeTimeline extends Fake implements matrix.Timeline {}

void main() {
  late _MockClientManager clientManager;
  late _MockClient client;
  late _MockRoom room;
  late _MockEvent event;
  late MatrixReactionDataSource datasource;

  setUpAll(() {
    registerFallbackValue(_MockEvent());
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(_FakeTimeline());
  });

  setUp(() {
    clientManager = _MockClientManager();
    client = _MockClient();
    room = _MockRoom();
    event = _MockEvent();
    datasource = MatrixReactionDataSource(clientManager);

    when(() => clientManager.client).thenReturn(client);
    when(() => client.getRoomById('!room:server.test')).thenReturn(room);
  });

  test('sendReply uses getEventById before timeline fallback', () async {
    when(() => room.getEventById(r'$original')).thenAnswer((_) async => event);
    when(() => room.sendEvent(any(), inReplyTo: any(named: 'inReplyTo')))
        .thenAnswer((_) async => r'$reply');

    final result = await datasource.sendReply(
      '!room:server.test',
      r'$original',
      '回复内容',
    );

    expect(result, r'$reply');
    verify(() => room.getEventById(r'$original')).called(1);
    verifyNever(() => room.getTimeline());
    verify(
      () => room.sendEvent(
        any(
          that: predicate<Map<String, dynamic>>(
            (content) => content['body'] == '回复内容',
          ),
        ),
        inReplyTo: event,
      ),
    ).called(1);
  });

  group('forwarding', () {
    late _MockRoom target;
    setUp(() {
      target = _MockRoom();
      when(() => client.getRoomById('!target:test')).thenReturn(target);
      when(() => target.encrypted).thenReturn(false);
      when(client.isLogged).thenReturn(true);
      when(() => client.userID).thenReturn('@alice:test');
      when(() => client.accessToken).thenReturn('test-token');
      when(() => event.messageType).thenReturn(matrix.MessageTypes.Image);
      when(() => event.content).thenReturn({
        'msgtype': 'm.image',
        'body': 'photo.jpg',
        'file': {
          'url': 'mxc://test/encrypted',
          'key': {'k': 'fixture'},
        },
        'm.relates_to': {'event_id': r'$original'},
        'm.mentions': {
          'user_ids': ['@bob:test'],
        },
      });
      when(() => target.sendEvent(any())).thenAnswer((_) async => r'$sent');
    });

    test(
      'preserves encrypted attachment metadata without old relations',
      () async {
        when(() => room.getEventById(r'$source'))
            .thenAnswer((_) async => event);
        expect(
          await datasource.forwardMessage(
            '!room:server.test',
            r'$source',
            '!target:test',
          ),
          r'$sent',
        );
        final content =
            verify(() => target.sendEvent(captureAny())).captured.single as Map;
        expect(content['file'], containsPair('url', 'mxc://test/encrypted'));
        expect(content, isNot(contains('m.relates_to')));
        expect(content, isNot(contains('m.mentions')));
        expect(event.content, contains('m.relates_to'));
      },
    );

    test('refuses changed client while original event loads', () async {
      final pending = Completer<matrix.Event?>();
      when(() => room.getEventById(r'$source'))
          .thenAnswer((_) => pending.future);
      final send = datasource.forwardMessage(
        '!room:server.test',
        r'$source',
        '!target:test',
      );
      final assertion = expectLater(send, throwsStateError);
      when(() => clientManager.client).thenReturn(_MockClient());
      pending.complete(event);
      await assertion;
      verifyNever(() => target.sendEvent(any()));
    });

    test('refuses replaced token on the same client', () async {
      final pending = Completer<matrix.Event?>();
      when(() => room.getEventById(r'$source'))
          .thenAnswer((_) => pending.future);
      final send = datasource.forwardMessage(
        '!room:server.test',
        r'$source',
        '!target:test',
      );
      final assertion = expectLater(send, throwsStateError);
      when(() => client.accessToken).thenReturn('replacement-token');
      pending.complete(event);
      await assertion;
      verifyNever(() => target.sendEvent(any()));
    });
  });

  test('moderator power level still permits reporting another user event', () {
    when(() => client.userID).thenReturn('@me:server.test');
    when(() => room.ownPowerLevel).thenReturn(matrix.PowerLevel(50));
    when(() => room.getState(matrix.EventTypes.RoomPowerLevels))
        .thenReturn(event);
    when(() => event.content).thenReturn({'redact': 50});

    expect(datasource.canRedact('!room:server.test', r'$other'), isTrue);
  });
}
