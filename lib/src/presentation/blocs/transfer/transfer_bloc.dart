import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/transfer_entity.dart';
import '../../../domain/repositories/transfer_repository.dart';
import '../../../integration/wallet_bridge.dart';
import 'transfer_event.dart';
import 'transfer_state.dart';

/// 转账BLoC
class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final ITransferRepository _transferRepository;
  final IWalletBridge _walletBridge;

  TransferBloc(this._transferRepository, this._walletBridge)
      : super(const TransferInitial()) {
    on<LoadWalletInfo>(_onLoadWalletInfo);
    on<LoadTokens>(_onLoadTokens);
    on<LoadTokenBalance>(_onLoadTokenBalance);
    on<InitiateTransfer>(_onInitiateTransfer);
    on<CreatePaymentRequest>(_onCreatePaymentRequest);
    on<FulfillPaymentRequest>(_onFulfillPaymentRequest);
    on<ValidateAddress>(_onValidateAddress);
    on<ClearTransferState>(_onClearTransferState);
  }

  Future<void> _onLoadWalletInfo(
    LoadWalletInfo event,
    Emitter<TransferState> emit,
  ) async {
    try {
      final isConnected = _walletBridge.isWalletConnected;
      final walletAddress = _walletBridge.walletAddress;
      final tokens = await _walletBridge.getSupportedTokens();

      // 加载所有代币余额
      final balances = <String, String>{};
      for (final token in tokens) {
        try {
          balances[token.symbol] = await _walletBridge.getBalance(token.symbol);
        } catch (e) {
          balances[token.symbol] = '0';
        }
      }

      emit(WalletInfoLoaded(
        isConnected: isConnected,
        walletAddress: walletAddress,
        tokens: tokens,
        balances: balances,
      ));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onLoadTokens(
    LoadTokens event,
    Emitter<TransferState> emit,
  ) async {
    if (state is! WalletInfoLoaded) {
      add(const LoadWalletInfo());
      return;
    }

    try {
      final tokens = await _transferRepository.getSupportedTokens();
      final currentState = state as WalletInfoLoaded;
      emit(currentState.copyWith(tokens: tokens));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onLoadTokenBalance(
    LoadTokenBalance event,
    Emitter<TransferState> emit,
  ) async {
    if (state is! WalletInfoLoaded) return;

    try {
      final balance = await _transferRepository.getTokenBalance(event.token);
      final currentState = state as WalletInfoLoaded;
      final newBalances = Map<String, String>.from(currentState.balances);
      newBalances[event.token] = balance;
      emit(currentState.copyWith(balances: newBalances));
    } catch (e) {
      // 忽略余额加载错误
    }
  }

  Future<void> _onInitiateTransfer(
    InitiateTransfer event,
    Emitter<TransferState> emit,
  ) async {
    emit(const TransferProcessing('正在处理转账...'));

    try {
      final transfer = await _transferRepository.initiateTransfer(
        roomId: event.roomId,
        receiverAddress: event.receiverAddress,
        amount: event.amount,
        token: event.token,
        memo: event.memo,
      );

      if (transfer.isSuccess) {
        emit(TransferSuccess(transfer));
      } else if (transfer.status == TransferStatus.cancelled) {
        emit(const TransferFailure('转账已取消'));
      } else {
        emit(TransferFailure(transfer.failureReason ?? '转账失败'));
      }
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onCreatePaymentRequest(
    CreatePaymentRequest event,
    Emitter<TransferState> emit,
  ) async {
    emit(const TransferProcessing('正在创建收款请求...'));

    try {
      final request = await _transferRepository.createPaymentRequest(
        amount: event.amount,
        token: event.token,
        memo: event.memo,
      );

      // 发送收款请求消息
      await _transferRepository.sendPaymentRequestMessage(
        roomId: event.roomId,
        request: request,
      );

      emit(PaymentRequestCreated(request));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onFulfillPaymentRequest(
    FulfillPaymentRequest event,
    Emitter<TransferState> emit,
  ) async {
    emit(const TransferProcessing('正在处理支付...'));

    try {
      final transfer = await _transferRepository.fulfillPaymentRequest(
        roomId: event.roomId,
        requestId: event.requestId,
        receiverAddress: event.receiverAddress,
        amount: event.amount,
        token: event.token,
      );

      if (transfer.isSuccess) {
        emit(TransferSuccess(transfer));
      } else {
        emit(TransferFailure(transfer.failureReason ?? '支付失败'));
      }
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onValidateAddress(
    ValidateAddress event,
    Emitter<TransferState> emit,
  ) async {
    final isValid = _transferRepository.isValidAddress(event.address);

    WalletUserInfo? userInfo;
    if (isValid) {
      userInfo = await _walletBridge.getUserInfoByAddress(event.address);
    }

    emit(AddressValidated(
      address: event.address,
      isValid: isValid,
      userInfo: userInfo,
    ));
  }

  void _onClearTransferState(
    ClearTransferState event,
    Emitter<TransferState> emit,
  ) {
    add(const LoadWalletInfo());
  }
}

