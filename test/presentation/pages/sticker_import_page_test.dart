import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/services/ai_sticker_service.dart';
import 'package:n42_chat/src/presentation/pages/sticker/sticker_store_page.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/sticker_repository.dart';
import 'package:n42_chat/src/presentation/pages/sticker/sticker_import_page.dart';
import 'package:n42_chat/src/presentation/widgets/chat/sticker_thumb.dart';

class _Repository extends Mock implements IStickerRepository {}

class _Ai extends Mock implements AiStickerService {}

class _Auth extends Mock
    implements
        IAuthRepository,
        IAccountBoundDeletionLifecycle,
        IAccountBoundAuthInvalidation {}

void main() {
  late _Repository repository;
  late _Auth auth;
  late AuthSessionInvalidation generation;
  late StreamController<AuthSessionInvalidation> invalidations;
  late GlobalKey<NavigatorState> navigator;
  late bool active;
  bool? returned;
  final pack = StickerPack(
    id: 'shared_art',
    name: 'Private art',
    source: StickerPackSource.matrix,
    origin: StickerPackOrigin(
      roomId: '!pack:test',
      eventId: r'$pack',
      stateKey: 'art',
      roomName: 'Project group',
    ),
    stickers: const [Sticker(id: 'smile', url: 'emoji:🙂')],
  );
  const link = 'https://matrix.to/#/!pack:test/\$pack';

  setUp(() async {
    await GetIt.instance.reset();
    repository = _Repository();
    auth = _Auth();
    active = true;
    returned = null;
    navigator = GlobalKey<NavigatorState>();
    invalidations = StreamController<AuthSessionInvalidation>.broadcast(
      sync: true,
    );
    generation = AuthSessionInvalidation(
      userId: '@reader:test',
      homeserver: Uri.parse('https://test'),
      deviceId: 'D',
      isCurrent: () => active,
    );
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.accountInvalidationStream)
        .thenAnswer((_) => invalidations.stream);
    when(() => repository.importPack(any())).thenAnswer((_) async => pack);
    when(() => repository.installPack(any())).thenAnswer((_) async => true);
    GetIt.instance.registerSingleton<IStickerRepository>(repository);
    GetIt.instance.registerSingleton<IAuthRepository>(auth);
  });
  tearDown(() async {
    await invalidations.close();
    await GetIt.instance.reset();
  });

  Future<void> open(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    double scale = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigator,
        locale: locale,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                returned = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (_) => const StickerImportPage(initialLink: link),
                  ),
                );
              },
              child: const Text('Open import'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open import'));
    await tester.pumpAndSettle();
  }

  Future<void> preview(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('sticker_import_preview')));
    await tester.pumpAndSettle();
  }

  Future<void> confirm(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('sticker_import_add')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sticker_import_confirm')));
    await tester.pump();
  }

  void switchAccount() {
    active = false;
    invalidations.add(generation);
  }

  testWidgets(
    'preview shows images and source but requires separate installation confirmation',
    (tester) async {
      await open(tester);
      verifyNever(() => repository.importPack(any()));
      await preview(tester);
      expect(find.byType(StickerThumb), findsOneWidget);
      expect(find.text('Project group'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('sticker_import_origin')),
        findsOneWidget,
      );
      verifyNever(() => repository.installPack(any()));
      await tester.tap(find.byKey(const ValueKey('sticker_import_add')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => repository.installPack(any()));
      await confirm(tester);
      await tester.pumpAndSettle();
      verify(() => repository.installPack(pack.id)).called(1);
      expect(returned, isTrue);
      expect(find.text('Open import'), findsOneWidget);
    },
  );

  testWidgets(
    'sticker management opens import without automatically previewing',
    (tester) async {
      final ai = _Ai();
      when(() => ai.isAvailable).thenReturn(false);
      GetIt.instance.registerSingleton<AiStickerService>(ai);
      when(() => repository.getCategories()).thenAnswer((_) async => []);
      when(() => repository.getInstalledPacks()).thenAnswer((_) async => []);
      when(() => repository.getStorePacks()).thenAnswer((_) async => []);
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: StickerStorePage(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('sticker_store_import')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('sticker_import_link')), findsOneWidget);
      verifyNever(() => repository.importPack(any()));
    },
  );

  testWidgets(
    'installed shared packs use image thumbnails without fabricated download counts',
    (tester) async {
      final ai = _Ai();
      when(() => ai.isAvailable).thenReturn(false);
      GetIt.instance.registerSingleton<AiStickerService>(ai);
      when(() => repository.getCategories()).thenAnswer((_) async => []);
      when(() => repository.getInstalledPacks())
          .thenAnswer((_) async => [pack.copyWith(isInstalled: true)]);
      when(() => repository.getStorePacks()).thenAnswer((_) async => []);
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: StickerStorePage(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('My Stickers'));
      await tester.pumpAndSettle();
      expect(find.byType(StickerThumb), findsOneWidget);
      expect(find.byIcon(Icons.download), findsNothing);
    },
  );

  testWidgets('unavailable packs stay uninstalled', (tester) async {
    when(() => repository.importPack(any())).thenAnswer((_) async => null);
    await open(tester);
    await preview(tester);
    expect(find.byKey(const ValueKey('sticker_import_error')), findsOneWidget);
    expect(find.byKey(const ValueKey('sticker_import_add')), findsNothing);
    verifyNever(() => repository.installPack(any()));
  });

  testWidgets('changing the link invalidates the reviewed pack', (
    tester,
  ) async {
    await open(tester);
    await preview(tester);
    await tester.enterText(
      find.byKey(const ValueKey('sticker_import_link')),
      'https://matrix.to/#/!other/\$new',
    );
    await tester.pump();
    expect(find.byKey(const ValueKey('sticker_import_add')), findsNothing);
    verifyNever(() => repository.installPack(any()));
  });

  testWidgets('account changes discard a delayed preview', (tester) async {
    final pending = Completer<StickerPack?>();
    when(() => repository.importPack(any())).thenAnswer((_) => pending.future);
    await open(tester);
    await tester.tap(find.byKey(const ValueKey('sticker_import_preview')));
    await tester.pump();
    switchAccount();
    pending.complete(pack);
    await tester.pumpAndSettle();
    expect(find.text(pack.name), findsNothing);
    expect(find.byKey(const ValueKey('sticker_import_error')), findsOneWidget);
    verifyNever(() => repository.installPack(any()));
  });

  testWidgets(
    'account changes close only the owned confirmation and clear the old preview',
    (tester) async {
      await open(tester);
      await preview(tester);
      await tester.tap(find.byKey(const ValueKey('sticker_import_add')));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      switchAccount();
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text(pack.name), findsNothing);
      expect(
        tester
            .widget<TextField>(
              find.byKey(const ValueKey('sticker_import_link')),
            )
            .controller!
            .text,
        isEmpty,
      );
      verifyNever(() => repository.installPack(any()));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'a rejected install retains the preview and permits an explicit retry',
    (tester) async {
      var attempts = 0;
      when(() => repository.installPack(any()))
          .thenAnswer((_) async => ++attempts > 1);
      await open(tester);
      await preview(tester);
      await confirm(tester);
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('sticker_import_error')),
        findsOneWidget,
      );
      expect(find.text(pack.name), findsOneWidget);
      await confirm(tester);
      await tester.pumpAndSettle();
      expect(attempts, 2);
      expect(returned, isTrue);
    },
  );

  for (final changeAccount in [false, true]) {
    testWidgets(
      'late install cannot pop a newer route: account change=$changeAccount',
      (tester) async {
        final pending = Completer<bool>();
        when(() => repository.installPack(any()))
            .thenAnswer((_) => pending.future);
        await open(tester);
        await preview(tester);
        await confirm(tester);
        // Repeated taps while the acknowledgement is pending cannot resubmit.
        await tester.tap(find.byKey(const ValueKey('sticker_import_add')));
        await tester.pump();
        if (changeAccount) switchAccount();
        unawaited(
          navigator.currentState!.push<void>(
            MaterialPageRoute<void>(
              builder: (_) => const Scaffold(body: Text('Replacement route')),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 400));
        pending.complete(true);
        await tester.pumpAndSettle();
        expect(find.text('Replacement route'), findsOneWidget);
        verify(() => repository.installPack(pack.id)).called(1);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final locale in S.supportedLocales) {
    testWidgets(
      '320px large-text preview and confirmation fit ${locale.toLanguageTag()}',
      (tester) async {
        tester.view.physicalSize = const Size(320, 740);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await open(tester, locale: locale, scale: 1.6);
        await preview(tester);
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(const ValueKey('sticker_import_add')));
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
