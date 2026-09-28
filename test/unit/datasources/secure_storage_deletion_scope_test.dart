import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
  for (final accountRecord in [false, true]) {
    test(
      'old A guarded ${accountRecord ? 'account' : 'session'} delete cannot erase new A save',
      () async {
        final key = accountRecord ? 'n42_chat_accounts' : 'n42_chat_session';
        final values = <String, String>{
          key: accountRecord
              ? jsonEncode({
                  '@a:hs': {
                    'homeserver': 'https://hs.test',
                    'deviceId': 'old-A',
                    'accessToken': 'old-token',
                  },
                })
              : jsonEncode({
                  'homeserver': 'https://hs.test',
                  'userId': '@a:hs',
                  'deviceId': 'old-A',
                  'accessToken': 'old-token',
                }),
        };
        final readEntered = Completer<void>();
        final releaseRead = Completer<void>();
        var pause = true;
        var originalGeneration = true;
        final underlying = _Storage();
        when(() => underlying.read(key: any(named: 'key'))).thenAnswer((
          call,
        ) async {
          final readKey = call.namedArguments[#key] as String;
          final captured = values[readKey];
          if (readKey == key && pause) {
            pause = false;
            readEntered.complete();
            await releaseRead.future;
          }
          return captured;
        });
        when(
          () => underlying.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((call) async {
          values[call.namedArguments[#key] as String] =
              call.namedArguments[#value] as String;
        });
        when(() => underlying.delete(key: any(named: 'key'))).thenAnswer((
          call,
        ) async {
          values.remove(call.namedArguments[#key] as String);
        });
        final cleanupStore = SecureStorageDataSource(storage: underlying);
        final loginStore = SecureStorageDataSource(storage: underlying);
        final cleanup = accountRecord
            ? cleanupStore.removeAccountIfMatches(
                '@a:hs',
                Uri.parse('https://hs.test'),
                canDelete: () => originalGeneration,
              )
            : cleanupStore.clearSessionIfMatches(
                '@a:hs',
                Uri.parse('https://hs.test'),
                canDelete: () => originalGeneration,
              );
        await readEntered.future;
        originalGeneration = false;
        final save = accountRecord
            ? loginStore.addAccount(
                userId: '@a:hs',
                homeserver: 'https://hs.test',
                accessToken: 'new-token',
                deviceId: 'new-A',
              )
            : loginStore.saveSession(
                homeserver: 'https://hs.test',
                accessToken: 'new-token',
                userId: '@a:hs',
                deviceId: 'new-A',
              );
        releaseRead.complete();
        await Future.wait([cleanup, save]);
        final decoded = jsonDecode(values[key]!) as Map;
        final saved = accountRecord ? decoded['@a:hs'] as Map : decoded;
        expect(saved['accessToken'], 'new-token');
        expect(saved['deviceId'], 'new-A');
      },
    );
  }
  test('A cleanup cannot erase a concurrent B session save', () async {
    final values = <String, String>{
      'n42_chat_session': jsonEncode({
        'homeserver': 'https://hs.test',
        'userId': '@a:hs',
        'accessToken': 'A-token',
        'deviceId': 'A',
      }),
    };
    final readStarted = Completer<void>();
    final releaseRead = Completer<void>();
    var pauseFirstRead = true;
    final underlying = _Storage();
    when(() => underlying.read(key: any(named: 'key'))).thenAnswer((
      call,
    ) async {
      final key = call.namedArguments[#key] as String;
      final captured = values[key];
      if (key == 'n42_chat_session' && pauseFirstRead) {
        pauseFirstRead = false;
        readStarted.complete();
        await releaseRead.future;
      }
      return captured;
    });
    when(
      () => underlying.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((call) async {
      values[call.namedArguments[#key] as String] =
          call.namedArguments[#value] as String;
    });
    when(() => underlying.delete(key: any(named: 'key'))).thenAnswer((
      call,
    ) async {
      values.remove(call.namedArguments[#key] as String);
    });
    final cleanupStorage = SecureStorageDataSource(storage: underlying);
    final loginStorage = SecureStorageDataSource(storage: underlying);
    final cleanup = cleanupStorage.clearSessionIfMatches(
      '@a:hs',
      Uri.parse('https://hs.test'),
    );
    await readStarted.future;
    final saveB = loginStorage.saveSession(
      homeserver: 'https://hs.test',
      accessToken: 'B-token',
      userId: '@b:hs',
      deviceId: 'B',
    );
    await Future<void>.delayed(Duration.zero);
    releaseRead.complete();
    await Future.wait([cleanup, saveB]);
    expect((await cleanupStorage.getSession())?['userId'], '@b:hs');
  });

  test('account-specific cleanup reports storage read failures', () async {
    final underlying = _Storage();
    when(
      () => underlying.read(key: 'n42_chat_session'),
    ).thenThrow(StateError('fixture read failed'));
    final storage = SecureStorageDataSource(storage: underlying);
    await expectLater(
      storage.clearSessionIfMatches('@a:hs', Uri.parse('https://hs.test')),
      throwsStateError,
    );
    verifyNever(() => underlying.delete(key: 'n42_chat_session'));
  });

  for (final oldValue in [
    '{malformed A',
    jsonEncode({
      'homeserver': 'https://hs.test',
      'userId': '@a:hs',
      'accessToken': 'A-token',
    }),
  ]) {
    test('old invalid session read cannot delete a later B save', () async {
      final values = <String, String>{'n42_chat_session': oldValue};
      final readStarted = Completer<void>();
      final releaseRead = Completer<void>();
      var pauseFirstRead = true;
      final underlying = _Storage();
      when(() => underlying.read(key: 'n42_chat_session')).thenAnswer((
        _,
      ) async {
        final captured = values['n42_chat_session'];
        if (pauseFirstRead) {
          pauseFirstRead = false;
          readStarted.complete();
          await releaseRead.future;
        }
        return captured;
      });
      when(
        () => underlying.write(
          key: 'n42_chat_session',
          value: any(named: 'value'),
        ),
      ).thenAnswer((call) async {
        values['n42_chat_session'] = call.namedArguments[#value] as String;
      });
      when(() => underlying.delete(key: 'n42_chat_session')).thenAnswer((
        _,
      ) async {
        values.remove('n42_chat_session');
      });
      final oldReader = SecureStorageDataSource(storage: underlying);
      final newLogin = SecureStorageDataSource(storage: underlying);
      final pendingRead = oldReader.getSession();
      await readStarted.future;
      final saveB = newLogin.saveSession(
        homeserver: 'https://hs.test',
        accessToken: 'B-token',
        userId: '@b:hs',
        deviceId: 'B',
      );
      await Future<void>.delayed(Duration.zero);
      releaseRead.complete();
      expect(await pendingRead, isNull);
      await saveB;
      expect((await oldReader.getSession())?['userId'], '@b:hs');
    });
  }
}
