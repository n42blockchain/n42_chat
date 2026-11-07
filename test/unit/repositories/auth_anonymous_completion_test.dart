import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/repositories/auth_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class _Auth extends Mock implements MatrixAuthDataSource {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements Client {}

class _Storage extends Mock implements SecureStorageDataSource {}

class _Repository extends AuthRepositoryImpl {
  _Repository(_Auth auth)
    : super(authDataSource: auth, secureStorage: _Storage());
  late Future<AuthResult> Function() registerResult;
  late Future<bool> Function(String) rename;
  @override
  Future<AuthResult> register({
    required String homeserver,
    required String username,
    required String password,
    String? email,
    String? registrationToken,
  }) => registerResult();
  @override
  Future<bool> updateDisplayName(String name) => rename(name);
}

void main() {
  for (final switchAt in [
    'before nickname',
    'during nickname',
    'token replaced',
    'rename failed',
    'never',
  ]) {
    test('anonymous completion is session bound: $switchAt', () async {
      final auth = _Auth();
      final manager = _Manager();
      final client = _Client();
      var loggedIn = false;
      var user = '@guest:example';
      var token = 'guest-token';
      var renames = 0;
      final renameStarted = Completer<void>();
      final renamed = Completer<bool>();
      when(() => auth.clientManager).thenReturn(manager);
      when(() => manager.client).thenReturn(client);
      when(() => auth.isLoggedIn).thenAnswer((_) => loggedIn);
      when(() => auth.userId).thenAnswer((_) => user);
      when(() => client.userID).thenAnswer((_) => user);
      when(() => client.accessToken).thenAnswer((_) => token);
      when(() => auth.isUsernameAvailable(any(), any()))
          .thenAnswer((_) async => true);
      final repository = _Repository(auth);
      repository.registerResult = () async {
        loggedIn = true;
        if (switchAt == 'before nickname') user = '@normal:example';
        return AuthResult.success(
          const UserEntity(userId: '@guest:example', displayName: 'guest'),
        );
      };
      repository.rename = (name) {
        renames++;
        expect(name, startsWith('Live Guest '));
        renameStarted.complete();
        return renamed.future;
      };
      final result = repository.registerAnonymously(
        homeserver: 'https://example',
        password: 'fixture',
      );
      if (switchAt != 'before nickname') {
        await renameStarted.future;
        if (switchAt == 'during nickname') user = '@normal:example';
        if (switchAt == 'token replaced') token = 'replacement-token';
        renamed.complete(switchAt != 'rename failed');
      } else {
        renamed.complete(true);
      }
      final completed = await result;
      expect(
        completed.success,
        switchAt == 'never' || switchAt == 'rename failed',
      );
      expect(renames, switchAt == 'before nickname' ? 0 : 1);
      repository.dispose();
    });
  }
}
