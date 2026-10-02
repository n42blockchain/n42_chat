import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_event.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_state.dart';
import 'package:n42_chat/src/presentation/pages/contact/contact_detail_page.dart';
import 'package:n42_chat/src/presentation/pages/contact/contact_list_page.dart';

class _ContactBlocMock extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _GroupBlocMock extends MockBloc<GroupEvent, GroupState>
    implements GroupBloc {}

class _ContactRepositoryMock extends Mock implements IContactRepository {}

class _MessageRepositoryMock extends Mock implements IMessageRepository {}

class _FakeContactEvent extends Fake implements ContactEvent {}

class _FakeGroupEvent extends Fake implements GroupEvent {}

const _alice = ContactEntity(
  userId: '@alice:server.test',
  displayName: 'Alice',
  isFriend: true,
);
const _bob = ContactEntity(
  userId: '@bob:server.test',
  displayName: 'Bob',
  isFriend: true,
);
const _eve = ContactEntity(userId: '@eve:server.test', displayName: 'Eve');

ContactState _loadedContacts() => const ContactState(
  status: ContactStatus.loaded,
  contacts: [_alice],
  groupedContacts: {
    'A': [_alice],
  },
  indexLetters: ['A'],
);

void main() {
  late _ContactBlocMock contacts;
  late _GroupBlocMock groups;
  late _ContactRepositoryMock contactRepository;
  late StreamController<ContactState> contactStateChanges;
  late StreamController<GroupState> groupStateChanges;
  late ContactState currentContactState;
  late GroupState currentGroupState;

  setUpAll(() {
    registerFallbackValue(_FakeContactEvent());
    registerFallbackValue(_FakeGroupEvent());
  });

  setUp(() async {
    await getIt.reset();
    contactStateChanges = StreamController<ContactState>.broadcast();
    groupStateChanges = StreamController<GroupState>.broadcast();
    currentContactState = _loadedContacts();
    currentGroupState = const GroupState();
    contacts = _ContactBlocMock();
    groups = _GroupBlocMock();
    contactRepository = _ContactRepositoryMock();

    when(() => contacts.state).thenAnswer((_) => currentContactState);
    when(() => contacts.stream).thenAnswer((_) => contactStateChanges.stream);
    when(() => contacts.add(any())).thenReturn(null);
    when(() => groups.state).thenAnswer((_) => currentGroupState);
    when(() => groups.stream).thenAnswer((_) => groupStateChanges.stream);
    when(() => groups.add(any())).thenReturn(null);
    when(() => groups.close()).thenAnswer((_) async {});

    getIt.registerSingleton<GroupBloc>(groups);
    getIt.registerSingleton<IContactRepository>(contactRepository);
  });

  tearDown(() async {
    await contactStateChanges.close();
    await groupStateChanges.close();
    await getIt.reset();
  });

  Widget app({bool showAppBar = true}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: BlocProvider<ContactBloc>.value(
        value: contacts,
        child: ContactListPage(showAppBar: showAppBar),
      ),
    );
  }

  Future<void> pumpPage(WidgetTester tester, {bool showAppBar = true}) async {
    await tester.pumpWidget(app(showAppBar: showAppBar));
    await tester.pumpAndSettle();
  }

  Future<void> revealAlice(WidgetTester tester) async {
    await tester.scrollUntilVisible(
      find.text('Alice'),
      250,
      scrollable: find
          .descendant(
            of: find.byType(CustomScrollView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
  }

  testWidgets(
    'search shows local and global results and clears back to contacts',
    (tester) async {
      await pumpPage(tester);
      verify(() => contacts.add(const LoadContacts())).called(1);
      verify(() => groups.add(const LoadGroups())).called(1);

      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'Bob');
      verify(() => contacts.add(const SearchContacts('Bob'))).called(1);

      currentContactState = const ContactState(
        status: ContactStatus.loaded,
        contacts: [_alice],
        searchQuery: 'Bob',
        filteredContacts: [_bob],
        searchResults: [_eve],
      );
      contactStateChanges.add(currentContactState);
      await tester.pumpAndSettle();

      expect(find.text('Bob'), findsNWidgets(2));
      expect(find.text('Eve'), findsOneWidget);
      expect(find.text('Contacts'), findsNWidgets(2));
      expect(find.text('Search results'), findsOneWidget);

      await tester.enterText(searchField, '');
      verify(() => contacts.add(const ClearSearch())).called(1);
      currentContactState = _loadedContacts();
      contactStateChanges.add(currentContactState);
      await tester.pumpAndSettle();
      await revealAlice(tester);
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Search Results'), findsNothing);
    },
  );

  testWidgets('load failure offers a retry that reloads contacts', (
    tester,
  ) async {
    currentContactState = const ContactState(
      status: ContactStatus.error,
      errorMessage: 'Membership unavailable',
    );
    await pumpPage(tester);

    expect(find.text('Failed to load'), findsOneWidget);
    expect(find.text('Membership unavailable'), findsOneWidget);
    await tester.tap(find.text('Retry'));

    verify(() => contacts.add(const LoadContacts())).called(2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('submitting an add-contact ID starts that chat request', (
    tester,
  ) async {
    await pumpPage(tester);
    await tester.tap(find.byIcon(Icons.person_add_outlined));
    await tester.pumpAndSettle();

    final dialogInput = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(dialogInput, '@new:server.test');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    verify(() => contacts.add(const StartChat('@new:server.test'))).called(1);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('saving a contact remark trims the value and updates its owner', (
    tester,
  ) async {
    await pumpPage(tester);
    await revealAlice(tester);
    await tester.longPress(find.text('Alice'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set remark'));
    await tester.pumpAndSettle();

    final remarkInput = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(remarkInput, '  Ally  ');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    verify(
      () => contacts.add(const SetContactRemark('@alice:server.test', 'Ally')),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact actions remain scrollable on a short viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await pumpPage(tester);
    await revealAlice(tester);
    await tester.longPress(find.text('Alice'));
    await tester.pumpAndSettle();

    final sheet = find.byType(BottomSheet);
    final sheetScrollable = find.descendant(
      of: sheet,
      matching: find.byType(Scrollable),
    );
    expect(sheetScrollable, findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Share contact'),
      80,
      scrollable: sheetScrollable,
    );
    expect(find.text('Share contact'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed chat creation is shown from the contact profile', (
    tester,
  ) async {
    when(
      () => contactRepository.startDirectChat(_alice.userId),
    ).thenThrow(StateError('offline'));
    await pumpPage(tester);
    await revealAlice(tester);
    await tester.tap(find.text('Alice'));
    await tester.pumpAndSettle();

    expect(find.byType(ContactDetailPage), findsOneWidget);
    await tester.tap(find.text('Message'));
    await tester.pumpAndSettle();

    expect(find.textContaining('offline'), findsOneWidget);
    expect(find.byType(ContactDetailPage), findsOneWidget);
    verify(() => contactRepository.startDirectChat(_alice.userId)).called(1);
  });

  testWidgets('recommending a contact sends its card to the selected friend', (
    tester,
  ) async {
    final messageRepository = _MessageRepositoryMock();
    when(
      () => contactRepository.getContacts(),
    ).thenAnswer((_) async => const [_alice, _bob]);
    when(
      () => contactRepository.startDirectChat(_bob.userId),
    ).thenAnswer((_) async => '!direct:bob:server.test');
    when(
      () => messageRepository.sendContactCard(
        '!direct:bob:server.test',
        userId: _alice.userId,
        displayName: _alice.displayName,
        avatarUrl: null,
      ),
    ).thenAnswer((_) async => r'$event:card');
    getIt.registerSingleton<IMessageRepository>(messageRepository);

    await pumpPage(tester);
    await revealAlice(tester);
    await tester.longPress(find.text('Alice'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Share contact'));
    await tester.pumpAndSettle();

    expect(find.text('Select a friend to recommend to'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Bob'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Alice'), findsNothing);
    await tester.tap(find.widgetWithText(ListTile, 'Bob'));
    await tester.pumpAndSettle();

    verify(() => contactRepository.startDirectChat(_bob.userId)).called(1);
    verify(
      () => messageRepository.sendContactCard(
        '!direct:bob:server.test',
        userId: _alice.userId,
        displayName: 'Alice',
        avatarUrl: null,
      ),
    ).called(1);
    expect(find.text("Recommended Alice's card to Bob"), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group invite actions dispatch accept and reject events', (
    tester,
  ) async {
    const invite = GroupEntity(roomId: '!invite:server.test', name: 'Invited');
    currentGroupState = const GroupState(
      status: GroupStatus.loaded,
      invites: [invite],
    );
    await pumpPage(tester);
    await tester.tap(find.text('Group Chat'));
    await tester.pumpAndSettle();

    expect(find.text('Invited'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Accept'));
    verify(
      () => groups.add(const AcceptGroupInvite('!invite:server.test')),
    ).called(1);
    await tester.tap(find.widgetWithText(TextButton, 'Reject'));

    verify(
      () => groups.add(const RejectGroupInvite('!invite:server.test')),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group options confirm leaving members and dissolving owners', (
    tester,
  ) async {
    const memberGroup = GroupEntity(
      roomId: '!member:server.test',
      name: 'Member Group',
      myRole: GroupRole.member,
    );
    const ownedGroup = GroupEntity(
      roomId: '!owner:server.test',
      name: 'Owned Group',
      myRole: GroupRole.owner,
    );
    currentGroupState = const GroupState(
      status: GroupStatus.loaded,
      groups: [memberGroup, ownedGroup],
    );
    await pumpPage(tester);
    await tester.tap(find.text('Group Chat'));
    await tester.pumpAndSettle();

    await tester.longPress(find.text('Member Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();
    verify(() => groups.add(const LeaveGroup('!member:server.test'))).called(1);

    await tester.longPress(find.text('Owned Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dissolve Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dissolve'));
    await tester.pumpAndSettle();
    verify(() => groups.add(const DeleteGroup('!owner:server.test'))).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('embedded contacts omit the app bar while retaining search', (
    tester,
  ) async {
    await pumpPage(tester, showAppBar: false);

    expect(find.byType(AppBar), findsNothing);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
  });
}
