import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';

class _Client extends Mock implements matrix.Client {}

class _Manager extends Mock implements MatrixClientManager {}

void main() {
  late _Client client;
  late _Manager manager;
  late MatrixStickerDataSource source;
  late Map<String, Map<String, dynamic>> accountData;

  setUp(() {
    client = _Client();
    manager = _Manager();
    source = MatrixStickerDataSource(manager);
    accountData = {};
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice:test');
    when(() => client.deviceID).thenReturn('D');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.accessToken).thenReturn('fixture-token');
    when(() => client.getAccountData(any(), any())).thenAnswer(
      (call) async =>
          jsonDecode(jsonEncode(accountData[call.positionalArguments[1]] ?? {}))
              as Map<String, dynamic>,
    );
    when(() => client.setAccountData(any(), any(), any()))
        .thenAnswer((call) async {
          accountData[call.positionalArguments[1] as String] = jsonDecode(
            jsonEncode(call.positionalArguments[2]),
          ) as Map<String, dynamic>;
        });
  });

  test('custom pack management source survives reopening', () async {
    const pack = StickerPack(
      id: 'custom_owned',
      name: 'Owned',
      source: StickerPackSource.custom,
    );
    expect(await source.installPack(pack.id, pack), isTrue);
    final reopened = (await MatrixStickerDataSource(
      manager,
    ).getInstalledPacks()).singleWhere((pack) => pack.id == 'custom_owned');
    expect(reopened.source, StickerPackSource.custom);
  });

  test('stored ownership does not depend on identifier spelling', () async {
    const pack = StickerPack(
      id: 'owned_identifier',
      name: 'Owned',
      source: StickerPackSource.custom,
    );
    expect(await source.installPack(pack.id, pack), isTrue);
    final reopened = (await source.getInstalledPacks()).singleWhere(
      (p) => p.id == pack.id,
    );
    expect(reopened.source, StickerPackSource.custom);
  });

  test('legacy custom packs recover management without new metadata', () async {
    const pack = StickerPack(id: 'custom_legacy', name: 'Legacy');
    expect(await source.installPack(pack.id, pack), isTrue);
    accountData['${MatrixStickerDataSource.stickerPackType}.${pack.id}']!
        .remove('n42.source');
    final reopened = (await source.getInstalledPacks()).singleWhere(
      (p) => p.id == pack.id,
    );
    expect(reopened.source, StickerPackSource.custom);
  });

  test(
    'same emoji preserves both images and stable identifiers after reopen',
    () async {
      const pack = StickerPack(
        id: 'custom',
        name: 'Two smiles',
        stickers: [
          Sticker(
            id: 'first',
            url: 'mxc://test/first',
            emoji: '🙂',
            name: 'First smile',
          ),
          Sticker(
            id: 'second',
            url: 'mxc://test/second',
            emoji: '🙂',
            name: 'Second smile',
          ),
        ],
      );
      expect(await source.installPack(pack.id, pack), isTrue);
      final reopened = await MatrixStickerDataSource(manager)
          .getInstalledPacks();
      final saved = reopened.singleWhere((p) => p.id == pack.id);
      expect(saved.stickers.map((s) => s.id), ['first', 'second']);
      expect(saved.stickers.map((s) => s.emoji), ['🙂', '🙂']);
      expect(saved.stickers.map((s) => s.url), [
        'mxc://test/first',
        'mxc://test/second',
      ]);
      final repository = StickerRepositoryImpl(source);
      addTearDown(repository.dispose);
      expect(await repository.renamePack(saved.id, 'Renamed'), isTrue);
      final renamed = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == pack.id,
      );
      expect(renamed.stickers.map((s) => s.id), ['first', 'second']);
      expect(
        await repository.removeStickerFromPack(
          packId: pack.id,
          stickerId: 'first',
        ),
        isTrue,
      );
      final remaining = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == pack.id,
      );
      expect(remaining.stickers.single.id, 'second');
      expect(remaining.stickers.single.emoji, '🙂');
    },
  );

  test('image packs without optional metadata remain readable', () async {
    accountData[MatrixStickerDataSource.installedPacksType] = {
      'pack_ids': ['minimal'],
    };
    accountData['${MatrixStickerDataSource.stickerPackType}.minimal'] = {
      'images': {
        'cat_wave': {'url': 'mxc://test/cat', 'body': 'A waving cat'},
      },
    };
    final pack = (await source.getInstalledPacks()).singleWhere(
      (p) => p.id == 'minimal',
    );
    expect(pack.name, 'minimal');
    expect(pack.stickers.single.id, 'cat_wave');
    expect(pack.stickers.single.name, 'A waving cat');
  });

  test(
    'standard attribution is read while legacy author retains precedence',
    () async {
      accountData[MatrixStickerDataSource.installedPacksType] = {
        'pack_ids': ['credit'],
      };
      final data = <String, dynamic>{
        'pack': {'display_name': 'Cats', 'attribution': 'Original artist'},
        'images': {
          'cat': {'url': 'mxc://test/cat'},
        },
      };
      accountData['${MatrixStickerDataSource.stickerPackType}.credit'] = data;
      expect(
        (await source.getInstalledPacks())
            .singleWhere((p) => p.id == 'credit')
            .author,
        'Original artist',
      );
      (data['pack'] as Map<String, dynamic>)['author'] = 'Legacy artist';
      expect(
        (await source.getInstalledPacks())
            .singleWhere((p) => p.id == 'credit')
            .author,
        'Legacy artist',
      );
    },
  );

  test(
    'legacy image keys remain valid identifiers and emoji aliases',
    () async {
      accountData[MatrixStickerDataSource.installedPacksType] = {
        'pack_ids': ['legacy'],
      };
      accountData['${MatrixStickerDataSource.stickerPackType}.legacy'] = {
        'pack': {'display_name': 'Old pack'},
        'images': {
          'wave': {'url': 'mxc://test/wave', 'body': 'Wave'},
        },
      };
      final pack = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == 'legacy',
      );
      expect(pack.stickers.single.id, 'wave');
      expect(pack.stickers.single.emoji, 'wave');
      expect(await source.installPack(pack.id, pack), isTrue);
      final reloaded = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == 'legacy',
      );
      expect(reloaded.stickers.single.id, 'wave');
      expect(reloaded.stickers.single.emoji, 'wave');
    },
  );

  test(
    'an explicitly absent emoji does not become the sticker identifier',
    () async {
      const pack = StickerPack(
        id: 'no-emoji',
        name: 'Plain',
        stickers: [Sticker(id: 'plain-id', url: 'mxc://test/plain')],
      );
      expect(await source.installPack(pack.id, pack), isTrue);
      final saved = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == pack.id,
      );
      expect(saved.stickers.single.id, 'plain-id');
      expect(saved.stickers.single.emoji, isNull);
    },
  );

  test(
    'duplicate identifiers are rejected before any account data is written',
    () async {
      const pack = StickerPack(
        id: 'invalid',
        name: 'Invalid',
        stickers: [
          Sticker(id: 'same', url: 'mxc://test/first', emoji: '🙂'),
          Sticker(id: 'same', url: 'mxc://test/second', emoji: '😄'),
        ],
      );
      expect(await source.installPack(pack.id, pack), isFalse);
      expect(accountData, isEmpty);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test('empty identifiers cannot write an unreadable pack', () async {
    const pack = StickerPack(
      id: 'invalid',
      name: 'Invalid',
      stickers: [Sticker(id: '', url: 'mxc://test/empty')],
    );
    expect(await source.installPack(pack.id, pack), isFalse);
    verifyNever(() => client.setAccountData(any(), any(), any()));
  });

  test(
    'malformed optional emoji metadata keeps legacy images readable',
    () async {
      accountData[MatrixStickerDataSource.installedPacksType] = {
        'pack_ids': ['legacy'],
      };
      accountData['${MatrixStickerDataSource.stickerPackType}.legacy'] = {
        'pack': {'display_name': 'Old pack'},
        'images': {
          'wave': {'url': 'mxc://test/wave', 'n42.emoji': 42},
        },
      };
      final pack = (await source.getInstalledPacks()).singleWhere(
        (p) => p.id == 'legacy',
      );
      expect(pack.stickers.single.id, 'wave');
      expect(pack.stickers.single.emoji, 'wave');
    },
  );
}
