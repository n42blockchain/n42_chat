import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/points_repository.dart';
import 'points_event.dart';
import 'points_state.dart';

/// BLoC that manages points / rewards state.
///
/// Delegates all data operations to [IPointsRepository] and maps
/// events to states following the standard loading / loaded / error
/// lifecycle.
class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final IPointsRepository _repository;

  PointsBloc({required IPointsRepository repository})
      : _repository = repository,
        super(const PointsState()) {
    on<PointsLoadBalance>(_onLoadBalance);
    on<PointsLoadTransactions>(_onLoadTransactions);
    on<PointsLoadLeaderboard>(_onLoadLeaderboard);
    on<PointsLoadConfig>(_onLoadConfig);
    on<PointsUpdateConfig>(_onUpdateConfig);
    on<PointsLoadRedemptionItems>(_onLoadRedemptionItems);
    on<PointsRedeemItem>(_onRedeemItem);
  }

  Future<void> _onLoadBalance(
    PointsLoadBalance event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      final balance = await _repository.getBalance(
        event.userId,
        event.roomId,
      );
      emit(state.copyWith(
        status: PointsStatus.loaded,
        balance: balance,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadTransactions(
    PointsLoadTransactions event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      final transactions = await _repository.getTransactions(
        event.userId,
        event.roomId,
      );
      emit(state.copyWith(
        status: PointsStatus.loaded,
        transactions: transactions,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadLeaderboard(
    PointsLoadLeaderboard event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      final leaderboard = await _repository.getLeaderboard(event.roomId);
      emit(state.copyWith(
        status: PointsStatus.loaded,
        leaderboard: leaderboard,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadConfig(
    PointsLoadConfig event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      final config = await _repository.getConfig(event.roomId);
      emit(state.copyWith(
        status: PointsStatus.loaded,
        config: config,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateConfig(
    PointsUpdateConfig event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      await _repository.updateConfig(event.config);
      emit(state.copyWith(
        status: PointsStatus.loaded,
        config: event.config,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadRedemptionItems(
    PointsLoadRedemptionItems event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.loading));
    try {
      final items = await _repository.getRedemptionItems(event.roomId);
      emit(state.copyWith(
        status: PointsStatus.loaded,
        redemptionItems: items,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRedeemItem(
    PointsRedeemItem event,
    Emitter<PointsState> emit,
  ) async {
    emit(state.copyWith(status: PointsStatus.redeeming));
    try {
      await _repository.redeemItem(
        userId: event.userId,
        roomId: event.roomId,
        itemId: event.itemId,
      );

      // Refresh balance and redemption items after successful redemption
      final balance = await _repository.getBalance(
        event.userId,
        event.roomId,
      );
      final items = await _repository.getRedemptionItems(event.roomId);

      // Emit `redeemed` as a one-shot status. The UI layer (BlocListener)
      // should react to this status (e.g., show a snackbar) and then
      // trigger a fresh PointsLoadBalance to reset to `loaded`.
      emit(state.copyWith(
        status: PointsStatus.redeemed,
        balance: balance,
        redemptionItems: items,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PointsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
