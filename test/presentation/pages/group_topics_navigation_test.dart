import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/pages/group/group_topics_page.dart';

class _MockGroupRepository extends Mock implements IGroupRepository {}

void main() {
  const roomId = '!topics:example.org';
  late _MockGroupRepository repository;

  setUp(() async {
    await getIt.reset();
    repository = _MockGroupRepository();
    when(() => repository.getGroup(roomId)).thenAnswer(
      (_) async => const GroupEntity(
        roomId: roomId,
        name: 'Topics test group',
        canChangeSettings: true,
      ),
    );
    when(() => repository.getGroupMembers(roomId)).thenAnswer((_) async => []);
    when(() => repository.getChannels(roomId)).thenAnswer((_) async => []);
    getIt.registerFactory<GroupBloc>(() => GroupBloc(repository));
  });

  tearDown(() async => getIt.reset());

  testWidgets(
    'Edit route keeps the GroupBloc available to channel management',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: GroupTopicsPage(roomId: roomId)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Topic Channels'), findsOneWidget);
    },
  );
}
