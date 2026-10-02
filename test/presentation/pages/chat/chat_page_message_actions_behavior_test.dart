import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ChatBlocMock extends MockBloc<ChatEvent, ChatState>
    implements ChatBloc {}

class _ContactBlocMock extends Mock implements ContactBloc {}

class _FakeChatEvent extends Fake implements ChatEvent {}

const _roomId = '!message-actions:server.test';

MessageEntity _message({bool isFromMe = false, int? selfDestructAfter}) =>
    MessageEntity(
      id: r'$event:message',
      roomId: _roomId,
      senderId: isFromMe ? '@me:server.test' : '@alice:server.test',
      senderName: isFromMe ? 'Me' : 'Alice',
      content: 'Message action target',
      type: MessageType.text,
      timestamp: DateTime(2026, 10, 2),
      isFromMe: isFromMe,
      selfDestructAfter: selfDestructAfter,
    );

void main() {
  late _ChatBlocMock chat;
  late _ContactBlocMock contacts;
  late ChatState currentChatState;
  late List<ChatEvent> events;

  setUpAll(() {
    registerFallbackValue(_FakeChatEvent());
  });

  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());

    chat = _ChatBlocMock();
    events = [];
    currentChatState = ChatState(messages: [_message()]);
    when(() => chat.state).thenAnswer((_) => currentChatState);
    when(() => chat.stream).thenAnswer((_) => const Stream<ChatState>.empty());
    when(() => chat.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ChatEvent);
    });

    contacts = _ContactBlocMock();
    when(() => contacts.state).thenReturn(const ContactState());
    when(
      () => contacts.stream,
    ).thenAnswer((_) => const Stream<ContactState>.empty());
  });

  tearDown(() async {
    await getIt.reset();
  });

  Future<S> openChat(
    WidgetTester tester, {
    required MessageEntity message,
    bool canPinMessages = false,
    List<MessageEntity> pinnedMessages = const [],
  }) async {
    currentChatState = ChatState(
      messages: [message],
      canPinMessages: canPinMessages,
      pinnedMessages: pinnedMessages,
    );
    tester.view.physicalSize = const Size(430, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ContactBloc>.value(
          value: contacts,
          child: BlocProvider<ChatBloc>.value(
            value: chat,
            child: const ChatPage(
              conversation: ConversationEntity(
                id: _roomId,
                name: 'Message actions',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(ChatPage)))!;
  }

  Future<void> openMessageMenu(WidgetTester tester) async {
    await tester.longPress(find.text('Message action target'));
    await tester.pumpAndSettle();
  }

  Future<void> openMoreAction(
    WidgetTester tester,
    ValueKey<String> actionKey,
  ) async {
    await openMessageMenu(tester);
    await tester.tap(find.byKey(const ValueKey('message-action-more')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(actionKey));
    await tester.tap(find.byKey(actionKey));
    await tester.pumpAndSettle();
  }

  testWidgets('copy action places the message text on the clipboard', (
    tester,
  ) async {
    final message = _message();
    String? copiedText;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copiedText =
              (call.arguments as Map<Object?, Object?>)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    final l10n = await openChat(tester, message: message);

    await openMessageMenu(tester);
    await tester.tap(find.byKey(const ValueKey('message-action-copy')));
    await tester.pumpAndSettle();

    expect(copiedText, message.content);
    expect(find.text(l10n.chatCopied), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('quote action sets the selected message as the reply target', (
    tester,
  ) async {
    final message = _message();
    await openChat(tester, message: message);

    await openMessageMenu(tester);
    await tester.tap(find.byKey(const ValueKey('message-action-quote')));
    await tester.pumpAndSettle();

    final event = events.whereType<SetReplyTarget>().single;
    expect(event.message, message);
    expect(tester.takeException(), isNull);
  });

  testWidgets('quick reaction dispatches the selected emoji for the message', (
    tester,
  ) async {
    final message = _message();
    await openChat(tester, message: message);

    await openMessageMenu(tester);
    await tester.tap(find.text('😀'));
    await tester.pumpAndSettle();

    final event = events.whereType<AddReaction>().single;
    expect(event.messageId, message.id);
    expect(event.emoji, '😀');
    expect(tester.takeException(), isNull);
  });

  testWidgets('pin action dispatches a pin event when the room permits it', (
    tester,
  ) async {
    final message = _message();
    final l10n = await openChat(tester, message: message, canPinMessages: true);

    await openMessageMenu(tester);
    await tester.tap(find.byKey(const ValueKey('message-action-more')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('message-action-pin')),
    );
    await tester.tap(find.byKey(const ValueKey('message-action-pin')));
    await tester.pumpAndSettle();

    expect(events.whereType<PinMessage>().single.messageId, message.id);
    expect(find.text(l10n.conversationPin), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'recall confirmation redacts the message and shows recalled state',
    (tester) async {
      final message = _message(isFromMe: true);
      final l10n = await openChat(tester, message: message);

      await openMessageMenu(tester);
      await tester.tap(find.byKey(const ValueKey('message-action-more')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('message-action-recall')),
      );
      await tester.tap(find.byKey(const ValueKey('message-action-recall')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.chatRecall));
      await tester.pumpAndSettle();

      expect(events.whereType<RedactMessage>().single.messageId, message.id);
      expect(find.text(message.content), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('edit action loads my text and selects it for editing', (
    tester,
  ) async {
    final message = _message(isFromMe: true);
    await openChat(tester, message: message);

    await openMoreAction(tester, const ValueKey('message-action-edit'));

    expect(events.whereType<SetEditTarget>().single.message, message);
    final composer = tester.widget<TextField>(find.byType(TextField).last);
    expect(composer.controller?.text, message.content);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling local deletion leaves the message untouched', (
    tester,
  ) async {
    final message = _message();
    final l10n = await openChat(tester, message: message);

    await openMoreAction(tester, const ValueKey('message-action-delete'));
    expect(find.text(l10n.chatDeleteThisMessage), findsOneWidget);
    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();

    expect(events.whereType<DeleteMessagesLocally>(), isEmpty);
    expect(find.text(message.content), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('confirming local deletion removes only this message locally', (
    tester,
  ) async {
    final message = _message();
    final l10n = await openChat(tester, message: message);

    await openMoreAction(tester, const ValueKey('message-action-delete'));
    await tester.tap(find.text(l10n.commonDelete));
    await tester.pumpAndSettle();

    expect(events.whereType<DeleteMessagesLocally>().single.messageIds, [
      message.id,
    ]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('remind action is rejected in a direct conversation', (
    tester,
  ) async {
    final l10n = await openChat(tester, message: _message());
    events.clear();

    await openMoreAction(tester, const ValueKey('message-action-remind'));

    expect(find.text(l10n.chatRemindOnlyInGroup), findsOneWidget);
    expect(events, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('multi-select cannot forward a self-destructing message', (
    tester,
  ) async {
    final message = _message(selfDestructAfter: 30);
    final l10n = await openChat(tester, message: message);
    events.clear();

    await openMessageMenu(tester);
    await tester.tap(find.byKey(const ValueKey('message-action-select')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey(message.id)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.chatMultiForward));
    await tester.pumpAndSettle();

    expect(find.text(l10n.chatRedPacketTransferCannotForward), findsOneWidget);
    expect(events, isEmpty);
    expect(find.text(l10n.chatSelectedCount(1)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
