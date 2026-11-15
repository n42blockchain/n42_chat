import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_subscription.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/sticker_repository.dart';
import 'package:n42_chat/src/presentation/pages/sticker/sticker_subscriptions_page.dart';

class _Repository extends Mock implements IStickerRepository {}

class _Auth extends Mock
    implements
        IAuthRepository,
        IAccountBoundDeletionLifecycle,
        IAccountBoundAuthInvalidation,
        IAccountBoundSessionChanges {}

void main() {
  late _Repository repository;
  late _Auth auth;
  late bool active;
  late AuthSessionInvalidation generation;
  late StreamController<AuthSessionInvalidation> invalidations;
  late StreamController<void> sessions;
  const reference = StickerPackSubscription(
    roomId: '!unreadable:test',
    stateKey: 'Shared art',
  );

  setUp(() {
    repository = _Repository();
    auth = _Auth();
    active = true;
    invalidations = StreamController.broadcast();
    sessions = StreamController.broadcast();
    generation = AuthSessionInvalidation(
      userId: '@owner:test',
      homeserver: Uri.parse('https://test'),
      deviceId: 'D',
      isCurrent: () => active,
    );
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.accountInvalidationStream)
        .thenAnswer((_) => invalidations.stream);
    when(() => auth.accountSessionChanges).thenAnswer((_) => sessions.stream);
    when(() => repository.getPackSubscriptions())
        .thenAnswer((_) async => [reference]);
    GetIt.instance.registerSingleton<IStickerRepository>(repository);
    GetIt.instance.registerSingleton<IAuthRepository>(auth);
  });
  tearDown(() async {
    await invalidations.close();
    await sessions.close();
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
        home: const StickerSubscriptionsPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> remove(WidgetTester tester) async {
    await tester.tap(find.byType(OutlinedButton).first);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'unreadable references can be removed without resolving source content',
    (tester) async {
      when(() => repository.setPackSubscribed(reference, enabled: false))
          .thenAnswer((_) async {
            when(() => repository.getPackSubscriptions())
                .thenAnswer((_) async => []);
            return true;
          });
      await open(tester);
      expect(find.text(reference.roomId), findsOneWidget);
      verifyNever(() => repository.getInstalledPacks());
      await remove(tester);
      verifyNever(
        () => repository.setPackSubscribed(reference, enabled: false),
      );
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(
        () => repository.setPackSubscribed(reference, enabled: false),
      );
      await remove(tester);
      await tester.tap(
        find.byKey(const ValueKey('sticker_unsubscribe_confirm')),
      );
      await tester.pumpAndSettle();
      verify(() => repository.setPackSubscribed(reference, enabled: false))
          .called(1);
      expect(find.text('No sticker subscriptions'), findsOneWidget);
    },
  );

  testWidgets(
    'failed removal keeps the reference and does not retry the write',
    (tester) async {
      when(() => repository.setPackSubscribed(reference, enabled: false))
          .thenAnswer((_) async => false);
      await open(tester);
      await remove(tester);
      await tester.tap(
        find.byKey(const ValueKey('sticker_unsubscribe_confirm')),
      );
      await tester.pumpAndSettle();
      expect(find.text(reference.roomId), findsOneWidget);
      expect(
        find.byKey(const ValueKey('sticker_subscription_error')),
        findsOneWidget,
      );
      verify(() => repository.setPackSubscribed(reference, enabled: false))
          .called(1);
    },
  );

  testWidgets(
    'session change clears private references and its owned confirmation',
    (tester) async {
      await open(tester);
      await remove(tester);
      active = false;
      sessions.add(null);
      await tester.pumpAndSettle();
      expect(find.text(reference.roomId), findsNothing);
      expect(
        find.byKey(const ValueKey('sticker_unsubscribe_confirm')),
        findsNothing,
      );
      verifyNever(
        () => repository.setPackSubscribed(reference, enabled: false),
      );
    },
  );

  testWidgets('late account read cannot restore private references', (
    tester,
  ) async {
    final pending = Completer<List<StickerPackSubscription>>();
    when(() => repository.getPackSubscriptions())
        .thenAnswer((_) => pending.future);
    await tester.pumpWidget(
      const MaterialApp(home: StickerSubscriptionsPage()),
    );
    await tester.pump();
    active = false;
    invalidations.add(generation);
    await tester.pump();
    pending.complete([reference]);
    await tester.pumpAndSettle();
    expect(find.text(reference.roomId), findsNothing);
  });

  testWidgets(
    'late unsubscribe completion cannot restore a replaced account list',
    (tester) async {
      final pending = Completer<bool>();
      when(() => repository.setPackSubscribed(reference, enabled: false))
          .thenAnswer((_) => pending.future);
      await open(tester);
      await remove(tester);
      await tester.tap(
        find.byKey(const ValueKey('sticker_unsubscribe_confirm')),
      );
      await tester.pumpAndSettle();
      active = false;
      invalidations.add(generation);
      await tester.pumpAndSettle();
      pending.complete(true);
      await tester.pumpAndSettle();
      expect(find.text(reference.roomId), findsNothing);
      verify(() => repository.getPackSubscriptions()).called(1);
      expect(tester.takeException(), isNull);
    },
  );

  for (final locale in S.supportedLocales) {
    testWidgets(
      'subscription management fits 320px large text ${locale.toLanguageTag()}',
      (tester) async {
        tester.view.physicalSize = const Size(320, 740);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await open(tester, locale: locale, scale: 1.6);
        expect(tester.takeException(), isNull);
        await remove(tester);
        expect(
          find.byKey(const ValueKey('sticker_unsubscribe_confirm')),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }
}
