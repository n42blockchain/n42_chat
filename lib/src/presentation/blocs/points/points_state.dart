import 'package:equatable/equatable.dart';

import '../../../domain/entities/points/points_balance.dart';
import '../../../domain/entities/points/points_config.dart';
import '../../../domain/entities/points/points_transaction.dart';
import '../../../domain/entities/points/redemption_item.dart';

/// The loading lifecycle of the points feature.
enum PointsStatus {
  /// No data has been requested yet.
  initial,

  /// A request is in flight.
  loading,

  /// Data has been successfully loaded.
  loaded,

  /// An error occurred during the last request.
  error,

  /// A redemption is being processed.
  redeeming,

  /// A redemption completed successfully.
  redeemed,
}

/// Immutable state for the [PointsBloc].
class PointsState extends Equatable {
  /// Current loading status.
  final PointsStatus status;

  /// The user's points balance in the current room.
  final PointsBalance? balance;

  /// Recent transaction history.
  final List<PointsTransaction> transactions;

  /// Room leaderboard entries.
  final List<PointsBalance> leaderboard;

  /// Points system configuration for the room.
  final PointsConfig? config;

  /// Available redemption items.
  final List<RedemptionItem> redemptionItems;

  /// Human-readable error message when [status] is [PointsStatus.error].
  final String? errorMessage;

  const PointsState({
    this.status = PointsStatus.initial,
    this.balance,
    this.transactions = const [],
    this.leaderboard = const [],
    this.config,
    this.redemptionItems = const [],
    this.errorMessage,
  });

  /// Convenience getter for checking loading state.
  bool get isLoading => status == PointsStatus.loading;

  PointsState copyWith({
    PointsStatus? status,
    PointsBalance? balance,
    List<PointsTransaction>? transactions,
    List<PointsBalance>? leaderboard,
    PointsConfig? config,
    List<RedemptionItem>? redemptionItems,
    String? errorMessage,
  }) {
    return PointsState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      leaderboard: leaderboard ?? this.leaderboard,
      config: config ?? this.config,
      redemptionItems: redemptionItems ?? this.redemptionItems,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        balance,
        transactions,
        leaderboard,
        config,
        redemptionItems,
        errorMessage,
      ];
}
