import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/governance/proposal_entity.dart';
import 'package:n42_chat/src/domain/repositories/governance_repository.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_bloc.dart';
import 'package:n42_chat/src/presentation/pages/governance/create_proposal_page.dart';
import 'package:n42_chat/src/presentation/pages/governance/proposals_list_page.dart';

class MockGovernanceRepository extends Mock implements IGovernanceRepository {}

void main() {
  late MockGovernanceRepository mockRepository;
  late GovernanceBloc governanceBloc;

  setUpAll(() {
    registerFallbackValue(<String>[]);
    registerFallbackValue(DateTime(2026, 1, 1));
    registerFallbackValue(ProposalState.active);
  });

  final createdProposal = ProposalEntity(
    id: 'proposal-1',
    spaceId: 'space-1',
    title: 'New Proposal',
    body: 'Proposal body',
    author: '0xabc',
    state: ProposalState.active,
    choices: const ['Yes', 'No'],
    startTime: DateTime(2026, 1, 1, 10),
    endTime: DateTime(2026, 1, 4, 10),
  );

  setUp(() {
    mockRepository = MockGovernanceRepository();
    governanceBloc = GovernanceBloc(repository: mockRepository);
  });

  tearDown(() async {
    await governanceBloc.close();
  });

  testWidgets('refreshes proposals list after successful proposal creation', (
    tester,
  ) async {
    var loadCount = 0;

    when(
      () => mockRepository.getProposals(
        any(),
        state: any(named: 'state'),
        first: any(named: 'first'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async {
      loadCount += 1;
      return loadCount == 1 ? <ProposalEntity>[] : <ProposalEntity>[createdProposal];
    });

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GovernanceBloc>.value(
          value: governanceBloc,
          child: const ProposalsListPage(spaceId: 'space-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No proposals found'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(CreateProposalPage), findsOneWidget);

    Navigator.of(
      tester.element(find.byType(CreateProposalPage)),
    ).pop(true);
    await tester.pumpAndSettle();

    expect(loadCount, 2);
  });
}
