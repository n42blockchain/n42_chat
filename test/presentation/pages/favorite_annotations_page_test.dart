import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_reaction_datasource.dart';
import 'package:n42_chat/src/data/repositories/message_action_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_action_repository.dart';
import 'package:n42_chat/src/presentation/pages/favorite/favorite_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

class _Client extends Mock implements matrix.Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Reaction extends Mock implements MatrixReactionDataSource {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Store extends InMemorySharedPreferencesStore {
  _Store() : super.empty();
  bool reject = false;
  Completer<void>? hold;
  Completer<void>? started;

  @override
  Future<bool> setValue(String type, String key, Object value) async {
    final pending = hold;
    hold = null;
    if (pending != null) {
      started?.complete();
      await pending.future;
    }
    if (reject) {
      reject = false;
      return false;
    }
    return super.setValue(type, key, value);
  }
}

class _Fixture {
  final client = _Client();
  final manager = _Manager();
  final auth = _Auth();
  final store = _Store();
  String user = '@alice:test';
  bool active = true;
  late MessageActionRepositoryImpl repository;
  late final generation = AuthSessionInvalidation(
    userId: '@alice:test',
    homeserver: Uri.parse('https://test'),
    deviceId: 'D',
    isCurrent: () => active,
    matchesClient: (candidate) => identical(candidate, client),
  );

  Future<void> initialize(WidgetTester tester) async {
    await GetIt.instance.reset();
    SharedPreferences.setMockInitialValues({});
    SharedPreferencesStorePlatform.instance = store;
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenAnswer((_) => user);
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.deviceID).thenReturn('D');
    when(() => client.accessToken).thenReturn('fixture-token');
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    GetIt.instance.registerSingleton<MatrixClientManager>(manager);
    GetIt.instance.registerSingleton<IAuthRepository>(auth);
    registerRepository();
    for (final item in [
      ('one', 'Saved launch notes', MessageType.text),
      ('two', 'Project image', MessageType.image),
    ]) {
      await repository.saveMessage(
        MessageEntity(
          id: item.$1,
          roomId: '!room:test',
          senderId: '@alice:test',
          senderName: 'Alice',
          content: item.$2,
          type: item.$3,
          timestamp: DateTime.now(),
        ),
      );
    }
    await repository.editFavoriteTags('one', ['work']);
    await repository.editFavoriteRemark('one', 'Follow up tomorrow');
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      await GetIt.instance.reset();
      SharedPreferences.setMockInitialValues({});
    });
  }

  void registerRepository() {
    repository = MessageActionRepositoryImpl(
      _Reaction(),
      manager,
      PreferencesDataSource(),
    );
    GetIt.instance.registerSingleton<IMessageActionRepository>(repository);
  }

  void switchToB() {
    active = false;
    user = '@bob:test';
    when(() => auth.currentAccountGeneration).thenReturn(
      AuthSessionInvalidation(
        userId: user,
        homeserver: Uri.parse('https://test'),
        deviceId: 'D',
        isCurrent: () => true,
        matchesClient: (candidate) => identical(candidate, client),
      ),
    );
  }

  Future<void> open(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: FavoriteListPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> edit(WidgetTester tester, String title) async {
    await tester.longPress(find.text('Saved launch notes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
  }
}

void main() {
  testWidgets(
    'account change while options are open cannot rebind the editor',
    (tester) async {
      final f = _Fixture();
      await f.initialize(tester);
      await f.open(tester);
      await tester.longPress(find.text('Saved launch notes'));
      await tester.pumpAndSettle();
      f.switchToB();
      await tester.tap(find.text('Edit Remark'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Old account data');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Save failed'), findsOneWidget);
      expect(await f.repository.getSavedMessageFavorites(), isEmpty);
    },
  );

  testWidgets('favorites list displays and searches persisted annotations', (
    tester,
  ) async {
    final f = _Fixture();
    await f.initialize(tester);
    await f.open(tester);
    expect(find.text('work'), findsOneWidget);
    expect(find.text('Follow up tomorrow'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'tomorrow');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('Saved launch notes'), findsOneWidget);
    expect(find.text('Project image'), findsNothing);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'WORK');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('Saved launch notes'), findsOneWidget);
    expect(find.text('Project image'), findsNothing);
  });

  testWidgets('edits deduplicate tags and retain remarks after reopening', (
    tester,
  ) async {
    final f = _Fixture();
    await f.initialize(tester);
    await f.open(tester);
    await tester.tap(find.text('Text'));
    await tester.pumpAndSettle();
    await f.edit(tester, 'Edit Tags');
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'work',
    );
    await tester.enterText(find.byType(TextField), 'work, urgent，work');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('urgent'), findsOneWidget);
    expect(find.text('Project image'), findsNothing);
    await f.edit(tester, 'Edit Remark');
    await tester.enterText(find.byType(TextField), 'Review after launch');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox());
    await GetIt.instance.unregister<IMessageActionRepository>();
    f.registerRepository();
    await f.open(tester);
    expect(find.text('Review after launch'), findsOneWidget);
    expect(find.text('urgent'), findsOneWidget);
    expect(
      (await f.repository.getSavedMessageFavorites())
          .firstWhere((e) => e.message.id == 'one')
          .tags,
      ['work', 'urgent'],
    );
  });

  testWidgets('failed annotation write retains draft and supports retry', (
    tester,
  ) async {
    final f = _Fixture();
    await f.initialize(tester);
    await f.open(tester);
    await f.edit(tester, 'Edit Remark');
    await tester.enterText(find.byType(TextField), 'Keep this draft');
    f.store.reject = true;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Save failed'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Keep this draft',
    );
    expect(
      (await f.repository.getSavedMessageFavorites())
          .firstWhere((e) => e.message.id == 'one')
          .remark,
      'Follow up tomorrow',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Keep this draft'), findsOneWidget);
  });

  testWidgets('account change before saving cannot write another account', (
    tester,
  ) async {
    final f = _Fixture();
    await f.initialize(tester);
    await f.open(tester);
    await f.edit(tester, 'Edit Remark');
    await tester.enterText(find.byType(TextField), 'Private account A remark');
    f.active = false;
    f.user = '@bob:test';
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Save failed'), findsOneWidget);
    expect(await f.repository.getSavedMessageFavorites(), isEmpty);
    f.user = '@alice:test';
    expect(
      (await f.repository.getSavedMessageFavorites())
          .firstWhere((e) => e.message.id == 'one')
          .remark,
      'Follow up tomorrow',
    );
  });

  testWidgets(
    'late save after account change has no replacement-account success',
    (tester) async {
      final f = _Fixture();
      await f.initialize(tester);
      await f.open(tester);
      await f.edit(tester, 'Edit Remark');
      await tester.enterText(find.byType(TextField), 'Account A update');
      final pending = Completer<void>();
      f.store.hold = pending;
      f.store.started = Completer<void>();
      await tester.tap(find.text('Save'));
      await tester.pump();
      expect(f.store.started!.isCompleted, isTrue);
      await tester.binding.handlePopRoute();
      await tester.pump();
      expect(find.byType(AlertDialog), findsOneWidget);
      f.active = false;
      f.user = '@bob:test';
      pending.complete();
      await tester.pumpAndSettle();
      expect(find.text('Save failed'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(await f.repository.getSavedMessageFavorites(), isEmpty);
    },
  );
}
