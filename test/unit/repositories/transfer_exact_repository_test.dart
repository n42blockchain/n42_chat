import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/utils/payment_request_uri.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';
import 'package:n42_chat/src/data/repositories/transfer_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/transfer_entity.dart';
import 'package:n42_chat/src/domain/repositories/transfer_repository.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';

const _contract = '0xabcdef0123456789abcdef0123456789abcdef01';
const _asset = TokenInfo(
  symbol: 'USDT',
  name: 'Tether',
  decimals: 6,
  contractAddress: _contract,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contract,
  receiverAddress: '0xselectedSender',
);

class _RecordingWallet extends Mock
    implements IWalletBridge, IExactWalletTransfer {
  Map<String, String?>? exactCall;

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
    exactCall = {
      'toAddress': toAddress,
      'amount': amount,
      'token': token,
      'memo': memo,
      'chain': chain,
      'network': network,
      'assetType': assetType,
      'assetId': assetId,
    };
    return TransferResult.success('0xexactTx');
  }
}

class _LegacyWallet extends Mock implements IWalletBridge {}

class _MessageDataSource extends Mock implements MatrixMessageDataSource {}

class _ClientManager extends Mock implements MatrixClientManager {}

void main() {
  test('old concrete implements repository rejects exact capability', () {
    final repo = _LegacyTransferRepository();
    expect(() => requireExactTransferRepository(repo), throwsUnsupportedError);
    expect(repo.legacyCalled, isFalse);
  });

  group('TransferRepositoryImpl exact capability', () {
    late _RecordingWallet wallet;
    late _MessageDataSource messages;
    late TransferRepositoryImpl repo;

    setUp(() {
      wallet = _RecordingWallet();
      messages = _MessageDataSource();
      when(() => wallet.isWalletConnected).thenReturn(true);
      when(() => wallet.walletAddress).thenReturn('0xdefaultWrongChain');
      when(() => wallet.getSupportedTokens()).thenAnswer((_) async => [_asset]);
      when(
        () => messages.sendCustomMessage(
          roomId: any(named: 'roomId'),
          msgType: any(named: 'msgType'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => '\$event');
      when(
        () => messages.sendRoomEvent(
          roomId: any(named: 'roomId'),
          type: any(named: 'type'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => '\$ack');
      repo = TransferRepositoryImpl(wallet, messages, _ClientManager());
    });

    test(
      'dispatches all exact fields and records selected sender identity',
      () async {
        final transfer = await repo.initiateTransferExact(
          roomId: '!room:server',
          receiverAddress: '0xrecipient',
          amount: '9007199254.123456',
          token: 'USDT',
          memo: 'invoice',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contract,
        );

        expect(transfer.isSuccess, isTrue);
        expect(transfer.senderAddress, '0xselectedSender');
        expect(transfer.amount, '9007199254.123456');
        expect(transfer.chain, 'ETH');
        expect(transfer.network, 'mainnet');
        expect(transfer.assetType, 'token');
        expect(transfer.assetId, _contract);
        expect(wallet.exactCall, {
          'toAddress': '0xrecipient',
          'amount': '9007199254.123456',
          'token': 'USDT',
          'memo': 'invoice',
          'chain': 'ETH',
          'network': 'mainnet',
          'assetType': 'token',
          'assetId': _contract,
        });
        verifyNever(
          () => wallet.requestTransfer(
            toAddress: any(named: 'toAddress'),
            amount: any(named: 'amount'),
            token: any(named: 'token'),
            memo: any(named: 'memo'),
          ),
        );
        final sent =
            verify(
                  () => messages.sendCustomMessage(
                    roomId: '!room:server',
                    msgType: TransferMessageContent.msgType,
                    content: captureAny(named: 'content'),
                  ),
                ).captured.single
                as Map<String, dynamic>;
        expect(sent['asset_id'], _contract);
        expect(sent['chain'], 'ETH');
      },
    );

    test(
      'rejects wrong network and excess precision before wallet call',
      () async {
        for (final (network, amount) in [
          ('testnet', '1'),
          ('mainnet', '1.0000001'),
        ]) {
          await expectLater(
            repo.initiateTransferExact(
              roomId: '!room:server',
              receiverAddress: '0xrecipient',
              amount: amount,
              token: 'USDT',
              chain: 'ETH',
              network: network,
              assetType: 'token',
              assetId: _contract,
            ),
            throwsStateError,
          );
        }
        expect(wallet.exactCall, isNull);
        verifyNever(
          () => wallet.requestTransfer(
            toAddress: any(named: 'toAddress'),
            amount: any(named: 'amount'),
            token: any(named: 'token'),
            memo: any(named: 'memo'),
          ),
        );
        verifyNever(
          () => messages.sendCustomMessage(
            roomId: any(named: 'roomId'),
            msgType: any(named: 'msgType'),
            content: any(named: 'content'),
          ),
        );
      },
    );

    test(
      'creates exact request from selected asset and serializes identity',
      () async {
        final request = await repo.createPaymentRequestExact(
          asset: _asset,
          amount: '1.250000',
          memo: 'bill',
        );
        expect(request.receiverAddress, '0xselectedSender');
        expect(request.chain, 'ETH');
        expect(request.assetId, _contract);
        expect(request.amount, '1.250000');
        expect(
          PaymentRequestUri.tryParseExact(request.qrCodeData)?.assetId,
          _contract,
        );
        await repo.sendPaymentRequestMessage(
          roomId: '!room:server',
          request: request,
        );
        final sent =
            verify(
                  () => messages.sendCustomMessage(
                    roomId: '!room:server',
                    msgType: PaymentRequestContent.msgType,
                    content: captureAny(named: 'content'),
                  ),
                ).captured.single
                as Map<String, dynamic>;
        expect(sent['chain'], 'ETH');
        expect(sent['network'], 'mainnet');
        expect(sent['asset_type'], 'token');
        expect(sent['asset_id'], _contract);
        expect(sent['amount'], '1.250000');
      },
    );

    test('exact fulfillment keeps identity in acknowledgement', () async {
      final transfer = await repo.fulfillPaymentRequestExact(
        roomId: '!room:server',
        requestId: 'req-1',
        receiverAddress: '0xrecipient',
        amount: '1.250000',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      );
      expect(transfer.isSuccess, isTrue);
      final ack =
          verify(
                () => messages.sendRoomEvent(
                  roomId: '!room:server',
                  type: PaymentRequestFulfillmentContent.eventType,
                  content: captureAny(named: 'content'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(ack['chain'], 'ETH');
      expect(ack['network'], 'mainnet');
      expect(ack['asset_type'], 'token');
      expect(ack['asset_id'], _contract);
      expect(ack['amount'], '1.250000');
    });
  });

  test(
    'repository with legacy-only wallet fails exact transfer closed',
    () async {
      final wallet = _LegacyWallet();
      when(() => wallet.isWalletConnected).thenReturn(true);
      when(() => wallet.getSupportedTokens()).thenAnswer((_) async => [_asset]);
      final repo = TransferRepositoryImpl(
        wallet,
        _MessageDataSource(),
        _ClientManager(),
      );
      await expectLater(
        repo.initiateTransferExact(
          roomId: '!room:server',
          receiverAddress: '0xrecipient',
          amount: '1',
          token: 'USDT',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contract,
        ),
        throwsUnsupportedError,
      );
      verifyNever(
        () => wallet.requestTransfer(
          toAddress: any(named: 'toAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          memo: any(named: 'memo'),
        ),
      );
    },
  );
}

class _LegacyTransferRepository implements ITransferRepository {
  bool legacyCalled = false;

  @override
  Future<TransferEntity> initiateTransfer({
    required String roomId,
    required String receiverAddress,
    required String amount,
    required String token,
    String? memo,
  }) async {
    legacyCalled = true;
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransferMessage({
    required String roomId,
    required TransferEntity transfer,
  }) async => throw UnimplementedError();
  @override
  Future<void> updateTransferStatus({
    required String transferId,
    required TransferStatus status,
    String? transactionHash,
    String? failureReason,
  }) async => throw UnimplementedError();
  @override
  Future<PaymentRequest> createPaymentRequest({
    required String amount,
    required String token,
    String? memo,
  }) async => throw UnimplementedError();
  @override
  Future<String> sendPaymentRequestMessage({
    required String roomId,
    required PaymentRequest request,
  }) async => throw UnimplementedError();
  @override
  Future<TransferEntity> fulfillPaymentRequest({
    required String roomId,
    required String requestId,
    required String receiverAddress,
    required String amount,
    required String token,
  }) async => throw UnimplementedError();
  @override
  Future<List<TransferEntity>> getTransfersByRoom(String roomId) async => [];
  @override
  Future<TransferEntity?> getTransfer(String transferId) async => null;
  @override
  Future<List<TransferEntity>> getAllTransfers({
    int? limit,
    int? offset,
  }) async => [];
  @override
  Future<List<TokenInfo>> getSupportedTokens() async => [];
  @override
  Future<String> getTokenBalance(String token) async => '0';
  @override
  bool isValidAddress(String address) => false;
  @override
  String? get currentWalletAddress => null;
  @override
  bool get isWalletConnected => false;
}
