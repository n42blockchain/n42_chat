import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:matrix/src/utils/cached_stream_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';
import 'package:n42_chat/src/core/utils/matrix_sticker_pack_link.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_subscription.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_subscriptions.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_publication.dart';

class _Client extends Mock implements Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

class _Room extends Mock implements Room {}

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
        final ownerClient = _Client(), ownerManager = _Manager();
        final lifecycle = _Lifecycle(), ownerRoom = _Room();
        when(() => ownerManager.client).thenReturn(ownerClient);
        when(() => ownerClient.userID).thenReturn(accounts.first.userId);
        when(() => ownerClient.deviceID).thenReturn(accounts.first.deviceId);
        when(() => ownerClient.homeserver).thenReturn(uri);
        when(() => ownerClient.accessToken)
            .thenReturn(accounts.first.accessToken);
        when(() => ownerClient.getRoomById(roomId)).thenReturn(ownerRoom);
        final creation = await apis.first.getRoomStateWithKey(
          roomId,
          EventTypes.RoomCreate,
          '',
        );
        when(() => ownerRoom.roomVersion)
            .thenReturn(creation['room_version'] as String? ?? '1');
        // Cache adapter for the room just created by this disposable owner.
        when(() => ownerRoom.creatorUserIds)
            .thenReturn({accounts.first.userId});
        final generation = AuthSessionInvalidation(
          userId: accounts.first.userId,
          homeserver: uri,
          deviceId: accounts.first.deviceId,
          isCurrent: () => true,
          matchesClient: (client) => identical(client, ownerClient),
        );
        when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
        when(() => ownerClient.getJoinedMembersByRoom(any())).thenAnswer(
          (call) => apis.first.getJoinedMembersByRoom(
            call.positionalArguments[0] as String,
          ),
        );
        when(() => ownerClient.getRoomStateWithKey(any(), any(), any()))
            .thenAnswer(
              (call) => apis.first.getRoomStateWithKey(
                call.positionalArguments[0] as String,
                call.positionalArguments[1] as String,
                call.positionalArguments[2] as String,
              ),
            );
        when(() => ownerClient.setRoomStateWithKey(any(), any(), any(), any()))
            .thenAnswer(
              (call) => apis.first.setRoomStateWithKey(
                call.positionalArguments[0] as String,
                call.positionalArguments[1] as String,
                call.positionalArguments[2] as String,
                call.positionalArguments[3] as Map<String, dynamic>,
              ),
            );
        when(() => ownerClient.getAccountData(any(), any())).thenAnswer(
          (call) => apis.first.getAccountData(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
          ),
        );
        when(() => ownerClient.setAccountData(any(), any(), any())).thenAnswer(
          (call) => apis.first.setAccountData(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
            call.positionalArguments[2] as Map<String, dynamic>,
          ),
        );
        final owned = StickerPack(
          id: 'custom_live',
          name: 'Owned shared art',
          author: 'Synthetic QA',
          source: StickerPackSource.custom,
          stickers: [
            Sticker(
              id: 'smile',
              url: '$mxc',
              name: 'Synthetic pixel',
              mimeType: 'image/png',
            ),
          ],
        );
        final ownerSource = MatrixStickerDataSource(ownerManager);
        expect(await ownerSource.installPack(owned.id, owned), isTrue);
        final ownerRepository = StickerRepositoryImpl(
          ownerSource,
          publication: MatrixStickerPublication(ownerManager, lifecycle),
        );
        addTearDown(ownerRepository.dispose);
        final reviewed = await ownerRepository.getPackById(owned.id);
        final shareUrl = await ownerRepository.publishPack(
          owned.id,
          roomId,
          reviewedPack: reviewed!,
        );
        expect(shareUrl, isNotNull);
        final eventId = parseMatrixStickerPackLink(shareUrl!)!.eventId;
        final reopenedOwner = StickerRepositoryImpl(
          MatrixStickerDataSource(ownerManager),
        );
        addTearDown(reopenedOwner.dispose);
        expect(await reopenedOwner.getPackShareUrl(owned.id), shareUrl);
        verify(
          () => ownerClient.setRoomStateWithKey(
            any(),
            'm.room.image_pack',
            any(),
            any(),
          ),
        ).called(1);
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
        final readerUpdates = CachedStreamController<SyncUpdate>();
        addTearDown(readerUpdates.close);
        when(() => client.onSync).thenReturn(readerUpdates);
        when(() => client.getJoinedRooms())
            .thenAnswer((_) => apis.last.getJoinedRooms());
        final readerLifecycle = _Lifecycle();
        final readerGeneration = AuthSessionInvalidation(
          userId: accounts.last.userId,
          homeserver: uri,
          deviceId: accounts.last.deviceId,
          isCurrent: () => true,
          matchesClient: (c) => identical(c, client),
        );
        when(() => readerLifecycle.currentAccountGeneration)
            .thenReturn(readerGeneration);
        when(() => client.getRoomStateWithKey(any(), any(), any())).thenAnswer(
          (call) => apis.last.getRoomStateWithKey(
            call.positionalArguments[0] as String,
            call.positionalArguments[1] as String,
            call.positionalArguments[2] as String,
          ),
        );
        final subscriptions = MatrixStickerSubscriptions(
          manager,
          readerLifecycle,
        );
        final repository = StickerRepositoryImpl(
          MatrixStickerDataSource(manager),
          subscriptions: subscriptions,
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
        expect(preview!.origin!.stateKey, startsWith('n42_'));
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
        final liveReference = StickerPackSubscription(
          roomId: roomId,
          stateKey: preview.origin!.stateKey,
        );
        expect(await subscriptions.getEnabled(), isEmpty);
        expect(
          await repository.setPackSubscribed(liveReference, enabled: true),
          isTrue,
        );
        expect(
          (await repository.getInstalledPacks()).where(
            (pack) => pack.subscription == liveReference,
          ),
          hasLength(1),
        );
        await repository.recordStickerUsage(liveReference.packId, 'smile');
        expect(
          (await repository.getRecentStickers()).single.packId,
          liveReference.packId,
        );
        final updatedVisible = Completer<void>(),
            leftVisible = Completer<void>();
        var left = false;
        final visible = repository.watchInstalledPacks().listen((packs) {
          if (packs.any(
                (pack) =>
                    pack.subscription == liveReference &&
                    pack.name == 'Updated live art',
              ) &&
              !updatedVisible.isCompleted) {
            updatedVisible.complete();
          }
          if (left &&
              !packs.any((pack) => pack.subscription == liveReference) &&
              !leftVisible.isCompleted) {
            leftVisible.complete();
          }
        });
        addTearDown(visible.cancel);
        final enabledData = await apis.last.getAccountData(
          accounts.last.userId,
          'm.image_pack.rooms',
        );
        expect(enabledData['rooms'], {
          roomId: {liveReference.stateKey: <String, dynamic>{}},
        });
        final reopenedSubscriptions = MatrixStickerSubscriptions(
          manager,
          readerLifecycle,
        );
        expect(await reopenedSubscriptions.getEnabled(), [liveReference]);
        // Feed the real server sync response into the SDK stream adapter. The
        // installed-pack stream consumed by the picker must resolve fresh state.
        await apis.first.setRoomStateWithKey(
          roomId,
          'm.room.image_pack',
          liveReference.stateKey,
          {
            'pack': {
              'display_name': 'Updated live art',
              'usage': ['sticker'],
            },
            'images': {
              'smile': {'url': '$mxc', 'body': 'Updated description'},
            },
          },
        );
        expect(await reopenedSubscriptions.getEnabled(), [liveReference]);
        final refreshedSync = await apis.last.sync(timeout: 0);
        readerUpdates.add(refreshedSync);
        await updatedVisible.future.timeout(const Duration(seconds: 10));
        expect(preview.name, 'Owned shared art');
        expect(
          (await repository.getRecentStickers()).single.sticker.name,
          'Updated description',
        );
        final currentPack = await apis.last.getRoomStateWithKey(
          roomId,
          'm.room.image_pack',
          liveReference.stateKey,
        );
        expect(
          (currentPack['pack'] as Map)['display_name'],
          'Updated live art',
        );
        // Losing room access must not lock the user's own subscription list.
        left = true;
        await apis.last.leaveRoom(roomId);
        expect(await apis.last.getJoinedRooms(), isNot(contains(roomId)));
        readerUpdates.add(
          await apis.last.sync(since: refreshedSync.nextBatch, timeout: 0),
        );
        await leftVisible.future.timeout(const Duration(seconds: 10));
        expect(await repository.getRecentStickers(), isEmpty);
        expect(await repository.getPackSubscriptions(), [liveReference]);
        expect(
          await repository.setPackSubscribed(liveReference, enabled: false),
          isTrue,
        );
        expect(await reopenedSubscriptions.getEnabled(), isEmpty);
        verifyNever(() => client.joinRoom(any()));
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
