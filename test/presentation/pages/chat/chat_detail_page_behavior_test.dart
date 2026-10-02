import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ConversationRepositoryMock extends Mock
    implements IConversationRepository {}

class _GroupRepositoryMock extends Mock implements IGroupRepository {}

class _ContactBlocMock extends Mock implements ContactBloc {}

const _roomId = '!room:server.test';

void main() {
  late _ConversationRepositoryMock conversationRepository;
  late _ContactBlocMock contactBloc;

  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});

    conversationRepository = _ConversationRepositoryMock();
    contactBloc = _ContactBlocMock();
    when(() => contactBloc.state).thenReturn(const ContactState());
    when(
      () => contactBloc.stream,
    ).thenAnswer((_) => const Stream<ContactState>.empty());
    when(
      () => conversationRepository.getNotificationMode(_roomId),
    ).thenAnswer((_) async => ConversationNotificationMode.allMessages);
    when(
      () => conversationRepository.getStrongReminder(_roomId),
    ).thenAnswer((_) async => false);
    getIt.registerSingleton<IConversationRepository>(conversationRepository);
  });

  tearDown(() async {
    await getIt.reset();
  });

  Widget buildPage(
    ConversationEntity conversation, {
    bool canChangeSettings = false,
  }) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: BlocProvider<ContactBloc>.value(
        value: contactBloc,
        child: ChatDetailPage(
          conversation: conversation,
          canChangeSettings: canChangeSettings,
        ),
      ),
    );
  }

  testWidgets('failed notification update restores the displayed mode', (
    tester,
  ) async {
    when(
      () => conversationRepository.setNotificationMode(
        _roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).thenThrow(StateError('storage unavailable'));

    await tester.pumpWidget(
      buildPage(
        const ConversationEntity(
          id: _roomId,
          name: 'Sam',
          type: ConversationType.direct,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final notificationItem = find.text('Message notifications');
    await tester.ensureVisible(notificationItem);
    await tester.tap(notificationItem);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mentions Only'));
    await tester.pumpAndSettle();

    expect(find.text('All Messages'), findsOneWidget);
    verify(
      () => conversationRepository.setNotificationMode(
        _roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('notification selection persists the chosen room mode', (
    tester,
  ) async {
    when(
      () => conversationRepository.setNotificationMode(
        _roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(
      buildPage(
        const ConversationEntity(
          id: _roomId,
          name: 'Sam',
          type: ConversationType.direct,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final notificationItem = find.text('Message notifications');
    await tester.ensureVisible(notificationItem);
    await tester.tap(notificationItem);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mentions Only'));
    await tester.pumpAndSettle();

    expect(find.text('Mentions Only'), findsOneWidget);
    verify(
      () => conversationRepository.setNotificationMode(
        _roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).called(1);
  });

  testWidgets('pin and strong reminder switches save their new values', (
    tester,
  ) async {
    when(
      () => conversationRepository.setPinned(_roomId, true),
    ).thenAnswer((_) async {});
    when(
      () => conversationRepository.setStrongReminder(_roomId, true),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(
      buildPage(
        const ConversationEntity(
          id: _roomId,
          name: 'Sam',
          type: ConversationType.direct,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final pinLabel = find.text('Pin Chat');
    await tester.ensureVisible(pinLabel);
    await tester.tap(pinLabel);
    await tester.pumpAndSettle();

    final reminderLabel = find.text('Strong Reminder');
    await tester.ensureVisible(reminderLabel);
    await tester.tap(reminderLabel);
    await tester.pumpAndSettle();

    verify(() => conversationRepository.setPinned(_roomId, true)).called(1);
    verify(
      () => conversationRepository.setStrongReminder(_roomId, true),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group name edit trims input and saves through the repository', (
    tester,
  ) async {
    final groupRepository = _GroupRepositoryMock();
    when(
      () => groupRepository.setGroupName(_roomId, 'Project Team'),
    ).thenAnswer((_) async {});
    getIt.registerSingleton<IGroupRepository>(groupRepository);

    await tester.pumpWidget(
      buildPage(
        const ConversationEntity(
          id: _roomId,
          name: 'Team',
          type: ConversationType.group,
        ),
        canChangeSettings: true,
      ),
    );
    await tester.pumpAndSettle();

    final groupNameItem = find.text('Group Name');
    await tester.ensureVisible(groupNameItem);
    await tester.tap(groupNameItem);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '  Project Team  ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Project Team'), findsOneWidget);
    verify(
      () => groupRepository.setGroupName(_roomId, 'Project Team'),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group name edit reports when the user lacks permission', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildPage(
        const ConversationEntity(
          id: _roomId,
          name: 'Team',
          type: ConversationType.group,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final groupNameItem = find.text('Group Name');
    await tester.ensureVisible(groupNameItem);
    await tester.tap(groupNameItem);
    await tester.pumpAndSettle();

    expect(find.text('You do not have permission to modify'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'group member actions call their callbacks with the selected ID',
    (tester) async {
      var addMemberCalls = 0;
      String? removedMemberId;
      String? tappedMemberId;
      String? tappedMemberName;
      String? tappedAvatarUrl;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: BlocProvider<ContactBloc>.value(
            value: contactBloc,
            child: ChatDetailPage(
              conversation: const ConversationEntity(
                id: _roomId,
                name: 'Team',
                type: ConversationType.group,
                memberAvatarUrls: [null],
                memberNames: ['Alice'],
                memberIds: ['@alice:server.test'],
              ),
              canKickMembers: true,
              onAddMember: () => addMemberCalls++,
              onRemoveMember: (userId) => removedMemberId = userId,
              onMemberTap: (userId, displayName, avatarUrl) {
                tappedMemberId = userId;
                tappedMemberName = displayName;
                tappedAvatarUrl = avatarUrl;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Alice'));
      expect(tappedMemberId, '@alice:server.test');
      expect(tappedMemberName, 'Alice');
      expect(tappedAvatarUrl, isNull);

      await tester.tap(find.byIcon(Icons.add));
      expect(addMemberCalls, 1);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Alice'));
      await tester.pumpAndSettle();

      expect(removedMemberId, '@alice:server.test');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('group member list loads roles and filters by member name', (
    tester,
  ) async {
    final groupRepository = _GroupRepositoryMock();
    when(() => groupRepository.getGroupMembers(_roomId)).thenAnswer(
      (_) async => const [
        GroupMember(
          userId: '@alice:server.test',
          displayName: 'Alice',
          role: GroupRole.owner,
        ),
        GroupMember(
          userId: '@lee:server.test',
          displayName: 'Lee',
          role: GroupRole.admin,
        ),
        GroupMember(userId: '@bob:server.test', displayName: 'Bob'),
      ],
    );
    getIt.registerSingleton<IGroupRepository>(groupRepository);
    String? selectedMemberId;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ContactBloc>.value(
          value: contactBloc,
          child: ChatDetailPage(
            conversation: const ConversationEntity(
              id: _roomId,
              name: 'Team',
              type: ConversationType.group,
            ),
            onMemberTap: (userId, _, _) => selectedMemberId = userId,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final membersLink = find.textContaining('View all members');
    await tester.ensureVisible(membersLink);
    await tester.tap(membersLink);
    await tester.pumpAndSettle();

    expect(find.text('Members (3)'), findsOneWidget);
    expect(find.text('Owner'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Bob');
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Bob'), findsOneWidget);
    expect(find.text('Alice'), findsNothing);
    expect(find.text('Lee'), findsNothing);
    await tester.tap(find.widgetWithText(ListTile, 'Bob'));

    expect(selectedMemberId, '@bob:server.test');
    verify(() => groupRepository.getGroupMembers(_roomId)).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling clear keeps history and confirming invokes callback', (
    tester,
  ) async {
    var clearCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ContactBloc>.value(
          value: contactBloc,
          child: ChatDetailPage(
            conversation: const ConversationEntity(id: _roomId, name: 'Sam'),
            onClearHistory: () => clearCalls++,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final clearItem = find.text('Clear Chat History');
    await tester.ensureVisible(clearItem);
    await tester.tap(clearItem);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(clearCalls, 0);

    await tester.ensureVisible(clearItem);
    await tester.tap(clearItem);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    expect(clearCalls, 1);
    expect(find.text('Chat history cleared'), findsOneWidget);
  });

  testWidgets('report submission closes the form and confirms submission', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildPage(const ConversationEntity(id: _roomId, name: 'Sam')),
    );
    await tester.pumpAndSettle();

    final reportItem = find.text('Report');
    await tester.ensureVisible(reportItem);
    await tester.tap(reportItem);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(RadioListTile<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text('Report submitted'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('report requires a reason before submission', (tester) async {
    await tester.pumpWidget(
      buildPage(const ConversationEntity(id: _roomId, name: 'Sam')),
    );
    await tester.pumpAndSettle();

    final reportItem = find.text('Report');
    await tester.ensureVisible(reportItem);
    await tester.tap(reportItem);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(find.text('Please select a reason'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
