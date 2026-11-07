import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/repositories/auth_repository_impl.dart';

class _Auth extends Mock implements MatrixAuthDataSource {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements Client {}

class _Storage extends Mock implements SecureStorageDataSource {}

void main() {
  late _Auth auth;
  late _Manager manager;
  late _Client client;
  late AuthRepositoryImpl repository;
  late String userId;

  setUp(() {
    auth = _Auth();
    manager = _Manager();
    client = _Client();
    userId = '@first:example';
    when(() => auth.clientManager).thenReturn(manager);
    when(() => auth.isLoggedIn).thenReturn(true);
    when(() => auth.userId).thenAnswer((_) => userId);
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenAnswer((_) => userId);
    when(() => client.setAccountData(any(), any(), any()))
        .thenAnswer((_) async {});
    repository = AuthRepositoryImpl(
      authDataSource: auth,
      secureStorage: _Storage(),
    );
  });

  test(
    'late profile read cannot populate a replacement account cache',
    () async {
      final pending = Completer<Map<String, dynamic>>();
      when(() => client.getAccountData(any(), any()))
          .thenAnswer((_) => pending.future);
      final read = repository.getUserProfileData();
      userId = '@second:example';
      pending.complete({'signature': 'first account only'});
      expect(await read, isNull);
      expect(repository.currentUser!.signature, isNull);
    },
  );

  test(
    'account switch during profile read prevents subsequent write',
    () async {
      final pending = Completer<Map<String, dynamic>>();
      when(() => client.getAccountData(any(), any()))
          .thenAnswer((_) => pending.future);
      final write = repository.updateUserProfileData(
        signature: 'new signature',
      );
      userId = '@second:example';
      pending.complete({'region': 'first account region'});
      expect(await write, isFalse);
      verifyNever(() => client.setAccountData(any(), any(), any()));
      expect(repository.currentUser!.signature, isNull);
    },
  );

  test(
    'late profile write cannot populate a replacement account cache',
    () async {
      final pending = Completer<void>();
      when(() => client.getAccountData(any(), any()))
          .thenAnswer((_) async => <String, dynamic>{});
      when(() => client.setAccountData(any(), any(), any()))
          .thenAnswer((_) => pending.future);
      final write = repository.updateUserProfileData(
        signature: 'first account only',
      );
      await Future<void>.delayed(Duration.zero);
      userId = '@second:example';
      pending.complete();
      expect(await write, isFalse);
      expect(repository.currentUser!.signature, isNull);
    },
  );

  test('late standard profile cannot rename a replacement account', () async {
    final pending = Completer<Profile>();
    when(() => manager.getUserProfile(any())).thenAnswer((_) => pending.future);
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) async => <String, dynamic>{});
    final read = repository.getCurrentUserProfile();
    userId = '@second:example';
    pending.complete(
      Profile(userId: '@first:example', displayName: 'First account name'),
    );
    expect(await read, isNull);
    expect(repository.currentUser!.displayName, isNot('First account name'));
  });

  test('token replacement invalidates an in-flight profile read', () async {
    var token = 'synthetic-first';
    final pending = Completer<Map<String, dynamic>>();
    when(() => client.accessToken).thenAnswer((_) => token);
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) => pending.future);
    final read = repository.getUserProfileData();
    token = 'synthetic-second';
    pending.complete({'signature': 'old session'});
    expect(await read, isNull);
    expect(repository.currentUser!.signature, isNull);
  });

  test('same account receives its standard and custom profile', () async {
    when(() => manager.getUserProfile(any())).thenAnswer(
      (_) async => Profile(userId: userId, displayName: 'Current name'),
    );
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) async => {'signature': 'Current signature'});
    final profile = await repository.getCurrentUserProfile();
    expect(profile!.userId, userId);
    expect(profile.displayName, 'Current name');
    expect(profile.signature, 'Current signature');
  });

  test('same account retains profile fields and accepts its update', () async {
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) async => {'region': 'keep'});
    expect(await repository.updateUserProfileData(signature: 'new'), isTrue);
    expect(repository.currentUser!.signature, 'new');
    expect(repository.currentUser!.region, 'keep');
    verify(
      () => client.setAccountData('@first:example', 'n42.user.profile', {
        'region': 'keep',
        'signature': 'new',
      }),
    ).called(1);
  });
}
