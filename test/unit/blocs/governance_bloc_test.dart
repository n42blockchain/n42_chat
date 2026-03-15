import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/governance/proposal_entity.dart';
import 'package:n42_chat/src/domain/entities/governance/vote_entity.dart';
import 'package:n42_chat/src/domain/repositories/governance_repository.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_event.dart';
import 'package:n42_chat/src/presentation/blocs/governance/governance_state.dart';

class MockGovernanceRepository extends Mock implements IGovernanceRepository {}

void main() {
  late MockGovernanceRepository mockRepository;

  final staleProposal = ProposalEntity(
    id: 'proposal-1',
    spaceId: 'space-1',
    title: 'Old title',
    body: 'Old body',
    author: '0xabc',
    state: ProposalState.active,
    choices: const ['Yes', 'No'],
    startTime: DateTime(2026, 1, 1, 10),
    endTime: DateTime(2026, 1, 4, 10),
    votesCount: 1,
  );

  final freshProposal = staleProposal.copyWith(
    title: 'Fresh title',
    votesCount: 3,
    scoresTotal: 42,
  );

  const freshVotes = <VoteEntity>[];

  setUp(() {
    mockRepository = MockGovernanceRepository();
  });

  group('GovernanceBloc', () {
    blocTest<GovernanceBloc, GovernanceState>(
      'load proposal detail syncs refreshed proposal back into proposals list',
      setUp: () {
        when(
          () => mockRepository.getProposal('proposal-1'),
        ).thenAnswer((_) async => freshProposal);
        when(
          () => mockRepository.getVotes(
            'proposal-1',
            voter: any(named: 'voter'),
            first: any(named: 'first'),
            skip: any(named: 'skip'),
          ),
        ).thenAnswer((_) async => freshVotes);
      },
      build: () => GovernanceBloc(repository: mockRepository),
      seed: () => GovernanceState(
        status: GovernanceStatus.loaded,
        proposals: [staleProposal],
      ),
      act: (bloc) => bloc.add(const GovernanceLoadProposalDetail('proposal-1')),
      expect: () => [
        isA<GovernanceState>()
            .having((s) => s.status, 'status', GovernanceStatus.loading),
        isA<GovernanceState>()
            .having((s) => s.status, 'status', GovernanceStatus.loaded)
            .having((s) => s.selectedProposal?.title, 'selected title', 'Fresh title')
            .having((s) => s.proposals.first.title, 'list title', 'Fresh title')
            .having((s) => s.proposals.first.votesCount, 'votesCount', 3),
      ],
    );

    blocTest<GovernanceBloc, GovernanceState>(
      'cast vote syncs refreshed proposal back into proposals list',
      setUp: () {
        when(
          () => mockRepository.castVote(
            spaceId: 'space-1',
            proposalId: 'proposal-1',
            choice: 1,
            reason: null,
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockRepository.getProposal('proposal-1'),
        ).thenAnswer((_) async => freshProposal);
        when(
          () => mockRepository.getVotes(
            'proposal-1',
            voter: any(named: 'voter'),
            first: any(named: 'first'),
            skip: any(named: 'skip'),
          ),
        ).thenAnswer((_) async => freshVotes);
      },
      build: () => GovernanceBloc(repository: mockRepository),
      seed: () => GovernanceState(
        status: GovernanceStatus.loaded,
        proposals: [staleProposal],
        selectedProposal: staleProposal,
      ),
      act: (bloc) => bloc.add(
        const GovernanceCastVote(
          spaceId: 'space-1',
          proposalId: 'proposal-1',
          choice: 1,
        ),
      ),
      expect: () => [
        isA<GovernanceState>()
            .having((s) => s.status, 'status', GovernanceStatus.voting),
        isA<GovernanceState>()
            .having((s) => s.status, 'status', GovernanceStatus.voted)
            .having((s) => s.selectedProposal?.title, 'selected title', 'Fresh title')
            .having((s) => s.proposals.first.title, 'list title', 'Fresh title')
            .having((s) => s.proposals.first.votesCount, 'votesCount', 3),
      ],
    );
  });
}
