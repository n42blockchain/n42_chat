import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/payment_asset_match.dart';
import 'package:n42_chat/src/core/utils/payment_request_uri.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';

void main() {
  const ethUsdt = TokenInfo(
    symbol: 'USDT',
    name: 'Tether on Ethereum',
    decimals: 6,
    contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
    chain: 'ETH',
    network: 'mainnet',
    assetType: 'token',
    assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
    receiverAddress: '0xmyeth',
  );
  const arbUsdt = TokenInfo(
    symbol: 'USDT',
    name: 'Tether on Arbitrum',
    decimals: 6,
    contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
    chain: 'ARB',
    network: 'mainnet',
    assetType: 'token',
    assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
    receiverAddress: '0xmyarb',
  );
  const ethNative = TokenInfo(
    symbol: 'ETH',
    name: 'Ether',
    decimals: 18,
    isNative: true,
    chain: 'ETH',
    network: 'mainnet',
    assetType: 'native',
    receiverAddress: '0xmyeth',
  );
  const solUsdc = TokenInfo(
    symbol: 'USDC',
    name: 'USD Coin on Solana',
    decimals: 6,
    contractAddress: 'MintAbc123',
    chain: 'SOL',
    network: 'mainnet',
    assetType: 'token',
    assetId: 'MintAbc123',
    receiverAddress: 'MySolAddress',
  );

  test('exact request selects one chain, network and contract', () {
    const request = PaymentRequestData(
      receiverAddress: '0xrecipient',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'token',
      assetId: '0xABCDEF0123456789ABCDEF0123456789ABCDEF01',
      amount: '9007199254.123456',
    );

    final result = resolvePaymentAsset(request, [ethUsdt, arbUsdt, ethNative]);
    expect(result.status, PaymentAssetResolutionStatus.matched);
    expect(identical(result.asset, ethUsdt), isTrue);
    expect(result.asset?.receiverAddress, '0xmyeth');
  });

  test('wrong chain, network and contract cannot select a ticker twin', () {
    for (final request in [
      const PaymentRequestData(
        receiverAddress: 'recipient',
        chain: 'N',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      ),
      const PaymentRequestData(
        receiverAddress: 'recipient',
        chain: 'ETH',
        network: 'testnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      ),
      const PaymentRequestData(
        receiverAddress: 'recipient',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0x1111111111111111111111111111111111111111',
      ),
    ]) {
      expect(
        resolvePaymentAsset(request, [ethUsdt, arbUsdt]).status,
        PaymentAssetResolutionStatus.unavailable,
      );
    }
  });

  test('native identity never selects a contract asset', () {
    const request = PaymentRequestData(
      receiverAddress: '0xrecipient',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'native',
    );
    final result = resolvePaymentAsset(request, [ethUsdt, ethNative]);
    expect(result.status, PaymentAssetResolutionStatus.matched);
    expect(identical(result.asset, ethNative), isTrue);
  });

  test('non-EVM asset IDs remain case sensitive', () {
    const wrongCase = PaymentRequestData(
      receiverAddress: 'recipient',
      chain: 'SOL',
      network: 'mainnet',
      assetType: 'token',
      assetId: 'mintabc123',
    );
    const exactCase = PaymentRequestData(
      receiverAddress: 'recipient',
      chain: 'SOL',
      network: 'mainnet',
      assetType: 'token',
      assetId: 'MintAbc123',
    );
    expect(
      resolvePaymentAsset(wrongCase, [solUsdc]).status,
      PaymentAssetResolutionStatus.unavailable,
    );
    expect(resolvePaymentAsset(exactCase, [solUsdc]).asset, same(solUsdc));
  });

  test(
    'duplicate exact matches and inconsistent token metadata fail closed',
    () {
      const request = PaymentRequestData(
        receiverAddress: 'recipient',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      );
      expect(
        resolvePaymentAsset(request, [ethUsdt, ethUsdt]).status,
        PaymentAssetResolutionStatus.ambiguous,
      );
      const inconsistent = TokenInfo(
        symbol: 'USDT',
        name: 'Bad metadata',
        decimals: 6,
        isNative: true,
        contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      );
      expect(
        resolvePaymentAsset(request, [inconsistent]).status,
        PaymentAssetResolutionStatus.unavailable,
      );
    },
  );

  test(
    'selected decimals reject zero and excess precision without rounding',
    () {
      for (final amount in ['0', '-1', '1e2', '1.0000001', '0.0000001']) {
        final request = PaymentRequestData(
          receiverAddress: 'recipient',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: ethUsdt.assetId,
          amount: amount,
        );
        expect(
          resolvePaymentAsset(request, [ethUsdt]).status,
          PaymentAssetResolutionStatus.invalid,
          reason: amount,
        );
      }
      expect(isValidPaymentAmountForDecimals('9007199254.123456', 6), isTrue);
      expect(isValidPaymentAmountForDecimals('1.1', 0), isFalse);
    },
  );

  test('legacy ticker requests report ambiguity or selection required', () {
    const request = PaymentRequestData(
      receiverAddress: 'recipient',
      token: 'USDT',
    );
    expect(
      resolvePaymentAsset(request, [ethUsdt, arbUsdt]).status,
      PaymentAssetResolutionStatus.ambiguous,
    );
    final unique = resolvePaymentAsset(request, [ethUsdt]);
    expect(unique.status, PaymentAssetResolutionStatus.requiresSelection);
    expect(unique.asset, isNull);
    expect(unique.candidates, [same(ethUsdt)]);
  });

  test('legacy requests never infer a default chain or unspecified asset', () {
    const request = PaymentRequestData(receiverAddress: 'recipient');
    expect(
      resolvePaymentAsset(request, [ethNative, ethUsdt]).status,
      PaymentAssetResolutionStatus.ambiguous,
    );
    expect(
      resolvePaymentAsset(request, []).status,
      PaymentAssetResolutionStatus.unavailable,
    );
  });

  test(
    'selected asset creates a host-readable v1 request with its receiver',
    () {
      final request = createExactPaymentRequestForAsset(
        ethUsdt,
        amount: '0.000001',
      );
      expect(request?.receiverAddress, '0xmyeth');
      expect(request?.chain, 'ETH');
      expect(request?.assetId, ethUsdt.assetId);
      expect(request?.amount, '0.000001');
      expect(
        PaymentRequestUri.tryParseExact(PaymentRequestUri.encode(request!)),
        request,
      );
    },
  );

  test(
    'QR creation rejects missing receiver and excess selected precision',
    () {
      const missingReceiver = TokenInfo(
        symbol: 'USDT',
        name: 'Tether',
        decimals: 6,
        contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      );
      expect(createExactPaymentRequestForAsset(missingReceiver), isNull);
      expect(
        createExactPaymentRequestForAsset(ethUsdt, amount: '0.0000001'),
        isNull,
      );
      expect(createExactPaymentRequestForAsset(ethNative), isNotNull);
    },
  );
}
