import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_event.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_state.dart';
import 'package:n42_chat/src/presentation/pages/group/group_settings_page.dart';

class _GroupBloc extends Mock implements GroupBloc {
  _GroupBloc(this._state);

  final GroupState _state;

  @override
  GroupState get state => _state;

  @override
  Stream<GroupState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

void main() {
  setUpAll(() {
    registerFallbackValue(const LoadGroupDetails('fallback'));
  });

  late List<GroupEvent> events;

  setUp(() {
    events = [];
  });

  _GroupBloc makeBloc(GroupEntity group) {
    final bloc = _GroupBloc(
      GroupState(status: GroupStatus.loaded, currentGroup: group),
    );
    when(() => bloc.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as GroupEvent);
    });
    return bloc;
  }

  Future<S> openPage(
    WidgetTester tester, {
    required GroupEntity group,
    VoidCallback? onClearHistory,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<GroupBloc>.value(
          value: makeBloc(group),
          child: GroupSettingsPage(
            roomId: group.roomId,
            onClearHistory: onClearHistory,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(GroupSettingsPage)))!;
  }

  testWidgets('invalid member limit does not clear the existing limit', (
    tester,
  ) async {
    final l10n = await openPage(
      tester,
      group: const GroupEntity(
        roomId: '!group:server.test',
        name: 'Coverage Group',
        canManageMemberLimit: true,
        memberCount: 12,
        maxMembers: 50,
      ),
    );

    await tester.scrollUntilVisible(find.text(l10n.groupMaxMembers), 240);
    await tester.tap(find.text(l10n.groupMaxMembers));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'not-a-number');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(l10n.transferEnterValidAmount), findsOneWidget);
    expect(events.whereType<SetMaxMembers>(), isEmpty);

    await tester.enterText(find.byType(TextField), '0');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(l10n.transferEnterValidAmount), findsOneWidget);
    expect(events.whereType<SetMaxMembers>(), isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('accepts a positive whole-number member limit', (tester) async {
    final l10n = await openPage(
      tester,
      group: const GroupEntity(
        roomId: '!group:server.test',
        name: 'Coverage Group',
        canManageMemberLimit: true,
        maxMembers: 50,
      ),
    );

    await tester.scrollUntilVisible(find.text(l10n.groupMaxMembers), 240);
    await tester.tap(find.text(l10n.groupMaxMembers));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '75');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    final updates = events.whereType<SetMaxMembers>();
    expect(updates, hasLength(1));
    expect(updates.single.maxMembers, 75);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('clearing member limit remains an explicit empty submission', (
    tester,
  ) async {
    final l10n = await openPage(
      tester,
      group: const GroupEntity(
        roomId: '!group:server.test',
        name: 'Coverage Group',
        canManageMemberLimit: true,
        maxMembers: 50,
      ),
    );

    await tester.scrollUntilVisible(find.text(l10n.groupMaxMembers), 240);
    await tester.tap(find.text(l10n.groupMaxMembers));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();

    final updates = events.whereType<SetMaxMembers>();
    expect(updates, hasLength(1));
    expect(updates.single.maxMembers, isNull);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('clear history calls its callback only after confirmation', (
    tester,
  ) async {
    var clears = 0;
    final l10n = await openPage(
      tester,
      group: const GroupEntity(
        roomId: '!group:server.test',
        name: 'Coverage Group',
      ),
      onClearHistory: () => clears++,
    );

    await tester.scrollUntilVisible(
      find.text(l10n.commonClearChatHistory),
      240,
    );
    await tester.tap(find.text(l10n.commonClearChatHistory));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();
    expect(clears, 0);

    await tester.tap(find.text(l10n.commonClearChatHistory));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonClear));
    await tester.pumpAndSettle();
    expect(clears, 1);
    expect(tester.takeException(), isNull);
  });
}
