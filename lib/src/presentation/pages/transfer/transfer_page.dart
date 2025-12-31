import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../integration/wallet_bridge.dart';
import '../../blocs/transfer/transfer_bloc.dart';
import '../../blocs/transfer/transfer_event.dart';
import '../../blocs/transfer/transfer_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 转账页面
class TransferPage extends StatefulWidget {
  final String roomId;
  final String? recipientAddress;
  final String? recipientName;

  const TransferPage({
    super.key,
    required this.roomId,
    this.recipientAddress,
    this.recipientName,
  });

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  TokenInfo? _selectedToken;
  bool _isAddressValid = false;
  WalletUserInfo? _recipientInfo;

  @override
  void initState() {
    super.initState();
    context.read<TransferBloc>().add(const LoadWalletInfo());

    if (widget.recipientAddress != null) {
      _addressController.text = widget.recipientAddress!;
      _validateAddress(widget.recipientAddress!);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _validateAddress(String address) {
    if (address.isNotEmpty) {
      context.read<TransferBloc>().add(ValidateAddress(address));
    } else {
      setState(() {
        _isAddressValid = false;
        _recipientInfo = null;
      });
    }
  }

  void _submitTransfer() {
    final address = _addressController.text.trim();
    final amount = _amountController.text.trim();
    final memo = _memoController.text.trim();

    if (!_isAddressValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的收款地址')),
      );
      return;
    }

    if (amount.isEmpty || double.tryParse(amount) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的转账金额')),
      );
      return;
    }

    if (_selectedToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请选择代币')),
      );
      return;
    }

    context.read<TransferBloc>().add(InitiateTransfer(
          roomId: widget.roomId,
          receiverAddress: address,
          amount: amount,
          token: _selectedToken!.symbol,
          memo: memo.isNotEmpty ? memo : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state is AddressValidated) {
          setState(() {
            _isAddressValid = state.isValid;
            _recipientInfo = state.userInfo;
          });
        } else if (state is TransferSuccess) {
          Navigator.pop(context, state.transfer);
        } else if (state is TransferFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
          appBar: N42AppBar(
            title: '转账',
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: _buildBody(state, isDark),
        );
      },
    );
  }

  Widget _buildBody(TransferState state, bool isDark) {
    if (state is TransferProcessing) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(state.message),
          ],
        ),
      );
    }

    List<TokenInfo> tokens = [];
    Map<String, String> balances = {};

    if (state is WalletInfoLoaded) {
      tokens = state.tokens;
      balances = state.balances;

      // 默认选择第一个代币
      if (_selectedToken == null && tokens.isNotEmpty) {
        _selectedToken = tokens.first;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 收款地址
          _buildSectionTitle('收款地址', isDark),
          const SizedBox(height: 8),
          _buildAddressInput(isDark),

          // 收款人信息
          if (_recipientInfo != null || widget.recipientName != null)
            _buildRecipientInfo(isDark),

          const SizedBox(height: 24),

          // 代币选择
          _buildSectionTitle('选择代币', isDark),
          const SizedBox(height: 8),
          _buildTokenSelector(tokens, balances, isDark),

          const SizedBox(height: 24),

          // 转账金额
          _buildSectionTitle('转账金额', isDark),
          const SizedBox(height: 8),
          _buildAmountInput(balances, isDark),

          const SizedBox(height: 24),

          // 备注
          _buildSectionTitle('备注（可选）', isDark),
          const SizedBox(height: 8),
          _buildMemoInput(isDark),

          const SizedBox(height: 32),

          // 转账按钮
          _buildSubmitButton(isDark),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
    );
  }

  Widget _buildAddressInput(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isAddressValid
              ? AppColors.success
              : (_addressController.text.isNotEmpty
                  ? AppColors.error
                  : (isDark ? AppColors.dividerDark : AppColors.divider)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: '输入或粘贴钱包地址',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                hintStyle: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
              onChanged: (value) {
                _validateAddress(value.trim());
              },
            ),
          ),
          // 粘贴按钮
          IconButton(
            icon: const Icon(Icons.content_paste, size: 20),
            onPressed: () async {
              final data = await Clipboard.getData(Clipboard.kTextPlain);
              if (data?.text != null) {
                _addressController.text = data!.text!;
                _validateAddress(data.text!.trim());
              }
            },
          ),
          // 扫描二维码
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, size: 20),
            onPressed: () {
              // TODO: 实现二维码扫描
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('扫描功能开发中...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientInfo(bool isDark) {
    final name = _recipientInfo?.displayName ?? widget.recipientName;
    final avatar = _recipientInfo?.avatarUrl;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          N42Avatar(
            imageUrl: avatar,
            name: name ?? '',
            size: 36,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? '未知用户',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              if (_isAddressValid)
                Text(
                  '地址已验证',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.success,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTokenSelector(
    List<TokenInfo> tokens,
    Map<String, String> balances,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: tokens.map((token) {
          final isSelected = _selectedToken?.symbol == token.symbol;
          final balance = balances[token.symbol] ?? '0';

          return InkWell(
            onTap: () {
              setState(() {
                _selectedToken = token;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.dividerDark : AppColors.divider,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // 代币图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.backgroundDark : AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        token.symbol.substring(0, token.symbol.length.clamp(0, 2)),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 代币信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          token.symbol,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          token.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 余额
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        balance,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '可用',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // 选中标记
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAmountInput(Map<String, String> balances, bool isDark) {
    final balance = _selectedToken != null
        ? balances[_selectedToken!.symbol] ?? '0'
        : '0';

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 32,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                _selectedToken?.symbol ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '可用余额: $balance ${_selectedToken?.symbol ?? ''}',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () {
                  _amountController.text = balance;
                },
                child: const Text('全部'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemoInput(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _memoController,
        decoration: InputDecoration(
          hintText: '添加备注信息',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _buildSubmitButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: N42Button(
        text: '确认转账',
        onPressed: _submitTransfer,
      ),
    );
  }
}

