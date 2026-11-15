import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_publication.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';
import 'package:n42_chat/src/domain/entities/sticker_publication_receipt_failure.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class _Source extends Mock implements MatrixStickerDataSource {}

class _Publisher extends Mock implements MatrixStickerPublication {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

void main() {
  late _Source source;
  late _Publisher publisher;
  late _Lifecycle lifecycle;
  late StickerRepositoryImpl repository;
  late bool active;
  const pack = StickerPack(
    id: 'custom_art',
    name: 'Reviewed art',
    source: StickerPackSource.custom,
    stickers: [Sticker(id: 'one', url: 'mxc://test/image')],
  );
  final origin = StickerPackOrigin(
    roomId: '!room:test',
    eventId: r'$published',
  );
  setUp(() {
    registerFallbackValue(pack);
    registerFallbackValue(origin);
    registerFallbackValue(() => true);
    source = _Source();
    publisher = _Publisher();
    lifecycle = _Lifecycle();
    active = true;
    final generation = AuthSessionInvalidation(
      userId: '@owner:test',
      homeserver: Uri.parse('https://test'),
      deviceId: 'D',
      isCurrent: () => active,
    );
    when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
    when(() => publisher.lifecycle).thenReturn(lifecycle);
    when(() => source.accountScope).thenReturn('original');
    when(() => source.getInstalledPacks()).thenAnswer((_) async => [pack]);
    when(() => publisher.publish(any(), any())).thenAnswer((_) async => origin);
    when(
      () => source.savePublicationReceipt(
        any(),
        any(),
        isCurrent: any(named: 'isCurrent'),
      ),
    ).thenAnswer((_) async => true);
    when(() => source.getPublicationReceipt(any()))
        .thenAnswer((_) async => null);
    repository = StickerRepositoryImpl(source, publication: publisher);
  });
  tearDown(() => repository.dispose());
  test(
    'publishes only the reviewed owned snapshot and returns source link',
    () async {
      expect(
        await repository.publishPack(pack.id, '!room:test', reviewedPack: pack),
        origin.shareUrl,
      );
      verify(() => publisher.publish(pack, '!room:test')).called(1);
    },
  );
  test('changed content after review is rejected before room write', () async {
    when(() => source.getInstalledPacks())
        .thenAnswer((_) async => [pack.copyWith(name: 'Changed art')]);
    expect(
      await repository.publishPack(pack.id, '!room:test', reviewedPack: pack),
      isNull,
    );
    verifyNever(() => publisher.publish(any(), any()));
  });
  test('replacement account during lookup cannot publish', () async {
    final gate = Completer<List<StickerPack>>();
    when(() => source.getInstalledPacks()).thenAnswer((_) => gate.future);
    final pending = repository.publishPack(
      pack.id,
      '!room:test',
      reviewedPack: pack,
    );
    active = false;
    when(() => source.accountScope).thenReturn('replacement');
    gate.complete([pack]);
    expect(await pending, isNull);
    verifyNever(() => publisher.publish(any(), any()));
  });
  test('late server receipt does not return old account link', () async {
    final gate = Completer<StickerPackOrigin>();
    when(() => publisher.publish(any(), any())).thenAnswer((_) => gate.future);
    final pending = repository.publishPack(
      pack.id,
      '!room:test',
      reviewedPack: pack,
    );
    await Future<void>.delayed(Duration.zero);
    active = false;
    gate.complete(origin);
    expect(await pending, isNull);
  });
  test('imported packs cannot be republished as owned', () async {
    final imported = pack.copyWith(source: StickerPackSource.matrix);
    when(() => source.getInstalledPacks()).thenAnswer((_) async => [imported]);
    expect(
      await repository.publishPack(
        pack.id,
        '!room:test',
        reviewedPack: imported,
      ),
      isNull,
    );
    verifyNever(() => publisher.publish(any(), any()));
  });
  test(
    'confirmed room link is retained when private receipt save fails',
    () async {
      when(
        () => source.savePublicationReceipt(
          any(),
          any(),
          isCurrent: any(named: 'isCurrent'),
        ),
      ).thenAnswer((_) async => false);
      await expectLater(
        repository.publishPack(pack.id, '!room:test', reviewedPack: pack),
        throwsA(
          isA<StickerPublicationReceiptFailure>().having(
            (e) => e.shareUrl,
            'confirmed link',
            origin.shareUrl,
          ),
        ),
      );
      verify(() => publisher.publish(pack, '!room:test')).called(1);
    },
  );
  test(
    'account invalidation during private save cannot expose old receipt',
    () async {
      final gate = Completer<bool>();
      when(
        () => source.savePublicationReceipt(
          any(),
          any(),
          isCurrent: any(named: 'isCurrent'),
        ),
      ).thenAnswer((_) => gate.future);
      final pending = repository.publishPack(
        pack.id,
        '!room:test',
        reviewedPack: pack,
      );
      await Future<void>.delayed(Duration.zero);
      active = false;
      gate.complete(true);
      expect(await pending, isNull);
    },
  );
  test('saved receipt is read on reopening without a room write', () async {
    when(() => source.getPublicationReceipt(pack))
        .thenAnswer((_) async => origin.shareUrl);
    final reopened = StickerRepositoryImpl(source, publication: publisher);
    addTearDown(reopened.dispose);
    expect(await reopened.getPackShareUrl(pack.id), origin.shareUrl);
    verifyNever(() => publisher.publish(any(), any()));
  });
  test(
    'mutable local list cannot change the published snapshot receipt',
    () async {
      final mutable = pack.copyWith(stickers: [...pack.stickers]);
      final reviewed = mutable.copyWith(
        stickers: List.unmodifiable(mutable.stickers),
      );
      when(() => source.getInstalledPacks()).thenAnswer((_) async => [mutable]);
      final gate = Completer<StickerPackOrigin>();
      when(() => publisher.publish(any(), any()))
          .thenAnswer((_) => gate.future);
      final pending = repository.publishPack(
        pack.id,
        '!room:test',
        reviewedPack: reviewed,
      );
      await Future<void>.delayed(Duration.zero);
      mutable.stickers[0] = mutable.stickers.single.copyWith(
        url: 'mxc://test/changed',
      );
      gate.complete(origin);
      expect(await pending, origin.shareUrl);
      final saved =
          verify(
                () => source.savePublicationReceipt(
                  captureAny(),
                  any(),
                  isCurrent: any(named: 'isCurrent'),
                ),
              ).captured.single
              as StickerPack;
      expect(saved.stickers.single.url, 'mxc://test/image');
      expect(() => saved.stickers.clear(), throwsUnsupportedError);
    },
  );
  test('receipt is not exposed for a different reviewed preview', () async {
    expect(
      await repository.getPackShareUrl(
        pack.id,
        reviewedPack: pack.copyWith(name: 'Other art'),
      ),
      isNull,
    );
    verifyNever(() => source.getPublicationReceipt(any()));
  });
}
