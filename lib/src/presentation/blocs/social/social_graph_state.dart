import 'package:equatable/equatable.dart';

import '../../../domain/entities/social/social_profile.dart';
import '../../../domain/entities/social/social_recommendation.dart';

/// The loading lifecycle of the social graph feature.
enum SocialGraphStatus {
  /// No data has been requested yet.
  initial,

  /// A request is in flight.
  loading,

  /// Data has been successfully loaded.
  loaded,

  /// An error occurred during the last request.
  error,
}

/// Immutable state for the [SocialGraphBloc].
class SocialGraphState extends Equatable {
  /// Current loading status.
  final SocialGraphStatus status;

  /// The loaded social profile (null until [SocialGraphLoadProfile] succeeds).
  final SocialProfile? profile;

  /// List of recommended connections.
  final List<SocialRecommendation> recommendations;

  /// Search results from [SocialGraphSearchProfiles].
  final List<SocialProfile> searchResults;

  /// Similarity score from [SocialGraphCalculateSimilarity].
  final double? similarityScore;

  /// Human-readable error message when [status] is [SocialGraphStatus.error].
  final String? errorMessage;

  const SocialGraphState({
    this.status = SocialGraphStatus.initial,
    this.profile,
    this.recommendations = const [],
    this.searchResults = const [],
    this.similarityScore,
    this.errorMessage,
  });

  /// Convenience getter for checking loading state.
  bool get isLoading => status == SocialGraphStatus.loading;

  SocialGraphState copyWith({
    SocialGraphStatus? status,
    SocialProfile? profile,
    List<SocialRecommendation>? recommendations,
    List<SocialProfile>? searchResults,
    double? similarityScore,
    String? errorMessage,
  }) {
    return SocialGraphState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      recommendations: recommendations ?? this.recommendations,
      searchResults: searchResults ?? this.searchResults,
      similarityScore: similarityScore ?? this.similarityScore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profile,
        recommendations,
        searchResults,
        similarityScore,
        errorMessage,
      ];
}
