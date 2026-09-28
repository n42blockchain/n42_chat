import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';

import '../../mocks/mock_wallet_bridge.dart';

void main() {
  test(
    'old wallet bridge rejects an exact request without legacy transfer',
    () async {
      final bridge = _LegacyWalletBridge();

      final result = await requestWalletTransferExact(
        bridge,
        toAddress: '0xreceiver',
        amount: '1.25',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xcontract',
      );

      expect(result.success, isFalse);
      expect(result.errorCode, 'unsupported');
      expect(bridge.legacyTransferCalled, isFalse);
    },
  );

  test('exact capability receives the complete unchanged request', () async {
    final bridge = _ExactWalletBridge();

    final result = await requestWalletTransferExact(
      bridge,
      toAddress: '0xreceiver',
      amount: '1.2500',
      token: 'USDT',
      memo: 'invoice',
      chain: 'ETH',
      network: 'testnet',
      assetType: 'token',
      assetId: '0xcontract',
    );

    expect(result.success, isTrue);
    expect(bridge.received, {
      'toAddress': '0xreceiver',
      'amount': '1.2500',
      'token': 'USDT',
      'memo': 'invoice',
      'chain': 'ETH',
      'network': 'testnet',
      'assetType': 'token',
      'assetId': '0xcontract',
    });
  });

  test('partial or invalid exact identity never reaches the wallet', () async {
    final bridge = _ExactWalletBridge();
    for (final request in [
      (chain: '', network: 'mainnet', type: 'native', id: null),
      (chain: 'ETH', network: '', type: 'native', id: null),
      (chain: 'ETH', network: 'other', type: 'native', id: null),
      (chain: 'ETH', network: 'mainnet', type: 'token', id: null),
      (chain: 'ETH', network: 'mainnet', type: 'native', id: '0xcontract'),
      (chain: 'ETH', network: 'mainnet', type: 'other', id: null),
    ]) {
      final result = await requestWalletTransferExact(
        bridge,
        toAddress: '0xreceiver',
        amount: '1',
        token: 'ETH',
        chain: request.chain,
        network: request.network,
        assetType: request.type,
        assetId: request.id,
      );
      expect(result.success, isFalse);
      expect(result.errorCode, 'invalid_identity');
    }
    expect(bridge.received, isNull);
  });

  test('invalid amount and receiver never reach the wallet', () async {
    final bridge = _ExactWalletBridge();
    for (final amount in [
      '0',
      '0.000',
      '-1',
      '+1',
      '1e2',
      '1.',
      '.5',
      'oops',
    ]) {
      final result = await requestWalletTransferExact(
        bridge,
        toAddress: '0xreceiver',
        amount: amount,
        token: 'ETH',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'native',
      );
      expect(result.success, isFalse, reason: amount);
      expect(result.errorCode, 'invalid_amount');
    }
    final missingReceiver = await requestWalletTransferExact(
      bridge,
      toAddress: ' ',
      amount: '1',
      token: 'ETH',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'native',
    );
    expect(missingReceiver.errorCode, 'invalid_identity');
    expect(bridge.received, isNull);
  });

  test('host-style token subtype exposes identity through TokenInfo', () {
    const TokenInfo token = _HostStyleTokenInfo(
      symbol: 'USDT',
      name: 'Tether',
      decimals: 6,
      contractAddress: '0xcontract',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'token',
      assetId: '0xcontract',
      receiverAddress: '0xreceiver',
    );

    expect(token.chain, 'ETH');
    expect(token.network, 'mainnet');
    expect(token.assetType, 'token');
    expect(token.assetId, '0xcontract');
    expect(token.receiverAddress, '0xreceiver');
  });

  test('base TokenInfo keeps identity optional for legacy callers', () {
    const token = TokenInfo(symbol: 'ETH', name: 'Ether', decimals: 18);
    expect(token.chain, isNull);
    expect(token.network, isNull);
    expect(token.assetType, isNull);
    expect(token.assetId, isNull);
    expect(token.receiverAddress, isNull);
  });
}

class _LegacyWalletBridge extends MockWalletBridge {
  bool legacyTransferCalled = false;

  @override
  Future<TransferResult> requestTransfer({
    required String toAddress,
    required String amount,
    required String token,
    String? memo,
  }) async {
    legacyTransferCalled = true;
    return TransferResult.success('legacy');
  }
}

class _ExactWalletBridge extends _LegacyWalletBridge
    implements IExactWalletTransfer {
  Map<String, String?>? received;

  @override
  Future<TransferResult> requestTransferExact({
    required String toAddress,
    required String amount,
    required String token,
    String? memo,
    required String chain,
    required String network,
    required String assetType,
    String? assetId,
  }) async {
    received = {
      'toAddress': toAddress,
      'amount': amount,
      'token': token,
      'memo': memo,
      'chain': chain,
      'network': network,
      'assetType': assetType,
      'assetId': assetId,
    };
    return TransferResult.success('exact');
  }
}

class _HostStyleTokenInfo extends TokenInfo {
  const _HostStyleTokenInfo({
    required super.symbol,
    required super.name,
    required super.decimals,
    required super.contractAddress,
    required this.chain,
    required this.network,
    required this.assetType,
    required this.assetId,
    required this.receiverAddress,
  });

  final String chain;
  final String network;
  final String assetType;
  final String? assetId;
  final String? receiverAddress;
}
