import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/governance/proposal_entity.dart';
import 'package:n42_chat/src/domain/entities/governance/vote_entity.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_event.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_state.dart';
import 'package:n42_chat/src/presentation/pages/governance/proposal_detail_page.dart';

class MockGovernanceBloc extends Mock implements GovernanceBloc {}

class FakeGovernanceEvent extends Fake implements GovernanceEvent {}

void main() {
  late MockGovernanceBloc mockGovernanceBloc;
  late StreamController<GovernanceState> stateController;

  final staleProposal = ProposalEntity(
    id: 'proposal-old',
    spaceId: 'space-1',
    title: 'Old proposal',
    body: 'Old body',
    author: '0xabc',
    state: ProposalState.active,
    choices: const ['Yes', 'No'],
    startTime: DateTime(2026, 1, 1, 10),
    endTime: DateTime(2026, 1, 4, 10),
  );

  setUpAll(() {
    registerFallbackValue(FakeGovernanceEvent());
  });

  setUp(() {
    mockGovernanceBloc = MockGovernanceBloc();
    stateController = StreamController<GovernanceState>.broadcast();

    when(() => mockGovernanceBloc.state).thenReturn(
      GovernanceState(
        status: GovernanceStatus.loaded,
        selectedProposal: staleProposal,
      ),
    );
    when(
      () => mockGovernanceBloc.stream,
    ).thenAnswer((_) => stateController.stream);
    when(() => mockGovernanceBloc.add(any())).thenReturn(null);
  });

  tearDown(() async {
    await stateController.close();
  });

  testWidgets(
    'does not render stale proposal content from another detail page',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GovernanceBloc>.value(
            value: mockGovernanceBloc,
            child: const ProposalDetailPage(
              proposalId: 'proposal-new',
              spaceId: 'space-1',
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Old proposal'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      verify(
        () => mockGovernanceBloc.add(
          const GovernanceLoadProposalDetail('proposal-new'),
        ),
      ).called(1);
    },
  );

  testWidgets('renders an integral numeric vote choice as its option name', (
    tester,
  ) async {
    final proposal = ProposalEntity(
      id: 'proposal-new',
      spaceId: 'space-1',
      title: 'New proposal',
      body: 'Proposal body',
      author: '0xabc',
      state: ProposalState.closed,
      choices: const ['Yes', 'No'],
      startTime: DateTime(2026, 1, 1, 10),
      endTime: DateTime(2026, 1, 4, 10),
    );
    when(() => mockGovernanceBloc.state).thenReturn(
      GovernanceState(
        status: GovernanceStatus.loaded,
        selectedProposal: proposal,
        votes: [
          VoteEntity(
            id: 'vote-1',
            voter: '0x1234567890abcdef',
            proposalId: proposal.id,
            choice: 1.0,
            created: DateTime(2026, 1, 2, 10),
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GovernanceBloc>.value(
          value: mockGovernanceBloc,
          child: const ProposalDetailPage(
            proposalId: 'proposal-new',
            spaceId: 'space-1',
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Yes'), findsNWidgets(2));
    expect(find.text('1.0'), findsNothing);
  });

  testWidgets('keeps fractional and weighted vote choices unchanged', (
    tester,
  ) async {
    final proposal = ProposalEntity(
      id: 'proposal-new',
      spaceId: 'space-1',
      title: 'New proposal',
      body: 'Proposal body',
      author: '0xabc',
      state: ProposalState.closed,
      choices: const ['Yes', 'No'],
      startTime: DateTime(2026, 1, 1, 10),
      endTime: DateTime(2026, 1, 4, 10),
    );
    when(() => mockGovernanceBloc.state).thenReturn(
      GovernanceState(
        status: GovernanceStatus.loaded,
        selectedProposal: proposal,
        votes: [
          VoteEntity(
            id: 'fractional-vote',
            voter: '0x1234567890abcdef',
            proposalId: proposal.id,
            choice: 1.5,
            created: DateTime(2026, 1, 2, 10),
          ),
          VoteEntity(
            id: 'weighted-vote',
            voter: '0xabcdef1234567890',
            proposalId: proposal.id,
            choice: const {'Yes': 0.5, 'No': 0.5},
            created: DateTime(2026, 1, 2, 11),
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GovernanceBloc>.value(
          value: mockGovernanceBloc,
          child: const ProposalDetailPage(
            proposalId: 'proposal-new',
            spaceId: 'space-1',
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('1.5'), findsOneWidget);
    expect(find.text('{Yes: 0.5, No: 0.5}'), findsOneWidget);
  });
}
