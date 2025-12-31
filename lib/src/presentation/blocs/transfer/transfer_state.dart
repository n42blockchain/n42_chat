import 'package:equatable/equatable.dart';

import '../../../domain/entities/transfer_entity.dart';
import '../../../integration/wallet_bridge.dart';

/// 转账状态基类
abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object?> get props => [];
}

/// 转账初始状态
class TransferInitial extends TransferState {
  const TransferInitial();
}

/// 钱包信息已加载
class WalletInfoLoaded extends TransferState {
  /// 钱包是否已连接
  final bool isConnected;

  /// 钱包地址
  final String? walletAddress;

  /// 支持的代币列表
  final List<TokenInfo> tokens;

  /// 代币余额
  final Map<String, String> balances;

  const WalletInfoLoaded({
    required this.isConnected,
    this.walletAddress,
    this.tokens = const [],
    this.balances = const {},
  });

  @override
  List<Object?> get props => [isConnected, walletAddress, tokens, balances];

  WalletInfoLoaded copyWith({
    bool? isConnected,
    String? walletAddress,
    List<TokenInfo>? tokens,
    Map<String, String>? balances,
  }) {
    return WalletInfoLoaded(
      isConnected: isConnected ?? this.isConnected,
      walletAddress: walletAddress ?? this.walletAddress,
      tokens: tokens ?? this.tokens,
      balances: balances ?? this.balances,
    );
  }
}

/// 转账处理中
class TransferProcessing extends TransferState {
  final String message;

  const TransferProcessing([this.message = '处理中...']);

  @override
  List<Object?> get props => [message];
}

/// 转账成功
class TransferSuccess extends TransferState {
  final TransferEntity transfer;

  const TransferSuccess(this.transfer);

  @override
  List<Object?> get props => [transfer];
}

/// 转账失败
class TransferFailure extends TransferState {
  final String error;

  const TransferFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// 收款请求已创建
class PaymentRequestCreated extends TransferState {
  final PaymentRequest request;

  const PaymentRequestCreated(this.request);

  @override
  List<Object?> get props => [request];
}

/// 地址验证结果
class AddressValidated extends TransferState {
  final String address;
  final bool isValid;
  final WalletUserInfo? userInfo;

  const AddressValidated({
    required this.address,
    required this.isValid,
    this.userInfo,
  });

  @override
  List<Object?> get props => [address, isValid, userInfo];
}

