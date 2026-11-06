import 'dart:async';

import 'package:n42_chat/src/domain/entities/recovered_composer_text.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_detail_page.dart';

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
import 'package:n42_chat/src/domain/entities/user_entity.dart';
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
    when(() => auth.currentUser)
        .thenReturn(const UserEntity(userId: '@me:hs.test', displayName: 'Me'));
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

class _DraftStore extends PreferencesDataSource {
  final pending = Completer<String?>();
  final writes = <(String, String, String)>[];
  @override
  Future<String?> getAccountDraft(
    String roomId, {
    required String ownerUserId,
    required bool Function() isCurrent,
  }) async {
    expect(ownerUserId, '@me:hs.test');
    return pending.future;
  }

  @override
  Future<void> saveAccountDraft(
    String roomId,
    String text, {
    required String ownerUserId,
    required bool Function() isCurrent,
  }) async {
    if (isCurrent()) writes.add((roomId, ownerUserId, text));
  }
}

void main() {
  setUpAll(() => registerFallbackValue(_Event()));
  for (final scenario in [
    'load',
    'typed',
    'typed then cleared',
    'account changed',
    'failure',
    'recover',
    'recover foreign room',
    'recover foreign owner',
    'recover account changed',
    'recover input changed',
  ]) {
    testWidgets('composer draft $scenario', (tester) async {
      await getIt.reset();
      SharedPreferences.setMockInitialValues({});
      final store = _DraftStore();
      getIt.registerSingleton<PreferencesDataSource>(store);
      final account = _ReportAccount();
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
                id: '!room:test',
                name: 'Room',
                type: ConversationType.direct,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final input = find.byType(TextField).first;
      if (scenario.startsWith('typed')) {
        await tester.enterText(input, 'new text');
        if (scenario == 'typed then cleared') await tester.enterText(input, '');
      }
      if (scenario == 'account changed') account.active = false;
      if (scenario == 'failure') {
        store.pending.completeError(StateError('offline'));
      } else {
        store.pending.complete('saved account text');
      }
      await tester.pumpAndSettle();
      if (scenario.startsWith('recover')) {
        final controller = tester.widget<TextField>(input).controller!;
        expect(controller.text, 'saved account text');
        await tester.tap(find.byIcon(Icons.more_horiz));
        await tester.pumpAndSettle();
        expect(find.byType(ChatDetailPage), findsOneWidget);
        if (scenario == 'recover account changed') account.active = false;
        if (scenario == 'recover input changed') {
          controller.text = 'new input';
          controller.text = 'saved account text';
        }
        Navigator.of(tester.element(find.byType(ChatDetailPage))).pop(
          RecoveredComposerText(
            ownerUserId: scenario == 'recover foreign owner'
                ? '@other:test'
                : '@me:hs.test',
            roomId: scenario == 'recover foreign room'
                ? '!other:test'
                : '!room:test',
            text: 'recovered text',
          ),
        );
        await tester.pumpAndSettle();
        expect(
          controller.text,
          scenario == 'recover'
              ? 'saved account text\nrecovered text'
              : 'saved account text',
        );
        verifyNever(() => chat.add(any(that: isA<SendTextMessage>())));
        expect(tester.takeException(), isNull);
        return;
      }
      final text = tester.widget<TextField>(input).controller!.text;
      expect(
        text,
        scenario == 'load'
            ? 'saved account text'
            : scenario == 'typed'
            ? 'new text'
            : '',
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      if (['account changed', 'failure'].contains(scenario)) {
        expect(store.writes, isEmpty);
      } else {
        expect(store.writes.single, ('!room:test', '@me:hs.test', text));
      }
    });
  }
}
