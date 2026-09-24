import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/contact_privacy_service.dart';
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
    when(() => client.accountData).thenReturn({});
    when(() => client.rooms).thenReturn([]);
    when(
      () =>
          client.setPresence(any(), any(), statusMsg: any(named: 'statusMsg')),
    ).thenAnswer((_) async {});
    when(
      () => client.setAccountData(any(), any(), any()),
    ).thenAnswer((_) async {});

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
      final statusRoom = _MockRoom();
      final createEvent = _MockEvent();
      when(() => createEvent.senderId).thenReturn('@me:example.org');
      when(() => statusRoom.id).thenReturn('!stories:example.org');
      when(() => statusRoom.membership).thenReturn(matrix.Membership.join);
      when(
        () => statusRoom.tags,
      ).thenReturn({ContactPrivacyService.storyTag: matrix.Tag()});
      when(() => statusRoom.getState(any(), any())).thenAnswer((invocation) {
        if (invocation.positionalArguments.first ==
            matrix.EventTypes.RoomCreate) {
          return createEvent;
        }
        return null;
      });
      when(() => client.rooms).thenReturn([statusRoom]);
      when(
        () => client.getAccountData(
          '@me:example.org',
          ContactPrivacyService.accountType,
        ),
      ).thenAnswer((_) async => {});
      when(() => client.getPresence('@me:example.org')).thenAnswer(
        (_) async => matrix.GetPresenceResponse(
          presence: matrix.PresenceType.unavailable,
          statusMsg: 'Busy',
        ),
      );
      when(
        () => client.setRoomStateWithKey(any(), any(), any(), any()),
      ).thenAnswer((_) async => 'state-event');

      final result = await dataSource.getCurrentUserStatusMessage();

      expect(result, isNull);
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
