import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_event.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_state.dart';
import 'package:n42_chat/src/presentation/pages/transfer/transfer_page.dart';
import 'package:n42_chat/src/presentation/widgets/common/n42_button.dart';

class MockTransferBloc extends MockBloc<TransferEvent, TransferState>
    implements TransferBloc {}

class FakeTransferEvent extends Fake implements TransferEvent {}

const _contractA = '0xabcdef0123456789abcdef0123456789abcdef01';
const _contractB = '0x1111111111111111111111111111111111111111';
const _tokenA = TokenInfo(
  symbol: 'USDT',
  name: 'Tether A',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contractA,
  contractAddress: _contractA,
  receiverAddress: '0xsender',
);
const _tokenB = TokenInfo(
  symbol: 'USDT',
  name: 'Tether B',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _contractB,
  contractAddress: _contractB,
  receiverAddress: '0xsender',
);
const _caseVariantToken = TokenInfo(
  symbol: 'usdt',
  name: 'Lower case',
  decimals: 6,
);
const _legacyToken = TokenInfo(symbol: 'USDT', name: 'Upper case', decimals: 6);
const _collisionContract = '0xabcdef01234567ffabcdef0123456789abcdef01';
const _collisionToken = TokenInfo(
  symbol: 'USDT',
  name: 'Tether A',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: _collisionContract,
  contractAddress: _collisionContract,
  receiverAddress: '0xsender',
);

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTransferEvent());
  });

  Future<MockTransferBloc> openRequest(
    WidgetTester tester,
    PaymentRequest request,
    List<TokenInfo> tokens,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = MockTransferBloc();
    final state = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: tokens,
      balances: const {'USDT': '99'},
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: TransferPage(
            roomId: '!room:server.test',
            paymentRequest: request,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return bloc;
  }

  for (final scenario in [
    (
      name: 'wrong network',
      network: 'testnet',
      amount: '1',
      assets: const [_tokenA],
    ),
    (
      name: 'duplicate identity',
      network: 'mainnet',
      amount: '1',
      assets: const [_tokenA, _tokenA],
    ),
    (
      name: 'excess precision',
      network: 'mainnet',
      amount: '1.0000001',
      assets: const [_tokenA],
    ),
    (
      name: 'partial identity',
      network: null,
      amount: '1',
      assets: const [_tokenA],
    ),
  ]) {
    testWidgets('exact request ${scenario.name} cannot be fulfilled', (
      tester,
    ) async {
      final request = PaymentRequest(
        requestId: 'req-invalid',
        amount: scenario.amount,
        token: 'USDT',
        receiverAddress: '0xreceiver',
        qrCodeData: 'v1',
        chain: 'ETH',
        network: scenario.network,
        assetType: 'token',
        assetId: _contractA,
        createdAt: DateTime(2026, 1, 1),
      );
      final bloc = await openRequest(tester, request, scenario.assets);
      expect(find.byIcon(Icons.check_circle), findsNothing);
      await tester.tap(find.byType(N42Button));
      await tester.pump();
      verifyNever(() => bloc.add(any(that: isA<FulfillPaymentRequest>())));
    });
  }

  testWidgets(
    'legacy request with duplicate ticker requires selected identity',
    (tester) async {
      final request = PaymentRequest(
        requestId: 'req-legacy',
        amount: '1.25',
        token: 'USDT',
        receiverAddress: '0xreceiver',
        qrCodeData: 'legacy',
        createdAt: DateTime(2026, 1, 1),
      );
      final bloc = await openRequest(tester, request, const [_tokenA, _tokenB]);
      expect(find.byIcon(Icons.check_circle), findsNothing);
      await tester.tap(find.byType(N42Button));
      await tester.pump();
      verifyNever(() => bloc.add(any(that: isA<FulfillPaymentRequest>())));
      await tester.tap(find.text('Tether B'));
      await tester.pump();
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      await tester.tap(find.byType(N42Button));
      await tester.pump();
      verify(
        () => bloc.add(
          const FulfillPaymentRequest(
            roomId: '!room:server.test',
            requestId: 'req-legacy',
            receiverAddress: '0xreceiver',
            amount: '1.25',
            token: 'USDT',
            chain: 'ETH',
            network: 'mainnet',
            assetType: 'token',
            assetId: _contractB,
          ),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'case-variant legacy request cannot emit ticker-only fulfillment',
    (tester) async {
      final request = PaymentRequest(
        requestId: 'req-case',
        amount: '1',
        token: 'USDT',
        receiverAddress: '0xreceiver',
        qrCodeData: 'legacy',
        createdAt: DateTime(2026, 1, 1),
      );
      final bloc = await openRequest(tester, request, const [
        _legacyToken,
        _caseVariantToken,
      ]);
      expect(find.byIcon(Icons.check_circle), findsNothing);
      await tester.tap(find.text('Upper case'));
      await tester.tap(find.byType(N42Button));
      await tester.pump();
      verifyNever(() => bloc.add(any(that: isA<FulfillPaymentRequest>())));
    },
  );

  testWidgets('same-name contracts show full distinguishing IDs', (
    tester,
  ) async {
    final request = PaymentRequest(
      requestId: 'req-legacy',
      amount: '1',
      token: 'USDT',
      receiverAddress: '0xreceiver',
      qrCodeData: 'legacy',
      createdAt: DateTime(2026, 1, 1),
    );
    await openRequest(tester, request, const [_tokenA, _collisionToken]);
    final first = tester.widget<Text>(find.textContaining(_contractA));
    final second = tester.widget<Text>(find.textContaining(_collisionContract));
    expect(first.overflow, isNot(TextOverflow.ellipsis));
    expect(second.overflow, isNot(TextOverflow.ellipsis));
    expect(first.maxLines, isNull);
    expect(second.maxLines, isNull);
  });

  testWidgets('manual transfer selects one same-symbol contract', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = MockTransferBloc();
    const state = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: [_tokenA, _tokenB],
      balances: {'USDT': '99'},
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: const TransferPage(
            roomId: '!room:server.test',
            recipientAddress: '0xreceiver',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle), findsNothing);
    await tester.tap(find.text('Tether B'));
    await tester.enterText(find.byType(TextField).at(1), '1.250000');
    await tester.tap(find.byType(N42Button));
    await tester.pump();
    verify(
      () => bloc.add(
        const InitiateTransfer(
          roomId: '!room:server.test',
          receiverAddress: '0xreceiver',
          amount: '1.250000',
          token: 'USDT',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contractB,
        ),
      ),
    ).called(1);
  });

  testWidgets('manual case-variant ticker cannot default or dispatch', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = MockTransferBloc();
    const state = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: [_legacyToken, _caseVariantToken],
      balances: {'USDT': '99'},
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: const TransferPage(
            roomId: '!room:server.test',
            recipientAddress: '0xreceiver',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle), findsNothing);
    await tester.tap(find.text('Upper case'));
    await tester.enterText(find.byType(TextField).at(1), '1');
    await tester.tap(find.byType(N42Button));
    await tester.pump();
    verifyNever(() => bloc.add(any(that: isA<InitiateTransfer>())));
  });

  testWidgets('payment request forwards exact identity into fulfillment', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = MockTransferBloc();
    const state = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: [
        TokenInfo(
          symbol: 'USDT',
          name: 'Other Tether',
          decimals: 6,
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: '0x1111111111111111111111111111111111111111',
          contractAddress: '0x1111111111111111111111111111111111111111',
          receiverAddress: '0xsender',
        ),
        TokenInfo(
          symbol: 'USDT',
          name: 'Tether',
          decimals: 6,
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
          contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
          receiverAddress: '0xsender',
        ),
      ],
      balances: {'USDT': '99'},
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: TransferPage(
            roomId: '!room:server.test',
            paymentRequest: PaymentRequest(
              requestId: 'req-exact',
              amount: '1.250000',
              token: 'USDT',
              receiverAddress: '0xreceiver',
              qrCodeData: 'n42pay://v1/pay',
              chain: 'ETH',
              network: 'mainnet',
              assetType: 'token',
              assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
              createdAt: DateTime(2026, 1, 1),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.text('Other Tether'), findsNothing);
    await tester.tap(find.byType(N42Button));
    await tester.pump();
    verify(
      () => bloc.add(
        const FulfillPaymentRequest(
          roomId: '!room:server.test',
          requestId: 'req-exact',
          receiverAddress: '0xreceiver',
          amount: '1.250000',
          token: 'USDT',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
        ),
      ),
    ).called(1);
  });

  testWidgets(
    'payment request mode keeps wallet tokens visible after address validation and dispatches fulfill event',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final bloc = MockTransferBloc();
      final request = PaymentRequest(
        requestId: 'req-42',
        amount: '12.5',
        token: 'USDT',
        receiverAddress: '0xreceiver',
        memo: 'Dinner',
        qrCodeData: 'wallet:0xreceiver?amount=12.5',
        createdAt: DateTime(2026, 3, 21, 10),
      );

      const state = TransferState(
        status: TransferBlocStatus.addressValidated,
        isWalletConnected: true,
        walletAddress: '0xsender',
        tokens: [
          TokenInfo(symbol: 'ETH', name: 'Ethereum', decimals: 18),
          TokenInfo(symbol: 'USDT', name: 'Tether USD', decimals: 6),
        ],
        balances: {'ETH': '1.0', 'USDT': '99.5'},
        validatedAddress: '0xreceiver',
        isAddressValid: true,
      );

      when(() => bloc.state).thenReturn(state);
      whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
      when(() => bloc.add(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: BlocProvider<TransferBloc>.value(
            value: bloc,
            child: TransferPage(
              roomId: '!room:server.test',
              recipientName: 'Alice',
              paymentRequest: request,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('USDT'), findsWidgets);
      expect(find.text('12.5'), findsOneWidget);
      expect(find.text('Dinner'), findsOneWidget);

      await tester.tap(find.byType(N42Button));
      await tester.pump();

      verify(
        () => bloc.add(
          const FulfillPaymentRequest(
            roomId: '!room:server.test',
            requestId: 'req-42',
            receiverAddress: '0xreceiver',
            amount: '12.5',
            token: 'USDT',
          ),
        ),
      ).called(1);
    },
  );

  testWidgets('expired payment request does not dispatch fulfill event', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final bloc = MockTransferBloc();
    final request = PaymentRequest(
      requestId: 'req-expired',
      amount: '12.5',
      token: 'USDT',
      receiverAddress: '0xreceiver',
      memo: 'Dinner',
      qrCodeData: 'wallet:0xreceiver?amount=12.5',
      createdAt: DateTime(2026, 3, 21, 10),
      expiresAt: DateTime(2000, 1, 1),
    );

    const state = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: [TokenInfo(symbol: 'USDT', name: 'Tether USD', decimals: 6)],
      balances: {'USDT': '99.5'},
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );

    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: TransferPage(
            roomId: '!room:server.test',
            recipientName: 'Alice',
            paymentRequest: request,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(N42Button));
    await tester.pump();

    verifyNever(
      () => bloc.add(
        const FulfillPaymentRequest(
          roomId: '!room:server.test',
          requestId: 'req-expired',
          receiverAddress: '0xreceiver',
          amount: '12.5',
          token: 'USDT',
        ),
      ),
    );
    expect(find.text('Expired'), findsOneWidget);
  });
}
