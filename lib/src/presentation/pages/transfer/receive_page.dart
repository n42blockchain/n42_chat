import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../integration/wallet_bridge.dart';
import '../../blocs/transfer/transfer_bloc.dart';
import '../../blocs/transfer/transfer_event.dart';
import '../../blocs/transfer/transfer_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 收款页面
class ReceivePage extends StatefulWidget {
  final String? roomId;

  const ReceivePage({
    super.key,
    this.roomId,
  });

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  TokenInfo? _selectedToken;
  bool _showRequestForm = false;

  @override
  void initState() {
    super.initState();
    context.read<TransferBloc>().add(const LoadWalletInfo());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _createPaymentRequest() {
    final amount = _amountController.text.trim();
    final memo = _memoController.text.trim();

    if (amount.isEmpty || double.tryParse(amount) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的金额')),
      );
      return;
    }

    if (_selectedToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请选择代币')),
      );
      return;
    }

    if (widget.roomId != null) {
      context.read<TransferBloc>().add(CreatePaymentRequest(
            roomId: widget.roomId!,
            amount: amount,
            token: _selectedToken!.symbol,
            memo: memo.isNotEmpty ? memo : null,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state is PaymentRequestCreated) {
          Navigator.pop(context, state.request);
        } else if (state is TransferFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        String? walletAddress;
        List<TokenInfo> tokens = [];

        if (state is WalletInfoLoaded) {
          walletAddress = state.walletAddress;
          tokens = state.tokens;

          if (_selectedToken == null && tokens.isNotEmpty) {
            _selectedToken = tokens.first;
          }
        }

        return Scaffold(
          backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
          appBar: N42AppBar(
            title: '收款',
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: _buildBody(walletAddress, tokens, state, isDark),
        );
      },
    );
  }

  Widget _buildBody(
    String? walletAddress,
    List<TokenInfo> tokens,
    TransferState state,
    bool isDark,
  ) {
    if (state is TransferProcessing) {
      return const Center(child: CircularProgressIndicator());
    }

    if (walletAddress == null) {
      return const Center(
        child: N42EmptyState(
          icon: Icons.account_balance_wallet_outlined,
          title: '钱包未连接',
          description: '请先连接钱包',
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 收款二维码
          _buildQRCode(walletAddress, isDark),

          const SizedBox(height: 24),

          // 钱包地址
          _buildAddressSection(walletAddress, isDark),

          const SizedBox(height: 32),

          // 发送收款请求按钮
          if (widget.roomId != null) ...[
            if (!_showRequestForm) ...[
              N42Button(
                text: '发送收款请求',
                type: N42ButtonType.secondary,
                onPressed: () {
                  setState(() {
                    _showRequestForm = true;
                  });
                },
              ),
            ] else ...[
              _buildRequestForm(tokens, isDark),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildQRCode(String walletAddress, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          QrImageView(
            data: walletAddress,
            version: QrVersions.auto,
            size: 200,
            backgroundColor: Colors.white,
            errorStateBuilder: (context, error) => const Center(
              child: Text('二维码生成失败'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '扫描二维码向我付款',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(String walletAddress, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '我的钱包地址',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  walletAddress,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'monospace',
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: walletAddress));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('地址已复制')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestForm(List<TokenInfo> tokens, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '创建收款请求',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // 代币选择
          DropdownButtonFormField<TokenInfo>(
            value: _selectedToken,
            decoration: const InputDecoration(
              labelText: '选择代币',
              border: OutlineInputBorder(),
            ),
            items: tokens.map((token) {
              return DropdownMenuItem(
                value: token,
                child: Text('${token.symbol} - ${token.name}'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedToken = value;
              });
            },
          ),

          const SizedBox(height: 16),

          // 金额输入
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '金额',
              border: const OutlineInputBorder(),
              suffixText: _selectedToken?.symbol,
            ),
          ),

          const SizedBox(height: 16),

          // 备注输入
          TextField(
            controller: _memoController,
            decoration: const InputDecoration(
              labelText: '备注（可选）',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          // 按钮
          Row(
            children: [
              Expanded(
                child: N42Button(
                  text: '取消',
                  type: N42ButtonType.secondary,
                  onPressed: () {
                    setState(() {
                      _showRequestForm = false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: N42Button(
                  text: '发送请求',
                  onPressed: _createPaymentRequest,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

