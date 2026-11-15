import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final code in ['M_USER_LOCKED', 'M_USER_DEACTIVATED']) {
    test('SDK sync retains session and database after $code', () async {
      sqfliteFfiInit();
      final directory = await Directory.systemTemp.createTemp('matrix-sync-');
      addTearDown(() => directory.delete(recursive: true));
      // Use a real SDK database and sync loop; only the remote HTTP peer is fake.
      // ignore: deprecated_member_use
      final database = await MatrixSdkDatabase.init(
        'restriction-test',
        database: await databaseFactoryFfi.openDatabase(
          '${directory.path}/matrix.sqlite',
          options: OpenDatabaseOptions(singleInstance: false),
        ),
        sqfliteFactory: databaseFactoryFfi,
        fileStorageLocation: directory.uri,
      );
      var restricted = false;
      var syncs = 0;
      final unexpectedRequests = <String>[];
      final client = Client(
        'restriction-test',
        database: database,
        httpClient: MockClient((request) async {
          final path = request.url.path;
          if (path.endsWith('/filter')) {
            return http.Response('{"filter_id":"test-filter"}', 200);
          }
          if (path.endsWith('/keys/query')) {
            return http.Response('{"device_keys":{}}', 200);
          }
          if (path.endsWith('/sync')) {
            syncs++;
            if (restricted) {
              return http.Response(
                jsonEncode({
                  'errcode': code,
                  'error': 'Account unavailable',
                  'soft_logout': true,
                }),
                code == 'M_USER_LOCKED' ? 401 : 403,
              );
            }
            return http.Response(
              jsonEncode({'next_batch': 'batch-$syncs'}),
              200,
            );
          }
          unexpectedRequests.add('${request.method} $path');
          throw StateError('Unexpected SDK request: ${request.method} $path');
        }),
      );
      client.backgroundSync = false;
      client.syncErrorTimeoutSec = 0;
      addTearDown(client.dispose);
      final clears = <SessionClearReason>[];
      final states = <LoginState>[];
      final updates = <SyncStatusUpdate>[];
      final subscriptions = [
        client.onSessionCleared.stream.listen(clears.add),
        client.onLoginStateChanged.stream.listen(states.add),
        client.onSyncStatus.stream.listen(updates.add),
      ];
      addTearDown(() async {
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
      });
      await client.init(
        newToken: 'fixture-token',
        newUserID: '@fixture:example.invalid',
        newHomeserver: Uri.parse('https://example.invalid'),
        newDeviceID: 'FIXTURE',
      );
      await database.storeAccountData('test.preserved', {'value': 'keep'});
      final storedSession = await database.getClient('restriction-test');
      final previousBatch = client.prevBatch;
      restricted = true;
      await client.oneShotSync(timeout: Duration.zero);
      await Future<void>.delayed(Duration.zero);
      expect(updates.last.status, SyncStatus.error);
      expect((updates.last.error!.exception as MatrixException).errcode, code);
      expect(client.accessToken, 'fixture-token');
      expect(client.userID, '@fixture:example.invalid');
      expect(client.deviceID, 'FIXTURE');
      expect(client.prevBatch, previousBatch);
      expect(client.isLogged(), isTrue);
      expect(clears, isEmpty);
      expect(unexpectedRequests, isEmpty);
      expect(await database.getClient('restriction-test'), storedSession);
      expect(states, isNot(contains(LoginState.loggedOut)));
      expect(states, isNot(contains(LoginState.softLoggedOut)));
      expect((await database.getAccountData())['test.preserved']?.content, {
        'value': 'keep',
      });
      if (code == 'M_USER_LOCKED') {
        restricted = false;
        await client.oneShotSync(timeout: Duration.zero);
        await Future<void>.delayed(Duration.zero);
        expect(updates.last.status, SyncStatus.finished);
        expect(client.prevBatch, isNot(previousBatch));
        expect(client.accessToken, 'fixture-token');
        expect(clears, isEmpty);
      }
    });
  }
}
