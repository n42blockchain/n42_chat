import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/encryption/local_room_key_store.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';

class _Client extends Mock implements Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
  late _Client client;
  late _Manager manager;
  late _Storage storage;
  late MatrixAuthDataSource source;
  late bool syncing;

  setUpAll(() => registerFallbackValue(AuthenticationData()));

  setUp(() {
    client = _Client();
    manager = _Manager();
    storage = _Storage();
    syncing = true;
    when(() => manager.client).thenReturn(client);
    when(() => manager.isLoggedIn).thenReturn(true);
    when(() => manager.discardLocalSession()).thenAnswer((_) async {});
    when(() => client.userID).thenReturn('@alice:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.backgroundSync = any()).thenAnswer((call) {
      return syncing = call.positionalArguments.single as bool;
    });
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    source = MatrixAuthDataSource(
      clientManager: manager,
      localRoomKeys: LocalRoomKeyStore(storage: storage),
    );
  });

  test('pauses sync and discards the session locally on success', () async {
    when(
      () => client.deactivateAccount(
        auth: any(named: 'auth'),
        erase: any(named: 'erase'),
      ),
    ).thenAnswer((_) async {
      expect(syncing, isFalse);
      return IdServerUnbindResult.success;
    });

    await source.deactivateAccount(password: 'secret');

    verify(() => manager.discardLocalSession()).called(1);
    verify(() => storage.delete(key: any(named: 'key'))).called(1);
    verifyNever(() => client.logout());
    expect(syncing, isFalse);
  });

  test('resumes sync and keeps the session when the server rejects', () async {
    when(
      () => client.deactivateAccount(
        auth: any(named: 'auth'),
        erase: any(named: 'erase'),
      ),
    ).thenThrow(MatrixException.fromJson({'errcode': 'M_FORBIDDEN'}));

    await expectLater(
      source.deactivateAccount(),
      throwsA(isA<MatrixException>()),
    );

    expect(syncing, isTrue);
    verifyNever(() => manager.discardLocalSession());
    verifyNever(() => storage.delete(key: any(named: 'key')));
  });
}
