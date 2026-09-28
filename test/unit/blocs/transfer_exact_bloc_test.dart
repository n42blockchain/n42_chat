import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/transfer_entity.dart';
import 'package:n42_chat/src/domain/repositories/transfer_repository.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_event.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_state.dart';

class _LegacyRepository extends Mock implements ITransferRepository {}

class _ExactRepository extends Mock
    implements ITransferRepository, IExactTransferRepository {}

class _Wallet extends Mock implements IWalletBridge {}

const _contract = '0xabcdef0123456789abcdef0123456789abcdef01';
const _otherContract = '0x1111111111111111111111111111111111111111';
const _asset = TokenInfo(
  symbol: 'USDT',
  name: 'Tether',
  decimals: 6,
  contractAddress: _contract,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contract,
  receiverAddress: '0xmyeth',
);
const _sameTicker = TokenInfo(
  symbol: 'USDT',
  name: 'Other Tether',
  decimals: 6,
  contractAddress: _otherContract,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _otherContract,
  receiverAddress: '0xmyeth',
);
final _transfer = TransferEntity(
  id: 'tx',
  senderAddress: '0xmyeth',
  receiverAddress: '0xrecipient',
  amount: '1.250000',
  token: 'USDT',
  status: TransferStatus.completed,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contract,
  createdAt: DateTime.utc(2026, 1, 1),
);
final _request = PaymentRequest(
  requestId: 'req',
  amount: '1.250000',
  token: 'USDT',
  receiverAddress: '0xmyeth',
  qrCodeData: 'n42pay://v1/pay?...',
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contract,
  createdAt: DateTime.utc(2026, 1, 1),
);

TransferState _loaded({List<TokenInfo> assets = const [_asset, _sameTicker]}) =>
    TransferState(
      status: TransferBlocStatus.walletLoaded,
      isWalletConnected: true,
      tokens: assets,
      balances: const {'USDT': '999999999'},
    );

void main() {
  late _LegacyRepository legacyRepo;
  late _ExactRepository exactRepo;

  setUp(() {
    legacyRepo = _LegacyRepository();
    exactRepo = _ExactRepository();
  });

  blocTest<TransferBloc, TransferState>(
    'partial exact initiate fails before repository call',
    build: () => TransferBloc(legacyRepo, _Wallet()),
    seed: _loaded,
    act: (bloc) => bloc.add(
      const InitiateTransfer(
        roomId: '!room',
        receiverAddress: '0xrecipient',
        amount: '1',
        token: 'USDT',
        chain: 'ETH',
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.failure,
      ),
    ],
    verify: (_) {
      verifyNever(
        () => legacyRepo.initiateTransfer(
          roomId: any(named: 'roomId'),
          receiverAddress: any(named: 'receiverAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          memo: any(named: 'memo'),
        ),
      );
    },
  );

  blocTest<TransferBloc, TransferState>(
    'exact initiate carries full identity to optional repository',
    build: () {
      when(
        () => exactRepo.initiateTransferExact(
          roomId: any(named: 'roomId'),
          receiverAddress: any(named: 'receiverAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          memo: any(named: 'memo'),
          chain: any(named: 'chain'),
          network: any(named: 'network'),
          assetType: any(named: 'assetType'),
          assetId: any(named: 'assetId'),
        ),
      ).thenAnswer((_) async => _transfer);
      return TransferBloc(exactRepo, _Wallet());
    },
    seed: _loaded,
    act: (bloc) => bloc.add(
      const InitiateTransfer(
        roomId: '!room',
        receiverAddress: '0xrecipient',
        amount: '1.250000',
        token: 'USDT',
        memo: 'invoice',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.processing,
      ),
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.success,
      ),
    ],
    verify: (_) {
      verify(
        () => exactRepo.initiateTransferExact(
          roomId: '!room',
          receiverAddress: '0xrecipient',
          amount: '1.250000',
          token: 'USDT',
          memo: 'invoice',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contract,
        ),
      ).called(1);
    },
  );

  blocTest<TransferBloc, TransferState>(
    'complete exact initiate rejects repository without capability',
    build: () => TransferBloc(legacyRepo, _Wallet()),
    seed: _loaded,
    act: (bloc) => bloc.add(
      const InitiateTransfer(
        roomId: '!room',
        receiverAddress: '0xrecipient',
        amount: '1',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.failure,
      ),
    ],
    verify: (_) => verifyNever(
      () => legacyRepo.initiateTransfer(
        roomId: any(named: 'roomId'),
        receiverAddress: any(named: 'receiverAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    ),
  );

  for (final event in [
    const InitiateTransfer(
      roomId: '!room',
      receiverAddress: '0xrecipient',
      amount: '1',
      token: 'USDT',
      chain: 'ETH',
      network: 'testnet',
      assetType: 'token',
      assetId: _contract,
    ),
    const InitiateTransfer(
      roomId: '!room',
      receiverAddress: '0xrecipient',
      amount: '1.0000001',
      token: 'USDT',
      chain: 'ETH',
      network: 'mainnet',
      assetType: 'token',
      assetId: _contract,
    ),
  ]) {
    blocTest<TransferBloc, TransferState>(
      'wrong network or precision fails despite symbol balance: ${event.network}/${event.amount}',
      build: () => TransferBloc(exactRepo, _Wallet()),
      seed: _loaded,
      act: (bloc) => bloc.add(event),
      expect: () => [
        isA<TransferState>().having(
          (s) => s.status,
          'status',
          TransferBlocStatus.failure,
        ),
      ],
      verify: (_) => verifyNever(
        () => exactRepo.initiateTransferExact(
          roomId: any(named: 'roomId'),
          receiverAddress: any(named: 'receiverAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          memo: any(named: 'memo'),
          chain: any(named: 'chain'),
          network: any(named: 'network'),
          assetType: any(named: 'assetType'),
          assetId: any(named: 'assetId'),
        ),
      ),
    );
  }

  blocTest<TransferBloc, TransferState>(
    'duplicate exact assets fail before repository dispatch',
    build: () => TransferBloc(exactRepo, _Wallet()),
    seed: () => _loaded(assets: const [_asset, _asset]),
    act: (bloc) => bloc.add(
      const InitiateTransfer(
        roomId: '!room',
        receiverAddress: '0xrecipient',
        amount: '1',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.failure,
      ),
    ],
  );

  blocTest<TransferBloc, TransferState>(
    'exact payment request creation passes selected asset',
    build: () {
      when(
        () => exactRepo.createPaymentRequestExact(
          asset: _asset,
          amount: '1.250000',
          memo: null,
        ),
      ).thenAnswer((_) async => _request);
      when(
        () => exactRepo.sendPaymentRequestMessage(
          roomId: '!room',
          request: _request,
        ),
      ).thenAnswer((_) async => '\$event');
      return TransferBloc(exactRepo, _Wallet());
    },
    seed: _loaded,
    act: (bloc) => bloc.add(
      const CreatePaymentRequest(
        roomId: '!room',
        amount: '1.250000',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.processing,
      ),
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.paymentCreated,
      ),
    ],
    verify: (_) => verify(
      () => exactRepo.createPaymentRequestExact(
        asset: _asset,
        amount: '1.250000',
        memo: null,
      ),
    ).called(1),
  );

  blocTest<TransferBloc, TransferState>(
    'partial exact payment request cannot invoke legacy creation',
    build: () => TransferBloc(legacyRepo, _Wallet()),
    seed: _loaded,
    act: (bloc) => bloc.add(
      const CreatePaymentRequest(
        roomId: '!room',
        amount: '1',
        token: 'USDT',
        chain: 'ETH',
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.failure,
      ),
    ],
    verify: (_) => verifyNever(
      () => legacyRepo.createPaymentRequest(
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    ),
  );

  blocTest<TransferBloc, TransferState>(
    'exact fulfillment passes request and full asset identity',
    build: () {
      when(
        () => exactRepo.fulfillPaymentRequestExact(
          roomId: any(named: 'roomId'),
          requestId: any(named: 'requestId'),
          receiverAddress: any(named: 'receiverAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          chain: any(named: 'chain'),
          network: any(named: 'network'),
          assetType: any(named: 'assetType'),
          assetId: any(named: 'assetId'),
        ),
      ).thenAnswer((_) async => _transfer);
      return TransferBloc(exactRepo, _Wallet());
    },
    seed: _loaded,
    act: (bloc) => bloc.add(
      const FulfillPaymentRequest(
        roomId: '!room',
        requestId: 'req',
        receiverAddress: '0xrecipient',
        amount: '1.250000',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.processing,
      ),
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.success,
      ),
    ],
    verify: (_) => verify(
      () => exactRepo.fulfillPaymentRequestExact(
        roomId: '!room',
        requestId: 'req',
        receiverAddress: '0xrecipient',
        amount: '1.250000',
        token: 'USDT',
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: _contract,
      ),
    ).called(1),
  );

  blocTest<TransferBloc, TransferState>(
    'partial exact fulfillment cannot invoke legacy fulfillment',
    build: () => TransferBloc(legacyRepo, _Wallet()),
    seed: _loaded,
    act: (bloc) => bloc.add(
      const FulfillPaymentRequest(
        roomId: '!room',
        requestId: 'req',
        receiverAddress: '0xrecipient',
        amount: '1',
        token: 'USDT',
        chain: 'ETH',
      ),
    ),
    expect: () => [
      isA<TransferState>().having(
        (s) => s.status,
        'status',
        TransferBlocStatus.failure,
      ),
    ],
    verify: (_) => verifyNever(
      () => legacyRepo.fulfillPaymentRequest(
        roomId: any(named: 'roomId'),
        requestId: any(named: 'requestId'),
        receiverAddress: any(named: 'receiverAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
      ),
    ),
  );
}
