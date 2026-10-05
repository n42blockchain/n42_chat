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
  final events = <GroupEvent>[];

  @override
  GroupState get state => const GroupState(
    status: GroupStatus.loaded,
    currentGroup: GroupEntity(
      roomId: '!edit:hs.test',
      name: 'Project Group',
      topic: 'Current topic',
      announcement: 'Current announcement',
      memberCount: 5,
      maxMembers: 50,
      myRole: GroupRole.admin,
      canInvite: true,
      canKick: true,
      canChangeSettings: true,
      canEditName: true,
      canEditAvatar: false,
      canEditDescription: true,
      canChangeVisibility: true,
      canManageChannels: true,
      canManageBot: true,
      canManageContentFilter: true,
      canManageMemberLimit: true,
    ),
  );

  @override
  Stream<GroupState> get stream => const Stream.empty();

  @override
  void add(GroupEvent event) => events.add(event);

  @override
  Future<void> close() async {}
}

void main() {
  testWidgets('group admins edit details and cancel or clear history', (
    tester,
  ) async {
    final bloc = _GroupBloc();
    var clearCalls = 0;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<GroupBloc>.value(
          value: bloc,
          child: GroupSettingsPage(
            roomId: '!edit:hs.test',
            onClearHistory: () => clearCalls++,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(GroupSettingsPage)))!;

    expect(find.text('Project Group'), findsOneWidget);
    expect(find.text('Current topic'), findsOneWidget);
    expect(find.text('Current announcement'), findsOneWidget);

    await tester.tap(find.text('Project Group'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '  Updated Group  ');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();
    expect(
      bloc.events.whereType<UpdateGroupName>().single.name,
      'Updated Group',
    );

    await tester.ensureVisible(find.text('Current announcement'));
    await tester.tap(find.text('Current announcement'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'New announcement');
    await tester.tap(find.text(l10n.groupPublish));
    await tester.pumpAndSettle();
    expect(
      bloc.events.whereType<UpdateGroupAnnouncement>().single.announcement,
      'New announcement',
    );

    await tester.ensureVisible(find.text('Current topic'));
    await tester.tap(find.text('Current topic'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'New topic');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();
    expect(bloc.events.whereType<UpdateGroupTopic>().single.topic, 'New topic');

    await tester.ensureVisible(find.text(l10n.groupMaxMembers));
    await tester.tap(find.text(l10n.groupMaxMembers));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '90');
    await tester.tap(find.text(l10n.commonConfirm));
    await tester.pumpAndSettle();
    expect(bloc.events.whereType<SetMaxMembers>().single.maxMembers, 90);

    final visibility = find.byType(SwitchListTile).first;
    await tester.ensureVisible(visibility);
    await tester.tap(visibility);
    await tester.pumpAndSettle();
    expect(
      bloc.events.whereType<UpdateGroupVisibility>().single.isPublic,
      true,
    );

    await tester.ensureVisible(find.text(l10n.commonClearChatHistory));
    await tester.tap(find.text(l10n.commonClearChatHistory));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();
    expect(clearCalls, 0);
    await tester.tap(find.text(l10n.commonClearChatHistory));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonClear));
    await tester.pumpAndSettle();
    expect(clearCalls, 1);
    expect(find.text(l10n.commonChatHistoryCleared), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
