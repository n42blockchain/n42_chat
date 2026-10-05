import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_event.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_state.dart';
import 'package:n42_chat/src/presentation/pages/contact/contact_list_page.dart';

class _Contacts extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _ContactRepository extends Mock implements IContactRepository {}

class _ContactEvent extends Fake implements ContactEvent {}

class _Groups extends MockBloc<GroupEvent, GroupState> implements GroupBloc {}

Widget _buildPage(ContactBloc contacts, GroupBloc groups) => MultiBlocProvider(
  providers: [
    BlocProvider<ContactBloc>.value(value: contacts),
    BlocProvider<GroupBloc>.value(value: groups),
  ],
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    home: ContactListPage(groupBloc: groups),
  ),
);

void main() {
  late _Contacts contacts;
  late _Groups groups;

  setUpAll(() => registerFallbackValue(_ContactEvent()));

  setUp(() {
    contacts = _Contacts();
    groups = _Groups();
    whenListen(
      groups,
      const Stream<GroupState>.empty(),
      initialState: const GroupState.initial(),
    );
  });

  testWidgets('shows loading while the contact snapshot is being fetched', (
    tester,
  ) async {
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(status: ContactStatus.loading),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(() => contacts.add(const LoadContacts())).called(1);
  });

  testWidgets('shows a retry action when contact loading fails', (
    tester,
  ) async {
    const failed = ContactState(
      status: ContactStatus.error,
      errorMessage: 'offline',
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: failed,
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;

    expect(find.text(l10n.commonLoadFailed), findsOneWidget);
    expect(find.text('offline'), findsOneWidget);
    await tester.tap(find.text(l10n.commonRetry));

    verify(() => contacts.add(const LoadContacts())).called(2);
  });

  testWidgets('renders local and global contact results for a search', (
    tester,
  ) async {
    const local = ContactEntity(
      userId: '@alice:example.org',
      displayName: 'Alice Local',
      isFriend: true,
    );
    const global = ContactEntity(
      userId: '@alice2:example.org',
      displayName: 'Alice Directory',
    );
    const state = ContactState(
      status: ContactStatus.loaded,
      searchQuery: 'alice',
      filteredContacts: [local],
      searchResults: [global],
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: state,
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;

    expect(find.text(l10n.commonContacts), findsNWidgets(2));
    expect(find.text('Alice Local'), findsOneWidget);
    expect(find.text(l10n.contactSearchResults), findsOneWidget);
    expect(find.text('Alice Directory'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('search field dispatches queries and clears them when emptied', (
    tester,
  ) async {
    final events = <ContactEvent>[];
    when(() => contacts.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ContactEvent);
    });
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(status: ContactStatus.loaded),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final search = find.byType(TextField).first;
    expect(events, [const LoadContacts()]);

    await tester.enterText(search, '  bob  ');
    await tester.pump();
    expect(events, [const LoadContacts(), const SearchContacts('  bob  ')]);

    await tester.enterText(search, '');
    await tester.pump();
    expect(events, [
      const LoadContacts(),
      const SearchContacts('  bob  '),
      const ClearSearch(),
    ]);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'add-contact dialog ignores empty input and dispatches a user ID',
    (tester) async {
      whenListen(
        contacts,
        const Stream<ContactState>.empty(),
        initialState: const ContactState(status: ContactStatus.loaded),
      );

      await tester.pumpWidget(_buildPage(contacts, groups));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_add_outlined));
      await tester.pumpAndSettle();
      final input = find.byType(TextField).last;

      await tester.enterText(input, '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(find.text('Add Contact'), findsOneWidget);
      verifyNever(() => contacts.add(const StartChat('')));

      await tester.enterText(input, '@bob:example.org');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      verify(() => contacts.add(const StartChat('@bob:example.org'))).called(1);
      expect(find.text('Add Contact'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('empty search offers to clear the query', (tester) async {
    const state = ContactState(
      status: ContactStatus.loaded,
      searchQuery: 'no-match',
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: state,
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;

    expect(find.text(l10n.contactNotFound), findsOneWidget);
    await tester.tap(find.text(l10n.commonClear));

    verify(() => contacts.add(const ClearSearch())).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('setting a contact remark trims and dispatches the new name', (
    tester,
  ) async {
    const alice = ContactEntity(
      userId: '@alice:example.org',
      displayName: 'Alice',
      isFriend: true,
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        contacts: [alice],
        groupedContacts: {
          'A': [alice],
        },
        indexLetters: ['A'],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Alice').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonSetRemark));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '  Best friend  ');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    verify(
      () => contacts.add(
        const SetContactRemark('@alice:example.org', 'Best friend'),
      ),
    ).called(1);
    expect(find.text(l10n.commonSetRemark), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group invites and owner actions dispatch the selected events', (
    tester,
  ) async {
    const invite = GroupEntity(roomId: '!invite:hs', name: 'Invited Group');
    const ownedGroup = GroupEntity(
      roomId: '!owned:hs',
      name: 'My Group',
      memberCount: 4,
      myRole: GroupRole.owner,
    );
    const joinedGroup = GroupEntity(
      roomId: '!joined:hs',
      name: 'Joined Group',
      memberCount: 3,
    );
    whenListen(
      groups,
      const Stream<GroupState>.empty(),
      initialState: const GroupState(
        status: GroupStatus.loaded,
        groups: [ownedGroup, joinedGroup],
        invites: [invite],
      ),
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(status: ContactStatus.loaded),
    );
    if (getIt.isRegistered<GroupBloc>()) {
      await getIt.unregister<GroupBloc>();
    }
    getIt.registerSingleton<GroupBloc>(groups);
    addTearDown(() async => getIt.unregister<GroupBloc>());

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.tap(find.text(l10n.commonGroupChat));
    await tester.pumpAndSettle();

    expect(find.text(l10n.commonGroupInvites), findsOneWidget);
    expect(find.text('Invited Group'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, l10n.commonAccept));
    await tester.pump();
    verify(() => groups.add(const AcceptGroupInvite('!invite:hs'))).called(1);
    await tester.tap(find.widgetWithText(TextButton, l10n.commonReject));
    await tester.pump();
    verify(() => groups.add(const RejectGroupInvite('!invite:hs'))).called(1);

    await tester.longPress(find.text('My Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonDissolveGroup));
    await tester.pumpAndSettle();
    expect(
      find.text(l10n.commonConfirmDissolveGroup('My Group')),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(TextButton, l10n.commonDissolve));
    await tester.pumpAndSettle();
    verify(() => groups.add(const DeleteGroup('!owned:hs'))).called(1);

    await tester.longPress(find.text('Joined Group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonLeaveGroup));
    await tester.pumpAndSettle();
    expect(
      find.text(l10n.commonConfirmLeaveGroup('Joined Group')),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(TextButton, l10n.commonLeave));
    await tester.pumpAndSettle();
    verify(() => groups.add(const LeaveGroup('!joined:hs'))).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('groups contacts and counts incoming friend requests only', (
    tester,
  ) async {
    const starred = ContactEntity(
      userId: '@starred:example.org',
      displayName: 'Starred Friend',
      isStarred: true,
    );
    const alice = ContactEntity(
      userId: '@alice:example.org',
      displayName: 'Alice',
      isFriend: true,
    );
    const state = ContactState(
      status: ContactStatus.loaded,
      contacts: [starred, alice],
      friendRequests: [
        FriendRequest(id: 'incoming', userId: '@new:hs', userName: 'New'),
        FriendRequest(
          id: 'outgoing',
          userId: '@sent:hs',
          userName: 'Sent',
          isOutgoing: true,
        ),
      ],
      groupedContacts: {
        '☆': [starred],
        'A': [alice],
      },
      indexLetters: ['☆', 'A'],
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: state,
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;

    expect(find.text('1'), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text(l10n.contactStarredFriends), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.text('Alice'), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.text(l10n.contactCount(2)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('accepting a friend request hides it and refreshes contacts', (
    tester,
  ) async {
    const request = FriendRequest(
      id: 'incoming-1',
      userId: '@new:example.org',
      userName: 'New Friend',
    );
    const outgoing = FriendRequest(
      id: 'outgoing-1',
      userId: '@pending:example.org',
      userName: 'Pending Friend',
      isOutgoing: true,
    );
    final repository = _ContactRepository();
    if (getIt.isRegistered<IContactRepository>()) {
      await getIt.unregister<IContactRepository>();
    }
    when(
      () => repository.acceptFriendRequest('incoming-1'),
    ).thenAnswer((_) async {});
    getIt.registerSingleton<IContactRepository>(repository);
    addTearDown(() async => getIt.unregister<IContactRepository>());
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        friendRequests: [request, outgoing],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.tap(find.text(l10n.contactNewFriends));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, l10n.commonAccept));
    await tester.pumpAndSettle();

    verify(() => repository.acceptFriendRequest('incoming-1')).called(1);
    verify(() => contacts.add(const RefreshContacts())).called(1);
    expect(
      find.text(l10n.contactAcceptedFriendRequest('New Friend')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('friend_request_incoming-1')),
      findsNothing,
    );
    expect(find.text(l10n.contactRequestsOutgoing), findsOneWidget);
    expect(find.text(l10n.contactRequestPending), findsOneWidget);
    expect(find.text(l10n.contactRequestHint), findsOneWidget);
    expect(
      find.byKey(const ValueKey('friend_request_outgoing-1')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('rejecting a friend request hides it and confirms the result', (
    tester,
  ) async {
    const request = FriendRequest(
      id: 'reject-1',
      userId: '@reject:example.org',
      userName: 'Rejected Friend',
    );
    final repository = _ContactRepository();
    if (getIt.isRegistered<IContactRepository>()) {
      await getIt.unregister<IContactRepository>();
    }
    when(
      () => repository.rejectFriendRequest('reject-1'),
    ).thenAnswer((_) async {});
    getIt.registerSingleton<IContactRepository>(repository);
    addTearDown(() async => getIt.unregister<IContactRepository>());
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        friendRequests: [request],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.tap(find.text(l10n.contactNewFriends));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, l10n.commonReject));
    await tester.pumpAndSettle();

    verify(() => repository.rejectFriendRequest('reject-1')).called(1);
    verify(() => contacts.add(const RefreshContacts())).called(1);
    expect(
      find.text(l10n.contactRejectedFriendRequest('Rejected Friend')),
      findsOneWidget,
    );
    expect(find.text(l10n.contactNoFriendRequests), findsOneWidget);
    expect(find.byKey(const ValueKey('friend_request_reject-1')), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed friend request rejection keeps the request visible', (
    tester,
  ) async {
    const request = FriendRequest(
      id: 'incoming-2',
      userId: '@retry:example.org',
      userName: 'Retry Friend',
    );
    final repository = _ContactRepository();
    if (getIt.isRegistered<IContactRepository>()) {
      await getIt.unregister<IContactRepository>();
    }
    when(
      () => repository.rejectFriendRequest('incoming-2'),
    ).thenThrow(StateError('offline'));
    when(
      () => repository.getContactById('@retry:example.org'),
    ).thenAnswer((_) async => null);
    when(
      () => repository.getPendingFriendRequests(),
    ).thenAnswer((_) async => [request]);
    getIt.registerSingleton<IContactRepository>(repository);
    addTearDown(() async => getIt.unregister<IContactRepository>());
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        friendRequests: [request],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.tap(find.text(l10n.contactNewFriends));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, l10n.commonReject));
    await tester.pumpAndSettle();

    expect(find.text('Retry Friend'), findsOneWidget);
    expect(find.text(l10n.commonSaveFailed), findsOneWidget);
    verifyNever(() => contacts.add(const RefreshContacts()));

    await tester.tap(find.text('Retry Friend'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.contactN42Id('retry')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('friend request page shows its empty state', (tester) async {
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(status: ContactStatus.loaded),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.tap(find.text(l10n.contactNewFriends));
    await tester.pumpAndSettle();

    expect(find.text(l10n.contactNoFriendRequests), findsOneWidget);
    expect(find.byIcon(Icons.person_add_disabled_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact menu reports unsupported home-screen action', (
    tester,
  ) async {
    const alice = ContactEntity(
      userId: '@alice:example.org',
      displayName: 'Alice',
      isFriend: true,
    );
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        contacts: [alice],
        groupedContacts: {
          'A': [alice],
        },
        indexLetters: ['A'],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Alice').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.contactAddToHomeScreen));
    await tester.pumpAndSettle();

    expect(
      find.text(l10n.commonFeatureComingSoon(l10n.contactAddToHomeScreen)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed direct chat hides loading and reports the error', (
    tester,
  ) async {
    const alice = ContactEntity(
      userId: '@alice:example.org',
      displayName: 'Alice',
      isFriend: true,
    );
    final repository = _ContactRepository();
    if (getIt.isRegistered<IContactRepository>()) {
      await getIt.unregister<IContactRepository>();
    }
    when(
      () => repository.startDirectChat('@alice:example.org'),
    ).thenThrow(StateError('offline'));
    getIt.registerSingleton<IContactRepository>(repository);
    addTearDown(() async => getIt.unregister<IContactRepository>());
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(
        status: ContactStatus.loaded,
        contacts: [alice],
        groupedContacts: {
          'A': [alice],
        },
        indexLetters: ['A'],
      ),
    );

    await tester.pumpWidget(_buildPage(contacts, groups));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(ContactListPage)))!;
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Alice').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonSendMessage));
    await tester.pumpAndSettle();

    verify(() => repository.startDirectChat('@alice:example.org')).called(1);
    expect(
      find.text(l10n.contactOpenChatFailed('Bad state: offline')),
      findsOneWidget,
    );
    expect(find.text(l10n.contactOpeningChat), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
