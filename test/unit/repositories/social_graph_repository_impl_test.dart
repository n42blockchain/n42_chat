import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/social_graph_service.dart';
import 'package:n42_chat/src/data/datasources/social/debank_datasource.dart';
import 'package:n42_chat/src/data/datasources/social/on_chain_identity_datasource.dart';
import 'package:n42_chat/src/data/models/social/debank_portfolio_model.dart';
import 'package:n42_chat/src/data/repositories/social_graph_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/social/social_connection.dart';
import 'package:n42_chat/src/domain/entities/social/social_profile.dart';
import 'package:n42_chat/src/domain/entities/social/social_recommendation.dart';

class MockDeBankDatasource extends Mock implements DeBankDatasource {}

class MockOnChainIdentityDatasource extends Mock
    implements OnChainIdentityDatasource {}

class MockSocialGraphService extends Mock implements SocialGraphService {}

void main() {
  late MockDeBankDatasource mockDeBank;
  late MockOnChainIdentityDatasource mockIdentity;
  late MockSocialGraphService mockGraphService;
  late SocialGraphRepositoryImpl repository;

  setUp(() {
    mockDeBank = MockDeBankDatasource();
    mockIdentity = MockOnChainIdentityDatasource();
    mockGraphService = MockSocialGraphService();
    repository = SocialGraphRepositoryImpl(
      debank: mockDeBank,
      identity: mockIdentity,
      graphService: mockGraphService,
    );
  });

  test('searchProfiles accepts a direct wallet address query', () async {
    const address = '0x1111111111111111111111111111111111111111';
    when(
      () => mockDeBank.getUserPortfolio(address),
    ).thenAnswer((_) async => const DeBankPortfolioModel(totalUsdValue: 42));
    when(
      () => mockDeBank.getUsedChains(address),
    ).thenAnswer((_) async => ['eth']);
    when(
      () => mockIdentity.getReverseIdentities(address),
    ).thenAnswer((_) async => {'ens': 'alice.eth'});

    final results = await repository.searchProfiles(address);

    expect(results, hasLength(1));
    expect(results.first.address, address);
    expect(results.first.ensName, 'alice.eth');
    verifyNever(() => mockIdentity.resolveENS(any()));
  });

  test('getConnections deduplicates identical connection entries', () async {
    const address = '0x1111111111111111111111111111111111111111';
    const other = '0x2222222222222222222222222222222222222222';
    const connection = SocialConnection(
      fromAddress: address,
      toAddress: other,
      type: ConnectionType.commonTokens,
      strength: 0.8,
    );

    when(
      () => mockGraphService.getRecommendations(address, limit: 50),
    ).thenAnswer(
      (_) async => const [
        SocialRecommendation(
          profile: SocialProfile(address: other),
          similarityScore: 0.8,
          connections: [connection],
          reason: 'Shared holdings',
        ),
        SocialRecommendation(
          profile: SocialProfile(address: other),
          similarityScore: 0.7,
          connections: [connection],
          reason: 'Shared holdings again',
        ),
      ],
    );

    final connections = await repository.getConnections(address);

    expect(connections, hasLength(1));
    expect(connections.first.toAddress, other);
  });
}
