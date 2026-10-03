import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_contact_datasource.dart';

class _MockMatrixClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

void main() {
  late _MockMatrixClientManager clientManager;
  late _MockClient client;
  late MatrixContactDataSource dataSource;
  late List<matrix.Room> rooms;

  setUpAll(() {
    registerFallbackValue(matrix.PresenceType.online);
  });

  setUp(() {
    clientManager = _MockMatrixClientManager();
    client = _MockClient();
    rooms = [];
    when(() => clientManager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:example.org');
    when(() => client.accountData).thenReturn(<String, matrix.BasicEvent>{});
    when(() => client.rooms).thenReturn(rooms);
    when(
      () => client.getAccountData(any(), any()),
    ).thenAnswer((_) async => <String, dynamic>{});
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

      final result = await dataSource.getCurrentUserStatusMessage();

      verify(
        () => client.setPresence(
          '@me:example.org',
          matrix.PresenceType.unavailable,
          statusMsg: null,
        ),
      ).called(1);
      verify(
        () => client.setAccountData(
          '@me:example.org',
          'n42.user.status',
          <String, dynamic>{},
        ),
      ).called(1);
      verifyNever(() => client.createRoom(name: any(named: 'name')));
      expect(result, isNull);
    },
  );
}
