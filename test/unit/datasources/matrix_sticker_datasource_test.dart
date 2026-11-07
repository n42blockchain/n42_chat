import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';

class _MockMatrixClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

void main() {
  late _MockMatrixClientManager clientManager;
  late _MockClient client;
  late MatrixStickerDataSource dataSource;

  setUp(() {
    clientManager = _MockMatrixClientManager();
    client = _MockClient();
    dataSource = MatrixStickerDataSource(clientManager);

    when(() => clientManager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice:matrix.example.com');
    when(() => client.homeserver)
        .thenReturn(Uri.parse('https://matrix.example.com'));
    when(
      () => client.getAccountData(
        '@alice:matrix.example.com',
        MatrixStickerDataSource.installedPacksType,
      ),
    ).thenAnswer(
      (_) async => {
        'pack_ids': ['pack-1'],
      },
    );
    when(
      () => client.getAccountData(
        '@alice:matrix.example.com',
        '${MatrixStickerDataSource.stickerPackType}.pack-1',
      ),
    ).thenAnswer(
      (_) async => {
        'pack': {
          'display_name': 'Animals',
          'avatar_url': 'mxc://cdn.example.com/avatar123',
        },
        'images': {
          'cat': {
            'url': 'mxc://cdn.example.com/cat123',
            'body': 'Cat',
            'info': {'w': 128, 'h': 128, 'mimetype': 'image/png', 'size': 1024},
          },
        },
      },
    );
  });

  test('installed sticker cache does not cross account switches', () async {
    final repository = StickerRepositoryImpl(dataSource);
    addTearDown(repository.dispose);
    expect(
      (await repository.getInstalledPacks()).any((p) => p.id == 'pack-1'),
      isTrue,
    );
    when(() => client.userID).thenReturn('@bob:matrix.example.com');
    when(
      () => client.getAccountData(
        '@bob:matrix.example.com',
        MatrixStickerDataSource.installedPacksType,
      ),
    ).thenAnswer((_) async => {'pack_ids': <String>[]});
    expect(
      (await repository.getInstalledPacks()).any((p) => p.id == 'pack-1'),
      isFalse,
    );
  });

  test(
    'held sticker index cannot fetch pack details as a replacement user',
    () async {
      final pending = Completer<Map<String, dynamic>>();
      when(
        () => client.getAccountData(
          '@alice:matrix.example.com',
          MatrixStickerDataSource.installedPacksType,
        ),
      ).thenAnswer((_) => pending.future);
      final read = dataSource.getInstalledPacks();
      when(() => client.userID).thenReturn('@bob:matrix.example.com');
      pending.complete({
        'pack_ids': ['pack-1'],
      });
      final packs = await read;
      expect(packs.any((p) => p.id == 'pack-1'), isFalse);
      verifyNever(
        () => client.getAccountData('@bob:matrix.example.com', any()),
      );
    },
  );

  test(
    'getInstalledPacks maps mxc urls to authenticated media download urls',
    () async {
      final packs = await dataSource.getInstalledPacks();
      final pack = packs.firstWhere((p) => p.id == 'pack-1');

      expect(
        pack.avatarHttpUrl,
        'https://matrix.example.com/_matrix/client/v1/media/download/cdn.example.com/avatar123',
      );
      expect(pack.stickers, hasLength(1));
      expect(
        pack.stickers.first.httpUrl,
        'https://matrix.example.com/_matrix/client/v1/media/download/cdn.example.com/cat123',
      );
    },
  );
}
