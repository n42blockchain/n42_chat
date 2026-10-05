import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ConversationRepository extends Mock implements IConversationRepository {}

class _ContactRepository extends Mock implements IContactRepository {}

class _GroupRepository extends Mock implements IGroupRepository {}

void main() {
  const roomId = '!coverage-room:test';
  late _ConversationRepository repository;
  late _GroupRepository groupRepository;
  late ContactBloc contactBloc;

  Future<void> pumpPage(
    WidgetTester tester, {
    bool pinned = false,
    VoidCallback? onClearHistory,
    bool canChangeSettings = false,
    void Function(String userId, String displayName, String? avatarUrl)?
    onMemberTap,
    ConversationEntity? conversation,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ContactBloc>.value(
          value: contactBloc,
          child: ChatDetailPage(
            conversation:
                conversation ??
                ConversationEntity(
                  id: roomId,
                  name: 'Coverage room',
                  isPinned: pinned,
                ),
            onClearHistory: onClearHistory,
            canChangeSettings: canChangeSettings,
            onMemberTap: onMemberTap,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() async {
    await GetIt.I.reset();
    SharedPreferences.setMockInitialValues({});
    repository = _ConversationRepository();
    groupRepository = _GroupRepository();
    contactBloc = ContactBloc(_ContactRepository());
    getIt.registerSingleton<IConversationRepository>(repository);
    getIt.registerSingleton<IGroupRepository>(groupRepository);
    when(
      () => repository.getNotificationMode(roomId),
    ).thenAnswer((_) async => ConversationNotificationMode.allMessages);
    when(
      () => repository.getStrongReminder(roomId),
    ).thenAnswer((_) async => false);
    when(() => groupRepository.getGroup(roomId)).thenAnswer((_) async => null);
    when(
      () => groupRepository.getGroupMembers(roomId),
    ).thenAnswer((_) async => []);
    when(
      () => repository.setNotificationMode(
        roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).thenAnswer((_) async {});
  });

  tearDown(() async {
    await contactBloc.close();
    await GetIt.I.reset();
  });

  testWidgets(
    'loads pin and strong-reminder state from the conversation services',
    (tester) async {
      when(
        () => repository.getStrongReminder(roomId),
      ).thenAnswer((_) async => true);

      await pumpPage(tester, pinned: true);

      final switches = tester.widgetList<Switch>(find.byType(Switch));
      expect(switches.map((item) => item.value), [true, true, false]);
      verify(() => repository.getNotificationMode(roomId)).called(1);
      verify(() => repository.getStrongReminder(roomId)).called(1);
    },
  );

  testWidgets('persists a pin change and rolls back the switch on failure', (
    tester,
  ) async {
    await pumpPage(tester);
    when(
      () => repository.setPinned(roomId, true),
    ).thenThrow(StateError('offline'));

    await tester.ensureVisible(find.text('Pin Chat'));
    await tester.tap(find.text('Pin Chat'));
    await tester.pumpAndSettle();

    expect(tester.widgetList<Switch>(find.byType(Switch)).first.value, isFalse);
    verify(() => repository.setPinned(roomId, true)).called(1);
  });

  testWidgets('persists strong-reminder changes', (tester) async {
    await pumpPage(tester);
    when(
      () => repository.setStrongReminder(roomId, true),
    ).thenAnswer((_) async {});

    await tester.ensureVisible(find.text('Strong Reminder'));
    await tester.tap(find.text('Strong Reminder'));
    await tester.pumpAndSettle();

    verify(() => repository.setStrongReminder(roomId, true)).called(1);
    expect(
      tester.widgetList<Switch>(find.byType(Switch)).elementAt(1).value,
      isTrue,
    );
  });

  testWidgets('notification sheet persists only the selected changed mode', (
    tester,
  ) async {
    await pumpPage(tester);

    await tester.ensureVisible(find.text('Message Notifications'));
    await tester.tap(find.text('Message Notifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mentions Only'));
    await tester.pumpAndSettle();

    verify(
      () => repository.setNotificationMode(
        roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).called(1);
    expect(find.text('Mentions Only'), findsOneWidget);
  });

  testWidgets('notification mode rolls back when persistence fails', (
    tester,
  ) async {
    when(
      () => repository.setNotificationMode(
        roomId,
        ConversationNotificationMode.mentionsOnly,
      ),
    ).thenThrow(StateError('offline'));
    await pumpPage(tester);

    await tester.ensureVisible(find.text('Message Notifications'));
    await tester.tap(find.text('Message Notifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mentions Only'));
    await tester.pumpAndSettle();

    expect(find.text('All Messages'), findsOneWidget);
  });

  testWidgets(
    'clearing history requires confirmation and calls the callback once',
    (tester) async {
      var clearCount = 0;
      await pumpPage(tester, onClearHistory: () => clearCount++);

      await tester.ensureVisible(find.text('Clear Chat History'));
      await tester.tap(find.text('Clear Chat History'));
      await tester.pumpAndSettle();
      expect(clearCount, 0);

      await tester.tap(find.widgetWithText(TextButton, 'Clear'));
      await tester.pumpAndSettle();

      expect(clearCount, 1);
      expect(find.text('Chat history cleared'), findsOneWidget);
    },
  );

  testWidgets(
    'group member list shows role badges and filters by name and ID',
    (tester) async {
      when(() => groupRepository.getGroupMembers(roomId)).thenAnswer(
        (_) async => const [
          GroupMember(
            userId: '@alice:hs.test',
            displayName: 'Alice Adams',
            role: GroupRole.owner,
          ),
          GroupMember(
            userId: '@bob:hs.test',
            displayName: 'Bob Brown',
            role: GroupRole.admin,
          ),
          GroupMember(userId: '@charlie:hs.test', displayName: 'Charlie Chen'),
        ],
      );
      await pumpPage(
        tester,
        conversation: const ConversationEntity(
          id: roomId,
          name: 'Coverage group',
          type: ConversationType.group,
        ),
      );

      await tester.tap(find.textContaining('View All Members'));
      await tester.pumpAndSettle();

      expect(find.text('Owner'), findsOneWidget);
      expect(find.text('Admin'), findsOneWidget);
      expect(find.text('Alice Adams'), findsOneWidget);
      expect(find.text('Bob Brown'), findsOneWidget);
      expect(find.text('Charlie Chen'), findsOneWidget);

      final search = find.byType(TextField);
      await tester.enterText(search, 'ALICE');
      await tester.pumpAndSettle();
      expect(find.text('Alice Adams'), findsOneWidget);
      expect(find.text('Bob Brown'), findsNothing);

      await tester.enterText(search, '@BOB:HS.TEST');
      await tester.pumpAndSettle();
      expect(find.text('Bob Brown'), findsOneWidget);
      expect(find.text('Alice Adams'), findsNothing);
    },
  );

  testWidgets('group member list reports empty search results', (tester) async {
    when(() => groupRepository.getGroupMembers(roomId)).thenAnswer(
      (_) async => const [
        GroupMember(userId: '@alice:hs.test', displayName: 'Alice'),
      ],
    );
    await pumpPage(
      tester,
      conversation: const ConversationEntity(
        id: roomId,
        name: 'Coverage group',
        type: ConversationType.group,
      ),
    );

    await tester.tap(find.textContaining('View All Members'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'missing');
    await tester.pumpAndSettle();

    expect(find.text('No matching members found'), findsOneWidget);
    expect(find.text('Alice'), findsNothing);
  });

  testWidgets('selecting a group member forwards the member identity', (
    tester,
  ) async {
    when(() => groupRepository.getGroupMembers(roomId)).thenAnswer(
      (_) async => const [
        GroupMember(userId: '@alice:hs.test', displayName: 'Alice'),
      ],
    );
    String? selectedId;
    String? selectedName;
    String? selectedAvatar;
    await pumpPage(
      tester,
      conversation: const ConversationEntity(
        id: roomId,
        name: 'Coverage group',
        type: ConversationType.group,
      ),
      onMemberTap: (id, name, avatar) {
        selectedId = id;
        selectedName = name;
        selectedAvatar = avatar;
      },
    );

    await tester.tap(find.textContaining('View All Members'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alice'));

    expect(selectedId, '@alice:hs.test');
    expect(selectedName, 'Alice');
    expect(selectedAvatar, isNull);
  });

  testWidgets('editable group announcement saves trimmed text', (tester) async {
    when(() => groupRepository.getGroup(roomId)).thenAnswer(
      (_) async => const GroupEntity(
        roomId: roomId,
        name: 'Coverage group',
        announcement: 'Old announcement',
      ),
    );
    when(
      () => groupRepository.setGroupAnnouncement(roomId, 'New announcement'),
    ).thenAnswer((_) async {});
    await pumpPage(
      tester,
      canChangeSettings: true,
      conversation: const ConversationEntity(
        id: roomId,
        name: 'Coverage group',
        type: ConversationType.group,
      ),
    );

    await tester.ensureVisible(find.text('Group Announcement'));
    await tester.tap(find.text('Group Announcement'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '  New announcement  ');
    await tester.tap(find.widgetWithText(TextButton, 'Save'));
    await tester.pumpAndSettle();

    verify(
      () => groupRepository.setGroupAnnouncement(roomId, 'New announcement'),
    ).called(1);
    expect(find.text('New announcement'), findsOneWidget);
  });

  testWidgets('failed announcement update keeps the current announcement', (
    tester,
  ) async {
    when(() => groupRepository.getGroup(roomId)).thenAnswer(
      (_) async => const GroupEntity(
        roomId: roomId,
        name: 'Coverage group',
        announcement: 'Existing announcement',
      ),
    );
    when(
      () => groupRepository.setGroupAnnouncement(roomId, 'Replacement'),
    ).thenThrow(StateError('offline'));
    await pumpPage(
      tester,
      canChangeSettings: true,
      conversation: const ConversationEntity(
        id: roomId,
        name: 'Coverage group',
        type: ConversationType.group,
      ),
    );

    await tester.ensureVisible(find.text('Group Announcement'));
    await tester.tap(find.text('Group Announcement'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Replacement');
    await tester.tap(find.widgetWithText(TextButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Update failed'), findsOneWidget);
    expect(find.text('Existing announcement'), findsOneWidget);
  });
}
