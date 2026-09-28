import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/payment_asset_match.dart';
import '../../../core/utils/payment_request_uri.dart';
import '../../../integration/wallet_bridge.dart';
import '../../blocs/transfer/transfer_bloc.dart';
import '../../blocs/transfer/transfer_event.dart';
import '../../blocs/transfer/transfer_state.dart';
import '../../helpers/bloc_message_helper.dart';
import '../../widgets/common/common_widgets.dart';
import 'merchant_qr_page.dart';

/// 收款页面
class ReceivePage extends StatefulWidget {
  final String? roomId;

  const ReceivePage({super.key, this.roomId});

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

    if (_selectedToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.transferPleaseSelectToken ?? 'Please select a token',
          ),
        ),
      );
      return;
    }

    if (!isValidPaymentAmountForDecimals(amount, _selectedToken!.decimals)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.transferPleaseEnterValidAmount ??
                'Please enter a valid amount',
          ),
        ),
      );
      return;
    }

    final selected = _selectedToken!;
    final exact = _hasIdentity(selected);
    if (exact &&
        createExactPaymentRequestForAsset(selected, amount: amount) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.transferAssetUnavailable ??
                'Payment asset is unavailable',
          ),
        ),
      );
      return;
    }

    if (widget.roomId != null) {
      context.read<TransferBloc>().add(
        CreatePaymentRequest(
          roomId: widget.roomId!,
          amount: amount,
          token: _selectedToken!.symbol,
          memo: memo.isNotEmpty ? memo : null,
          chain: exact ? selected.chain : null,
          network: exact ? selected.network : null,
          assetType: exact ? selected.assetType : null,
          assetId: exact ? selected.assetId : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state.status == TransferBlocStatus.paymentCreated) {
          Navigator.pop(context, state.paymentRequest!);
        } else if (state.status == TransferBlocStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resolveBlocMessage(context, state.errorMessage!)),
            ),
          );
        }
      },
      builder: (context, state) {
        String? walletAddress;
        List<TokenInfo> tokens = [];

        if (state.status == TransferBlocStatus.walletLoaded) {
          walletAddress = state.walletAddress;
          tokens = selectableReceiveAssets(state.tokens);

          if (_selectedToken != null &&
              !tokens.any((token) => identical(token, _selectedToken))) {
            _selectedToken = null;
          }

          if (_selectedToken == null &&
              tokens.isNotEmpty &&
              tokens
                      .where(
                        (token) =>
                            token.symbol.toLowerCase() ==
                            tokens.first.symbol.toLowerCase(),
                      )
                      .length ==
                  1) {
            _selectedToken = tokens.first;
          }
        }

        return Scaffold(
          backgroundColor: context.pageBackground,
          appBar: N42AppBar(
            title: S.of(context)?.transferReceive ?? 'Receive',
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: _buildBody(walletAddress, tokens, state),
        );
      },
    );
  }

  Widget _buildBody(
    String? walletAddress,
    List<TokenInfo> tokens,
    TransferState state,
  ) {
    if (state.isProcessing) {
      return const Center(child: CircularProgressIndicator());
    }

    if (walletAddress == null) {
      return Center(
        child: N42EmptyState(
          icon: Icons.account_balance_wallet_outlined,
          title:
              S.of(context)?.transferWalletNotConnected ??
              'Wallet Not Connected',
          description:
              S.of(context)?.transferPleaseConnectWallet ??
              'Please connect your wallet first',
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 收款二维码
          _buildTokenSelector(tokens),
          if (_selectedToken != null && _hasIdentity(_selectedToken!)) ...[
            const SizedBox(height: 8),
            _buildSelectedAssetDetail(),
          ],

          const SizedBox(height: 16),

          _buildQRCode(walletAddress),

          const SizedBox(height: 24),

          // 钱包地址
          if (_receiveAddress(walletAddress) != null)
            _buildAddressSection(_receiveAddress(walletAddress)!),

          const SizedBox(height: 32),

          // 商户收款码（带金额二维码）
          N42Button(
            text: 'Merchant QR (with amount)',
            type: N42ButtonType.secondary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (_) => const MerchantQrPage()),
              );
            },
          ),

          // 发送收款请求按钮
          if (widget.roomId != null) ...[
            const SizedBox(height: 16),
            if (!_showRequestForm) ...[
              N42Button(
                text:
                    S.of(context)?.transferSendPaymentRequest ??
                    'Send Payment Request',
                type: N42ButtonType.secondary,
                onPressed: () {
                  setState(() {
                    _showRequestForm = true;
                  });
                },
              ),
            ] else ...[
              _buildRequestForm(tokens),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildQRCode(String walletAddress) {
    final asset = _selectedToken;
    final request = asset != null && _hasIdentity(asset)
        ? createExactPaymentRequestForAsset(asset)
        : null;
    final data = asset == null
        ? null
        : _hasIdentity(asset)
        ? (request == null ? null : PaymentRequestUri.encode(request))
        : asset.receiverAddress ?? walletAddress;
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
          if (data != null)
            QrImageView(
              key: ValueKey<String>(data),
              data: data,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: Colors.white,
              errorStateBuilder: (ctx, error) => Center(
                child: Text(
                  S.of(context)?.transferQrCodeGenerateFailed ??
                      'QR code generation failed',
                ),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  S.of(context)?.transferAssetUnavailable ??
                      'Payment asset is unavailable',
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            S.of(context)?.transferScanQrToPayMe ?? 'Scan QR code to pay me',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasIdentity(TokenInfo asset) =>
      asset.chain != null ||
      asset.network != null ||
      asset.assetType != null ||
      asset.assetId != null;

  String? _receiveAddress(String walletAddress) {
    final asset = _selectedToken;
    if (asset == null) return null;
    return _hasIdentity(asset)
        ? createExactPaymentRequestForAsset(asset)?.receiverAddress
        : asset.receiverAddress ?? walletAddress;
  }

  Widget _buildTokenSelector(
    List<TokenInfo> tokens,
  ) => DropdownButtonFormField<TokenInfo>(
    isExpanded: true,
    itemHeight: 86,
    initialValue: _selectedToken,
    decoration: InputDecoration(
      labelText: S.of(context)?.transferSelectToken ?? 'Select Token',
      border: const OutlineInputBorder(),
    ),
    items: tokens
        .map(
          (token) => DropdownMenuItem(
            value: token,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${token.symbol} - ${token.name}'),
                if (_hasIdentity(token))
                  Text(
                    '${token.chain} / ${token.network} · ${token.assetType}',
                  ),
                if (token.assetId != null)
                  Text(
                    token.assetId!,
                    softWrap: true,
                    style: const TextStyle(fontSize: 11),
                  ),
              ],
            ),
          ),
        )
        .toList(),
    selectedItemBuilder: (_) => tokens
        .map(
          (token) => Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${token.symbol} - ${token.name}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList(),
    onChanged: (value) => setState(() => _selectedToken = value),
  );

  Widget _buildSelectedAssetDetail() {
    final token = _selectedToken!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${token.chain} / ${token.network} · ${token.assetType}',
          style: TextStyle(fontSize: 12, color: context.textSecondary),
        ),
        if (token.assetId != null)
          Text(
            token.assetId!,
            softWrap: true,
            style: TextStyle(fontSize: 12, color: context.textSecondary),
          ),
      ],
    );
  }

  Widget _buildAddressSection(String walletAddress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context)?.transferMyWalletAddress ?? 'My Wallet Address',
            style: TextStyle(fontSize: 13, color: context.textSecondary),
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
                    color: context.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: walletAddress));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context)?.commonAddressCopied ?? 'Address copied',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestForm(List<TokenInfo> tokens) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context)?.transferCreatePaymentRequest ??
                'Create Payment Request',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // 代币选择
          Text(
            _selectedToken?.name ??
                (S.of(context)?.transferPleaseSelectToken ??
                    'Please select a token'),
          ),
          if (_selectedToken != null && _hasIdentity(_selectedToken!))
            _buildSelectedAssetDetail(),

          const SizedBox(height: 16),

          // 金额输入
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: S.of(context)?.commonTransferAmount ?? 'Amount',
              border: const OutlineInputBorder(),
              suffixText: _selectedToken?.symbol,
            ),
          ),

          const SizedBox(height: 16),

          // 备注输入
          TextField(
            controller: _memoController,
            decoration: InputDecoration(
              labelText:
                  S.of(context)?.transferMemoOptional ?? 'Memo (optional)',
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          // 按钮
          Row(
            children: [
              Expanded(
                child: N42Button(
                  text: S.of(context)?.commonCancel ?? 'Cancel',
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
                  text: S.of(context)?.transferSendRequest ?? 'Send Request',
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
