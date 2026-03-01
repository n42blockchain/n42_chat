import '../../data/datasources/social/alchemy_social_datasource.dart';
import '../../data/datasources/social/debank_datasource.dart';
import '../../data/models/social/social_similarity_model.dart';
import '../../domain/entities/social/social_connection.dart';
import '../../domain/entities/social/social_profile.dart';
import '../../domain/entities/social/social_recommendation.dart';

/// Service for calculating on-chain social similarity between addresses.
///
/// Uses multiple data sources (DeBank for tokens/chains, Alchemy for NFTs)
/// to compute a multi-dimensional similarity score: token overlap, NFT
/// collection overlap, chain usage, etc.
///
/// The similarity is calculated as a weighted Jaccard index across each
/// dimension, with weights reflecting the strength of each signal:
/// - Token overlap: 30%
/// - NFT collections: 25%
/// - Transaction interaction: 20%
/// - Chain usage: 15%
/// - DAO membership: 10%
class SocialGraphService {
  final DeBankDatasource _debank;
  final AlchemySocialDatasource _alchemy;

  SocialGraphService({
    required DeBankDatasource debank,
    required AlchemySocialDatasource alchemy,
  })  : _debank = debank,
        _alchemy = alchemy;

  /// Calculate the multi-dimensional similarity between [addressA] and
  /// [addressB].
  ///
  /// Fetches token holdings, NFT collections, and chain usage in parallel,
  /// then computes the Jaccard index for each dimension.
  Future<SocialSimilarityModel> calculateSimilarity(
    String addressA,
    String addressB,
  ) async {
    final results = await Future.wait([
      _tokenOverlapScore(addressA, addressB),
      _nftCollectionScore(addressA, addressB),
      _chainUsageScore(addressA, addressB),
    ]);

    final tokenResult = results[0];
    final nftResult = results[1];
    final chainResult = results[2];

    final model = SocialSimilarityModel(
      addressA: addressA,
      addressB: addressB,
      tokenOverlap: tokenResult.score,
      nftOverlap: nftResult.score,
      chainUsage: chainResult.score,
      commonTokens: tokenResult.items,
      commonNftCollections: nftResult.items,
      commonChains: chainResult.items,
    );

    return SocialSimilarityModel(
      addressA: addressA,
      addressB: addressB,
      tokenOverlap: model.tokenOverlap,
      nftOverlap: model.nftOverlap,
      transactionInteraction: model.transactionInteraction,
      chainUsage: model.chainUsage,
      daoMembership: model.daoMembership,
      totalScore: model.weightedScore,
      commonTokens: model.commonTokens,
      commonNftCollections: model.commonNftCollections,
      commonChains: model.commonChains,
    );
  }

  /// Get social recommendations for [address].
  ///
  /// Strategy:
  /// 1. Fetch the user's NFT collections.
  /// 2. For each collection (up to 5), fetch other owners.
  /// 3. Calculate similarity with each candidate.
  /// 4. Return the top [limit] results sorted by score.
  Future<List<SocialRecommendation>> getRecommendations(
    String address, {
    int limit = 20,
  }) async {
    // Step 1: Get user's NFT collections to discover candidate peers
    final nfts = await _alchemy.getUserNFTs(address, pageSize: 50);

    // Step 2: Extract unique contract addresses (limit to 5 API calls)
    final contracts = nfts
        .map((nft) => nft['contract']?['address'] as String?)
        .where((addr) => addr != null)
        .toSet()
        .take(5)
        .toList();

    // Step 3: Collect unique owners across all collections.
    // Cap to 200 entries to limit downstream API calls (each candidate
    // triggers token + NFT + chain lookups against DeBank and Alchemy).
    final holderSet = <String>{};
    for (final contract in contracts) {
      if (contract == null) continue;
      try {
        final owners = await _alchemy.getCollectionOwners(contract);
        holderSet.addAll(owners);
        if (holderSet.length >= 200) break; // rate-limit: cap holder set
      } catch (_) {
        // Skip collections where owner lookup fails
      }
    }

    // Remove the querying user from candidates
    holderSet.remove(address.toLowerCase());

    // Step 4: Score each candidate.
    // Limit candidates to avoid excessive API calls (each candidate
    // requires ~5 API calls for similarity calculation).
    final maxCandidates = limit < 10 ? limit : 10;
    final candidates = holderSet.take(maxCandidates).toList();
    final recommendations = <SocialRecommendation>[];

    for (final candidate in candidates) {
      try {
        final similarity = await calculateSimilarity(address, candidate);
        if (similarity.totalScore > 0.1) {
          final connections = <SocialConnection>[];

          if (similarity.commonTokens.isNotEmpty) {
            connections.add(SocialConnection(
              fromAddress: address,
              toAddress: candidate,
              type: ConnectionType.commonTokens,
              strength: similarity.tokenOverlap,
              sharedItems: similarity.commonTokens,
            ));
          }
          if (similarity.commonNftCollections.isNotEmpty) {
            connections.add(SocialConnection(
              fromAddress: address,
              toAddress: candidate,
              type: ConnectionType.commonNfts,
              strength: similarity.nftOverlap,
              sharedItems: similarity.commonNftCollections,
            ));
          }
          if (similarity.commonChains.isNotEmpty) {
            connections.add(SocialConnection(
              fromAddress: address,
              toAddress: candidate,
              type: ConnectionType.commonChains,
              strength: similarity.chainUsage,
              sharedItems: similarity.commonChains,
            ));
          }

          recommendations.add(SocialRecommendation(
            profile: SocialProfile(address: candidate),
            similarityScore: similarity.totalScore,
            connections: connections,
            reason: _buildReason(similarity),
          ));
        }
      } catch (_) {
        // Skip candidates with API errors
      }
    }

    // Sort by similarity score descending and take the top results
    recommendations
        .sort((a, b) => b.similarityScore.compareTo(a.similarityScore));
    return recommendations.take(limit).toList();
  }

  // ---------------------------------------------------------------------------
  // Dimension scoring
  // ---------------------------------------------------------------------------

  // Each scoring method makes 2-3 API calls per invocation.
  // With N candidates, total API calls = N * ~7 (token: 3, NFT: 2, chain: 2).
  // The candidate cap in getRecommendations() keeps this bounded.

  Future<_ScoreResult> _tokenOverlapScore(
    String addrA,
    String addrB,
  ) async {
    try {
      final chainsA = await _debank.getUsedChains(addrA);
      final commonChain = chainsA.isNotEmpty ? chainsA.first : 'eth';

      final tokensA = await _debank.getUserTokenList(addrA, commonChain);
      final tokensB = await _debank.getUserTokenList(addrB, commonChain);

      final symbolsA = tokensA
          .map((t) => t['symbol'] as String?)
          .where((s) => s != null)
          .toSet();
      final symbolsB = tokensB
          .map((t) => t['symbol'] as String?)
          .where((s) => s != null)
          .toSet();

      final common = symbolsA.intersection(symbolsB);
      final union = symbolsA.union(symbolsB);

      final score = union.isEmpty ? 0.0 : common.length / union.length;
      return _ScoreResult(score, common.cast<String>().toList());
    } catch (_) {
      return const _ScoreResult(0, []);
    }
  }

  Future<_ScoreResult> _nftCollectionScore(
    String addrA,
    String addrB,
  ) async {
    try {
      final nftsA = await _alchemy.getUserNFTs(addrA, pageSize: 50);
      final nftsB = await _alchemy.getUserNFTs(addrB, pageSize: 50);

      final collectionsA = nftsA
          .map((n) => n['contract']?['address'] as String?)
          .where((a) => a != null)
          .toSet();
      final collectionsB = nftsB
          .map((n) => n['contract']?['address'] as String?)
          .where((a) => a != null)
          .toSet();

      final common = collectionsA.intersection(collectionsB);
      final union = collectionsA.union(collectionsB);

      final score = union.isEmpty ? 0.0 : common.length / union.length;
      return _ScoreResult(score, common.cast<String>().toList());
    } catch (_) {
      return const _ScoreResult(0, []);
    }
  }

  Future<_ScoreResult> _chainUsageScore(
    String addrA,
    String addrB,
  ) async {
    try {
      final chainsA = await _debank.getUsedChains(addrA);
      final chainsB = await _debank.getUsedChains(addrB);

      final setA = chainsA.toSet();
      final setB = chainsB.toSet();

      final common = setA.intersection(setB);
      final union = setA.union(setB);

      final score = union.isEmpty ? 0.0 : common.length / union.length;
      return _ScoreResult(score, common.toList());
    } catch (_) {
      return const _ScoreResult(0, []);
    }
  }

  String _buildReason(SocialSimilarityModel similarity) {
    final parts = <String>[];
    if (similarity.commonTokens.isNotEmpty) {
      parts.add('${similarity.commonTokens.length} common tokens');
    }
    if (similarity.commonNftCollections.isNotEmpty) {
      parts.add(
          '${similarity.commonNftCollections.length} shared NFT collections');
    }
    if (similarity.commonChains.isNotEmpty) {
      parts.add('${similarity.commonChains.length} common chains');
    }
    return parts.isEmpty ? 'On-chain activity overlap' : parts.join(', ');
  }
}

/// Internal helper for returning a score together with the matching items.
class _ScoreResult {
  final double score;
  final List<String> items;
  const _ScoreResult(this.score, this.items);
}
