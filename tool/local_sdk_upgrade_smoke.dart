// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

import 'live_smoke_credentials.dart';

/// Two phases use the identical source with the actual SDK 15/16 package maps.
/// The fixture contains synthetic session keys/tokens and must remain private.
Future<void> main() => runLocalSdkUpgrade();

Future<void> runLocalSdkUpgrade({Map<String, String>? environment}) async {
  final env = environment ?? Platform.environment;
  final mode = env['N42_QA_UPGRADE_MODE'];
  final uri = Uri.tryParse(env['N42_TEST_HOMESERVER'] ?? '');
  final path = env['N42_QA_UPGRADE_DIR'] ?? '';
  final root = Directory(path);
  if (!{'seed', 'verify'}.contains(mode) ||
      uri == null ||
      uri.scheme != 'http' ||
      !{'localhost', '127.0.0.1', '::1'}.contains(uri.host) ||
      uri.userInfo.isNotEmpty ||
      uri.hasQuery ||
      uri.hasFragment ||
      path.isEmpty ||
      !root.isAbsolute ||
      !root.uri.pathSegments
          .where((s) => s.isNotEmpty)
          .last
          .startsWith('n42-sdk-upgrade-') ||
      FileSystemEntity.typeSync(path, followLinks: false) !=
          FileSystemEntityType.directory ||
      (root.statSync().mode & 0x3f) != 0 ||
      env['N42_TEST_USERNAME'] != null ||
      env['N42_TEST_PASSWORD'] != null) {
    throw StateError(
      'Explicit loopback and private owned upgrade fixture required.',
    );
  }
  final seed = mode == 'seed';
  if (seed && root.listSync().isNotEmpty) {
    throw StateError('Seeding requires an empty owned fixture directory.');
  }
  final package = await Isolate.resolvePackageUri(
    Uri.parse('package:matrix/matrix.dart'),
  );
  if (package == null) {
    throw StateError('Cannot resolve Matrix package identity.');
  }
  final pubspec = File.fromUri(package.resolve('../pubspec.yaml'))
      .readAsStringSync();
  final version = RegExp(
    r'^version:\s*(\S+)',
    multiLine: true,
  ).firstMatch(pubspec)?.group(1);
  if (version != (seed ? '15.0.0' : '16.0.1')) {
    throw StateError(
      'Upgrade phase is running with the wrong actual Matrix SDK.',
    );
  }
  final stamp = DateTime.now().microsecondsSinceEpoch;
  final credentials = seed
      ? List.generate(
          2,
          (i) => LiveSmokeCredentials.fromEnvironment(
            env,
            temporaryUsername: () => 'n42up_${stamp}_$i',
          ),
        )
      : <LiveSmokeCredentials>[];
  final stateFile = File('${root.path}/fixture.json');
  final Map<String, dynamic> state = seed
      ? {
          'kind': 'n42-sdk-upgrade',
          'sourceVersion': '15.0.0',
          'homeserver': uri.toString(),
          'tag': stamp.toString(),
          'accounts': <Map<String, dynamic>>[],
          'events': <String, String>{},
        }
      : jsonDecode(stateFile.readAsStringSync()) as Map<String, dynamic>;
  if (!seed &&
      (state['kind'] != 'n42-sdk-upgrade' ||
          state['sourceVersion'] != '15.0.0' ||
          state['homeserver'] != uri.toString() ||
          (state['accounts'] as List).length != 2 ||
          !(state['accounts'] as List).every(
            (a) => (a['userId'] as String).startsWith('@n42up_'),
          ))) {
    throw StateError('Fixture does not identify disposable SDK 15 accounts.');
  }
  await vod.init();
  sqfliteFfiInit();
  final clients = <Client>[];
  final gates = <_Transport>[];
  Map<String, Object>? result;
  try {
    for (var i = 0; i < 2; i++) {
      final gate = _Transport(online: seed);
      gates.add(gate);
      final db = await databaseFactoryFfi.openDatabase(
        '${root.path}/$i.sqlite',
      );
      final database = await MatrixSdkDatabase.init(
        'upgrade-$i',
        database: db,
        sqfliteFactory: databaseFactoryFfi,
      );
      final client = Client('upgrade-$i', database: database, httpClient: gate);
      clients.add(client);
      if (seed) {
        await client.checkHomeserver(uri);
        Future<RegisterResponse> register(String? session) => client.register(
          username: credentials[i].username,
          password: credentials[i].password,
          initialDeviceDisplayName: 'Synthetic SDK upgrade',
          auth: _TokenAuth(
            env['N42_TEST_INVITE_CODE']!.trim(),
            session: session,
          ),
        );
        try {
          await register(null);
        } on MatrixException catch (e) {
          if (e.response?.statusCode != 401) rethrow;
          final session =
              (jsonDecode(e.response!.body) as Map)['session'] as String?;
          if (session == null) rethrow;
          await register(session);
        }
      } else {
        // Load existing SQLite state with all network traffic blocked.
        await client.init(waitForFirstSync: false);
        await client.abortSync();
        final expected = (state['accounts'] as List)[i] as Map;
        if (!client.isLogged() ||
            client.userID != expected['userId'] ||
            client.deviceID != expected['deviceId'] ||
            client.fingerprintKey != expected['fingerprint']) {
          throw StateError(
            'Existing account/device identity changed on upgrade.',
          );
        }
      }
      if (!client.encryptionEnabled) {
        throw StateError('Stored encryption not initialized.');
      }
      final fingerprint = client.fingerprintKey;
      final device = client.deviceID;
      if (!client.isLogged() ||
          fingerprint.isEmpty ||
          device == null ||
          device.isEmpty) {
        throw StateError('Fixture device identity is incomplete.');
      }
    }
    if (seed) {
      final room = await clients.first.createRoom(
        name: 'Synthetic persisted upgrade',
        preset: CreateRoomPreset.privateChat,
        initialState: [
          StateEvent(
            type: EventTypes.Encryption,
            content: {'algorithm': 'm.megolm.v1.aes-sha2'},
          ),
        ],
      );
      state['roomId'] = room;
      await _until(clients, () => clients.first.getRoomById(room) != null);
      await clients.first.getRoomById(room)!.invite(clients.last.userID!);
      await clients.last.joinRoom(room);
      await _until(
        clients,
        () => clients.every((c) => c.getRoomById(room)?.encrypted == true),
      );
      final events = state['events'] as Map<String, String>;
      for (var i = 0; i < 4; i++) {
        final body = 'SDK 15 retained payload $stamp/$i 中文🙂';
        final id = await clients[i % 2].getRoomById(room)!.sendTextEvent(body);
        if (id == null || events.containsKey(id)) {
          throw StateError('Missing or duplicate fixture message.');
        }
        events[id] = body;
      }
      await _until(clients, () => _readable(clients, room, events));
      for (final client in clients) {
        (state['accounts'] as List).add({
          'userId': client.userID,
          'deviceId': client.deviceID,
          'fingerprint': client.fingerprintKey,
        });
        await client.abortSync();
      }
      stateFile.writeAsStringSync(jsonEncode(state), flush: true);
      result = {
        'seeded': true,
        'matrixVersion': version!,
        'accounts': 2,
        'persistedEvents': 4,
        'readChecks': 8,
      };
    } else {
      final room = state['roomId'] as String;
      final events = Map<String, String>.from(state['events'] as Map);
      if (events.length != 4 || !await _readable(clients, room, events)) {
        throw StateError(
          'Existing encrypted history is not readable while offline.',
        );
      }
      final blocked = gates.fold<int>(0, (sum, g) => sum + g.blocked);
      for (var i = 0; i < 2; i++) {
        gates[i].online = true;
        clients[i].backgroundSync = true;
        await clients[i].oneShotSync(timeout: Duration.zero);
      }
      for (var i = 0; i < 2; i++) {
        final body = 'SDK 16 new payload ${state['tag']}/$i';
        final id = await clients[i].getRoomById(room)!.sendTextEvent(body);
        if (id == null || events.containsKey(id)) {
          throw StateError('Missing or duplicate post-upgrade event.');
        }
        events[id] = body;
      }
      await _until(clients, () => _readable(clients, room, events));
      for (final client in clients) {
        await client.logout();
      }
      result = {
        'passed': true,
        'sourceVersion': '15.0.0',
        'targetVersion': version!,
        'accounts': 2,
        'retainedDevices': 2,
        'retainedFingerprints': 2,
        'offlineHistoricalReads': 8,
        'postUpgradeReadableEventsPerClient': 6,
        'postUpgradeReadChecks': 12,
        'offlineTransportBlockedRequests': blocked,
        'newPasswordLogins': 0,
        'scope': 'actual SQLite/crypto SDK upgrade; not native secure storage or physical UI',
      };
    }
  } finally {
    for (final client in clients.reversed) {
      await client.dispose();
    }
  }
  if (!seed) {
    await root.delete(recursive: true);
  }
  print(jsonEncode(result));
}

Future<bool> _readable(
  List<Client> clients,
  String room,
  Map<String, String> events,
) async {
  for (final client in clients) {
    final r = client.getRoomById(room);
    if (r == null || !r.encrypted) return false;
    for (final e in events.entries) {
      final event = await r.getEventById(e.key);
      if (event?.type != EventTypes.Message || event?.body != e.value) {
        return false;
      }
    }
  }
  return true;
}

Future<void> _until(
  List<Client> clients,
  FutureOr<bool> Function() ready,
) async {
  final end = DateTime.now().add(const Duration(minutes: 2));
  while (DateTime.now().isBefore(end)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException(
    'SDK upgrade fixture did not reach the expected state',
  );
}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}

class _Transport extends http.BaseClient {
  _Transport({required this.online});
  bool online;
  int blocked = 0;
  final http.Client _delegate = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (!online) {
      blocked++;
      throw const SocketException('Offline SDK upgrade verification');
    }
    return _delegate.send(request);
  }

  @override
  void close() => _delegate.close();
}
