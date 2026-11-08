import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/data/repositories/sticker_repository_impl.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_subscriptions.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_subscription.dart';

class _Source extends Mock implements MatrixStickerDataSource {}

class _Subscriptions extends Mock implements MatrixStickerSubscriptions {}

void main() {
  late _Source source;
  late _Subscriptions subscriptions;
  late StickerRepositoryImpl repository;
  late StreamController<void> changes;
  late List<StickerPackSubscription> references;
  late Object? scope;
  const ref = StickerPackSubscription(roomId: '!room:test', stateKey: 'art');
  const private = StickerPack(id: 'custom_owned', name: 'Private');
  final live = StickerPack(
    id: ref.packId,
    name: 'Live art',
    source: StickerPackSource.matrix,
    subscription: ref,
    isInstalled: true,
    stickers: const [Sticker(id: 'one', url: 'mxc://test/image')],
  );
  setUp(() {
    registerFallbackValue(ref);
    registerFallbackValue(private);
    source = _Source();
    subscriptions = _Subscriptions();
    changes = StreamController<void>.broadcast(sync: true);
    scope = 'original';
    references = [ref];
    when(() => source.accountScope).thenReturn('sdk-account');
    when(() => subscriptions.accountScope).thenAnswer((_) => scope);
    when(() => subscriptions.watchChanges()).thenAnswer((_) => changes.stream);
    when(() => subscriptions.getJoinedRoomIds())
        .thenAnswer((_) async => references.map((r) => r.roomId).toSet());
    when(() => subscriptions.getEnabled())
        .thenAnswer((_) async => references.toList());
    when(
      () => subscriptions.setEnabled(any(), enabled: any(named: 'enabled')),
    ).thenAnswer((call) async {
      final reference = call.positionalArguments[0] as StickerPackSubscription;
      if (call.namedArguments[#enabled] as bool) {
        references = [...references, reference];
      } else {
        references = references.where((r) => r != reference).toList();
      }
    });
    when(() => source.getInstalledPacks()).thenAnswer((_) async => [private]);
    when(() => source.getSubscribedPack(any())).thenAnswer((_) async => live);
    repository = StickerRepositoryImpl(source, subscriptions: subscriptions);
  });
  tearDown(() async {
    repository.dispose();
    await changes.close();
  });
  test('existing picker list includes private and live packs and keeps successful reads cached', () async {
    final first = await repository.getInstalledPacks();
    expect(first, containsAll([private, live]));
    expect(await repository.getInstalledPacks(), same(first));
    verify(() => source.getSubscribedPack(ref)).called(1);
  });
  test('a relevant change refreshes cached live content', () async {
    await repository.getInstalledPacks();
    final updated = live.copyWith(name: 'Updated');
    when(() => source.getSubscribedPack(ref)).thenAnswer((_) async => updated);
    changes.add(null);
    expect(
      (await repository.getInstalledPacks())
          .firstWhere((p) => p.id == ref.packId)
          .name,
      'Updated',
    );
  });
  test(
    'unavailable pack remains removable without a private-manifest delete',
    () async {
      when(() => source.getSubscribedPack(ref)).thenAnswer((_) async => null);
      expect(
        (await repository.getInstalledPacks()).where((p) => p.id == ref.packId),
        isEmpty,
      );
      expect(await repository.getPackSubscriptions(), [ref]);
      expect(await repository.uninstallPack(ref.packId), isTrue);
      expect(await repository.getPackSubscriptions(), isEmpty);
      verifyNever(() => source.uninstallPack(any()));
      expect(await repository.getInstalledPacks(), contains(private));
    },
  );
  test('installing an already-enabled live pack does not copy it into private storage', () async {
    expect(await repository.installPack(ref.packId), isTrue);
    verifyNever(() => source.installPack(any(), any()));
  });
  test(
    'inactive login cannot expose cached private or subscribed packs',
    () async {
      await repository.getInstalledPacks();
      scope = null;
      final packs = await repository.getInstalledPacks();
      expect(
        packs.where((p) => p.id == private.id || p.id == live.id),
        isEmpty,
      );
    },
  );
  test(
    'late old-account response cannot replace a new account result',
    () async {
      final gate = Completer<StickerPack?>(), entered = Completer<void>();
      when(() => source.getSubscribedPack(ref)).thenAnswer((_) {
        entered.complete();
        return gate.future;
      });
      final old = repository.getInstalledPacks();
      await entered.future;
      scope = 'replacement';
      references = [];
      const replacement = StickerPack(id: 'custom_new', name: 'New account');
      when(() => source.getInstalledPacks())
          .thenAnswer((_) async => [replacement]);
      final current = await repository.getInstalledPacks();
      gate.complete(live);
      expect(current, contains(replacement));
      expect(await old, isNot(contains(live)));
      expect(await repository.getInstalledPacks(), same(current));
    },
  );
  test(
    'an older state read cannot overwrite a newer invalidation result',
    () async {
      final gate = Completer<StickerPack?>(), entered = Completer<void>();
      var calls = 0;
      final fresh = live.copyWith(name: 'Fresh');
      when(() => source.getSubscribedPack(ref)).thenAnswer((_) {
        if (calls++ == 0) {
          entered.complete();
          return gate.future;
        }
        return Future.value(fresh);
      });
      final old = repository.getInstalledPacks();
      await entered.future;
      changes.add(null);
      final latest = repository.getInstalledPacks();
      gate.complete(live);
      expect(await old, contains(fresh));
      expect(await latest, contains(fresh));
      expect(await repository.getInstalledPacks(), isNot(contains(live)));
    },
  );
  test('transient content failure can recover on the next read without changing references', () async {
    var calls = 0;
    when(() => source.getSubscribedPack(ref))
        .thenAnswer((_) async => calls++ == 0 ? null : live);
    expect(await repository.getInstalledPacks(), isNot(contains(live)));
    expect(await repository.getInstalledPacks(), contains(live));
    verifyNever(
      () => subscriptions.setEnabled(any(), enabled: any(named: 'enabled')),
    );
  });
  test(
    'concurrent callers share one load and fan-out stays bounded at four',
    () async {
      references = [
        for (var i = 0; i < 9; i++)
          StickerPackSubscription(roomId: '!room:test', stateKey: '$i'),
      ];
      final firstBatch = Completer<void>(), release = Completer<void>();
      var active = 0, maxActive = 0, calls = 0;
      when(() => source.getSubscribedPack(any())).thenAnswer((call) async {
        active++;
        calls++;
        if (active > maxActive) maxActive = active;
        if (calls == 4) firstBatch.complete();
        await release.future;
        active--;
        final reference =
            call.positionalArguments[0] as StickerPackSubscription;
        return live.copyWith(id: reference.packId, subscription: reference);
      });
      final first = repository.getInstalledPacks(),
          second = repository.getInstalledPacks();
      expect(first, same(second));
      await firstBatch.future;
      expect(calls, 4);
      release.complete();
      expect((await first).where((p) => p.subscription != null), hasLength(9));
      expect(maxActive, 4);
    },
  );
  test(
    'synchronous private-load failure does not poison the next load',
    () async {
      final legacy = StickerRepositoryImpl(source);
      addTearDown(legacy.dispose);
      when(() => source.accountScope).thenReturn(null);
      when(() => source.getInstalledPacks()).thenThrow(StateError('temporary'));
      await expectLater(legacy.getInstalledPacks(), throwsStateError);
      when(() => source.getInstalledPacks()).thenAnswer((_) async => [private]);
      expect(await legacy.getInstalledPacks(), contains(private));
    },
  );
  test(
    'left-room reference remains removable but does not enter the picker',
    () async {
      when(() => subscriptions.getJoinedRoomIds())
          .thenAnswer((_) async => <String>{});
      expect(await repository.getInstalledPacks(), isNot(contains(live)));
      expect(await repository.getPackSubscriptions(), [ref]);
      verifyNever(() => source.getSubscribedPack(ref));
      expect(await repository.setPackSubscribed(ref, enabled: false), isTrue);
    },
  );
  test('queued stream delivery cannot emit a previous account list', () async {
    await repository.getInstalledPacks();
    final received = <List<StickerPack>>[];
    final listener = repository.watchInstalledPacks().listen(received.add);
    scheduleMicrotask(() => scope = 'replacement');
    await Future<void>.delayed(Duration.zero);
    expect(
      received
          .expand((packs) => packs)
          .where((pack) => pack.id == private.id || pack.id == live.id),
      isEmpty,
    );
    await listener.cancel();
  });

  test(
    'invalidations do not multiply in-flight reads for the same account',
    () async {
      references = [
        for (var i = 0; i < 4; i++)
          StickerPackSubscription(roomId: '!room:test', stateKey: '$i'),
      ];
      final entered = Completer<void>(), release = Completer<void>();
      var active = 0, maximum = 0, calls = 0;
      when(() => source.getSubscribedPack(any())).thenAnswer((call) async {
        active++;
        calls++;
        if (active > maximum) maximum = active;
        if (calls == 4) entered.complete();
        await release.future;
        active--;
        final reference =
            call.positionalArguments[0] as StickerPackSubscription;
        return live.copyWith(id: reference.packId, subscription: reference);
      });
      final original = repository.getInstalledPacks();
      await entered.future;
      changes.add(null);
      final latest = repository.getInstalledPacks();
      await Future<void>.delayed(Duration.zero);
      try {
        expect(
          calls,
          4,
          reason: 'Old in-flight reads share the four-slot account budget',
        );
      } finally {
        release.complete();
        await original;
        await latest;
      }
      expect(maximum, lessThanOrEqualTo(4));
    },
  );
}
