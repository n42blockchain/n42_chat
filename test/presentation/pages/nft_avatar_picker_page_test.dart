import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/pages/profile/nft_avatar_picker_page.dart';

class _Wallet extends Mock implements IWalletBridge {}

void main() {
  const contract = '0x1234567890123456789012345678901234567890';

  tearDown(() async => getIt.reset());

  Future<void> openPicker(
    WidgetTester tester, {
    required void Function({
      required String imageUrl,
      required String contractAddress,
      required int tokenId,
      required int chainId,
    })
    onConfirm,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NftAvatarPickerPage(onConfirm: onConfirm),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Custom'));
    await tester.pumpAndSettle();
  }

  Future<void> fillInputs(WidgetTester tester, String tokenId) async {
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), contract);
    await tester.enterText(fields.at(1), tokenId);
  }

  testWidgets('shows validation when contract or token ID is missing', (
    tester,
  ) async {
    await openPicker(
      tester,
      onConfirm:
          ({
            required imageUrl,
            required contractAddress,
            required tokenId,
            required chainId,
          }) {},
    );

    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();
    expect(find.text('Enter contract address and token ID'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, contract);
    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();
    expect(find.text('Enter contract address and token ID'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rejects an NFT that the connected wallet does not own', (
    tester,
  ) async {
    final wallet = _Wallet();
    when(
      () => wallet.getErc721Balance(contractAddress: contract, chainId: 1),
    ).thenAnswer((_) async => 0);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await openPicker(
      tester,
      onConfirm:
          ({
            required imageUrl,
            required contractAddress,
            required tokenId,
            required chainId,
          }) {},
    );
    await fillInputs(tester, '7');

    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();

    expect(find.text('You do not own this NFT'), findsOneWidget);
    verify(
      () => wallet.getErc721Balance(contractAddress: contract, chainId: 1),
    ).called(1);
    verifyNever(
      () => wallet.getErc721TokenUri(
        contractAddress: any(named: 'contractAddress'),
        tokenId: any(named: 'tokenId'),
        chainId: any(named: 'chainId'),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('selects a popular collection and confirms a verified NFT', (
    tester,
  ) async {
    final wallet = _Wallet();
    when(
      () => wallet.getErc721Balance(
        contractAddress: any(named: 'contractAddress'),
        chainId: 137,
      ),
    ).thenAnswer((_) async => 1);
    when(
      () => wallet.getErc721TokenUri(
        contractAddress: any(named: 'contractAddress'),
        tokenId: 42,
        chainId: 137,
      ),
    ).thenAnswer((_) async => null);
    getIt.registerSingleton<IWalletBridge>(wallet);

    Map<String, Object?>? confirmed;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NftAvatarPickerPage(
          onConfirm:
              ({
                required imageUrl,
                required contractAddress,
                required tokenId,
                required chainId,
              }) {
                confirmed = {
                  'imageUrl': imageUrl,
                  'contractAddress': contractAddress,
                  'tokenId': tokenId,
                  'chainId': chainId,
                };
              },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('BAYC'));
    await tester.pumpAndSettle();
    expect(
      find.text('0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D'),
      findsOneWidget,
    );
    expect(find.text('Custom'), findsOneWidget);
    await tester.tap(find.text('Polygon'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(1), '42');

    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();
    expect(find.text('Preview'), findsOneWidget);
    expect(find.byIcon(Icons.image_outlined), findsOneWidget);

    await tester.tap(find.text('Use as Avatar'));
    await tester.pumpAndSettle();
    expect(confirmed, {
      'imageUrl': 'nft://0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/42@137',
      'contractAddress': '0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D',
      'tokenId': 42,
      'chainId': 137,
    });
    verify(
      () => wallet.getErc721Balance(
        contractAddress: '0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D',
        chainId: 137,
      ),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows wallet errors and uses resolved metadata URLs', (
    tester,
  ) async {
    final wallet = _Wallet();
    var shouldFail = true;
    when(
      () => wallet.getErc721Balance(contractAddress: contract, chainId: 1),
    ).thenAnswer((_) async {
      if (shouldFail) throw StateError('rpc unavailable');
      return 1;
    });
    when(
      () => wallet.getErc721TokenUri(
        contractAddress: contract,
        tokenId: 11,
        chainId: 1,
      ),
    ).thenAnswer((_) async => 'https://images.example/nft.png');
    getIt.registerSingleton<IWalletBridge>(wallet);
    await openPicker(
      tester,
      onConfirm:
          ({
            required imageUrl,
            required contractAddress,
            required tokenId,
            required chainId,
          }) {},
    );
    await fillInputs(tester, '11');

    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();
    expect(find.text('Bad state: rpc unavailable'), findsOneWidget);

    shouldFail = false;
    await tester.tap(find.text('Verify Ownership & Preview'));
    await tester.pumpAndSettle();
    expect(find.text('Preview'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
