import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _Event extends Fake implements ChatEvent {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _GroupRepository extends Mock implements IGroupRepository {}

class _Contacts extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _ReportAccount {
  _ReportAccount() {
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('token-A');
    when(() => client.deviceID).thenReturn(null);
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.currentUser).thenReturn(null);
    final groups = _GroupRepository();
    when(() => groups.getGroupMembers(any())).thenAnswer((_) async => []);
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    getIt.registerSingleton<IGroupRepository>(groups);
  }

  final manager = _Manager();
  final client = _Client();
  final auth = _Auth();
  bool active = true;
  late final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: null,
    isCurrent: () => active,
    matchesClient: (candidate) => identical(candidate, client),
  );
}

void main() {
  const eventId = r'$actual-event';
  const roomId = '!actual-room:hs.test';

  setUpAll(() => registerFallbackValue(_Event()));

  _Contacts contacts() {
    final bloc = _Contacts();
    whenListen(
      bloc,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(),
    );
    return bloc;
  }

  for (final type in [ConversationType.direct, ConversationType.group]) {
    testWidgets('$type menu reports actual event ID and selected reason', (
      tester,
    ) async {
      await getIt.reset();
      SharedPreferences.setMockInitialValues({});
      getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
      final account = _ReportAccount();
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox());
        await getIt.reset();
      });
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final chat = _Chat();
      final contactBloc = contacts();
      when(() => chat.state).thenReturn(
        ChatState(
          roomId: roomId,
          messages: [
            MessageEntity(
              id: eventId,
              roomId: roomId,
              senderId: '@bob:hs.test',
              senderName: 'Bob',
              content: 'Message text stays local',
              type: MessageType.text,
              timestamp: DateTime(2026),
              isFromMe: false,
            ),
          ],
          canSendMessages: false,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ChatBloc>.value(value: chat),
              BlocProvider<ContactBloc>.value(value: contactBloc),
            ],
            child: ChatPage(
              conversation: ConversationEntity(
                id: roomId,
                name: 'Conversation',
                type: type,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Message text stays local'));
      await tester.longPress(find.text('Message text stays local'));
      await tester.pumpAndSettle();
      final more = find.byKey(const ValueKey('message-action-more'));
      if (more.evaluate().isNotEmpty) {
        await tester.tap(more);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.byKey(const ValueKey('message-action-report')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      await tester.pump();
      await tester.tap(find.text('Confirm').last);
      await tester.pump();
      verify(() => chat.add(const InitializeChat(roomId))).called(1);
      final reports = verify(
        () => chat.add(captureAny()),
      ).captured.whereType<ReportMessage>().toList();
      expect(reports, hasLength(1));
      expect(reports.single.messageId, eventId);
      expect(reports.single.reason, 'Spam');
      expect(reports.single.roomId, roomId);
      expect(reports.single.origin?.isCurrent, isTrue);
      expect(account.active, isTrue);
    });
  }

  testWidgets('dialog opened by A rejects replacement A generation', (
    tester,
  ) async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    final account = _ReportAccount();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      await getIt.reset();
    });
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final chat = _Chat();
    final contactBloc = contacts();
    when(() => chat.state).thenReturn(
      ChatState(
        roomId: roomId,
        messages: [
          MessageEntity(
            id: eventId,
            roomId: roomId,
            senderId: '@bob:hs.test',
            senderName: 'Bob',
            content: 'Report after switch',
            type: MessageType.text,
            timestamp: DateTime(2026),
            isFromMe: false,
          ),
        ],
        canSendMessages: false,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ChatBloc>.value(value: chat),
            BlocProvider<ContactBloc>.value(value: contactBloc),
          ],
          child: const ChatPage(
            conversation: ConversationEntity(id: roomId, name: 'Bob'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Report after switch'));
    await tester.longPress(find.text('Report after switch'));
    await tester.pumpAndSettle();
    final more = find.byKey(const ValueKey('message-action-more'));
    if (more.evaluate().isNotEmpty) {
      await tester.tap(more);
      await tester.pumpAndSettle();
    }
    await tester.tap(find.byKey(const ValueKey('message-action-report')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spam'));
    await tester.pump();
    account.active = false;
    final replacement = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: null,
      isCurrent: () => true,
      matchesClient: (candidate) => identical(candidate, account.client),
    );
    when(() => account.auth.currentAccountGeneration).thenReturn(replacement);
    await tester.tap(find.text('Confirm').last);
    await tester.pump();
    verifyNever(() => chat.add(any(that: isA<ReportMessage>())));
  });

  testWidgets('report acknowledgement appears as success only after event', (
    tester,
  ) async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    _ReportAccount();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      await getIt.reset();
    });
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final chat = _Chat();
    final contactBloc = contacts();
    final updates = StreamController<ChatState>.broadcast();
    addTearDown(updates.close);
    final initial = ChatState(
      roomId: roomId,
      messages: [
        MessageEntity(
          id: eventId,
          roomId: roomId,
          senderId: '@bob:hs.test',
          senderName: 'Bob',
          content: 'Message text stays local',
          type: MessageType.text,
          timestamp: DateTime(2026),
          isFromMe: false,
        ),
      ],
      canSendMessages: false,
    );
    whenListen(chat, updates.stream, initialState: initial);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ChatBloc>.value(value: chat),
            BlocProvider<ContactBloc>.value(value: contactBloc),
          ],
          child: const ChatPage(
            conversation: ConversationEntity(id: roomId, name: 'Bob'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Report submitted'), findsNothing);
    updates.add(initial.copyWith(error: 'success:report'));
    await tester.pumpAndSettle();
    expect(find.text('Report submitted'), findsOneWidget);
    expect(find.text('success:report'), findsNothing);
  });
}
