import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';

class _Client extends Mock implements Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _TokenAuth extends AuthenticationData {
  _TokenAuth(this.token, {super.session})
    : super(type: 'm.login.registration_token');
  final String token;
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'token': token};
}

void main() {
  final endpoint = Platform.environment['N42_STICKER_LOOPBACK_URL'];
  test(
    'room-pack preview respects access and explicit snapshot installation',
    () async {
      final uri = Uri.parse(endpoint!);
      expect(uri.scheme, 'http');
      expect(['localhost', '127.0.0.1', '::1'], contains(uri.host));
      expect(uri.userInfo, isEmpty);
      expect(uri.hasQuery || uri.hasFragment, isFalse);
      final invite = Platform.environment['N42_TEST_INVITE_CODE'];
      expect(invite, isNotEmpty);
      final apis = <MatrixApi>[];
      final accounts = <RegisterResponse>[];
      final passwords = <String>[];
      final stamp = DateTime.now().microsecondsSinceEpoch;
      try {
        for (var i = 0; i < 2; i++) {
          final api = MatrixApi(homeserver: uri, httpClient: http.Client());
          apis.add(api);
          final random = Random.secure();
          final password = List.generate(
            32,
            (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
          ).join();
          passwords.add(password);
          Future<RegisterResponse> register(String? session) => api.register(
            username: 'n42pack${stamp}_$i',
            password: password,
            auth: _TokenAuth(invite!, session: session),
          );
          RegisterResponse registered;
          try {
            registered = await register(null);
          } on MatrixException catch (error) {
            if (!error.requireAdditionalAuthentication) rethrow;
            registered = await register(error.session);
          }
          api.accessToken = registered.accessToken;
          accounts.add(registered);
        }
        final image = base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jV2kAAAAASUVORK5CYII=',
        );
        final mxc = await apis.first.uploadContent(
          image,
          filename: 'owned.png',
          contentType: 'image/png',
        );
        final roomId = await apis.first.createRoom(
          name: 'Owned image pack',
          preset: CreateRoomPreset.privateChat,
        );
        final eventId = await apis.first.setRoomStateWithKey(
          roomId,
          'm.room.image_pack',
          'qa',
          {
            'pack': {
              'display_name': 'Owned shared art',
              'attribution': 'Synthetic QA',
            },
            'images': {
              'smile': {
                'url': '$mxc',
                'body': 'Synthetic pixel',
                'info': {'mimetype': 'image/png'},
              },
            },
          },
        );
        final reference = StickerPackOrigin(
          roomId: roomId,
          eventId: eventId,
          viaServers: [accounts.first.userId.split(':').skip(1).join(':')],
        );
        final client = _Client(), manager = _Manager();
        when(() => manager.client).thenReturn(client);
        when(() => client.userID).thenReturn(accounts.last.userId);
        when(() => client.deviceID).thenReturn(accounts.last.deviceId);
        when(() => client.homeserver).thenReturn(uri);
        when(() => client.accessToken).thenReturn(accounts.last.accessToken);
        when(() => client.getOneRoomEvent(any(), any())).thenAnswer(
          (call) => apis.last.getOneRoomEvent(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
          ),
        );
        when(() => client.getAccountData(any(), any())).thenAnswer(
          (call) => apis.last.getAccountData(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
          ),
        );
        when(() => client.setAccountData(any(), any(), any())).thenAnswer(
          (call) => apis.last.setAccountData(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
            call.positionalArguments[2] as Map<String, dynamic>,
          ),
        );
        final repository = StickerRepositoryImpl(
          MatrixStickerDataSource(manager),
        );
        addTearDown(repository.dispose);
        expect(await repository.importPack(reference.shareUrl), isNull);
        expect(await apis.last.getJoinedRooms(), isEmpty);
        verifyNever(() => client.joinRoom(any()));
        verifyNever(() => client.setAccountData(any(), any(), any()));
        // Explicit fixture setup represents the separate membership decision.
        await apis.first.inviteUser(roomId, accounts.last.userId);
        await apis.last.joinRoom(roomId);
        final preview = await repository.importPack(reference.shareUrl);
        expect(preview, isNotNull);
        expect(preview!.origin!.stateKey, 'qa');
        verifyNever(() => client.setAccountData(any(), any(), any()));
        final media = await apis.last.httpClient.get(
          Uri.parse(preview.stickers.single.httpUrl!),
          headers: {'Authorization': 'Bearer ${accounts.last.accessToken}'},
        );
        expect(media.statusCode, 200);
        expect(media.bodyBytes, orderedEquals(image));
        expect(await repository.installPack(preview.id), isTrue);
        final reopened = StickerRepositoryImpl(
          MatrixStickerDataSource(manager),
        );
        addTearDown(reopened.dispose);
        expect(
          (await reopened.getPackById(preview.id))!.origin,
          preview.origin,
        );
        expect(await reopened.uninstallPack(preview.id), isTrue);
        final fresh = StickerRepositoryImpl(MatrixStickerDataSource(manager));
        addTearDown(fresh.dispose);
        expect(
          (await fresh.getInstalledPacks()).where((p) => p.id == preview.id),
          isEmpty,
        );
      } finally {
        final failures = <Object>[];
        for (var i = 0; i < accounts.length; i++) {
          AuthenticationData auth(String? session) => AuthenticationPassword(
            password: passwords[i],
            identifier: AuthenticationUserIdentifier(user: accounts[i].userId),
            session: session,
          );
          try {
            try {
              await apis[i].deactivateAccount(auth: auth(null), erase: true);
            } on MatrixException catch (error) {
              if (!error.requireAdditionalAuthentication) rethrow;
              await apis[i].deactivateAccount(
                auth: auth(error.session),
                erase: true,
              );
            }
          } catch (error) {
            failures.add(error);
          }
        }
        for (final api in apis) {
          api.httpClient.close();
        }
        expect(
          failures,
          isEmpty,
          reason: 'All owned disposable accounts must be deactivated',
        );
      }
    },
    skip: endpoint == null
        ? 'Requires an owned loopback Matrix fixture'
        : false,
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
