import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/entities/space_entity.dart';
import 'package:n42_chat/src/domain/repositories/space_repository.dart';
import 'package:n42_chat/src/presentation/blocs/space/space_bloc.dart';
import 'package:n42_chat/src/presentation/pages/space/space_detail_page.dart';

class _SpaceRepository extends Mock implements ISpaceRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const spaceId = '!synthetic-space:example.invalid';

  late _SpaceRepository repository;
  late SpaceBloc bloc;
  late SpaceEntity space;
  Completer<SpaceEntity?>? pendingDetail;

  setUp(() async {
    await getIt.reset();
    repository = _SpaceRepository();
    space = SpaceEntity(
      id: spaceId,
      name: 'Synthetic community',
      description: 'A test community description',
      type: SpaceType.public,
      creatorId: '@owner:example.invalid',
      memberCount: 2,
      topics: const ['test topic'],
      createdAt: DateTime.utc(2026, 1, 1),
      children: const [
        SpaceChild(
          roomId: '!later:example.invalid',
          name: 'Later channel',
          type: SpaceChildType.channel,
          order: 2,
        ),
        SpaceChild(
          roomId: '!earlier:example.invalid',
          name: 'Earlier channel',
          type: SpaceChildType.channel,
          order: 1,
        ),
        SpaceChild(
          roomId: '!subspace:example.invalid',
          name: 'Nested community',
          type: SpaceChildType.subSpace,
          order: 1,
        ),
      ],
    );
    pendingDetail = null;

    when(
      () => repository.watchJoinedSpaces(),
    ).thenAnswer((_) => const Stream<List<SpaceEntity>>.empty());
    when(
      () => repository.getSpaceDetail(spaceId),
    ).thenAnswer((_) async => space);
    when(
      () => repository.getSpaceMembers(spaceId),
    ).thenAnswer((_) async => const <GroupMember>[]);
    when(
      () => repository.getJoinedSpaces(),
    ).thenAnswer((_) async => [space.copyWith(isJoined: true)]);
    when(() => repository.joinSpace(spaceId)).thenAnswer((_) async {});
    when(() => repository.leaveSpace(spaceId)).thenAnswer((_) async {});

    bloc = SpaceBloc(repository: repository);
  });

  tearDown(() async {
    final pending = pendingDetail;
    if (pending != null && !pending.isCompleted) {
      pending.complete(space);
    }
    await bloc.close();
    await getIt.reset();
  });

  Widget buildPage() => MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    home: BlocProvider.value(
      value: bloc,
      child: const SpaceDetailPage(spaceId: spaceId),
    ),
  );

  Future<void> flushBlocEvents(WidgetTester tester) async {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 1)),
    );
    await tester.pump();
  }

  testWidgets('shows loading while the Space detail request is pending', (
    tester,
  ) async {
    pendingDetail = Completer<SpaceEntity?>();
    when(
      () => repository.getSpaceDetail(spaceId),
    ).thenAnswer((_) => pendingDetail!.future);

    await tester.pumpWidget(buildPage());
    await tester.pump();
    await tester.pump();
    await flushBlocEvents(tester);
    verify(() => repository.getSpaceDetail(spaceId)).called(1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    pendingDetail!.complete(space);
    await flushBlocEvents(tester);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('shows a not-found state when the repository has no Space', (
    tester,
  ) async {
    when(
      () => repository.getSpaceDetail(spaceId),
    ).thenAnswer((_) async => null);

    await tester.pumpWidget(buildPage());
    await flushBlocEvents(tester);
    await tester.pumpAndSettle();

    expect(find.text('Community not found'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders Space content and joins through the repository', (
    tester,
  ) async {
    await tester.pumpWidget(buildPage());
    await tester.pump();
    await flushBlocEvents(tester);
    await tester.pumpAndSettle();

    expect(find.text('Synthetic community'), findsOneWidget);
    expect(find.text('A test community description'), findsOneWidget);
    expect(find.text('test topic'), findsOneWidget);
    expect(find.text('Join'), findsOneWidget);
    expect(find.text('Earlier channel'), findsOneWidget);
    expect(find.text('Later channel'), findsOneWidget);
    expect(find.text('Nested community'), findsOneWidget);
    expect(find.byTooltip('Add Channel'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Join'));
    await tester.pumpAndSettle();
    await flushBlocEvents(tester);
    await tester.pumpAndSettle();

    verify(() => repository.joinSpace(spaceId)).called(1);
    verify(() => repository.getJoinedSpaces()).called(1);
    expect(find.text('Synthetic community'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canceling leave preserves membership; confirming leaves once', (
    tester,
  ) async {
    space = space.copyWith(isJoined: true);
    await tester.pumpWidget(buildPage());
    await tester.pump();
    await flushBlocEvents(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Leave Community'));
    await tester.pumpAndSettle();
    expect(
      find.text('Are you sure you want to leave "Synthetic community"?'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();
    verifyNever(() => repository.leaveSpace(spaceId));

    await tester.tap(find.text('Leave Community'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Leave Community'));
    await tester.pumpAndSettle();
    await flushBlocEvents(tester);
    await tester.pumpAndSettle();

    verify(() => repository.leaveSpace(spaceId)).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens the full member list from the community preview', (
    tester,
  ) async {
    final members = List.generate(
      7,
      (index) => GroupMember(
        userId: '@member$index:example.invalid',
        displayName: 'Member $index',
        role: switch (index) {
          0 => GroupRole.owner,
          1 => GroupRole.admin,
          _ => GroupRole.member,
        },
      ),
    );
    space = space.copyWith(memberCount: members.length);
    when(
      () => repository.getSpaceMembers(spaceId),
    ).thenAnswer((_) async => members);

    await tester.pumpWidget(buildPage());
    await flushBlocEvents(tester);
    if (bloc.state.currentMembers.length != members.length) {
      await tester.runAsync(
        () => bloc.stream.firstWhere(
          (state) => state.currentMembers.length == members.length,
        ),
      );
      await tester.pump();
    }
    await tester.pumpAndSettle();

    expect(bloc.state.currentMembers, hasLength(7));
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -900));
    await tester.pumpAndSettle();
    final viewAllButton = find.textContaining('View all');
    expect(viewAllButton, findsOneWidget);
    await tester.ensureVisible(viewAllButton);
    await tester.tap(viewAllButton);
    await tester.pumpAndSettle();

    expect(find.text('(7)'), findsNWidgets(2));
    expect(find.text('Member 0'), findsWidgets);
    expect(find.text('Owner'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('@member0:example.invalid'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
