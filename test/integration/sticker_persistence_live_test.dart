import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';

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
  final url = Platform.environment['N42_STICKER_LOOPBACK_URL'];
  test(
    'real server preserves repeated emoji across reopen rename and removal',
    () async {
      final uri = Uri.parse(url!);
      expect(uri.scheme, 'http');
      expect(['localhost', '127.0.0.1', '::1'], contains(uri.host));
      expect(uri.userInfo, isEmpty);
      expect(uri.hasQuery || uri.hasFragment, isFalse);
      final token = Platform.environment['N42_TEST_INVITE_CODE'];
      expect(token, isNotEmpty);
      final transport = http.Client();
      final api = MatrixApi(homeserver: uri, httpClient: transport);
      final username = 'n42sticker${DateTime.now().microsecondsSinceEpoch}';
      final random = Random.secure();
      final password = List.generate(
        32,
        (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
      ).join();
      Future<RegisterResponse> register(String? session) => api.register(
        username: username,
        password: password,
        auth: _TokenAuth(token!, session: session),
      );
      RegisterResponse? registered;
      try {
        try {
          registered = await register(null);
        } on MatrixException catch (e) {
          if (!e.requireAdditionalAuthentication) rethrow;
          registered = await register(e.session);
        }
        api.accessToken = registered.accessToken;
        final client = _Client();
        final manager = _Manager();
        when(() => manager.client).thenReturn(client);
        when(() => client.userID).thenReturn(registered.userId);
        when(() => client.deviceID).thenReturn(registered.deviceId);
        when(() => client.homeserver).thenReturn(uri);
        when(() => client.accessToken).thenReturn(registered.accessToken);
        when(() => client.getAccountData(any(), any())).thenAnswer(
          (c) => api.getAccountData(
            c.positionalArguments[0] as String,
            c.positionalArguments[1] as String,
          ),
        );
        when(() => client.setAccountData(any(), any(), any())).thenAnswer(
          (c) => api.setAccountData(
            c.positionalArguments[0] as String,
            c.positionalArguments[1] as String,
            c.positionalArguments[2] as Map<String, dynamic>,
          ),
        );
        const pack = StickerPack(
          id: 'live-pack',
          name: 'Two smiles',
          stickers: [
            Sticker(id: 'first', url: 'mxc://fixture/first', emoji: '🙂'),
            Sticker(id: 'second', url: 'mxc://fixture/second', emoji: '🙂'),
          ],
        );
        expect(
          await MatrixStickerDataSource(manager).installPack(pack.id, pack),
          isTrue,
        );
        final source = MatrixStickerDataSource(manager);
        final repository = StickerRepositoryImpl(source);
        addTearDown(repository.dispose);
        final reopened = (await source.getInstalledPacks()).singleWhere(
          (p) => p.id == pack.id,
        );
        expect(reopened.stickers.map((s) => s.id), ['first', 'second']);
        expect(reopened.stickers.map((s) => s.emoji), ['🙂', '🙂']);
        expect(await repository.renamePack(pack.id, 'Renamed'), isTrue);
        expect(
          await repository.removeStickerFromPack(
            packId: pack.id,
            stickerId: 'first',
          ),
          isTrue,
        );
        final saved = (await MatrixStickerDataSource(
          manager,
        ).getInstalledPacks()).singleWhere((p) => p.id == pack.id);
        expect(saved.name, 'Renamed');
        expect(saved.stickers.single.id, 'second');
        expect(saved.stickers.single.emoji, '🙂');
        expect(await repository.uninstallPack(pack.id), isTrue);
        expect(
          (await MatrixStickerDataSource(
            manager,
          ).getInstalledPacks()).any((p) => p.id == pack.id),
          isFalse,
        );
      } finally {
        try {
          if (registered != null) {
            AuthenticationData auth(String? session) => AuthenticationPassword(
              password: password,
              identifier: AuthenticationUserIdentifier(
                user: registered!.userId,
              ),
              session: session,
            );
            try {
              await api.deactivateAccount(auth: auth(null), erase: true);
            } on MatrixException catch (e) {
              if (!e.requireAdditionalAuthentication) rethrow;
              await api.deactivateAccount(auth: auth(e.session), erase: true);
            }
          }
        } finally {
          transport.close();
        }
      }
    },
    skip: url == null
        ? 'Requires explicit owned loopback Matrix fixture'
        : false,
  );
}
