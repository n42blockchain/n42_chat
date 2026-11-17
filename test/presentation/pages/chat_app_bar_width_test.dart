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

  for (final width in [320.0, 375.0]) {
    testWidgets('chat top bar keeps a usable title at ${width}pt', (
      tester,
    ) async {
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
                child: const ChatPage(
                  conversation: ConversationEntity(
                    id: '!room:test',
                    name: _roomName,
                    type: ConversationType.direct,
                  ),
                ),
              ),
            ),
          );
      await tester.pumpAndSettle();

      final appBar = find.byType(AppBar);
      final title = find.descendant(of: appBar, matching: find.text(_roomName));
      expect(tester.getSize(title).width, greaterThanOrEqualTo(80));

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
