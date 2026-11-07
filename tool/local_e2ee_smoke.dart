// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

import 'live_smoke_credentials.dart';

/// Explicit loopback-only, three-client encrypted group protocol check.
/// Requires N42_TEST_HOMESERVER and N42_TEST_INVITE_CODE. Creates random users;
/// no existing accounts, credentials, recovery keys, or production endpoints.
Future<void> main() => runLocalE2eeSmoke();

Future<void> runLocalE2eeSmoke({Map<String, String>? environment}) async {
  final env = environment ?? Platform.environment;
  final uri = Uri.tryParse(env['N42_TEST_HOMESERVER'] ?? '');
  if (uri == null ||
      uri.scheme != 'http' ||
      !{'127.0.0.1', 'localhost', '::1'}.contains(uri.host) ||
      uri.userInfo.isNotEmpty ||
      uri.hasQuery ||
      uri.hasFragment) {
    throw StateError('Explicit loopback HTTP homeserver required.');
  }
  if (env['N42_TEST_USERNAME']?.isNotEmpty == true ||
      env['N42_TEST_PASSWORD']?.isNotEmpty == true) {
    throw StateError('Only generated disposable accounts are supported.');
  }
  final stamp = DateTime.now().microsecondsSinceEpoch;
  final credentials = List.generate(
    3,
    (index) => LiveSmokeCredentials.fromEnvironment(
      env,
      temporaryUsername: () => 'n42e2ee${stamp}_$index',
    ),
  );
  await vod.init();
  sqfliteFfiInit();
  final clients = <Client>[];
  final directory = await Directory.systemTemp.createTemp('n42-e2ee-qa-');
  try {
    for (var i = 0; i < credentials.length; i++) {
      final db = await databaseFactoryFfi.openDatabase(
        '${directory.path}/client-$i.sqlite',
      );
      final database = await MatrixSdkDatabase.init(
        'e2ee-$i',
        database: db,
        sqfliteFactory: databaseFactoryFfi,
      );
      final client = Client('e2ee-$i', database: database);
      clients.add(client);
      await client.checkHomeserver(uri);
      final credential = credentials[i];
      Future<RegisterResponse> register(String? session) => client.register(
        username: credential.username,
        password: credential.password,
        initialDeviceDisplayName: 'Isolated E2EE QA',
        auth: _TokenAuth(env['N42_TEST_INVITE_CODE']!.trim(), session: session),
      );
      try {
        await register(null);
      } on MatrixException catch (error) {
        if (error.response?.statusCode != 401) rethrow;
        final session =
            (jsonDecode(error.response!.body) as Map)['session'] as String?;
        if (session == null) rethrow;
        await register(session);
      }
      if (!client.encryptionEnabled) {
        throw StateError('Encryption not initialized');
      }
    }
    final roomId = await clients.first.createRoom(
      name: 'Isolated encrypted QA',
      preset: CreateRoomPreset.privateChat,
      initialState: [
        StateEvent(
          type: EventTypes.Encryption,
          content: {'algorithm': 'm.megolm.v1.aes-sha2'},
        ),
      ],
    );
    await _until(clients, () => clients.first.getRoomById(roomId) != null);
    final ownerRoom = clients.first.getRoomById(roomId)!;
    for (final client in clients.skip(1)) {
      await ownerRoom.invite(client.userID!);
      await client.joinRoom(roomId);
    }
    await _until(
      clients,
      () => clients.every((c) => c.getRoomById(roomId)?.encrypted == true),
    );
    var deliveries = 0;
    for (var sender = 0; sender < clients.length; sender++) {
      final body = 'isolated encrypted payload $stamp/$sender 中文🙂';
      final eventId = await clients[sender]
          .getRoomById(roomId)!
          .sendTextEvent(body);
      if (eventId == null) throw StateError('Missing event id');
      final raw = await clients[sender].getOneRoomEvent(roomId, eventId);
      if (raw.type != EventTypes.Encrypted ||
          jsonEncode(raw.content).contains(body)) {
        throw StateError('Server event is not opaque ciphertext');
      }
      for (final recipient in clients) {
        await _until(clients, () async {
          final event = await recipient
              .getRoomById(roomId)!
              .getEventById(eventId);
          return event?.type == EventTypes.Message &&
              event?.content['body'] == body;
        });
        deliveries++;
      }
    }
    print(
      jsonEncode({
        'clients': clients.length,
        'encrypted_events': 3,
        'decrypted_deliveries': deliveries,
        'server_ciphertext_checks': 3,
        'passed': true,
        'scope': 'isolated protocol; not UI, recovery or device acceptance',
      }),
    );
  } finally {
    for (final client in clients.reversed) {
      try {
        if (client.isLogged()) await client.logout();
      } catch (_) {
        print('QA session logout failed; local disposal continues');
      } finally {
        await client.dispose();
      }
    }
    await directory.delete(recursive: true);
  }
}

Future<void> _until(
  List<Client> clients,
  FutureOr<bool> Function() ready,
) async {
  final deadline = DateTime.now().add(const Duration(seconds: 60));
  while (DateTime.now().isBefore(deadline)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException('Encrypted group condition not reached');
}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}
