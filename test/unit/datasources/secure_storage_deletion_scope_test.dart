import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
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
}
