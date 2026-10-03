import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';

class _MockMatrixClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

class _MockRoom extends Mock implements matrix.Room {}

class _FakeEvent extends Fake implements matrix.Event {
  _FakeEvent(this.content);

  @override
  final Map<String, dynamic> content;
}

matrix.Event _event(Map<String, dynamic> content) => _FakeEvent(content);

void main() {
  late _MockMatrixClientManager clientManager;
  late _MockClient client;
  late _MockRoom room;
  late MatrixMessageDataSource dataSource;

  setUp(() {
    clientManager = _MockMatrixClientManager();
    client = _MockClient();
    room = _MockRoom();
    dataSource = MatrixMessageDataSource(clientManager);
    when(() => clientManager.client).thenReturn(client);
    when(() => client.getRoomById('!room:example.org')).thenReturn(room);
  });

  test(
    'returns only active locations with valid coordinates, newest first',
    () {
      final now = DateTime.now().toUtc();
      final startedAt = now.subtract(const Duration(minutes: 10));
      final newerAt = now.subtract(const Duration(minutes: 1));
      final earlierAt = now.subtract(const Duration(minutes: 3));
      when(() => room.states).thenReturn({
        'n42.live_location': {
          '@alice:example.org': _event({
            'sharing': true,
            'expires_at': now
                .add(const Duration(minutes: 30))
                .toIso8601String(),
            'started_at': startedAt.toIso8601String(),
          }),
          '@eve:example.org': _event({
            'sharing': true,
            'expires_at': now
                .add(const Duration(minutes: 30))
                .toIso8601String(),
            'started_at': startedAt.toIso8601String(),
          }),
          '@bob:example.org': _event({
            'sharing': true,
            'expires_at': now
                .subtract(const Duration(seconds: 1))
                .toIso8601String(),
          }),
          '@carol:example.org': _event({'sharing': false}),
          '@dave:example.org': _event({
            'sharing': true,
            'expires_at': now
                .add(const Duration(minutes: 30))
                .toIso8601String(),
          }),
        },
        'n42.live_location.update': {
          '@alice:example.org': _event({
            'latitude': '43.6532',
            'longitude': -79.3832,
            'accuracy': 5,
            'updated_at': newerAt.toIso8601String(),
          }),
          '@eve:example.org': _event({'latitude': 44.0, 'longitude': '-79.0'}),
          '@dave:example.org': _event({
            'latitude': 'not-a-number',
            'longitude': 1,
            'updated_at': earlierAt.toIso8601String(),
          }),
        },
        matrix.EventTypes.RoomMember: {
          '@alice:example.org': _event({
            'displayname': 'Alice',
            'avatar_url': 'https://example.org/alice.png',
          }),
        },
      });

      final locations = dataSource.getActiveLiveLocations('!room:example.org');

      expect(locations, hasLength(2));
      expect(locations.map((location) => location.userId), [
        '@alice:example.org',
        '@eve:example.org',
      ]);
      expect(locations.first.displayName, 'Alice');
      expect(locations.first.avatarUrl, 'https://example.org/alice.png');
      expect(locations.first.latitude, 43.6532);
      expect(locations.first.longitude, -79.3832);
      expect(locations.first.accuracy, 5);
      expect(locations.first.updatedAt, newerAt);
      expect(locations.first.durationMinutes, 31);
      expect(locations.last.displayName, '@eve:example.org');
      expect(locations.last.avatarUrl, isNull);
      expect(locations.last.updatedAt, startedAt);
      expect(locations.last.durationMinutes, 40);
    },
  );

  test('missing room or live-location state returns an empty list', () {
    when(() => client.getRoomById('!missing:example.org')).thenReturn(null);
    expect(dataSource.getActiveLiveLocations('!missing:example.org'), isEmpty);

    when(() => room.states).thenReturn({});
    expect(dataSource.getActiveLiveLocations('!room:example.org'), isEmpty);
  });
}
