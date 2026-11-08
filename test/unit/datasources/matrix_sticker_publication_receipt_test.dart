import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as m;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';

class _Client extends Mock implements m.Client {}

class _Manager extends Mock implements MatrixClientManager {}

void main() {
  late _Client client;
  late _Manager manager;
  late MatrixStickerDataSource source;
  late Map<String, Map<String, dynamic>> data;
  const pack = StickerPack(
    id: 'custom_art',
    name: 'Art',
    source: StickerPackSource.custom,
    stickers: [
      Sticker(id: 'one', url: 'mxc://test/image', name: 'Smile', emoji: '🙂'),
    ],
  );
  final origin = StickerPackOrigin(
    roomId: '!room:test',
    eventId: r'$published',
    stateKey: 'art',
  );
  setUp(() {
    client = _Client();
    manager = _Manager();
    source = MatrixStickerDataSource(manager);
    data = {};
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@owner:test');
    when(() => client.deviceID).thenReturn('D');
    when(() => client.accessToken).thenReturn('synthetic');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
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
  });
  test(
    'receipt survives a fresh datasource without modifying owned pack or index',
    () async {
      expect(
        await source.savePublicationReceipt(
          pack,
          origin,
          isCurrent: () => true,
        ),
        isTrue,
      );
      expect(
        await MatrixStickerDataSource(manager).getPublicationReceipt(pack),
        origin.shareUrl,
      );
      expect(data.keys, ['n42.sticker.publication.custom_art']);
    },
  );
  for (final field in [
    'name',
    'description',
    'author',
    'avatar',
    'media',
    'label',
    'emoji',
    'size',
  ]) {
    test('changed $field cannot reuse old publication receipt', () async {
      await source.savePublicationReceipt(pack, origin, isCurrent: () => true);
      final changed = switch (field) {
        'name' => pack.copyWith(name: 'New art'),
        'description' => pack.copyWith(description: 'New description'),
        'author' => pack.copyWith(author: 'Other artist'),
        'avatar' => pack.copyWith(avatarUrl: 'mxc://test/avatar'),
        'media' => pack.copyWith(
          stickers: [pack.stickers.single.copyWith(url: 'mxc://test/changed')],
        ),
        'label' => pack.copyWith(
          stickers: [pack.stickers.single.copyWith(name: 'Changed')],
        ),
        'emoji' => pack.copyWith(
          stickers: [pack.stickers.single.copyWith(emoji: '🙃')],
        ),
        _ => pack.copyWith(stickers: [pack.stickers.single.copyWith(size: 12)]),
      };
      expect(await source.getPublicationReceipt(changed), isNull);
    });
  }
  test(
    'installation and local usage do not invalidate content receipt',
    () async {
      await source.savePublicationReceipt(pack, origin, isCurrent: () => true);
      final changed = pack.copyWith(
        isInstalled: true,
        stickers: [
          pack.stickers.single.copyWith(
            usageCount: 100,
            httpUrl: 'https://test/resolved',
          ),
        ],
      );
      expect(await source.getPublicationReceipt(changed), origin.shareUrl);
    },
  );
  test(
    'stale account callback prevents even the first private write',
    () async {
      expect(
        await source.savePublicationReceipt(
          pack,
          origin,
          isCurrent: () => false,
        ),
        isFalse,
      );
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test('late receipt read rejects replaced access token', () async {
    await source.savePublicationReceipt(pack, origin, isCurrent: () => true);
    final gate = Completer<Map<String, dynamic>>();
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) => gate.future);
    final pending = source.getPublicationReceipt(pack);
    when(() => client.accessToken).thenReturn('replacement');
    gate.complete(data.values.single);
    expect(await pending, isNull);
  });
  test('malformed stored provenance is not returned as a share URL', () async {
    await source.savePublicationReceipt(pack, origin, isCurrent: () => true);
    data.values.single['origin'] = {
      'room_id': 'https://evil',
      'event_id': r'$bad',
    };
    expect(await source.getPublicationReceipt(pack), isNull);
  });
  test('failed private save is reported without retry', () async {
    when(() => client.setAccountData(any(), any(), any()))
        .thenThrow(StateError('offline'));
    expect(
      await source.savePublicationReceipt(pack, origin, isCurrent: () => true),
      isFalse,
    );
    verify(() => client.setAccountData(any(), any(), any())).called(1);
  });
}
