import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';

class _Client extends Mock implements matrix.Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Room extends Mock implements matrix.Room {}

void main() {
  late _Client client;
  late _Manager manager;
  late StickerRepositoryImpl repository;
  late matrix.MatrixEvent event;
  late Map<String, Map<String, dynamic>> data;
  const link = 'https://matrix.to/#/!pack:test/\$snapshot?via=test';
  setUp(() {
    client = _Client();
    manager = _Manager();
    data = {};
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@reader:test');
    when(() => client.deviceID).thenReturn('DEVICE');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.accessToken).thenReturn('synthetic-token');
    event = matrix.MatrixEvent(
      type: 'm.room.image_pack',
      stateKey: 'art',
      eventId: r'$snapshot',
      roomId: '!pack:test',
      senderId: '@owner:test',
      originServerTs: DateTime.now(),
      content: {
        'pack': {'display_name': 'Art', 'attribution': 'Artist'},
        'images': {
          'smile': {
            'url': 'mxc://test/image',
            'body': 'Smile',
            'info': {'mimetype': 'image/png'},
          },
        },
      },
    );
    when(() => client.getOneRoomEvent(any(), any()))
        .thenAnswer((_) async => event);
    when(() => client.getAccountData(any(), any())).thenAnswer(
      (call) async =>
          jsonDecode(jsonEncode(data[call.positionalArguments[1]] ?? {}))
              as Map<String, dynamic>,
    );
    when(() => client.setAccountData(any(), any(), any()))
        .thenAnswer((call) async {
          data[call.positionalArguments[1] as String] = jsonDecode(
            jsonEncode(call.positionalArguments[2]),
          ) as Map<String, dynamic>;
        });
    repository = StickerRepositoryImpl(MatrixStickerDataSource(manager));
  });
  tearDown(() => repository.dispose());

  test('preview is read-only; confirmed install persists origin and uninstall stays removed', () async {
    final pack = await repository.importPack(link);
    expect(pack, isNotNull);
    expect(pack!.isInstalled, isFalse);
    expect(pack.author, 'Artist');
    expect(pack.source, StickerPackSource.matrix);
    expect(pack.origin!.stateKey, 'art');
    verifyNever(() => client.setAccountData(any(), any(), any()));
    verifyNever(() => client.joinRoom(any()));
    expect(await repository.installPack(pack.id), isTrue);
    final reopened = StickerRepositoryImpl(MatrixStickerDataSource(manager));
    addTearDown(reopened.dispose);
    final installed = await reopened.getPackById(pack.id);
    expect(installed!.origin, pack.origin);
    expect(installed.source, StickerPackSource.matrix);
    expect(await reopened.getPackShareUrl(pack.id), pack.origin!.shareUrl);
    expect(await reopened.uninstallPack(pack.id), isTrue);
    final fresh = StickerRepositoryImpl(MatrixStickerDataSource(manager));
    addTearDown(fresh.dispose);
    expect(
      (await fresh.getInstalledPacks()).where((p) => p.id == pack.id),
      isEmpty,
    );
  });

  for (final invalid in [
    'message',
    'missing-state-key',
    'wrong-event',
    'unsafe-media',
    'emoticon-only',
  ]) {
    test('reject $invalid without writes', () async {
      switch (invalid) {
        case 'message':
          event.type = 'm.room.message';
        case 'missing-state-key':
          event.stateKey = null;
        case 'wrong-event':
          event.eventId = r'$different';
        case 'unsafe-media':
          (event.content['images'] as Map)['smile'] = {
            'url': 'https://evil/image',
          };
        case 'emoticon-only':
          event.content['pack'] = <String, dynamic>{
            ...event.content['pack'] as Map<String, dynamic>,
            'usage': ['emoticon'],
          };
      }
      expect(await repository.importPack(link), isNull);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    });
  }

  test(
    'remote ownership metadata cannot turn an import into an owned pack',
    () async {
      event.content['n42.source'] = 'custom';
      event.content['n42.origin'] = {
        'room_id': '!wrong:test',
        'event_id': r'$wrong',
      };
      final pack = await repository.importPack(link);
      expect(pack!.source, StickerPackSource.matrix);
      expect(pack.origin!.roomId, '!pack:test');
      expect(pack.origin!.eventId, r'$snapshot');
    },
  );

  test('missing pack metadata uses the joined room name and avatar', () async {
    event.content.remove('pack');
    final room = _Room();
    when(() => room.name).thenReturn('Group art');
    when(() => room.avatar).thenReturn(Uri.parse('mxc://test/avatar'));
    when(() => client.getRoomById('!pack:test')).thenReturn(room);
    final pack = await repository.importPack(link);
    expect(pack!.name, 'Group art');
    expect(pack.avatarUrl, 'mxc://test/avatar');
  });

  test(
    'received legacy shortcodes remain readable and retain their identifiers',
    () async {
      event.content['images'] = {
        '😄': {'url': 'mxc://test/image', 'body': 'Smile'},
      };
      final pack = await repository.importPack(link);
      expect(pack!.stickers.single.id, '😄');
      expect(await repository.installPack(pack.id), isTrue);
    },
  );

  for (final invalid in [
    'oversized',
    'too-many-images',
    'redacted',
    'wrong-room',
    'non-image',
  ]) {
    test('resource and provenance guard: $invalid', () async {
      switch (invalid) {
        case 'oversized':
          event.content['description'] = List.filled(22000, '界').join();
        case 'too-many-images':
          event.content['images'] = {
            for (var i = 0; i < 501; i++)
              'image_$i': {'url': 'mxc://test/image'},
          };
        case 'redacted':
          event.unsigned = {'redacted_because': {}};
        case 'wrong-room':
          event.roomId = '!other:test';
        case 'non-image':
          event.content['images'] = {
            'script': {
              'url': 'mxc://test/image',
              'info': {'mimetype': 'text/html'},
            },
          };
      }
      expect(await repository.importPack(link), isNull);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    });
  }

  test('a delayed preview cannot cross an account switch', () async {
    final pendingEvent = Completer<matrix.MatrixEvent>();
    when(() => client.getOneRoomEvent(any(), any()))
        .thenAnswer((_) => pendingEvent.future);
    final pending = repository.importPack(link);
    when(() => client.userID).thenReturn('@other:test');
    pendingEvent.complete(event);
    expect(await pending, isNull);
    verifyNever(() => client.setAccountData(any(), any(), any()));
  });

  test(
    'an old preview cannot be installed into a replacement account',
    () async {
      final pack = await repository.importPack(link);
      when(() => client.userID).thenReturn('@other:test');
      expect(await repository.installPack(pack!.id), isFalse);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
}
