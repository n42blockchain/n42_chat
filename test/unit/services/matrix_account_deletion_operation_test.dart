import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/encryption/account_session_index.dart';
import 'package:n42_chat/src/core/encryption/local_room_key_store.dart';
import 'package:n42_chat/src/core/utils/matrix_deletion_uia_coordinator.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_operation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Client extends Mock implements Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _RoomKeys extends Mock implements LocalRoomKeyStore {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final server = Uri.parse('https://hs.test');
  const userA = '@a:hs';
  const userB = '@b:hs';
  late _Client a;
  late _Client b;
  late _Manager manager;
  late _RoomKeys roomKeys;
  late SecureStorageDataSource storage;
  late AccountSessionIndex index;

  DeletionUiaReceipt receipt() => DeletionUiaReceipt(
    userId: userA,
    homeserver: server,
    requiresDeferredCleanup: false,
  );

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
    a = _Client();
    b = _Client();
    manager = _Manager();
    roomKeys = _RoomKeys();
    storage = SecureStorageDataSource();
    index = AccountSessionIndex();
    when(() => manager.client).thenReturn(a);
    when(() => manager.isLoggedIn).thenReturn(true);
    when(() => a.isLogged()).thenReturn(true);
    when(() => a.userID).thenReturn(userA);
    when(() => a.homeserver).thenReturn(server);
    when(() => a.deviceID).thenReturn('device-A');
    when(() => b.userID).thenReturn(userB);
    when(() => b.homeserver).thenReturn(server);
    when(() => b.deviceID).thenReturn('device-B');
    when(
      () => roomKeys.deleteForIdentity(server, userA),
    ).thenAnswer((_) async {});
    when(
      () => a.clear(reason: SessionClearReason.logout),
    ).thenAnswer((_) async {});
  });

  test(
    'request uses frozen A client and erase choice across async switch',
    () async {
      final result = Completer<IdServerUnbindResult>();
      final sent = <AuthenticationData?>[];
      when(
        () => a.deactivateAccount(auth: any(named: 'auth'), erase: false),
      ).thenAnswer((call) {
        sent.add(call.namedArguments[#auth] as AuthenticationData?);
        return result.future;
      });
      final operation = MatrixAccountDeletionOperation.capture(
        manager: manager,
        storage: storage,
        roomKeys: roomKeys,
        accountSessions: index,
        erase: false,
        generationIsCurrent: () => true,
      );
      final pending = operation.request(null);
      when(() => manager.client).thenReturn(b);
      result.complete(IdServerUnbindResult.success);
      await pending;
      expect(operation.serverConfirmed, isTrue);
      expect(operation.userId, userA);
      expect(operation.erase, isFalse);
      expect(sent, [null]);
      verifyNever(
        () => b.deactivateAccount(auth: any(named: 'auth'), erase: false),
      );
      await expectLater(operation.request(null), throwsStateError);
    },
  );

  test(
    'cleanup clears A without saving keys and retains unrelated B state',
    () async {
      when(
        () => a.deactivateAccount(auth: null, erase: true),
      ).thenAnswer((_) async => IdServerUnbindResult.success);
      await storage.saveSession(
        homeserver: server.toString(),
        accessToken: 'A-token',
        userId: userA,
        deviceId: 'device-A',
      );
      await storage.addAccount(
        userId: userA,
        homeserver: server.toString(),
        accessToken: 'A-token',
        deviceId: 'device-A',
      );
      await storage.addAccount(
        userId: userB,
        homeserver: server.toString(),
        accessToken: 'B-token',
        deviceId: 'device-B',
      );
      await index.remember(server, userA, 'device-A', 'N42Chat_A');
      await index.remember(server, userB, 'device-B', 'N42Chat_B');
      final operation = MatrixAccountDeletionOperation.capture(
        manager: manager,
        storage: storage,
        roomKeys: roomKeys,
        accountSessions: index,
        erase: true,
        generationIsCurrent: () => true,
      );
      await operation.request(null);
      expect(
        await operation.cleanup(receipt()),
        DeletionCleanupStatus.complete,
      );
      verify(() => a.clear(reason: SessionClearReason.logout)).called(1);
      verify(() => roomKeys.deleteForIdentity(server, userA)).called(1);
      expect(await storage.getSession(), isNull);
      expect((await storage.getAccounts()).keys, [userB]);
      expect(await index.lookup(server, userA, 'device-A'), isNull);
      expect(await index.lookup(server, userB, 'device-B'), 'N42Chat_B');
      verifyNever(() => b.clear(reason: SessionClearReason.logout));
    },
  );

  test('A to B switch preserves B session and defers A SDK clear', () async {
    when(
      () => a.deactivateAccount(auth: null, erase: true),
    ).thenAnswer((_) async => IdServerUnbindResult.success);
    final operation = MatrixAccountDeletionOperation.capture(
      manager: manager,
      storage: storage,
      roomKeys: roomKeys,
      accountSessions: index,
      erase: true,
      generationIsCurrent: () => true,
    );
    await operation.request(null);
    await storage.saveSession(
      homeserver: server.toString(),
      accessToken: 'B-token',
      userId: userB,
      deviceId: 'device-B',
    );
    await storage.addAccount(
      userId: userA,
      homeserver: server.toString(),
      accessToken: 'A-token',
      deviceId: 'device-A',
    );
    await storage.addAccount(
      userId: userB,
      homeserver: server.toString(),
      accessToken: 'B-token',
      deviceId: 'device-B',
    );
    await index.remember(server, userA, 'device-A', 'N42Chat_A');
    await index.remember(server, userB, 'device-B', 'N42Chat_B');
    when(() => manager.client).thenReturn(b);
    expect(
      await operation.cleanup(receipt()),
      DeletionCleanupStatus.deferredClientClear,
    );
    expect((await storage.getSession())?['userId'], userB);
    expect((await storage.getAccounts()).keys, [userB]);
    expect(await index.lookup(server, userA, 'device-A'), 'N42Chat_A');
    expect(await index.lookup(server, userB, 'device-B'), 'N42Chat_B');
    verifyNever(() => a.clear(reason: SessionClearReason.logout));
    verifyNever(() => b.clear(reason: SessionClearReason.logout));
    verify(() => roomKeys.deleteForIdentity(server, userA)).called(1);
  });

  test(
    'generation change rejects an ABA retry on the same client object',
    () async {
      var currentGeneration = true;
      final operation = MatrixAccountDeletionOperation.capture(
        manager: manager,
        storage: storage,
        roomKeys: roomKeys,
        accountSessions: index,
        erase: true,
        generationIsCurrent: () => currentGeneration,
      );
      currentGeneration = false;
      await expectLater(operation.request(null), throwsStateError);
      verifyNever(() => a.deactivateAccount(auth: null, erase: true));
    },
  );

  test(
    'scoped cleanup leaves unrelated secure wallet data untouched',
    () async {
      when(
        () => a.deactivateAccount(auth: null, erase: true),
      ).thenAnswer((_) async => IdServerUnbindResult.success);
      await storage.write('wallet_private_fixture', 'keep-B-wallet');
      final operation = MatrixAccountDeletionOperation.capture(
        manager: manager,
        storage: storage,
        roomKeys: roomKeys,
        accountSessions: index,
        erase: true,
        generationIsCurrent: () => true,
      );
      await operation.request(null);
      expect(
        await operation.cleanup(receipt()),
        DeletionCleanupStatus.complete,
      );
      expect(await storage.read('wallet_private_fixture'), 'keep-B-wallet');
    },
  );

  test(
    'cleanup failure retains A receipt and is idempotently retryable',
    () async {
      when(
        () => a.deactivateAccount(auth: null, erase: true),
      ).thenAnswer((_) async => IdServerUnbindResult.success);
      var fails = true;
      when(() => roomKeys.deleteForIdentity(server, userA)).thenAnswer((
        _,
      ) async {
        if (fails) throw StateError('fixture storage failure');
      });
      final operation = MatrixAccountDeletionOperation.capture(
        manager: manager,
        storage: storage,
        roomKeys: roomKeys,
        accountSessions: index,
        erase: true,
        generationIsCurrent: () => true,
      );
      await operation.request(null);
      await expectLater(
        operation.cleanup(receipt()),
        throwsA(
          isA<MatrixDeletionCleanupException>().having(
            (error) => error.receipt.userId,
            'receipt user',
            userA,
          ),
        ),
      );
      expect(operation.serverConfirmed, isTrue);
      fails = false;
      expect(
        await operation.cleanup(receipt()),
        DeletionCleanupStatus.complete,
      );
      verify(() => a.clear(reason: SessionClearReason.logout)).called(1);
      verify(() => roomKeys.deleteForIdentity(server, userA)).called(2);
    },
  );

  test('no cleanup is allowed before server confirmation', () async {
    final operation = MatrixAccountDeletionOperation.capture(
      manager: manager,
      storage: storage,
      roomKeys: roomKeys,
      accountSessions: index,
      erase: true,
      generationIsCurrent: () => true,
    );
    await expectLater(operation.cleanup(receipt()), throwsStateError);
    verifyNever(() => a.clear(reason: SessionClearReason.logout));
    verifyNever(() => roomKeys.deleteForIdentity(server, userA));
  });
}
