import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/conversation_repository.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_action_repository.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/blocs/message_action/message_action_bloc.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _ChatEvent extends Fake implements ChatEvent {}

class _Contacts extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Groups extends Mock implements IGroupRepository {}

class _MessageActions extends Mock implements IMessageActionRepository {}

class _Conversations extends Mock implements IConversationRepository {}

class _Messages extends Mock implements IMessageRepository {}

class _Account {
  _Account() {
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('token');
    when(() => client.deviceID).thenReturn(null);
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.currentUser).thenReturn(null);
    when(() => groups.getGroupMembers(any())).thenAnswer((_) async => []);
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    getIt.registerSingleton<IGroupRepository>(groups);
  }

  final manager = _Manager();
  final client = _Client();
  final auth = _Auth();
  final groups = _Groups();
  final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: null,
    isCurrent: () => true,
    matchesClient: (_) => true,
  );
}

const _roomId = '!message-actions:hs.test';

void main() {
  setUpAll(() {
    registerFallbackValue(_ChatEvent());
    registerFallbackValue(
      MessageEntity(
        id: 'fallback',
        roomId: _roomId,
        senderId: '@fallback:hs.test',
        senderName: 'Fallback',
        content: '',
        type: MessageType.text,
        timestamp: DateTime(2026),
      ),
    );
  });

  Future<_Chat> pumpChat(
    WidgetTester tester, {
    required MessageEntity message,
    MessageActionBloc? messageActionBloc,
  }) async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    _Account();
    if (messageActionBloc != null) {
      getIt.registerSingleton<MessageActionBloc>(
        messageActionBloc,
        dispose: (bloc) => bloc.close(),
      );
    }

    final chat = _Chat();
    final state = ChatState(
      roomId: _roomId,
      messages: [message],
      canSendMessages: false,
    );
    when(() => chat.state).thenReturn(state);
    final contacts = _Contacts();
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(),
    );

    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ChatBloc>.value(value: chat),
            BlocProvider<ContactBloc>.value(value: contacts),
          ],
          child: const ChatPage(
            conversation: ConversationEntity(
              id: _roomId,
              name: 'Message actions',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return chat;
  }

  Future<void> openMenu(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text));
    await tester.longPress(find.text(text));
    await tester.pumpAndSettle();
  }

  Future<void> tapMenuAction(WidgetTester tester, String id) async {
    final action = find.byKey(ValueKey('message-action-$id'));
    if (action.evaluate().isEmpty) {
      await tester.tap(find.byKey(const ValueKey('message-action-more')));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(action);
    await tester.tap(action);
    await tester.pumpAndSettle();
  }

  Future<void> tapMultiSelectMessage(WidgetTester tester, String text) async {
    final message = find.text(text);
    await tester.ensureVisible(message);
    // The text is inside the row's GestureDetector; hit testing is expected
    // to land on the enclosing selection row rather than the Text itself.
    await tester.tap(message, warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  Future<void> cleanup(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await getIt.reset();
    await tester.binding.setSurfaceSize(null);
  }

  testWidgets('copy action writes the exact text message to clipboard', (
    tester,
  ) async {
    final clipboardCalls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        clipboardCalls.add(call);
        return null;
      },
    );
    addTearDown(() async {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
      await cleanup(tester);
    });
    await pumpChat(
      tester,
      message: MessageEntity(
        id: r'$copy-event',
        roomId: _roomId,
        senderId: '@bob:hs.test',
        senderName: 'Bob',
        content: 'copy exactly this',
        type: MessageType.text,
        timestamp: DateTime(2026),
      ),
    );

    await openMenu(tester, 'copy exactly this');
    await tapMenuAction(tester, 'copy');

    final copyCall = clipboardCalls.singleWhere(
      (call) => call.method == 'Clipboard.setData',
    );
    expect(copyCall.arguments, {'text': 'copy exactly this'});
    expect(find.text('Copied'), findsOneWidget);
  });

  testWidgets('forward action sends text to the selected conversation', (
    tester,
  ) async {
    addTearDown(() => cleanup(tester));
    final conversations = _Conversations();
    final messages = _Messages();
    when(() => conversations.getConversations()).thenAnswer(
      (_) async => const [
        ConversationEntity(id: '!forward-target:hs.test', name: 'Target chat'),
      ],
    );
    when(
      () => messages.sendTextMessage(any(), any()),
    ).thenAnswer((_) async => null);
    await pumpChat(
      tester,
      message: MessageEntity(
        id: r'$forward-event',
        roomId: _roomId,
        senderId: '@bob:hs.test',
        senderName: 'Bob',
        content: 'forward this text',
        type: MessageType.text,
        timestamp: DateTime(2026),
      ),
    );
    getIt.registerSingleton<IConversationRepository>(conversations);
    getIt.registerSingleton<IMessageRepository>(messages);

    await openMenu(tester, 'forward this text');
    await tapMenuAction(tester, 'forward');
    await tester.tap(find.text('Target chat'));
    await tester.pumpAndSettle();

    verify(
      () => messages.sendTextMessage(
        '!forward-target:hs.test',
        'forward this text',
      ),
    ).called(1);
    expect(find.text('Message forwarded'), findsOneWidget);
  });

  testWidgets('favorite action persists the selected message', (tester) async {
    final repository = _MessageActions();
    final saved = Completer<MessageEntity>();
    when(() => repository.saveMessage(any())).thenAnswer((invocation) async {
      saved.complete(invocation.positionalArguments.single as MessageEntity);
    });
    final actions = MessageActionBloc(repository);
    addTearDown(() => cleanup(tester));
    final message = MessageEntity(
      id: r'$favorite-event',
      roomId: _roomId,
      senderId: '@bob:hs.test',
      senderName: 'Bob',
      content: 'save this message',
      type: MessageType.text,
      timestamp: DateTime(2026),
    );
    await pumpChat(tester, message: message, messageActionBloc: actions);

    await openMenu(tester, 'save this message');
    await tapMenuAction(tester, 'favorite');

    expect(await saved.future.timeout(const Duration(seconds: 1)), message);
    expect(find.text('Favorited'), findsOneWidget);
  });

  testWidgets('quick reaction dispatches the selected emoji for the message', (
    tester,
  ) async {
    addTearDown(() => cleanup(tester));
    final chat = await pumpChat(
      tester,
      message: MessageEntity(
        id: r'$reaction-event',
        roomId: _roomId,
        senderId: '@bob:hs.test',
        senderName: 'Bob',
        content: 'react to this',
        type: MessageType.text,
        timestamp: DateTime(2026),
      ),
    );

    await openMenu(tester, 'react to this');
    await tester.tap(find.text('❤️').first);
    await tester.pumpAndSettle();

    final events = verify(() => chat.add(captureAny())).captured;
    final reaction = events.whereType<AddReaction>().single;
    expect(reaction.messageId, r'$reaction-event');
    expect(reaction.emoji, '❤️');
    expect(find.text('Reaction added'), findsOneWidget);
  });

  testWidgets('multi-select collect favorites selected messages and exits', (
    tester,
  ) async {
    addTearDown(() => cleanup(tester));
    final chat = await pumpChat(
      tester,
      message: MessageEntity(
        id: r'$collect-event',
        roomId: _roomId,
        senderId: '@bob:hs.test',
        senderName: 'Bob',
        content: 'collect this message',
        type: MessageType.text,
        timestamp: DateTime(2026),
      ),
    );

    await openMenu(tester, 'collect this message');
    await tapMenuAction(tester, 'select');
    await tapMultiSelectMessage(tester, 'collect this message');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Collect'));
    await tester.pumpAndSettle();

    expect(find.text('Collected 1 messages'), findsOneWidget);
    expect(find.text('Collect'), findsNothing);
    await openMenu(tester, 'collect this message');
    expect(find.text('Unfav'), findsOneWidget);
    expect(
      verify(() => chat.add(captureAny())).captured.whereType<InitializeChat>(),
      hasLength(1),
    );
  });

  testWidgets(
    'multi-select delete recalls own messages and locally deletes others',
    (tester) async {
      addTearDown(() => cleanup(tester));
      final ownMessage = MessageEntity(
        id: r'$own-event',
        roomId: _roomId,
        senderId: '@me:hs.test',
        senderName: 'Me',
        content: 'my message',
        type: MessageType.text,
        timestamp: DateTime(2026),
        isFromMe: true,
      );
      final otherMessage = MessageEntity(
        id: r'$other-event',
        roomId: _roomId,
        senderId: '@bob:hs.test',
        senderName: 'Bob',
        content: 'their message',
        type: MessageType.text,
        timestamp: DateTime(2026),
      );
      await getIt.reset();
      SharedPreferences.setMockInitialValues({});
      getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
      _Account();
      final chat = _Chat();
      when(() => chat.state).thenReturn(
        ChatState(
          roomId: _roomId,
          messages: [ownMessage, otherMessage],
          canSendMessages: false,
        ),
      );
      final contacts = _Contacts();
      whenListen(
        contacts,
        const Stream<ContactState>.empty(),
        initialState: const ContactState(),
      );
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ChatBloc>.value(value: chat),
              BlocProvider<ContactBloc>.value(value: contacts),
            ],
            child: const ChatPage(
              conversation: ConversationEntity(
                id: _roomId,
                name: 'Message actions',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await openMenu(tester, 'my message');
      await tapMenuAction(tester, 'select');
      await tapMultiSelectMessage(tester, 'my message');
      await tapMultiSelectMessage(tester, 'their message');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete').first);
      await tester.pumpAndSettle();
      expect(find.textContaining('2 messages'), findsOneWidget);
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      final events = verify(() => chat.add(captureAny())).captured;
      expect(
        events.whereType<RedactMessage>().map((event) => event.messageId),
        [r'$own-event'],
      );
      expect(events.whereType<DeleteMessagesLocally>().single.messageIds, [
        r'$other-event',
      ]);
      expect(find.textContaining('Recalled 1 messages'), findsOneWidget);
    },
  );
}
