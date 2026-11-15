import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final changeClient in [true, false]) {
    for (final poll in [true, false]) {
      test(
        'reject ${poll ? 'poll' : 'text'} after ${changeClient ? 'client' : 'token'} changes during preparation',
        () async {
          final manager = _Manager();
          final client = _Client();
          final room = _Room();
          when(() => manager.client).thenReturn(client);
          when(client.isLogged).thenReturn(true);
          when(() => client.accessToken).thenReturn('test-session-a');
          when(() => room.encrypted).thenReturn(false);
          when(() => room.client).thenReturn(client);
          when(() => client.getRoomById('!room:test')).thenAnswer((_) {
            if (changeClient) {
              when(() => manager.client).thenReturn(_Client());
            } else {
              when(() => client.accessToken).thenReturn('test-session-b');
            }
            return room;
          });
          final data = MatrixMessageDataSource(manager);
          await expectLater(
            poll
                ? data.sendPollMessage(
                    '!room:test',
                    question: 'Private',
                    options: ['A', 'B'],
                    transactionId: 'scheduled',
                  )
                : data.sendTextMessage(
                    '!room:test',
                    'Private',
                    transactionId: 'scheduled',
                  ),
            throwsStateError,
          );
          verifyNever(
            () => room.sendTextEvent(any(), txid: any(named: 'txid')),
          );
          verifyNever(
            () => room.sendEvent(
              any(),
              type: any(named: 'type'),
              txid: any(named: 'txid'),
            ),
          );
        },
      );
    }
  }
}
