import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  for (final outdated in [false, true]) {
    test(
      'Matrix 13 database retains keys, trust and history (outdated=$outdated)',
      () async {
        sqfliteFfiInit();
        final temp = await Directory.systemTemp.createTemp(
          'n42-matrix-upgrade-',
        );
        final path = '${temp.path}/matrix.db';
        const user = '@fixture:example.test';
        const device = 'FIXTURE';
        final legacy = await databaseFactoryFfi.openDatabase(path);
        // Matrix 13's version-11 key/value schema. Use fake public test data only.
        final preserved = <String, Map<String, Object>>{
          'box_client': {
            'version': '11',
            'olm_account': 'encrypted-account-fixture',
            'userID': user,
            'deviceID': device,
            'prev_batch': 'retained-sync-cursor',
          },
          'box_rooms': {
            '!room:example.test': {'membership': 'join'},
          },
          'box_events': {
            'event-fixture': {'body': 'retained history'},
          },
          'box_inbound_group_session': {
            'session-fixture': {'pickle': 'opaque-inbound'},
          },
          'box_outbound_group_session': {
            '!room:example.test': {'pickle': 'opaque-outbound'},
          },
          'box_olm_session': {
            'olm-fixture': {'pickle': 'opaque-olm'},
          },
        };
        final seed = <String, Map<String, Object>>{
          ...preserved,
          'box_user_device_keys_outdated': {user: outdated},
          'box_user_device_keys': {
            '$user|$device': {
              'device_id': device,
              'verified': true,
              'blocked': false,
              'last_active': 123,
              'last_sent_message': 'sent-olm-fixture',
              'content': {
                'user_id': user,
                'device_id': device,
                'algorithms': ['m.olm.v1.curve25519-aes-sha2'],
                'keys': {'ed25519:$device': 'fake-signing-key'},
              },
            },
          },
        };
        for (final table in seed.entries) {
          await legacy.execute(
            'CREATE TABLE ${table.key} (k TEXT PRIMARY KEY NOT NULL, v TEXT)',
          );
          for (final row in table.value.entries) {
            await legacy.insert(table.key, {
              'k': row.key,
              'v': row.value is String ? row.value : jsonEncode(row.value),
            });
          }
        }
        await legacy.close();
        try {
          for (var reopen = 0; reopen < 2; reopen++) {
            final sqlite = await databaseFactoryFfi.openDatabase(path);
            final sdk = MatrixSdkDatabase.buildWithoutOpen(
              'upgrade',
              database: sqlite,
            );
            try {
              await sdk.open();
              final keys = await sdk.getDeviceKeysList(
                user,
                Client('fixture', database: sdk),
                skipSignatureCheck: true,
              );
              expect(keys, isNotNull);
              expect(keys!.outdated, outdated);
              expect(keys.deviceKeys.keys, [device]);
              expect(keys.deviceKeys[device]!.directVerified, isTrue);
              expect(keys.deviceKeys[device]!.toDbJson()['blocked'], isFalse);
              expect(await sdk.getLastSentMessageUserDeviceKey(user, device), [
                'sent-olm-fixture',
              ]);
              for (final table in preserved.entries) {
                final rows = await sqlite.query(table.key);
                final actual = {
                  for (final row in rows)
                    row['k']: table.key == 'box_client'
                        ? row['v']
                        : jsonDecode(row['v']! as String),
                };
                final expected = {...table.value};
                if (table.key == 'box_client') expected['version'] = '12';
                expect(
                  actual,
                  expected,
                  reason: '${table.key}, reopen $reopen',
                );
              }
            } finally {
              await sdk.close();
            }
          }
        } finally {
          await temp.delete(recursive: true);
        }
      },
    );
  }
}
