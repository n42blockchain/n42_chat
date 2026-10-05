import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/transfer_entity.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';

void main() {
  test('exact payment request identity survives Matrix message round trip', () {
    const request = PaymentRequestContent(
      requestId: 'req-1',
      receiverAddress: '0xreceiver',
      amount: '1.250000',
      token: 'USDT',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'token',
      assetId: '0xcontract',
    );
    final content = request.toMessageContent();
    expect(content['chain'], 'ETH');
    expect(content['network'], 'mainnet');
    expect(content['asset_type'], 'token');
    expect(content['asset_id'], '0xcontract');
    final parsed = PaymentRequestContent.fromMessageContent(content);
    expect(parsed.chain, 'ETH');
    expect(parsed.network, 'mainnet');
    expect(parsed.assetType, 'token');
    expect(parsed.assetId, '0xcontract');
    expect(parsed.amount, '1.250000');
  });

  test('legacy payment message has no exact identity fields', () {
    const request = PaymentRequestContent(
      requestId: 'legacy',
      receiverAddress: 'addr',
      amount: '1',
      token: 'ETH',
    );
    final parsed = PaymentRequestContent.fromMessageContent(
      request.toMessageContent(),
    );
    expect(parsed.chain, isNull);
    expect(parsed.network, isNull);
    expect(parsed.assetType, isNull);
    expect(parsed.assetId, isNull);
  });

  test('fulfillment acknowledgement preserves exact asset identity', () {
    final ack = PaymentRequestFulfillmentContent(
      requestId: 'req-1',
      transferId: 'tx-1',
      payerAddress: 'sender',
      receiverAddress: 'receiver',
      amount: '1.250000',
      token: 'USDT',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'token',
      assetId: '0xcontract',
      fulfilledAt: DateTime.utc(2026, 1, 1),
    );
    final parsed = PaymentRequestFulfillmentContent.fromEventContent(
      ack.toEventContent(),
    );
    expect(parsed.chain, 'ETH');
    expect(parsed.network, 'mainnet');
    expect(parsed.assetType, 'token');
    expect(parsed.assetId, '0xcontract');
    expect(parsed.amount, '1.250000');
  });

  test(
    'exact transfer identity survives entity JSON and message serialization',
    () {
      final transfer = TransferEntity(
        id: 'tx-1',
        senderAddress: 'sender',
        receiverAddress: 'receiver',
        amount: '1.250000',
        token: 'USDT',
        status: TransferStatus.completed,
        createdAt: DateTime.utc(2026, 1, 1),
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xcontract',
      );
      final parsed = TransferEntity.fromJson(transfer.toJson());
      expect(parsed.chain, 'ETH');
      expect(parsed.network, 'mainnet');
      expect(parsed.assetType, 'token');
      expect(parsed.assetId, '0xcontract');
      final message = TransferMessageContent(
        transferId: parsed.id,
        senderAddress: parsed.senderAddress,
        receiverAddress: parsed.receiverAddress,
        amount: parsed.amount,
        token: parsed.token,
        status: parsed.status,
        chain: parsed.chain,
        network: parsed.network,
        assetType: parsed.assetType,
        assetId: parsed.assetId,
      );
      final roundTrip = TransferMessageContent.fromMessageContent(
        message.toMessageContent(),
      );
      expect(roundTrip.chain, 'ETH');
      expect(roundTrip.network, 'mainnet');
      expect(roundTrip.assetType, 'token');
      expect(roundTrip.assetId, '0xcontract');
    },
  );

  test('PaymentRequest retains optional exact fields for fulfillment', () {
    final request = PaymentRequest(
      requestId: 'req',
      amount: '1',
      token: 'ETH',
      receiverAddress: 'receiver',
      qrCodeData: 'n42pay://v1/pay?...',
      createdAt: DateTime.utc(2026, 1, 1),
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'native',
    );
    expect(request.chain, 'ETH');
    expect(request.network, 'mainnet');
    expect(request.assetType, 'native');
    expect(request.assetId, isNull);
  });
}
