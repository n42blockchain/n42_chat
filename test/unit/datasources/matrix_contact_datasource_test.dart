import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_contact_datasource.dart';

class _MockMatrixClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

class _MockRoom extends Mock implements matrix.Room {}

class _MockEvent extends Mock implements matrix.Event {}

void main() {
  late _MockMatrixClientManager clientManager;
  late _MockClient client;
  late MatrixContactDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(matrix.PresenceType.online);
  });

  setUp(() {
    clientManager = _MockMatrixClientManager();
    client = _MockClient();
    when(() => clientManager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:example.org');
    when(() => client.accountData).thenReturn(<String, matrix.BasicEvent>{});
    when(
      () =>
          client.setPresence(any(), any(), statusMsg: any(named: 'statusMsg')),
    ).thenAnswer((_) async {});
    when(
      () => client.setAccountData(any(), any(), any()),
    ).thenAnswer((_) async {});

    final room = _MockRoom();
    final creation = _MockEvent();
    when(() => creation.senderId).thenReturn('@me:example.org');
    when(() => room.id).thenReturn('!status:example.org');
    when(() => room.membership).thenReturn(matrix.Membership.join);
    when(() => room.tags).thenReturn({'n42.stories': matrix.Tag()});
    when(
      () => room.getState(matrix.EventTypes.RoomCreate),
    ).thenReturn(creation);
    when(() => client.rooms).thenReturn([room]);
    when(
      () => client.getAccountData('@me:example.org', 'n42.contact.permissions'),
    ).thenAnswer((_) async => <String, dynamic>{});
    when(() => client.getPresence('@me:example.org')).thenAnswer(
      (_) async => matrix.GetPresenceResponse(
        presence: matrix.PresenceType.unavailable,
        statusMsg: 'Busy',
      ),
    );
    when(
      () => client.setRoomStateWithKey(any(), any(), any(), any()),
    ).thenAnswer((_) async => 'state-event');
    dataSource = MatrixContactDataSource(clientManager);
  });

  test(
    'expired timed status clears status message without forcing online presence',
    () async {
      when(
        () => client.getAccountData('@me:example.org', 'n42.user.status'),
      ).thenAnswer(
        (_) async => {
          'message': 'Busy',
          'expiresAt': DateTime.now()
              .toUtc()
              .subtract(const Duration(minutes: 1))
              .toIso8601String(),
        },
      );
      when(() => client.fetchCurrentPresence('@me:example.org')).thenAnswer(
        (_) async => matrix.CachedPresence(
          matrix.PresenceType.unavailable,
          null,
          'Busy',
          false,
          '@me:example.org',
        ),
      );

      final result = await dataSource.getCurrentUserStatusMessage();

      expect(result, isNull);
      verify(
        () => client.setRoomStateWithKey(
          '!status:example.org',
          'n42.user.status',
          '',
          <String, dynamic>{},
        ),
      ).called(1);
      verify(
        () => client.setAccountData(
          '@me:example.org',
          'n42.user.status',
          <String, dynamic>{},
        ),
      ).called(1);
      verify(
        () => client.setPresence(
          '@me:example.org',
          matrix.PresenceType.unavailable,
          statusMsg: '',
        ),
      ).called(1);
    },
  );
}
