import '../entities/social/social_connection.dart';
import '../entities/social/social_profile.dart';
import '../entities/social/social_recommendation.dart';

/// Repository interface for on-chain social graph operations.
///
/// Provides address-level social discovery: profile resolution,
/// connection enumeration, recommendation generation, and similarity
/// calculation across multiple chains and protocols.
abstract class ISocialGraphRepository {
  /// Get the on-chain social profile for [address].
  ///
  /// Resolves ENS/Lens/Farcaster identities and aggregates portfolio data.
  Future<SocialProfile> getProfile(String address);

  /// Get social connections for [address].
  ///
  /// Returns all known connections ordered by strength descending.
  Future<List<SocialConnection>> getConnections(String address);

  /// Get recommended connections based on on-chain similarity.
  ///
  /// Returns up to [limit] recommendations sorted by similarity score.
  Future<List<SocialRecommendation>> getRecommendations(
    String address, {
    int limit = 20,
  });

  /// Calculate the similarity score between [addressA] and [addressB].
  ///
  /// Returns a value from 0.0 (no overlap) to 1.0 (identical portfolios).
  Future<double> calculateSimilarity(String addressA, String addressB);

  /// Search for profiles by ENS name, Lens handle, or Farcaster username.
  Future<List<SocialProfile>> searchProfiles(String query);
}
