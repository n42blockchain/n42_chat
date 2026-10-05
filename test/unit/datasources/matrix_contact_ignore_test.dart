import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_contact_datasource.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Database extends Mock implements matrix.DatabaseApi {}

class _AccountDataClient extends matrix.Client {
  _AccountDataClient(this.server, String account)
    : super('ignore-fixture', database: _Database()) {
    setUserId(account);
    homeserver = Uri.parse('https://hs.test');
    accessToken = 'token-$account';
    accountData.addAll(server[account] ?? const {});
  }

  final Map<String, Map<String, matrix.BasicEvent>> server;

  @override
  Future<void> setAccountData(
    String userId,
    String type,
    Map<String, Object?> body,
  ) async {
    final event = matrix.BasicEvent(type: type, content: body);
    server.putIfAbsent(userId, () => {})[type] = event;
    accountData[type] = event;
  }

  @override
  Future<void> clearCache() async {}
}

void main() {
  const subject = '@blocked:hs.test';

  for (final operation in ['ignore', 'unignore']) {
    test('$operation fails explicitly without a Matrix client', () async {
      final manager = _Manager();
      when(() => manager.client).thenReturn(null);
      final source = MatrixContactDataSource(manager);
      final call = operation == 'ignore'
          ? source.ignoreUser(subject)
          : source.unignoreUser(subject);
      await expectLater(call, throwsStateError);
    });

    test(
      '$operation rejects A completion after manager switches to B',
      () async {
        final manager = _Manager();
        final a = _Client();
        final b = _Client();
        var current = a;
        when(() => manager.client).thenAnswer((_) => current);
        when(() => a.userID).thenReturn('@a:hs.test');
        when(() => a.homeserver).thenReturn(Uri.parse('https://hs.test'));
        when(() => a.accessToken).thenReturn('token-A');
        when(() => a.deviceID).thenReturn('device-A');
        final acknowledgement = Completer<void>();
        if (operation == 'ignore') {
          when(
            () => a.ignoreUser(subject),
          ).thenAnswer((_) => acknowledgement.future);
        } else {
          when(
            () => a.unignoreUser(subject),
          ).thenAnswer((_) => acknowledgement.future);
        }
        final source = MatrixContactDataSource(manager);
        final call = operation == 'ignore'
            ? source.ignoreUser(subject)
            : source.unignoreUser(subject);
        await Future<void>.delayed(Duration.zero);
        current = b;
        final result = expectLater(call, throwsStateError);
        acknowledgement.complete();
        await result;
        if (operation == 'ignore') {
          verify(() => a.ignoreUser(subject)).called(1);
          verifyNever(() => b.ignoreUser(any()));
        } else {
          verify(() => a.unignoreUser(subject)).called(1);
          verifyNever(() => b.unignoreUser(any()));
        }
      },
    );

    test('$operation rejects a changed token on the same client', () async {
      final manager = _Manager();
      final client = _Client();
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@a:hs.test');
      when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
      var token = 'token-A';
      when(() => client.accessToken).thenAnswer((_) => token);
      when(() => client.deviceID).thenReturn(null);
      final acknowledgement = Completer<void>();
      if (operation == 'ignore') {
        when(
          () => client.ignoreUser(subject),
        ).thenAnswer((_) => acknowledgement.future);
      } else {
        when(
          () => client.unignoreUser(subject),
        ).thenAnswer((_) => acknowledgement.future);
      }
      final source = MatrixContactDataSource(manager);
      final call = operation == 'ignore'
          ? source.ignoreUser(subject)
          : source.unignoreUser(subject);
      await Future<void>.delayed(Duration.zero);
      token = 'token-B';
      final result = expectLater(call, throwsStateError);
      acknowledgement.complete();
      await result;
    });

    test('$operation preserves SDK error for the unchanged account', () async {
      final manager = _Manager();
      final client = _Client();
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@a:hs.test');
      when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
      when(() => client.accessToken).thenReturn('token-A');
      when(() => client.deviceID).thenReturn(null);
      final error = StateError('SDK write failed');
      if (operation == 'ignore') {
        when(() => client.ignoreUser(subject)).thenThrow(error);
      } else {
        when(() => client.unignoreUser(subject)).thenThrow(error);
      }
      final source = MatrixContactDataSource(manager);
      final call = operation == 'ignore'
          ? source.ignoreUser(subject)
          : source.unignoreUser(subject);
      await expectLater(call, throwsA(same(error)));
    });
  }

  test(
    'Matrix account-data ignore state survives source/client recreation',
    () async {
      final server = <String, Map<String, matrix.BasicEvent>>{};
      final manager = _Manager();
      var client = _AccountDataClient(server, '@a:hs.test');
      when(() => manager.client).thenAnswer((_) => client);
      final source = MatrixContactDataSource(manager);
      expect(source.isUserIgnored(subject), isFalse);
      await source.ignoreUser(subject);
      expect(server['@a:hs.test']?['m.ignored_user_list']?.content, {
        'ignored_users': {subject: <String, Object?>{}},
      });

      client = _AccountDataClient(server, '@a:hs.test');
      final reopened = MatrixContactDataSource(manager);
      expect(reopened.isUserIgnored(subject), isTrue);
      client = _AccountDataClient(server, '@b:hs.test');
      expect(MatrixContactDataSource(manager).isUserIgnored(subject), isFalse);
      client = _AccountDataClient(server, '@a:hs.test');
      await reopened.unignoreUser(subject);
      client = _AccountDataClient(server, '@a:hs.test');
      expect(MatrixContactDataSource(manager).isUserIgnored(subject), isFalse);
      expect(server['@b:hs.test'], isNull);
    },
  );
}
