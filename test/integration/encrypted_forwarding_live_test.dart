import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vodozemac/flutter_vodozemac.dart' as flutter_vod;
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/services/matrix_history_sharing.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_group_datasource.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/chat_catch_up_repository.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_reaction_datasource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

class _Storage extends Mock implements SecureStorageDataSource {}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}

void main() {
  final endpoint = Platform.environment['N42_FORWARD_LOOPBACK_URL'];
  test(
    'real encrypted forwarding stays ciphertext and decrypts for the recipient',
    () async {
      final uri = Uri.parse(endpoint!);
      expect(uri.scheme, 'http');
      expect(['localhost', '127.0.0.1', '::1'], contains(uri.host));
      expect(uri.userInfo, isEmpty);
      expect(uri.hasQuery || uri.hasFragment, isFalse);
      final invite = Platform.environment['N42_TEST_INVITE_CODE'];
      expect(invite, isNotEmpty);
      final config = File('.dart_tool/package_config.json');
      final packages =
          (jsonDecode(await config.readAsString())
                  as Map<String, dynamic>)['packages']
              as List<dynamic>;
      final package = packages.cast<Map<String, dynamic>>().singleWhere(
        (p) => p['name'] == 'flutter_vodozemac',
      );
      final root = Directory.fromUri(
        config.absolute.uri.resolve(package['rootUri'] as String),
      ).uri;
      await flutter_vod.init(
        libraryPath: root
            .resolve(
              'macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/',
            )
            .toFilePath(),
      );
      sqfliteFfiInit();
      final directory = await Directory.systemTemp.createTemp(
        'n42-forward-qa-',
      );
      final clients = <Client>[];
      final passwords = <String>[];
      final stamp = DateTime.now().microsecondsSinceEpoch;
      try {
        for (var i = 0; i < 2; i++) {
          final db = await databaseFactoryFfi.openDatabase(
            '${directory.path}/client-$i.sqlite',
          );
          final database = await MatrixSdkDatabase.init(
            'forward-$i',
            database: db,
            sqfliteFactory: databaseFactoryFfi,
          );
          final client = Client(
            'forward-$i',
            database: database,
            importantStateEvents: {
              ...MatrixClientManager.requiredRoomStateEvents,
            },
          );
          clients.add(client);
          final random = Random.secure();
          final password = List.generate(
            32,
            (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
          ).join();
          passwords.add(password);
          await client.checkHomeserver(uri);
          Future<RegisterResponse> register(String? session) => client.register(
            username: 'n42forward${stamp}_$i',
            password: password,
            auth: _TokenAuth(invite!, session: session),
          );
          try {
            await register(null);
          } on MatrixException catch (e) {
            if (!e.requireAdditionalAuthentication) rethrow;
            await register(e.session);
          }
          expect(client.encryptionEnabled, isTrue);
        }
        final roomIds = <String>[];
        for (var i = 0; i < 2; i++) {
          final roomId = await clients.first.createRoom(
            name: 'Owned forwarding QA $i',
            preset: CreateRoomPreset.privateChat,
            initialState: [
              StateEvent(
                type: EventTypes.Encryption,
                content: {'algorithm': 'm.megolm.v1.aes-sha2'},
              ),
            ],
          );
          roomIds.add(roomId);
          await _syncUntil(
            clients,
            () => clients.first.getRoomById(roomId) != null,
          );
          await clients.first.getRoomById(roomId)!.invite(clients.last.userID!);
          await clients.last.joinRoom(roomId);
          await _syncUntil(
            clients,
            () =>
                clients.every((c) => c.getRoomById(roomId)?.encrypted == true),
          );
        }
        final sourceRoom = clients.first.getRoomById(roomIds.first)!;
        final body = 'Forwarding acceptance $stamp 中文🙂';
        final originalId = await sourceRoom.sendTextEvent(body);
        expect(originalId, isNotNull);
        await _syncUntil(
          clients,
          () async =>
              (await sourceRoom.getEventById(originalId!))?.content['body'] ==
              body,
        );
        final manager = _Manager();
        when(() => manager.client).thenReturn(clients.first);
        final forwardedId = await MatrixReactionDataSource(manager)
            .forwardMessage(roomIds.first, originalId!, roomIds.last);
        expect(forwardedId, isNotEmpty);
        final wire = await clients.first.getOneRoomEvent(
          roomIds.last,
          forwardedId!,
        );
        expect(wire.type, EventTypes.Encrypted);
        expect(jsonEncode(wire.content).contains(body), isFalse);
        await _syncUntil(clients, () async {
          final received = await clients.last
              .getRoomById(roomIds.last)!
              .getEventById(forwardedId);
          return received?.type == EventTypes.Message &&
              received?.content['body'] == body;
        });
        final original = await sourceRoom.getEventById(originalId);
        expect(original?.content['body'], body);
        final bytes = Uint8List.fromList(
          utf8.encode('Private attachment $stamp 中文'),
        );
        final attachmentId = await sourceRoom.sendFileEvent(
          MatrixFile(
            bytes: bytes,
            name: 'forwarding.txt',
            mimeType: 'text/plain',
          ),
        );
        expect(attachmentId, isNotEmpty);
        final forwardedAttachmentId = await MatrixReactionDataSource(manager)
            .forwardMessage(roomIds.first, attachmentId!, roomIds.last);
        expect(forwardedAttachmentId, isNotEmpty);
        final attachmentWire = await clients.first.getOneRoomEvent(
          roomIds.last,
          forwardedAttachmentId!,
        );
        expect(attachmentWire.type, EventTypes.Encrypted);
        expect(
          jsonEncode(attachmentWire.content).contains('forwarding.txt'),
          isFalse,
        );
        Event? receivedAttachment;
        await _syncUntil(clients, () async {
          receivedAttachment = await clients.last
              .getRoomById(roomIds.last)!
              .getEventById(forwardedAttachmentId);
          return receivedAttachment?.content['file'] is Map;
        });
        expect(receivedAttachment!.content['msgtype'], 'm.file');
        expect(receivedAttachment!.content['body'], 'forwarding.txt');
        expect(receivedAttachment!.content.containsKey('url'), isFalse);
        final downloaded = await receivedAttachment!
            .downloadAndDecryptAttachment();
        expect(downloaded.bytes, orderedEquals(bytes));
        await _verifyHistorySharing(
          clients,
          manager,
          roomIds,
          originalId,
          body,
        );
      } finally {
        try {
          for (var i = 0; i < clients.length; i++) {
            final client = clients[i];
            if (!client.isLogged()) continue;
            AuthenticationData auth(String? session) => AuthenticationPassword(
              password: passwords[i],
              identifier: AuthenticationUserIdentifier(user: client.userID!),
              session: session,
            );
            try {
              await client.deactivateAccount(auth: auth(null), erase: true);
            } on MatrixException catch (e) {
              if (!e.requireAdditionalAuthentication) rethrow;
              await client.deactivateAccount(
                auth: auth(e.session),
                erase: true,
              );
            }
          }
        } finally {
          for (final client in clients) {
            await client.dispose();
          }
          await directory.delete(recursive: true);
        }
      }
    },
    skip: endpoint == null || !Platform.isMacOS
        ? 'Requires owned loopback fixture and the packaged macOS crypto library'
        : false,
    timeout: const Timeout(Duration(minutes: 5)),
  );
}

Future<void> _syncUntil(
  List<Client> clients,
  FutureOr<bool> Function() ready,
) async {
  final caller = StackTrace.current.toString().split('\n').take(3).join('\n');
  final deadline = DateTime.now().add(const Duration(seconds: 60));
  while (DateTime.now().isBefore(deadline)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException(
    'Owned encrypted forwarding condition not reached\n$caller',
  );
}

Future<void> _verifyHistorySharing(
  List<Client> clients,
  _Manager manager,
  List<String> rooms,
  String originalId,
  String body,
) async {
  final sender = clients.first, recipient = clients.last;
  await sender.setAccountData(sender.userID!, 'm.direct', {
    recipient.userID!: [rooms.last],
  });
  await _syncUntil(clients, () => sender.getRoomById(rooms.last)!.isDirectChat);
  final lifecycle = _Lifecycle();
  final storage = _Storage();
  final journal = <String, String>{};
  final generation = AuthSessionInvalidation(
    userId: sender.userID!,
    homeserver: sender.homeserver!,
    deviceId: sender.deviceID,
    isCurrent: () => sender.isLogged(),
    matchesClient: (client) => identical(client, sender),
  );
  when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
  when(() => storage.readStrict(any()))
      .thenAnswer((call) async => journal[call.positionalArguments.first]);
  when(() => storage.write(any(), any())).thenAnswer((call) async {
    journal[call.positionalArguments[0] as String] =
        call.positionalArguments[1] as String;
  });
  final sharing = MatrixHistorySharing(manager, lifecycle, storage);
  try {
    final sourceRoom = sender.getRoomById(rooms.first)!;
    expect(
      sourceRoom.roomVersion,
      '12',
      reason: 'Fixture uses creator-privilege room version',
    );
    expect(sourceRoom.creatorUserIds, contains(sender.userID));
    await sharing.setHistorySharing(rooms.first, enabled: true);
    final draft = await sharing.previewHistory(
      roomId: rooms.first,
      targetRoomId: rooms.last,
      recipient: recipient.userID!,
      eventIds: [originalId],
    );
    expect(draft.messages.single.content, body);
    expect(await sharing.shareHistory(draft), HistoryShareStatus.completed);
    Future<List<Event>> history(String roomId) async {
      final timeline = await recipient.getRoomById(roomId)!.getTimeline();
      try {
        return List<Event>.of(timeline.events);
      } finally {
        timeline.cancelSubscriptions();
      }
    }

    await _syncUntil(
      clients,
      () async => (await history(rooms.last)).any(
        (e) =>
            e.content['n42.history_share'] is Map &&
            (e.content['n42.history_share'] as Map)['batch'] == draft.id &&
            (e.content['body'] as String? ?? '').contains(body),
      ),
    );
    final shared = (await history(rooms.last)).singleWhere(
      (e) =>
          e.content['n42.history_share'] is Map &&
          (e.content['n42.history_share'] as Map)['batch'] == draft.id,
    );
    expect(
      (await sender.getOneRoomEvent(rooms.last, shared.eventId)).type,
      EventTypes.Encrypted,
    );
    await _syncUntil(clients, () async {
      final audits = (await history(rooms.first)).where(
        (e) =>
            e.content['n42.history_share'] is Map &&
            (e.content['n42.history_share'] as Map)['batch'] == draft.id,
      );
      return audits
          .map((e) => (e.content['n42.history_share'] as Map)['phase'])
          .toSet()
          .containsAll(['requested', 'completed']);
    });
    final cancelled = await sharing.previewHistory(
      roomId: rooms.first,
      targetRoomId: rooms.last,
      recipient: recipient.userID!,
      eventIds: [originalId],
    );
    await sharing.setHistorySharing(rooms.first, enabled: false);
    await expectLater(sharing.shareHistory(cancelled), throwsStateError);
    await _verifyUnreadAttention(
      clients,
      manager,
      sharing,
      rooms.first,
      originalId,
    );
  } finally {
    await sharing.dispose();
  }
}

Future<void> _verifyUnreadAttention(
  List<Client> clients,
  _Manager manager,
  MatrixHistorySharing sharing,
  String roomId,
  String originalId,
) async {
  final room = clients.first.getRoomById(roomId)!;
  final peer = clients.last.getRoomById(roomId)!;
  print('[catchup-live] checking read marker and unread attention');
  await room.setReadMarker(originalId);
  await _syncUntil(clients, () => room.fullyRead == originalId);
  print('[catchup-live] read marker synchronized');
  final ordinary = await peer.sendTextEvent('Ordinary catch-up message');
  final mention = await peer.sendEvent({
    'msgtype': 'm.text',
    'body': 'Attention for the owner',
    'm.mentions': {
      'user_ids': [clients.first.userID!],
    },
  });
  final roomMention = await peer.sendEvent({
    'msgtype': 'm.text',
    'body': 'Attention for everyone',
    'm.mentions': {'room': true},
  });
  final reply = await peer.sendEvent({
    'msgtype': 'm.text',
    'body': 'Direct reply to the original',
    'm.relates_to': {
      'm.in_reply_to': {'event_id': originalId},
    },
  });
  expect([ordinary, mention, roomMention, reply], everyElement(isNotNull));
  await _syncUntil(
    clients,
    () async =>
        (await room.getEventById(reply!))?.content['body'] ==
        'Direct reply to the original',
  );
  print('[catchup-live] encrypted attention events synchronized');
  final attention = await sharing.unreadAttention(roomId);
  expect(attention.complete, isTrue);
  expect(
    attention.mentions.map((e) => e.id),
    unorderedEquals([mention, roomMention]),
  );
  expect(attention.replies.map((e) => e.id), [reply]);
  expect(attention.mentions.any((e) => e.id == ordinary), isFalse);
  final groups = MatrixGroupDataSource(manager);
  await groups.pinMessage(roomId, originalId);
  await _syncUntil(
    clients,
    () => clients.every(
      (c) =>
          (c
                      .getRoomById(roomId)!
                      .getState('m.room.pinned_events')
                      ?.content['pinned']
                  as List?)
              ?.contains(originalId) ==
          true,
    ),
  );
  expect(groups.getPinnedEventIds(roomId), contains(originalId));
  final state = await clients.first.getRoomStateWithKey(
    roomId,
    'm.room.pinned_events',
    '',
  );
  expect(state['pinned'], contains(originalId));
  expect(state.containsKey('expires_at'), isFalse);
  await groups.unpinMessage(roomId, originalId);
  await _syncUntil(
    clients,
    () => clients.every(
      (c) =>
          (c
                      .getRoomById(roomId)!
                      .getState('m.room.pinned_events')
                      ?.content['pinned']
                  as List?)
              ?.contains(originalId) ==
          false,
    ),
  );
  await room.setReadMarker(reply);
  await _syncUntil(clients, () => room.fullyRead == reply);
  final read = await sharing.unreadAttention(roomId);
  expect(read.complete, isTrue);
  expect(read.mentions, isEmpty);
  expect(read.replies, isEmpty);
}
