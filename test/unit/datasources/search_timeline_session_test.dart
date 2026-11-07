import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_search_datasource.dart';

class Manager extends Mock implements MatrixClientManager {}

class Client extends Mock implements matrix.Client {}

class Room extends Mock implements matrix.Room {}

class Timeline extends Mock implements matrix.Timeline {}

class Event extends Mock implements matrix.Event {}

class DirectoryResponse extends Mock
    implements matrix.SearchUserDirectoryResponse {}

class Profile extends Mock implements matrix.Profile {}

class PublicResponse extends Mock implements matrix.QueryPublicRoomsResponse {}

class PublicRoom extends Mock implements matrix.PublishedRoomsChunk {}

void main() {
  setUpAll(() => registerFallbackValue(matrix.PublicRoomQueryFilter()));
  late Manager manager;
  late Client client;
  late Room room;
  late Timeline timeline;
  late MatrixSearchDataSource source;
  late String user;
  setUp(() {
    manager = Manager();
    client = Client();
    room = Room();
    timeline = Timeline();
    user = '@a:test';
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenAnswer((_) => user);
    when(() => client.getRoomById('room')).thenReturn(room);
    when(() => client.rooms).thenReturn([room]);
    when(() => room.membership).thenReturn(matrix.Membership.join);
    when(() => room.getTimeline()).thenAnswer((_) async => timeline);
    when(() => timeline.events).thenReturn([]);
    when(() => timeline.requestHistory(historyCount: 100))
        .thenAnswer((_) async {});
    source = MatrixSearchDataSource(manager);
  });
  test('directory response from an old session is discarded', () async {
    final gate = Completer<matrix.SearchUserDirectoryResponse>();
    final response = DirectoryResponse();
    final profile = Profile();
    when(() => response.results).thenReturn([profile]);
    when(() => client.searchUserDirectory('secret', limit: 20))
        .thenAnswer((_) => gate.future);
    final pending = source.searchUsers('secret');
    user = '@b:test';
    gate.complete(response);
    expect(await pending, isEmpty);
  });
  test('public room response from an old session is discarded', () async {
    final gate = Completer<matrix.QueryPublicRoomsResponse>();
    final response = PublicResponse();
    final published = PublicRoom();
    when(() => response.chunk).thenReturn([published]);
    when(() => client.queryPublicRooms(limit: 20, filter: any(named: 'filter')))
        .thenAnswer((_) => gate.future);
    final pending = source.searchPublicRooms('secret');
    user = '@b:test';
    gate.complete(response);
    expect(await pending, isEmpty);
  });
  test('nonpositive limits never load a timeline', () async {
    expect(
      await source.searchMessagesInRoom('room', 'secret', limit: 0),
      isEmpty,
    );
    expect(await source.searchMessagesGlobally('secret', limit: -1), isEmpty);
    expect(
      await source.searchMessagesGlobally('secret', limitPerRoom: 0),
      isEmpty,
    );
    verifyNever(() => room.getTimeline());
  });
  Event message() {
    final event = Event();
    when(() => event.type).thenReturn(matrix.EventTypes.Message);
    when(() => event.status).thenReturn(matrix.EventStatus.synced);
    when(() => event.body).thenReturn('secret');
    when(() => event.eventId).thenReturn('event');
    when(() => event.originServerTs).thenReturn(DateTime(2026));
    return event;
  }

  for (final global in [false, true]) {
    test('session changes during timeline load global=$global', () async {
      final gate = Completer<matrix.Timeline>();
      when(() => room.getTimeline()).thenAnswer((_) => gate.future);
      final item = message();
      when(() => timeline.events).thenReturn([item]);
      final pending = global
          ? source.searchMessagesGlobally('secret')
          : source.searchMessagesInRoom('room', 'secret');
      user = '@b:test';
      gate.complete(timeline);
      expect(await pending, isEmpty);
      verifyNever(() => timeline.requestHistory(historyCount: 100));
      verify(() => timeline.cancelSubscriptions()).called(1);
    });
    test('successful search releases owned timeline global=$global', () async {
      final item = message();
      when(() => timeline.events).thenReturn([item]);
      final result = global
          ? await source.searchMessagesGlobally('secret')
          : await source.searchMessagesInRoom('room', 'secret', limit: 1);
      expect(result, hasLength(1));
      verify(() => timeline.cancelSubscriptions()).called(1);
    });
  }
  for (final fail in [false, true]) {
    test('session changes during history request failure=$fail', () async {
      final gate = Completer<void>();
      final entered = Completer<void>();
      final item = message();
      when(() => timeline.events).thenReturn([item]);
      when(() => timeline.requestHistory(historyCount: 100)).thenAnswer((_) {
        entered.complete();
        return gate.future;
      });
      final pending = source.searchMessagesInRoom('room', 'secret');
      await entered.future;
      user = '@b:test';
      if (fail) {
        gate.completeError(StateError('obsolete request'));
      } else {
        gate.complete();
      }
      expect(await pending, isEmpty);
      verify(() => timeline.cancelSubscriptions()).called(1);
    });
  }
  test(
    'global search stops before next room after failed old session',
    () async {
      final next = Room();
      when(() => client.rooms).thenReturn([room, next]);
      when(() => next.membership).thenReturn(matrix.Membership.join);
      when(() => next.getTimeline()).thenAnswer((_) async => timeline);
      final gate = Completer<matrix.Timeline>();
      when(() => room.getTimeline()).thenAnswer((_) => gate.future);
      final pending = source.searchMessagesGlobally('secret');
      user = '@b:test';
      gate.completeError(StateError('old timeline'));
      expect(await pending, isEmpty);
      verifyNever(() => next.getTimeline());
    },
  );
}
