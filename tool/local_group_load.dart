// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

import 'live_smoke_credentials.dart';
import 'local_e2ee_smoke.dart' show retryRateLimited;

Future<void> main() => runLocalGroupLoad();

/// Isolated protocol load. This does not exercise physical-device UI or push.
Future<void> runLocalGroupLoad({Map<String, String>? environment}) async {
  final env = environment ?? Platform.environment;
  final uri = Uri.tryParse(env['N42_TEST_HOMESERVER'] ?? '');
  final members = int.tryParse(env['N42_QA_GROUP_MEMBERS'] ?? '20');
  final count = int.tryParse(env['N42_QA_GROUP_MESSAGES'] ?? '10000');
  if (uri == null ||
      uri.scheme != 'http' ||
      !{'localhost', '127.0.0.1', '::1'}.contains(uri.host) ||
      uri.userInfo.isNotEmpty ||
      uri.hasQuery ||
      uri.hasFragment ||
      members == null ||
      members < 3 ||
      members > 20 ||
      count == null ||
      count < 10 ||
      count > 10000 ||
      env['N42_TEST_USERNAME'] != null ||
      env['N42_TEST_PASSWORD'] != null) {
    throw StateError(
      'Explicit loopback, generated accounts and bounded load required.',
    );
  }
  final stamp = DateTime.now().microsecondsSinceEpoch;
  final credentials = List.generate(
    members,
    (i) => LiveSmokeCredentials.fromEnvironment(
      env,
      temporaryUsername: () => 'n42load${stamp}_$i',
    ),
  );
  await vod.init();
  sqfliteFfiInit();
  final directory = await Directory.systemTemp.createTemp('n42-group-load-');
  final clients = <Client>[];
  final timelines = <Timeline>[];
  final sent = <String, String>{};
  final clock = Stopwatch()..start();
  try {
    for (var i = 0; i < members; i++) {
      final db = await databaseFactoryFfi.openDatabase(
        '${directory.path}/$i.sqlite',
      );
      final database = await MatrixSdkDatabase.init(
        'load-$i',
        database: db,
        sqfliteFactory: databaseFactoryFfi,
      );
      final client = Client('isolated-load-$i', database: database);
      clients.add(client);
      await client.checkHomeserver(uri);
      Future<RegisterResponse> register(String? session) => client.register(
        username: credentials[i].username,
        password: credentials[i].password,
        initialDeviceDisplayName: 'Isolated group load',
        auth: _TokenAuth(env['N42_TEST_INVITE_CODE']!.trim(), session: session),
      );
      try {
        await retryRateLimited(() => register(null));
      } on MatrixException catch (e) {
        if (e.response?.statusCode != 401) rethrow;
        final session =
            (jsonDecode(e.response!.body) as Map)['session'] as String?;
        if (session == null) rethrow;
        await retryRateLimited(() => register(session));
      }
      if (!client.encryptionEnabled) {
        throw StateError('Encryption not initialized');
      }
    }
    final roomId = await clients.first.createRoom(
      name: 'Synthetic encrypted group load',
      preset: CreateRoomPreset.privateChat,
      initialState: [
        StateEvent(
          type: EventTypes.Encryption,
          content: {'algorithm': 'm.megolm.v1.aes-sha2'},
        ),
      ],
    );
    await _until(clients, () => clients.first.getRoomById(roomId) != null);
    for (final client in clients.skip(1)) {
      await clients.first.getRoomById(roomId)!.invite(client.userID!);
      await client.joinRoom(roomId);
    }
    await _until(
      clients,
      () => clients.every((c) => c.getRoomById(roomId)?.encrypted == true),
    );
    final users = clients.map((c) => c.userID!).toSet();
    for (final client in clients) {
      await client.updateUserDeviceKeys(additionalUsers: users);
      await client.getRoomById(roomId)!.requestParticipants();
    }
    // Establish keys while all peers are online, then disconnect the last peer.
    final warmup = await clients.first
        .getRoomById(roomId)!
        .sendTextEvent('load warmup $stamp');
    await _until(clients, () async {
      for (final c in clients) {
        final event = await c.getRoomById(roomId)!.getEventById(warmup!);
        if (event?.body != 'load warmup $stamp') return false;
      }
      return true;
    });
    await clients.last.abortSync();
    final sendClock = Stopwatch()..start();
    var files = 0;
    for (var i = 0; i < count; i++) {
      final room = clients[i % (members - 1)].getRoomById(roomId)!;
      final body = 'n42-load/$stamp/$i 中文🙂';
      final txid = 'n42-load-$stamp-$i';
      String? eventId;
      if (i % 100 == 99) {
        eventId = await retryRateLimited(
          () => room.sendFileEvent(
            MatrixFile(
              bytes: Uint8List.fromList(utf8.encode(body)),
              name: "${body.replaceAll('/', '-')}.txt",
            ),
            txid: txid,
            displayPendingEvent: false,
          ),
        );
        files++;
      } else {
        eventId = await retryRateLimited(
          () => room.sendEvent(
            {
              'msgtype': ['m.text', 'm.notice', 'm.emote'][i % 3],
              'body': body,
            },
            txid: txid,
            displayPendingEvent: false,
          ),
        );
      }
      if (eventId == null || sent.containsKey(eventId)) {
        throw StateError('Missing or duplicate acknowledged event');
      }
      sent[eventId] = i % 100 == 99 ? "${body.replaceAll('/', '-')}.txt" : body;
      if (i % 100 == 0) {
        final raw = await clients.first.getOneRoomEvent(roomId, eventId);
        if (raw.type != EventTypes.Encrypted ||
            jsonEncode(raw.content).contains(body)) {
          throw StateError('Non-opaque server event');
        }
        print('QA encrypted load acknowledged ${i + 1}/$count');
      }
    }
    sendClock.stop();
    clients.last.backgroundSync = true;
    await clients.last.oneShotSync(timeout: Duration.zero);
    final results = <Map<String, Object>>[];
    for (var i = 0; i < members; i++) {
      final timeline = await clients[i].getRoomById(roomId)!.getTimeline();
      timelines.add(timeline);
      var previous = -1;
      for (var page = 0; page < count ~/ 100 + 20; page++) {
        final found = timeline.events
            .where((e) => sent.containsKey(e.eventId))
            .length;
        if (found == count) break;
        if (timeline.events.length == previous && !timeline.canRequestHistory) {
          break;
        }
        previous = timeline.events.length;
        await timeline.requestHistory(historyCount: 500);
      }
      final deadline = DateTime.now().add(const Duration(minutes: 3));
      while (DateTime.now().isBefore(deadline)) {
        final events = timeline.events
            .where((e) => sent.containsKey(e.eventId))
            .toList();
        if (events.length == count &&
            events.every(
              (e) => e.type == EventTypes.Message && e.body == sent[e.eventId],
            )) {
          break;
        }
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
      final events = timeline.events
          .where((e) => sent.containsKey(e.eventId))
          .toList();
      final unique = events.map((e) => e.eventId).toSet();
      if (events.length != count ||
          unique.length != count ||
          events.any(
            (e) => e.type != EventTypes.Message || e.body != sent[e.eventId],
          )) {
        throw StateError(
          'Recipient $i: received=${events.length}, unique=${unique.length}, expected=$count, unreadable=${events.where((e) => e.type != EventTypes.Message || e.body != sent[e.eventId]).length}',
        );
      }
      results.add({
        'recipient': i,
        'messages': events.length,
        'unique': unique.length,
      });
      print('QA encrypted load recipient ${i + 1}/$members verified');
    }
    print(
      jsonEncode({
        'passed': true,
        'members': members,
        'messages': count,
        'fileMessages': files,
        'deliveries': members * count,
        'sendMilliseconds': sendClock.elapsedMilliseconds,
        'totalMilliseconds': clock.elapsedMilliseconds,
        'offlineRecipient': members - 1,
        'recipients': results,
        'scope': 'Matrix SDK clients, independent SQLite stores, synthetic data; no device UI/push acceptance',
      }),
    );
  } finally {
    for (final timeline in timelines) {
      timeline.cancelSubscriptions();
    }
    for (final client in clients.reversed) {
      try {
        if (client.isLogged()) await client.logout();
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
  final deadline = DateTime.now().add(const Duration(minutes: 2));
  while (DateTime.now().isBefore(deadline)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException('Group load setup timed out');
}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}
