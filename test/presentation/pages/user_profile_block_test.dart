import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/pages/profile/user_profile_page.dart';

class _Repository extends Mock implements IContactRepository {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

void main() {
  const peer = '@friend:hs.test';
  late _Repository repository;
  late _Manager manager;
  late _Client client;
  late _Auth auth;
  late ContactBloc bloc;
  late AuthSessionInvalidation generation;
  late bool current;

  setUp(() {
    repository = _Repository();
    manager = _Manager();
    client = _Client();
    auth = _Auth();
    current = true;
    generation = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: null,
      isCurrent: () => current,
      matchesClient: (candidate) => identical(candidate, client),
    );
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('token-A');
    when(() => client.deviceID).thenReturn(null);
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => repository.isUserIgnored(peer)).thenReturn(false);
    when(() => repository.getContactById(peer)).thenAnswer(
      (_) async => const ContactEntity(userId: peer, displayName: 'Friend'),
    );
    when(
      () => repository.watchContacts(),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => repository.watchOnlineStatus(),
    ).thenAnswer((_) => const Stream.empty());
    when(() => repository.getContacts()).thenAnswer((_) async => []);
    when(
      () => repository.getPendingFriendRequests(),
    ).thenAnswer((_) async => []);
    bloc = ContactBloc(repository);
    getIt.pushNewScope();
    getIt.registerSingleton<IContactRepository>(repository);
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    addTearDown(() async {
      await bloc.close();
      await getIt.popScope();
    });
  });

  Future<void> openBlockDialog(
    WidgetTester tester, {
    bool initiallyBlocked = false,
  }) async {
    when(() => repository.isUserIgnored(peer)).thenReturn(initiallyBlocked);
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      BlocProvider<ContactBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: UserProfilePage(userId: peer),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final title = initiallyBlocked
        ? 'Remove from Blacklist'
        : 'Add to Blacklist';
    await tester.ensureVisible(find.text(title));
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  }

  testWidgets('A block error after B login does not appear on live profile', (
    tester,
  ) async {
    final pending = Completer<void>();
    when(() => repository.ignoreUser(peer)).thenAnswer((_) async {
      await pending.future;
      throw StateError('Matrix account changed');
    });
    await openBlockDialog(tester);
    await tester.tap(find.text('Add').last);
    await tester.pump();
    verify(() => repository.ignoreUser(peer)).called(1);
    current = false;
    pending.complete();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Matrix account changed'), findsNothing);
  });

  testWidgets('A block success after B login does not refresh B contacts', (
    tester,
  ) async {
    final pending = Completer<void>();
    when(() => repository.ignoreUser(peer)).thenAnswer((_) => pending.future);
    await openBlockDialog(tester);
    await tester.tap(find.text('Add').last);
    await tester.pump();
    verify(() => repository.ignoreUser(peer)).called(1);
    current = false;
    pending.complete();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    verifyNever(() => repository.getContacts());
  });

  testWidgets('A confirmation cannot submit after B login', (tester) async {
    await openBlockDialog(tester);
    current = false;
    await tester.tap(find.text('Add').last);
    await tester.pumpAndSettle();
    verifyNever(() => repository.ignoreUser(peer));
  });

  testWidgets('A unblock error after B login does not appear on profile', (
    tester,
  ) async {
    final pending = Completer<void>();
    when(() => repository.unignoreUser(peer)).thenAnswer((_) async {
      await pending.future;
      throw StateError('Matrix account changed');
    });
    await openBlockDialog(tester, initiallyBlocked: true);
    await tester.tap(find.text('Remove').last);
    await tester.pump();
    verify(() => repository.unignoreUser(peer)).called(1);
    current = false;
    pending.complete();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Matrix account changed'), findsNothing);
  });

  testWidgets('A unblock success after B login does not refresh B', (
    tester,
  ) async {
    final pending = Completer<void>();
    when(() => repository.unignoreUser(peer)).thenAnswer((_) => pending.future);
    await openBlockDialog(tester, initiallyBlocked: true);
    await tester.tap(find.text('Remove').last);
    await tester.pump();
    verify(() => repository.unignoreUser(peer)).called(1);
    current = false;
    pending.complete();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    verifyNever(() => repository.getContacts());
  });

  testWidgets('A confirmation rejects a replacement A generation', (
    tester,
  ) async {
    await openBlockDialog(tester);
    final returnedA = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: null,
      isCurrent: () => true,
      matchesClient: (candidate) => identical(candidate, client),
    );
    when(() => auth.currentAccountGeneration).thenReturn(returnedA);
    await tester.tap(find.text('Add').last);
    await tester.pumpAndSettle();
    verifyNever(() => repository.ignoreUser(peer));
  });

  testWidgets('same-account block refreshes contacts after success', (
    tester,
  ) async {
    when(() => repository.ignoreUser(peer)).thenAnswer((_) async {});
    await openBlockDialog(tester);
    await tester.tap(find.text('Add').last);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    verify(() => repository.ignoreUser(peer)).called(1);
    verify(() => repository.getContacts()).called(1);
  });

  testWidgets('same-account block failure remains visible', (tester) async {
    when(() => repository.ignoreUser(peer)).thenThrow(StateError('Offline'));
    await openBlockDialog(tester);
    await tester.tap(find.text('Add').last);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Bad state: Offline'), findsOneWidget);
    verifyNever(() => repository.getContacts());
  });
}
