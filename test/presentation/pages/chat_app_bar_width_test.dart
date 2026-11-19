import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _Contacts extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _Event extends Fake implements ChatEvent {}

const _roomName = 'A long conversation title for the top bar';

void main() {
  setUpAll(() => registerFallbackValue(_Event()));

  for (final isGroup in [false, true]) {
    for (final width in [320.0, 375.0, 430.0]) {
      testWidgets('chat top bar keeps a centered title at ${width}pt '
          '(${isGroup ? 'group' : 'direct'})', (tester) async {
        await getIt.reset();
        SharedPreferences.setMockInitialValues({});
        getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
        final chat = _Chat();
        whenListen(
          chat,
          const Stream<ChatState>.empty(),
          initialState: const ChatState(
            roomId: '!room:test',
            canSendMessages: true,
          ),
        );
        final contacts = _Contacts();
        whenListen(
          contacts,
          const Stream<ContactState>.empty(),
          initialState: const ContactState(),
        );
        addTearDown(() async {
          await tester.pumpWidget(const SizedBox());
          await getIt.reset();
        });
        tester.view.physicalSize = Size(width, 700);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            home: Scaffold(body: SizedBox()),
          ),
        );
        tester
            .state<NavigatorState>(find.byType(Navigator))
            .push(
              MaterialPageRoute<void>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ChatBloc>.value(value: chat),
                    BlocProvider<ContactBloc>.value(value: contacts),
                  ],
                  child: ChatPage(
                    conversation: ConversationEntity(
                      id: '!room:test',
                      name: _roomName,
                      type: isGroup
                          ? ConversationType.group
                          : ConversationType.direct,
                    ),
                  ),
                ),
              ),
            );
        await tester.pumpAndSettle();

        final appBar = find.byType(AppBar);
        final title = find.descendant(
          of: appBar,
          matching: find.text(_roomName),
        );
        final titleRect = tester.getRect(title);
        final back = find.descendant(
          of: appBar,
          matching: find.byTooltip('Back'),
        );
        final backRect = tester.getRect(back);
        if (isGroup) {
          // Group chats center the title between equal 44pt slots (back button
          // on the left, "..." menu on the right): width - 2 * 44 - 2 * 16.
          expect(titleRect.width, closeTo(width - 2 * 44 - 2 * 16, 1));
          expect(titleRect.center.dx, closeTo(width / 2, 1));
          // Back stays at the left edge of the bar.
          expect(backRect.left, lessThanOrEqualTo(4));
        } else {
          // Direct chats left-anchor the title: it starts just right of the
          // back button (56pt leading slot + 16pt spacing) and fills the space
          // up to the three 44pt trailing buttons: width - 56 - 132 - 2 * 16.
          expect(titleRect.left, closeTo(56 + 16, 2));
          expect(titleRect.left, greaterThan(backRect.right));
          expect(titleRect.width, closeTo(width - 56 - 132 - 2 * 16, 1));
        }
        expect(
          find.descendant(
            of: appBar,
            matching: find.byIcon(Icons.phone_outlined),
          ),
          isGroup ? findsNothing : findsOneWidget,
        );
        expect(
          find.descendant(
            of: appBar,
            matching: find.byIcon(Icons.videocam_outlined),
          ),
          isGroup ? findsNothing : findsOneWidget,
        );

        final actions = find.descendant(
          of: appBar,
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is IconButton ||
                widget.runtimeType.toString().startsWith('PopupMenuButton'),
          ),
        );
        expect(actions, findsWidgets);
        for (var i = 0; i < actions.evaluate().length; i++) {
          final size = tester.getSize(actions.at(i));
          expect(size.width, greaterThanOrEqualTo(44), reason: 'action $i');
          expect(size.height, greaterThanOrEqualTo(44), reason: 'action $i');
        }
        expect(tester.takeException(), isNull);
      });
    }
  }
}
