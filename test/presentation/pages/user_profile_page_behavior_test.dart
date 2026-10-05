import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/profile/user_profile_page.dart';

class _ContactsBloc extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _ContactEvent extends Fake implements ContactEvent {}

class _ContactRepository extends Mock implements IContactRepository {}

void main() {
  setUpAll(() => registerFallbackValue(_ContactEvent()));

  setUp(() => getIt.reset());
  tearDown(() => getIt.reset());

  Future<void> open(
    WidgetTester tester, {
    required IContactRepository repository,
  }) async {
    when(() => repository.isUserIgnored('@alice:hs.test')).thenReturn(false);
    final bloc = _ContactsBloc();
    whenListen(
      bloc,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(),
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ContactBloc>.value(
          value: bloc,
          child: const UserProfilePage(userId: '@alice:hs.test'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('loads and renders a remote contact profile', (tester) async {
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    when(() => repository.getContactById('@alice:hs.test')).thenAnswer(
      (_) async => const ContactEntity(
        userId: '@alice:hs.test',
        displayName: 'Alice Example',
        statusMessage: 'Hello there',
        isFriend: true,
        directRoomId: '!alice-room:hs.test',
        tags: ['Work', 'Friends'],
        n42Username: 'alice',
        walletAddress: '0xabc',
        ensName: 'alice.eth',
      ),
    );

    await open(tester, repository: repository);

    expect(find.text('Alice Example'), findsOneWidget);
    expect(find.text('@alice:hs.test'), findsOneWidget);
    expect(find.text('Hello there'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses a local name when the server has no contact record', (
    tester,
  ) async {
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    when(
      () => repository.getContactById('@alice:hs.test'),
    ).thenAnswer((_) async => null);

    await open(tester, repository: repository);

    expect(find.text('alice'), findsOneWidget);
    expect(find.text('@alice:hs.test'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the load error and lets the user retry', (tester) async {
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    var shouldFail = true;
    when(() => repository.getContactById('@alice:hs.test')).thenAnswer((
      _,
    ) async {
      if (shouldFail) throw StateError('offline');
      return const ContactEntity(
        userId: '@alice:hs.test',
        displayName: 'Alice after retry',
      );
    });

    await open(tester, repository: repository);
    expect(find.text('Bad state: offline'), findsOneWidget);
    shouldFail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Alice after retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
