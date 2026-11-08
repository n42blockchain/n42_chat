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
import 'package:n42_chat/src/data/datasources/matrix/matrix_reaction_datasource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _Manager extends Mock implements MatrixClientManager {}

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
          final client = Client('forward-$i', database: database);
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
  final deadline = DateTime.now().add(const Duration(seconds: 60));
  while (DateTime.now().isBefore(deadline)) {
    if (await ready()) return;
    await Future.wait(
      clients.map((c) => c.oneShotSync(timeout: Duration.zero)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  throw TimeoutException('Owned encrypted forwarding condition not reached');
}
