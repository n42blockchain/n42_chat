import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_event.dart';

class Repository extends Mock implements IGroupRepository {}

void main() {
  const room = '!room:example.org';
  const other = '!other:example.org';
  const member = GroupMember(userId: '@a:example.org', displayName: 'A');

  test('older member response cannot replace newer room details', () async {
    final repo = Repository();
    final pending = Completer<List<GroupMember>>();
    final started = Completer<void>();
    when(() => repo.getGroupMembers(room)).thenAnswer((_) {
      started.complete();
      return pending.future;
    });
    when(() => repo.getGroup(other)).thenAnswer(
      (_) async =>
          const GroupEntity(roomId: other, name: 'Other', memberCount: 0),
    );
    when(() => repo.getGroupMembers(other)).thenAnswer((_) async => []);
    final bloc = GroupBloc(repo);
    bloc.add(const LoadGroupMembers(room));
    await started.future;
    final loaded = bloc.stream.firstWhere(
      (s) => s.currentGroup?.roomId == other,
    );
    bloc.add(const LoadGroupDetails(other));
    await loaded;
    pending.complete([member]);
    await bloc.close();
    expect(bloc.state.currentGroup?.roomId, other);
    expect(bloc.state.members, isEmpty);
    verifyNever(() => repo.getGroup(room));
  });

  test(
    'newest member refresh wins when group responses arrive backwards',
    () async {
      final repo = Repository();
      final pending = Completer<GroupEntity?>();
      final started = Completer<void>();
      var calls = 0;
      when(() => repo.getGroupMembers(room)).thenAnswer((_) async => [member]);
      when(() => repo.getGroup(room)).thenAnswer((_) {
        final call = calls++;
        if (call == 0) {
          return Future.value(
            const GroupEntity(roomId: room, name: 'Initial', memberCount: 0),
          );
        }
        if (call == 1) {
          started.complete();
          return pending.future;
        }
        return Future.value(
          const GroupEntity(roomId: room, name: 'New', memberCount: 2),
        );
      });
      final bloc = GroupBloc(repo);
      final initial = bloc.stream.firstWhere((s) => s.currentGroup != null);
      bloc.add(const LoadGroupDetails(room));
      await initial;
      bloc.add(const LoadGroupMembers(room));
      await started.future;
      final updated = bloc.stream.firstWhere(
        (s) => s.currentGroup?.memberCount == 2,
      );
      bloc.add(const LoadGroupMembers(room));
      await updated;
      pending.complete(
        const GroupEntity(roomId: room, name: 'Old', memberCount: 1),
      );
      await bloc.close();
      expect(calls, 3);
      expect(bloc.state.currentGroup?.memberCount, 2);
      expect(bloc.state.members, [member]);
    },
  );

  test('group detail lookup failure still delivers loaded members', () async {
    final repo = Repository();
    when(() => repo.getGroupMembers(room)).thenAnswer((_) async => [member]);
    when(() => repo.getGroup(room)).thenThrow(StateError('offline'));
    final bloc = GroupBloc(repo);
    final updated = bloc.stream.firstWhere((s) => s.members.isNotEmpty);
    bloc.add(const LoadGroupMembers(room));
    await updated;
    expect(bloc.state.errorMessage, isNull);
    expect(bloc.state.members, [member]);
    await bloc.close();
  });
}
