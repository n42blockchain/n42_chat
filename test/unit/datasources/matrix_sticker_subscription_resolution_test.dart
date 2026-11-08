import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as m;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_subscription.dart';

class _Client extends Mock implements m.Client {}

class _Manager extends Mock implements MatrixClientManager {}

void main() {
  late _Client client;
  late _Manager manager;
  late MatrixStickerDataSource source;
  late Map<String, dynamic> content;
  const ref = StickerPackSubscription(roomId: '!room:test', stateKey: 'art');
  setUp(() {
    client = _Client();
    manager = _Manager();
    source = MatrixStickerDataSource(manager);
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@reader:test');
    when(() => client.deviceID).thenReturn('D');
    when(() => client.accessToken).thenReturn('synthetic');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    content = {
      'pack': <String, dynamic>{
        'display_name': 'Current art',
        'attribution': 'Artist',
      },
      'images': {
        'smile': {
          'url': 'mxc://test/image',
          'body': 'Smile',
          'info': {'mimetype': 'image/png'},
        },
      },
    };
    when(() => client.getRoomStateWithKey(any(), any(), any()))
        .thenAnswer((_) async => content);
  });
  test('resolves current content with stable identity and no private copy or room join', () async {
    final first = await source.getSubscribedPack(ref);
    expect(first!.id, ref.packId);
    expect(first.subscription, ref);
    expect(first.origin, isNull);
    expect(first.source, StickerPackSource.matrix);
    expect(first.isInstalled, isTrue);
    expect(first.author, 'Artist');
    (content['pack'] as Map)['display_name'] = 'Updated art';
    ((content['images'] as Map)['smile'] as Map)['url'] = 'mxc://test/updated';
    final updated = await source.getSubscribedPack(ref);
    expect(updated!.id, first.id);
    expect(updated.name, 'Updated art');
    expect(updated.stickers.single.url, 'mxc://test/updated');
    expect(first.name, 'Current art');
    expect(first.stickers.single.url, 'mxc://test/image');
    verifyNever(() => client.setAccountData(any(), any(), any()));
    verifyNever(() => client.joinRoom(any()));
  });
  test(
    'remote metadata cannot grant ownership or immutable provenance',
    () async {
      content['n42.source'] = 'custom';
      content['n42.origin'] = {'room_id': '!wrong:test', 'event_id': r'$wrong'};
      final pack = await source.getSubscribedPack(ref);
      expect(pack!.source, StickerPackSource.matrix);
      expect(pack.origin, isNull);
      expect(pack.subscription, ref);
    },
  );
  test('missing metadata falls back to room identity without fabricating a source event', () async {
    content.remove('pack');
    final pack = await source.getSubscribedPack(ref);
    expect(pack!.name, ref.roomId);
    expect(pack.origin, isNull);
  });
  for (final invalid in [
    'http',
    'mime',
    'avatar',
    'usage',
    'empty',
    'oversized',
  ]) {
    test('rejects $invalid room content', () async {
      final images = content['images'] as Map;
      switch (invalid) {
        case 'http':
          (images['smile'] as Map)['url'] = 'https://evil/image';
        case 'mime':
          (images['smile'] as Map)['info'] = {'mimetype': 'video/mp4'};
        case 'avatar':
          (content['pack'] as Map)['avatar_url'] = 'https://evil/avatar';
        case 'usage':
          (content['pack'] as Map)['usage'] = ['emoticon'];
        case 'empty':
          content['images'] = <String, dynamic>{};
        case 'oversized':
          content['images'] = {
            for (var i = 0; i < 501; i++) '$i': {'url': 'mxc://test/image'},
          };
      }
      expect(await source.getSubscribedPack(ref), isNull);
    });
  }
  test('account token replacement discards an old state response', () async {
    final gate = Completer<Map<String, dynamic>>();
    when(() => client.getRoomStateWithKey(any(), any(), any()))
        .thenAnswer((_) => gate.future);
    final pending = source.getSubscribedPack(ref);
    when(() => client.accessToken).thenReturn('replacement');
    gate.complete(content);
    expect(await pending, isNull);
  });
  test(
    'unreadable room does not auto-join or rewrite subscription data',
    () async {
      when(() => client.getRoomStateWithKey(any(), any(), any()))
          .thenThrow(m.MatrixException.fromJson({'errcode': 'M_FORBIDDEN'}));
      expect(await source.getSubscribedPack(ref), isNull);
      verifyNever(() => client.joinRoom(any()));
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test('identity distinguishes ambiguous delimiters and empty keys', () {
    const a = StickerPackSubscription(roomId: '!room:test', stateKey: 'a|b');
    const b = StickerPackSubscription(roomId: '!room:test|a', stateKey: 'b');
    expect(a.packId, isNot(b.packId));
    expect(
      ref.packId,
      isNot(const StickerPackSubscription(roomId: '!room:test').packId),
    );
  });
  test('recent live usage resolves current content without creating a private pack', () async {
    final current = await source.getSubscribedPack(ref);
    when(() => client.getAccountData(any(), any())).thenAnswer(
      (_) async => {
        'recent': [
          {
            'pack_id': ref.packId,
            'sticker_id': 'smile',
            'last_used': 1,
            'count': 3,
          },
        ],
      },
    );
    final recent = await source.getRecentStickers(resolvedPacks: [current!]);
    expect(recent.single.sticker.name, 'Smile');
    expect(recent.single.usageCount, 3);
    expect(await source.getRecentStickers(resolvedPacks: []), isEmpty);
    verifyNever(
      () => client.getAccountData(
        any(),
        '${MatrixStickerDataSource.stickerPackType}.${ref.packId}',
      ),
    );
  });
}
