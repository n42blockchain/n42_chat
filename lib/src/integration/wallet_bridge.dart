/// 钱包集成桥接接口
///
/// 在主应用中实现此接口以启用聊天中的加密货币转账功能
///
/// ## 使用示例
///
/// ```dart
/// class MyWalletBridge implements IWalletBridge {
///   @override
///   bool get isWalletConnected => _wallet.isConnected;
///
///   @override
///   Future<TransferResult> requestTransfer({...}) async {
///     // 实现转账逻辑
///   }
/// }
///
/// // 配置时传入
/// N42Chat.initialize(N42ChatConfig(
///   walletBridge: MyWalletBridge(),
/// ));
/// ```
abstract class IWalletBridge {
  /// 钱包是否已连接
  bool get isWalletConnected;

  /// 当前钱包地址
  String? get walletAddress;

  /// 获取支持的代币列表
  Future<List<TokenInfo>> getSupportedTokens();

  /// 获取代币余额
  ///
  /// [token] 代币符号或合约地址
  Future<String> getBalance(String token);

  /// 发起转账
  ///
  /// [toAddress] 接收方地址
  /// [amount] 转账金额
  /// [token] 代币符号或合约地址
  /// [memo] 备注
  Future<TransferResult> requestTransfer({
    required String toAddress,
    required String amount,
    required String token,
    String? memo,
  });

  /// 生成收款请求
  ///
  /// [amount] 请求金额
  /// [token] 代币符号
  /// [memo] 备注
  Future<PaymentRequest> generatePaymentRequest({
    required String amount,
    required String token,
    String? memo,
  });

  /// 显示收款二维码
  Future<void> showReceiveQRCode();

  /// 验证地址是否有效
  bool isValidAddress(String address);

  /// 获取地址对应的用户信息（如果有）
  Future<WalletUserInfo?> getUserInfoByAddress(String address);
}

/// 转账结果
class TransferResult {
  /// 是否成功
  final bool success;

  /// 交易哈希
  final String? transactionHash;

  /// 错误消息
  final String? errorMessage;

  /// 错误代码
  final String? errorCode;

  const TransferResult({
    required this.success,
    this.transactionHash,
    this.errorMessage,
    this.errorCode,
  });

  /// 创建成功结果
  factory TransferResult.success(String txHash) => TransferResult(
        success: true,
        transactionHash: txHash,
      );

  /// 创建失败结果
  factory TransferResult.failure(String error, {String? code}) => TransferResult(
        success: false,
        errorMessage: error,
        errorCode: code,
      );

  /// 创建取消结果
  factory TransferResult.cancelled() => const TransferResult(
        success: false,
        errorMessage: '用户取消',
        errorCode: 'CANCELLED',
      );
}

/// 收款请求
class PaymentRequest {
  /// 请求ID
  final String requestId;

  /// 请求金额
  final String amount;

  /// 代币符号
  final String token;

  /// 收款地址
  final String receiverAddress;

  /// 备注
  final String? memo;

  /// 二维码数据
  final String qrCodeData;

  /// 创建时间
  final DateTime createdAt;

  /// 过期时间
  final DateTime? expiresAt;

  const PaymentRequest({
    required this.requestId,
    required this.amount,
    required this.token,
    required this.receiverAddress,
    this.memo,
    required this.qrCodeData,
    required this.createdAt,
    this.expiresAt,
  });

  /// 是否已过期
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// 格式化显示金额
  String get formattedAmount => '$amount $token';
}

/// 代币信息
class TokenInfo {
  /// 代币符号
  final String symbol;

  /// 代币名称
  final String name;

  /// 小数位数
  final int decimals;

  /// 合约地址（原生代币为空）
  final String? contractAddress;

  /// 图标URL
  final String? iconUrl;

  /// 是否是原生代币
  final bool isNative;

  const TokenInfo({
    required this.symbol,
    required this.name,
    required this.decimals,
    this.contractAddress,
    this.iconUrl,
    this.isNative = false,
  });
}

/// 钱包用户信息
class WalletUserInfo {
  /// 钱包地址
  final String address;

  /// 用户名/昵称
  final String? username;

  /// 头像URL
  final String? avatarUrl;

  /// Matrix用户ID（如果已关联）
  final String? matrixUserId;

  const WalletUserInfo({
    required this.address,
    this.username,
    this.avatarUrl,
    this.matrixUserId,
  });

  /// 获取显示名称
  String get displayName {
    if (username != null && username!.isNotEmpty) {
      return username!;
    }
    // 缩短地址显示
    if (address.length > 10) {
      return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
    }
    return address;
  }
}

/// 模拟钱包桥接实现（用于测试）
class MockWalletBridge implements IWalletBridge {
  @override
  bool get isWalletConnected => true;

  @override
  String? get walletAddress => '0x1234567890abcdef1234567890abcdef12345678';

  @override
  Future<List<TokenInfo>> getSupportedTokens() async {
    return const [
      TokenInfo(
        symbol: 'ETH',
        name: 'Ethereum',
        decimals: 18,
        isNative: true,
      ),
      TokenInfo(
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        contractAddress: '0xdac17f958d2ee523a2206206994597c13d831ec7',
      ),
    ];
  }

  @override
  Future<String> getBalance(String token) async {
    return token == 'ETH' ? '1.5' : '100.00';
  }

  @override
  Future<TransferResult> requestTransfer({
    required String toAddress,
    required String amount,
    required String token,
    String? memo,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return TransferResult.success('0x${'1234' * 16}');
  }

  @override
  Future<PaymentRequest> generatePaymentRequest({
    required String amount,
    required String token,
    String? memo,
  }) async {
    return PaymentRequest(
      requestId: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      token: token,
      receiverAddress: walletAddress!,
      memo: memo,
      qrCodeData: 'n42://pay?address=$walletAddress&amount=$amount&token=$token',
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(minutes: 30)),
    );
  }

  @override
  Future<void> showReceiveQRCode() async {
    // 显示收款二维码
  }

  @override
  bool isValidAddress(String address) {
    return address.startsWith('0x') && address.length == 42;
  }

  @override
  Future<WalletUserInfo?> getUserInfoByAddress(String address) async {
    return null;
  }
}

