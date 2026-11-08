import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/sticker_repository.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/presentation/pages/sticker/sticker_publish_page.dart';

class _Repository extends Mock implements IStickerRepository {}

class _Conversations extends Mock implements IConversationRepository {}

class _Auth extends Mock
    implements
        IAuthRepository,
        IAccountBoundDeletionLifecycle,
        IAccountBoundAuthInvalidation {}

void main() {
  late _Repository repo;
  late _Conversations conversations;
  late _Auth auth;
  late bool active;
  late AuthSessionInvalidation generation;
  late StreamController<AuthSessionInvalidation> events;
  const pack = StickerPack(
    id: 'custom_art',
    name: 'Private art',
    source: StickerPackSource.custom,
    stickers: [Sticker(id: 'one', url: 'emoji:🙂')],
  );
  const room = ConversationEntity(
    id: '!group:test',
    name: 'Project group',
    type: ConversationType.group,
  );
  setUp(() async {
    await GetIt.instance.reset();
    registerFallbackValue(pack);
    repo = _Repository();
    conversations = _Conversations();
    auth = _Auth();
    active = true;
    events = StreamController<AuthSessionInvalidation>.broadcast(sync: true);
    generation = AuthSessionInvalidation(
      userId: '@me:test',
      homeserver: Uri.parse('https://test'),
      deviceId: 'D',
      isCurrent: () => active,
    );
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.accountInvalidationStream).thenAnswer((_) => events.stream);
    when(() => repo.getPackById(any())).thenAnswer((_) async => pack);
    when(
      () => repo.publishPack(
        any(),
        any(),
        reviewedPack: any(named: 'reviewedPack'),
      ),
    ).thenAnswer((_) async => 'https://matrix.to/#/!group:test/\$pack');
    when(() => conversations.getConversations()).thenAnswer(
      (_) async => [
        room,
        const ConversationEntity(
          id: '!hidden:test',
          name: 'Hidden',
          type: ConversationType.group,
          isHidden: true,
        ),
        const ConversationEntity(
          id: '!invite:test',
          name: 'Invited',
          type: ConversationType.group,
          isInvite: true,
        ),
        const ConversationEntity(id: '!direct:test', name: 'Direct'),
      ],
    );
    GetIt.instance.registerSingleton<IStickerRepository>(repo);
    GetIt.instance.registerSingleton<IConversationRepository>(conversations);
    GetIt.instance.registerSingleton<IAuthRepository>(auth);
  });
  tearDown(() async {
    await events.close();
    await GetIt.instance.reset();
  });
  Future<void> open(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    double scale = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: const StickerPublishPage(packId: 'custom_art'),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> review(WidgetTester tester) async {
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('sticker_publish_room_!group:test')),
      150,
      scrollable: find.byType(Scrollable).first,
    );
    final roomFinder = find.byKey(
      const ValueKey('sticker_publish_room_!group:test'),
    );
    await Scrollable.ensureVisible(tester.element(roomFinder), alignment: 0.5);
    await tester.pumpAndSettle();
    expect(roomFinder.hitTestable(), findsOneWidget);
    await tester.tap(roomFinder);
    await tester.pump();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('sticker_publish_review')),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    final reviewFinder = find.byKey(const ValueKey('sticker_publish_review'));
    await Scrollable.ensureVisible(
      tester.element(reviewFinder),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    expect(reviewFinder.hitTestable(), findsOneWidget);
    await tester.tap(reviewFinder);
    await tester.pumpAndSettle();
  }

  testWidgets('selection and review do not publish; cancel does not write', (
    tester,
  ) async {
    await open(tester);
    expect(find.text('Hidden'), findsNothing);
    expect(find.text('Invited'), findsNothing);
    expect(find.text('Direct'), findsNothing);
    await review(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
    verifyNever(
      () => repo.publishPack(
        any(),
        any(),
        reviewedPack: any(named: 'reviewedPack'),
      ),
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(
      () => repo.publishPack(
        any(),
        any(),
        reviewedPack: any(named: 'reviewedPack'),
      ),
    );
  });
  testWidgets(
    'confirmation publishes exact pack and room and disables duplicate submission',
    (tester) async {
      await open(tester);
      await review(tester);
      await tester.tap(find.byKey(const ValueKey('sticker_publish_confirm')));
      await tester.pumpAndSettle();
      verify(
        () => repo.publishPack('custom_art', '!group:test', reviewedPack: pack),
      ).called(1);
      expect(
        find.byKey(const ValueKey('sticker_publish_link')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('sticker_publish_review')),
        findsNothing,
      );
    },
  );
  testWidgets(
    'account invalidation closes only its confirmation and clears private data',
    (tester) async {
      await open(tester);
      await review(tester);
      active = false;
      events.add(generation);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Private art'), findsNothing);
      expect(find.text('Project group'), findsNothing);
      verifyNever(
        () => repo.publishPack(
          any(),
          any(),
          reviewedPack: any(named: 'reviewedPack'),
        ),
      );
    },
  );
  testWidgets(
    'late pack lookup cannot load replacement account conversations',
    (tester) async {
      final gate = Completer<StickerPack?>();
      when(() => repo.getPackById(any())).thenAnswer((_) => gate.future);
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: StickerPublishPage(packId: 'custom_art'),
        ),
      );
      active = false;
      events.add(generation);
      gate.complete(pack);
      await tester.pumpAndSettle();
      verifyNever(() => conversations.getConversations());
      expect(find.text('Private art'), findsNothing);
    },
  );
  testWidgets('late publication receipt cannot reveal the old account link', (
    tester,
  ) async {
    final gate = Completer<String?>();
    when(
      () => repo.publishPack(
        any(),
        any(),
        reviewedPack: any(named: 'reviewedPack'),
      ),
    ).thenAnswer((_) => gate.future);
    await open(tester);
    await review(tester);
    await tester.tap(find.byKey(const ValueKey('sticker_publish_confirm')));
    await tester.pump();
    active = false;
    events.add(generation);
    gate.complete('https://matrix.to/old-private-link');
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('sticker_publish_link')), findsNothing);
  });
  testWidgets(
    'uncertain publication shows check-before-retry message without automatic retry',
    (tester) async {
      when(
        () => repo.publishPack(
          any(),
          any(),
          reviewedPack: any(named: 'reviewedPack'),
        ),
      ).thenThrow(StateError('unknown receipt'));
      await open(tester);
      await review(tester);
      await tester.tap(find.byKey(const ValueKey('sticker_publish_confirm')));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'Publication was not confirmed. Check the group before trying again.',
        ),
        findsOneWidget,
      );
      verify(
        () => repo.publishPack(
          any(),
          any(),
          reviewedPack: any(named: 'reviewedPack'),
        ),
      ).called(1);
    },
  );
  for (final locale in S.supportedLocales) {
    testWidgets('320px large-text publication confirmation fits $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 740);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await open(tester, locale: locale, scale: 1.6);
      await review(tester);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(tester.takeException(), isNull);
      verifyNever(
        () => repo.publishPack(
          any(),
          any(),
          reviewedPack: any(named: 'reviewedPack'),
        ),
      );
    });
  }
}
