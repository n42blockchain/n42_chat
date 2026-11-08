import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/repositories/sticker_repository.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/widgets/chat/sticker_picker.dart';

class _Repo extends Mock implements IStickerRepository {}

class _Auth extends Mock
    implements
        IAuthRepository,
        IAccountBoundDeletionLifecycle,
        IAccountBoundSessionChanges,
        IAccountBoundAuthInvalidation {}

void main() {
  late _Repo repo;
  late StreamController<List<StickerPack>> changes;
  late List<StickerPack> packs;
  late List<String> selected;
  const old = StickerPack(
    id: 'subscribed_art',
    name: 'Live A',
    source: StickerPackSource.matrix,
    stickers: [Sticker(id: 'old', url: 'emoji:🙂')],
  );
  const updated = StickerPack(
    id: 'subscribed_art',
    name: 'Live B',
    source: StickerPackSource.matrix,
    stickers: [Sticker(id: 'new', url: 'emoji:🙃')],
  );
  setUp(() async {
    await getIt.reset();
    repo = _Repo();
    changes = StreamController<List<StickerPack>>.broadcast(sync: true);
    packs = [old];
    selected = [];
    when(() => repo.getInstalledPacks()).thenAnswer((_) async => packs);
    when(() => repo.watchInstalledPacks()).thenAnswer((_) => changes.stream);
    when(() => repo.getRecentStickers(limit: any(named: 'limit')))
        .thenAnswer((_) async => []);
    when(() => repo.recordStickerUsage(any(), any())).thenAnswer((_) async {});
    getIt.registerSingleton<IStickerRepository>(repo);
  });
  tearDown(() async {
    await changes.close();
    await getIt.reset();
  });
  Finder tab(String name) => find.byWidgetPredicate(
    (widget) => widget is Semantics && widget.properties.label == name,
  );
  Future<void> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StickerPicker(
            onStickerSelected: (sticker, pack) =>
                selected.add('$pack/${sticker.id}'),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets(
    'pack tab selection does not require an unattached page controller',
    (tester) async {
      await open(tester);
      await tester.tap(tab('Live A'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'an open picker renders updated content and sends its new identity',
    (tester) async {
      await open(tester);
      packs = [updated];
      changes.add(packs);
      await tester.pumpAndSettle();
      expect(tab('Live B'), findsOneWidget);
      expect(tab('Live A'), findsNothing);
      await tester.tap(find.text('🙃'));
      await tester.pump();
      expect(selected, ['subscribed_art/new']);
    },
  );
  testWidgets('removing the selected pack selects a safe remaining pack', (
    tester,
  ) async {
    const other = StickerPack(
      id: 'other',
      name: 'Other',
      stickers: [Sticker(id: 'extra', url: 'emoji:🥳')],
    );
    packs = [old, other];
    await open(tester);
    await tester.tap(tab('Other'));
    await tester.pumpAndSettle();
    packs = [updated];
    changes.add(packs);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('🙃'), findsOneWidget);
    expect(tab('Other'), findsNothing);
  });
  testWidgets(
    'old pending recent data cannot restore removed account content',
    (tester) async {
      final gate = Completer<List<RecentSticker>>();
      var calls = 0;
      when(() => repo.getRecentStickers(limit: any(named: 'limit')))
          .thenAnswer((_) => calls++ == 0 ? gate.future : Future.value([]));
      await open(tester);
      packs = [];
      changes.add(packs);
      await tester.pump();
      gate.complete([
        RecentSticker(
          sticker: old.stickers.single,
          packId: old.id,
          lastUsedAt: DateTime(2026),
        ),
      ]);
      await tester.pumpAndSettle();
      expect(tab('Live A'), findsNothing);
      expect(find.byIcon(Icons.access_time), findsNothing);
    },
  );
  testWidgets('repository replacement blocks actions from the old picker', (
    tester,
  ) async {
    await open(tester);
    await getIt.unregister<IStickerRepository>();
    getIt.registerSingleton<IStickerRepository>(_Repo());
    await tester.tap(find.text('🙂'));
    await tester.pump();
    expect(selected, isEmpty);
    verifyNever(() => repo.recordStickerUsage(any(), any()));
  });
  testWidgets(
    'session change clears old private content before replacement reads finish',
    (tester) async {
      final auth = _Auth();
      final sessions = StreamController<void>.broadcast(sync: true);
      final invalidations = StreamController<AuthSessionInvalidation>.broadcast(
        sync: true,
      );
      addTearDown(sessions.close);
      addTearDown(invalidations.close);
      var current = true;
      final before = AuthSessionInvalidation(
        userId: '@before:test',
        homeserver: Uri.parse('https://test'),
        deviceId: 'D',
        isCurrent: () => current,
      );
      when(() => auth.currentAccountGeneration).thenReturn(before);
      when(() => auth.accountSessionChanges).thenAnswer((_) => sessions.stream);
      when(() => auth.accountInvalidationStream)
          .thenAnswer((_) => invalidations.stream);
      getIt.registerSingleton<IAuthRepository>(auth);
      await open(tester);
      final gate = Completer<List<StickerPack>>();
      when(() => repo.getInstalledPacks()).thenAnswer((_) => gate.future);
      current = false;
      final after = AuthSessionInvalidation(
        userId: '@after:test',
        homeserver: Uri.parse('https://test'),
        deviceId: 'D',
        isCurrent: () => true,
      );
      when(() => auth.currentAccountGeneration).thenReturn(after);
      sessions.add(null);
      await tester.pump();
      expect(tab('Live A'), findsNothing);
      expect(find.text('🙂'), findsNothing);
      gate.complete([updated]);
      await tester.pumpAndSettle();
      expect(tab('Live B'), findsOneWidget);
    },
  );
}
