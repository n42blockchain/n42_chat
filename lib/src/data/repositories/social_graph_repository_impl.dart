import '../../core/services/social_graph_service.dart';
import '../../domain/entities/social/social_connection.dart';
import '../../domain/entities/social/social_profile.dart';
import '../../domain/entities/social/social_recommendation.dart';
import '../../domain/repositories/social_graph_repository.dart';
import '../datasources/social/debank_datasource.dart';
import '../datasources/social/on_chain_identity_datasource.dart';
import '../models/social/debank_portfolio_model.dart';

/// Implementation of [ISocialGraphRepository].
///
/// Aggregates data from DeBank (portfolio/tokens), Alchemy (NFTs), and
/// on-chain identity providers (ENS, Lens, Farcaster) to build a complete
/// social profile and compute recommendations.
class SocialGraphRepositoryImpl implements ISocialGraphRepository {
  final DeBankDatasource _debank;
  final OnChainIdentityDatasource _identity;
  final SocialGraphService _graphService;

  SocialGraphRepositoryImpl({
    required DeBankDatasource debank,
    required OnChainIdentityDatasource identity,
    required SocialGraphService graphService,
  }) : _debank = debank,
       _identity = identity,
       _graphService = graphService;

  /// Validate that [address] looks like a plausible blockchain address.
  ///
  /// Accepts EVM (0x-prefixed, 42 chars) and other common formats.
  /// This is a lightweight check to catch obvious bad input before
  /// making network calls.
  bool _isValidAddress(String address) {
    if (address.isEmpty) return false;
    // EVM addresses: 0x + 40 hex chars
    if (address.startsWith('0x')) {
      return address.length == 42 &&
          RegExp(r'^0x[0-9a-fA-F]{40}$').hasMatch(address);
    }
    // Non-EVM addresses: at least 20 chars, no whitespace
    return address.length >= 20 && !address.contains(RegExp(r'\s'));
  }

  @override
  Future<SocialProfile> getProfile(String address) async {
    if (!_isValidAddress(address)) {
      throw ArgumentError('Invalid address: $address');
    }

    // Fetch portfolio, chains, and identities in parallel
    final results = await Future.wait([
      _debank.getUserPortfolio(address),
      _debank.getUsedChains(address),
      _identity.getReverseIdentities(address),
    ]);

    final portfolio = results[0] as DeBankPortfolioModel;
    final chains = results[1] as List<String>;
    final identities = results[2] as Map<String, String?>;

    return SocialProfile(
      address: address,
      ensName: identities['ens'],
      lensHandle: identities['lens'],
      chains: chains,
      portfolioValueUsd: portfolio.totalUsdValue,
    );
  }

  @override
  Future<List<SocialConnection>> getConnections(String address) async {
    if (!_isValidAddress(address)) {
      throw ArgumentError('Invalid address: $address');
    }

    // Connections are derived from the recommendation engine
    final recommendations = await getRecommendations(address, limit: 50);
    final deduped = <String, SocialConnection>{};
    for (final connection in recommendations.expand((r) => r.connections)) {
      final key =
          '${connection.fromAddress.toLowerCase()}|${connection.toAddress.toLowerCase()}|${connection.type.name}';
      deduped.putIfAbsent(key, () => connection);
    }
    return deduped.values.toList(growable: false);
  }

  @override
  Future<List<SocialRecommendation>> getRecommendations(
    String address, {
    int limit = 20,
  }) async {
    if (!_isValidAddress(address)) {
      throw ArgumentError('Invalid address: $address');
    }

    return _graphService.getRecommendations(address, limit: limit);
  }

  @override
  Future<double> calculateSimilarity(String addressA, String addressB) async {
    if (!_isValidAddress(addressA)) {
      throw ArgumentError('Invalid addressA: $addressA');
    }
    if (!_isValidAddress(addressB)) {
      throw ArgumentError('Invalid addressB: $addressB');
    }

    final result = await _graphService.calculateSimilarity(addressA, addressB);
    return result.totalScore;
  }

  @override
  Future<List<SocialProfile>> searchProfiles(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      return [];
    }

    if (_isValidAddress(normalizedQuery)) {
      try {
        return [await getProfile(normalizedQuery)];
      } catch (_) {
        return [SocialProfile(address: normalizedQuery)];
      }
    }

    // Try resolving the query as ENS, Lens, or Farcaster in parallel
    final results = await Future.wait([
      _identity.resolveENS(normalizedQuery),
      _identity.resolveLensHandle(normalizedQuery),
      _identity.resolveFarcaster(normalizedQuery),
    ]);

    final profiles = <SocialProfile>[];
    final seen = <String>{};

    for (final address in results) {
      if (address != null &&
          address.isNotEmpty &&
          !seen.contains(address.toLowerCase())) {
        seen.add(address.toLowerCase());
        try {
          final profile = await getProfile(address);
          profiles.add(profile);
        } catch (_) {
          // Fall back to a minimal profile with just the address
          profiles.add(SocialProfile(address: address));
        }
      }
    }

    return profiles;
  }

  /// Release resources held by all datasources.
  void dispose() {
    _debank.dispose();
    _identity.dispose();
  }
}
