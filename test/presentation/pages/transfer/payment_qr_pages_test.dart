import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/utils/payment_request_uri.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_event.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_state.dart';
import 'package:n42_chat/src/presentation/pages/transfer/merchant_qr_page.dart';
import 'package:n42_chat/src/presentation/pages/transfer/receive_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class _Wallet extends Mock implements IWalletBridge {}

class _Bloc extends MockBloc<TransferEvent, TransferState>
    implements TransferBloc {}

class _Event extends Fake implements TransferEvent {}

const _assetA = TokenInfo(
  symbol: 'USDT',
  name: 'Tether A',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
  contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
  receiverAddress: '0xselectedA',
);
const _assetB = TokenInfo(
  symbol: 'USDT',
  name: 'Tether B',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0x1111111111111111111111111111111111111111',
  contractAddress: '0x1111111111111111111111111111111111111111',
  receiverAddress: '0xselectedB',
);
const _caseVariantAsset = TokenInfo(
  symbol: 'usdt',
  name: 'Tether A',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0xabcdef0123456789bbcdef0123456789abcdef01',
  contractAddress: '0xabcdef0123456789bbcdef0123456789abcdef01',
  receiverAddress: '0xselectedCase',
);
const _missingReceiver = TokenInfo(
  symbol: 'USDT',
  name: 'No receiver',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0x2222222222222222222222222222222222222222',
  contractAddress: '0x2222222222222222222222222222222222222222',
);

void main() {
  setUpAll(() => registerFallbackValue(_Event()));
  tearDown(() {
    if (getIt.isRegistered<IWalletBridge>()) getIt.unregister<IWalletBridge>();
  });

  testWidgets('merchant QR uses selected asset receiver and exact identity', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final wallet = _Wallet();
    when(() => wallet.walletAddress).thenReturn('0xglobal');
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_assetA, _assetB]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MerchantQrPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(QrImageView), findsNothing);
    await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Tether A').last);
    await tester.pumpAndSettle();
    final first = PaymentRequestUri.tryParseExact(
      (tester.widget<QrImageView>(find.byType(QrImageView)).key
              as ValueKey<String>)
          .value,
    );
    expect(first?.receiverAddress, '0xselectedA');
    expect(first?.assetId, _assetA.assetId);
    await tester.enterText(find.byType(TextField).first, '1.250000');
    await tester.pump();
    expect(
      PaymentRequestUri.tryParseExact(
        (tester.widget<QrImageView>(find.byType(QrImageView)).key
                as ValueKey<String>)
            .value,
      )?.amount,
      '1.250000',
    );
    await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Tether B').last);
    await tester.pumpAndSettle();
    final second = PaymentRequestUri.tryParseExact(
      (tester.widget<QrImageView>(find.byType(QrImageView)).key
              as ValueKey<String>)
          .value,
    );
    expect(second?.receiverAddress, '0xselectedB');
    expect(second?.assetId, _assetB.assetId);
  });

  testWidgets('merchant QR refuses selected asset without receiver', (
    tester,
  ) async {
    final wallet = _Wallet();
    when(() => wallet.walletAddress).thenReturn('0xglobal');
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_missingReceiver]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MerchantQrPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(QrImageView), findsNothing);
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
  });

  testWidgets('merchant QR excludes duplicate exact asset identities', (
    tester,
  ) async {
    final wallet = _Wallet();
    when(() => wallet.walletAddress).thenReturn('0xglobal');
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_assetA, _assetA]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MerchantQrPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(QrImageView), findsNothing);
    expect(find.textContaining('Tether A'), findsNothing);
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('merchant requires case-variant selection and shows full ID', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final wallet = _Wallet();
    when(() => wallet.walletAddress).thenReturn('0xglobal');
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_assetA, _caseVariantAsset]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MerchantQrPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(QrImageView), findsNothing);
    await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
    await tester.pumpAndSettle();
    expect(find.textContaining(_assetA.assetId!), findsWidgets);
    expect(find.textContaining(_caseVariantAsset.assetId!), findsWidgets);
    await tester.tap(find.textContaining(_caseVariantAsset.assetId!).last);
    await tester.pumpAndSettle();
    final detail = tester.widget<Text>(
      find.text(_caseVariantAsset.assetId!).last,
    );
    expect(detail.softWrap, isTrue);
    expect(
      PaymentRequestUri.tryParseExact(
        (tester.widget<QrImageView>(find.byType(QrImageView)).key
                as ValueKey<String>)
            .value,
      )?.assetId,
      _caseVariantAsset.assetId,
    );
  });

  testWidgets('merchant QR does not encode excess asset decimals', (
    tester,
  ) async {
    final wallet = _Wallet();
    when(() => wallet.walletAddress).thenReturn('0xglobal');
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_assetA]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MerchantQrPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(QrImageView), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '1.0000001');
    await tester.pump();
    expect(find.byType(QrImageView), findsNothing);
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
  });

  testWidgets(
    'receive QR and payment request use selected receiver and identity',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final bloc = _Bloc();
      const state = TransferState(
        status: TransferBlocStatus.walletLoaded,
        isWalletConnected: true,
        walletAddress: '0xglobal',
        tokens: [_assetA, _assetB],
      );
      when(() => bloc.state).thenReturn(state);
      whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
      when(() => bloc.add(any())).thenReturn(null);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: BlocProvider<TransferBloc>.value(
            value: bloc,
            child: const ReceivePage(roomId: '!room'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(QrImageView), findsNothing);
      await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Tether A').last);
      await tester.pumpAndSettle();
      expect(
        PaymentRequestUri.tryParseExact(
          (tester.widget<QrImageView>(find.byType(QrImageView)).key
                  as ValueKey<String>)
              .value,
        )?.receiverAddress,
        '0xselectedA',
      );
      await tester.tap(find.text('Send Payment Request'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Tether B').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '1.250000');
      await tester.tap(find.text('Send Request'));
      await tester.pump();
      verify(
        () => bloc.add(
          const CreatePaymentRequest(
            roomId: '!room',
            amount: '1.250000',
            token: 'USDT',
            chain: 'ETH',
            network: 'mainnet',
            assetType: 'token',
            assetId: '0x1111111111111111111111111111111111111111',
          ),
        ),
      ).called(1);
    },
  );

  testWidgets('receive rejects amount beyond selected asset precision', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = _Bloc();
    const state = TransferState(
      status: TransferBlocStatus.walletLoaded,
      isWalletConnected: true,
      walletAddress: '0xglobal',
      tokens: [_assetA],
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
    when(() => bloc.add(any())).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<TransferBloc>.value(
          value: bloc,
          child: const ReceivePage(roomId: '!room'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send Payment Request'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '1.0000001');
    await tester.tap(find.text('Send Request'));
    await tester.pump();
    verifyNever(() => bloc.add(any(that: isA<CreatePaymentRequest>())));
  });

  testWidgets(
    'receive requires case-variant choice and repeats full ID in request form',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final bloc = _Bloc();
      const state = TransferState(
        status: TransferBlocStatus.walletLoaded,
        isWalletConnected: true,
        walletAddress: '0xglobal',
        tokens: [_assetA, _caseVariantAsset],
      );
      when(() => bloc.state).thenReturn(state);
      whenListen(bloc, Stream<TransferState>.value(state), initialState: state);
      when(() => bloc.add(any())).thenReturn(null);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: BlocProvider<TransferBloc>.value(
            value: bloc,
            child: const ReceivePage(roomId: '!room'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(QrImageView), findsNothing);
      await tester.tap(find.byType(DropdownButtonFormField<TokenInfo>));
      await tester.pumpAndSettle();
      expect(find.textContaining(_assetA.assetId!), findsWidgets);
      expect(find.textContaining(_caseVariantAsset.assetId!), findsWidgets);
      await tester.tap(find.textContaining(_caseVariantAsset.assetId!).last);
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<Text>(find.text(_caseVariantAsset.assetId!).last)
            .softWrap,
        isTrue,
      );
      await tester.tap(find.text('Send Payment Request'));
      await tester.pumpAndSettle();
      expect(find.text(_caseVariantAsset.assetId!), findsAtLeastNWidgets(2));
    },
  );
}
