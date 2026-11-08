import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as m;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_publication.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class _Client extends Mock implements m.Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Room extends Mock implements m.Room {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

void main() {
  late _Client client;
  late _Manager manager;
  late _Room room;
  late MatrixStickerPublication service;
  late _Lifecycle lifecycle;
  late bool active;
  const user = '@owner:test';
  const roomId = '!room:test';
  const pack = StickerPack(
    id: 'custom_art',
    name: 'Art',
    source: StickerPackSource.custom,
    stickers: [
      Sticker(id: 'one', url: 'mxc://test/image', mimeType: 'image/png'),
    ],
  );
  setUp(() {
    client = _Client();
    manager = _Manager();
    room = _Room();
    lifecycle = _Lifecycle();
    active = true;
    final generation = AuthSessionInvalidation(
      userId: user,
      homeserver: Uri.parse('https://test'),
      deviceId: 'device',
      isCurrent: () => active,
      matchesClient: (c) => identical(c, client),
    );
    when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
    service = MatrixStickerPublication(manager, lifecycle);
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn(user);
    when(() => client.accessToken).thenReturn('synthetic');
    when(() => client.deviceID).thenReturn('device');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.getRoomById(roomId)).thenReturn(room);
    when(() => room.roomVersion).thenReturn('11');
    when(() => client.getJoinedMembersByRoom(roomId))
        .thenAnswer((_) async => {user: m.RoomMember()});
    when(
      () =>
          client.getRoomStateWithKey(roomId, m.EventTypes.RoomPowerLevels, ''),
    ).thenAnswer(
      (_) async => {
        'users': {user: 50},
      },
    );
    when(() => client.setRoomStateWithKey(any(), any(), any(), any()))
        .thenAnswer((_) async => r'$published');
  });
  test(
    'explicit publication writes standard content with a fresh state key',
    () async {
      final origin = await service.publish(pack, roomId);
      expect(origin.eventId, r'$published');
      final args = verify(
        () => client.setRoomStateWithKey(
          roomId,
          'm.room.image_pack',
          captureAny(),
          captureAny(),
        ),
      ).captured;
      expect(args[0], startsWith('n42_'));
      expect((args[1] as Map).keys, unorderedEquals(['pack', 'images']));
      expect(((args[1] as Map)['pack'] as Map)['usage'], ['sticker']);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test('insufficient state power rejects before write', () async {
    when(
      () =>
          client.getRoomStateWithKey(roomId, m.EventTypes.RoomPowerLevels, ''),
    ).thenAnswer(
      (_) async => {
        'users': {user: 0},
      },
    );
    await expectLater(service.publish(pack, roomId), throwsStateError);
    verifyNever(() => client.setRoomStateWithKey(any(), any(), any(), any()));
  });
  test('v12 creator can publish without a power users entry', () async {
    when(() => room.roomVersion).thenReturn('12');
    when(() => room.creatorUserIds).thenReturn({user});
    when(
      () =>
          client.getRoomStateWithKey(roomId, m.EventTypes.RoomPowerLevels, ''),
    ).thenAnswer((_) async => <String, dynamic>{});
    expect((await service.publish(pack, roomId)).eventId, r'$published');
  });
  test('creator still needs joined membership', () async {
    when(() => client.getJoinedMembersByRoom(roomId))
        .thenAnswer((_) async => {});
    await expectLater(service.publish(pack, roomId), throwsStateError);
    verifyNever(() => client.setRoomStateWithKey(any(), any(), any(), any()));
  });
  test('account change during permission read prevents publication', () async {
    final gate = Completer<Map<String, m.RoomMember>?>();
    when(() => client.getJoinedMembersByRoom(roomId))
        .thenAnswer((_) => gate.future);
    final pending = service.publish(pack, roomId);
    when(() => client.accessToken).thenReturn('replacement');
    gate.complete({user: m.RoomMember()});
    await expectLater(pending, throwsStateError);
    verifyNever(() => client.setRoomStateWithKey(any(), any(), any(), any()));
  });
  test('remote URLs and non-owned packs reject before network reads', () async {
    for (final invalid in [
      pack.copyWith(source: StickerPackSource.matrix),
      pack.copyWith(
        stickers: const [Sticker(id: 'one', url: 'https://evil/image')],
      ),
    ]) {
      await expectLater(
        service.publish(invalid, roomId),
        throwsFormatException,
      );
    }
    verifyNever(() => client.getJoinedMembersByRoom(any()));
  });
  test('uncertain server write propagates without retry', () async {
    when(() => client.setRoomStateWithKey(any(), any(), any(), any()))
        .thenThrow(StateError('connection lost'));
    await expectLater(service.publish(pack, roomId), throwsStateError);
    verify(() => client.setRoomStateWithKey(any(), any(), any(), any()))
        .called(1);
  });
  test('invalidation rejects a late successful server receipt', () async {
    final gate = Completer<String>();
    when(() => client.setRoomStateWithKey(any(), any(), any(), any()))
        .thenAnswer((_) => gate.future);
    final pending = service.publish(pack, roomId);
    await Future<void>.delayed(Duration.zero);
    active = false;
    gate.complete(r'$published');
    await expectLater(pending, throwsStateError);
    verify(() => client.setRoomStateWithKey(any(), any(), any(), any()))
        .called(1);
  });
  test(
    'legacy local IDs publish as valid shortcodes without changing the pack',
    () async {
      final legacy = pack.copyWith(
        stickers: const [Sticker(id: '旧/贴纸', url: 'mxc://test/image')],
      );
      await service.publish(legacy, roomId);
      final args = verify(
        () => client.setRoomStateWithKey(any(), any(), any(), captureAny()),
      ).captured;
      final images = (args.single as Map)['images'] as Map;
      expect(images.keys.single, matches(RegExp(r'^[A-Za-z0-9_-]{1,100}$')));
      expect((images.values.single as Map)['body'], '旧/贴纸');
      expect(legacy.stickers.single.id, '旧/贴纸');
    },
  );
  test('event-specific permission overrides state default', () async {
    when(
      () =>
          client.getRoomStateWithKey(roomId, m.EventTypes.RoomPowerLevels, ''),
    ).thenAnswer(
      (_) async => {
        'users': {user: 50},
        'events': {'m.room.image_pack': 100},
      },
    );
    await expectLater(service.publish(pack, roomId), throwsStateError);
    verifyNever(() => client.setRoomStateWithKey(any(), any(), any(), any()));
  });
  test(
    'duplicate images and oversized metadata reject before network reads',
    () async {
      for (final invalid in [
        pack.copyWith(stickers: [pack.stickers.single, pack.stickers.single]),
        pack.copyWith(description: List.filled(70000, 'x').join()),
      ]) {
        await expectLater(
          service.publish(invalid, roomId),
          throwsFormatException,
        );
      }
      verifyNever(() => client.getJoinedMembersByRoom(any()));
    },
  );
}
