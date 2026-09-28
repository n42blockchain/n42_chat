import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/pages/qrcode/scan_qr_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';

class _ExactWallet extends Mock
    implements IWalletBridge, IExactWalletTransfer {}

class _LegacyWallet extends Mock implements IWalletBridge {}

const _exactAsset = TokenInfo(
  symbol: 'USDT',
  name: 'Tether',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
  contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
  receiverAddress: '0xmine',
);
const _otherAsset = TokenInfo(
  symbol: 'USDT',
  name: 'Other Tether',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0x1111111111111111111111111111111111111111',
  contractAddress: '0x1111111111111111111111111111111111111111',
  receiverAddress: '0xmine',
);
const _noReceiverAsset = TokenInfo(
  symbol: 'USDT',
  name: 'Tether',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
  contractAddress: '0xabcdef0123456789abcdef0123456789abcdef01',
);
const _collisionAsset = TokenInfo(
  symbol: 'USDT',
  name: 'Tether',
  decimals: 6,
  chain: 'ETH',
  network: 'mainnet',
  assetType: 'token',
  assetId: '0xabcdef01234567ffabcdef0123456789abcdef01',
  contractAddress: '0xabcdef01234567ffabcdef0123456789abcdef01',
  receiverAddress: '0xmine',
);

class _Gallery extends ImagePickerPlatform {
  int calls = 0;
  Completer<XFile?>? pending;
  XFile? image;
  Object? error;

  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    expect(source, ImageSource.gallery);
    calls++;
    if (error != null) throw error!;
    return pending == null ? image : await pending!.future;
  }
}

class _Camera extends MobileScannerPlatform {
  BarcodeCapture? capture;
  Object? analysisError;
  int analyses = 0;
  @override
  Future<BarcodeCapture?> analyzeImage(
    String path, {
    List<BarcodeFormat> formats = const [],
  }) async {
    expect(path, '/test/qr.png');
    expect(formats, [BarcodeFormat.qrCode]);
    analyses++;
    if (analysisError != null) throw analysisError!;
    return capture;
  }

  int starts = 0;
  int stops = 0;
  int disposals = 0;
  @override
  Stream<BarcodeCapture?> get barcodesStream => const Stream.empty();
  @override
  Stream<TorchState> get torchStateStream => const Stream.empty();
  @override
  Stream<double> get zoomScaleStateStream => const Stream.empty();
  @override
  Widget buildCameraView() => const SizedBox.expand();
  @override
  Future<MobileScannerViewAttributes> start(StartOptions options) async {
    starts++;
    return const MobileScannerViewAttributes(
      cameraDirection: CameraFacing.back,
      currentTorchMode: TorchState.off,
      size: Size(320, 480),
    );
  }

  @override
  Future<void> stop() async {
    stops++;
  }

  @override
  Future<void> updateScanWindow(Rect? window) async {}
  @override
  Future<void> dispose() async {
    disposals++;
  }
}

void main() {
  const channel = MethodChannel('flutter.baseflow.com/permissions/methods');
  var permission = 0;
  var requests = 0;
  var checks = 0;
  Completer<Map<int, int>>? requestResult;
  Completer<int>? checkResult;
  late _Camera camera;
  late _Gallery gallery;
  late ImagePickerPlatform originalGallery;
  late MobileScannerPlatform originalCamera;

  setUp(() {
    originalGallery = ImagePickerPlatform.instance;
    gallery = _Gallery();
    ImagePickerPlatform.instance = gallery;
    permission = 0;
    requests = 0;
    checks = 0;
    requestResult = null;
    checkResult = null;
    originalCamera = MobileScannerPlatform.instance;
    camera = _Camera();
    MobileScannerPlatform.instance = camera;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          switch (call.method) {
            case 'checkPermissionStatus':
              checks++;
              return checkResult == null
                  ? permission
                  : await checkResult!.future;
            case 'requestPermissions':
              requests++;
              return requestResult == null
                  ? <int, int>{1: permission}
                  : await requestResult!.future;
            case 'openAppSettings':
              return true;
          }
          throw StateError('Unexpected permission call ${call.method}');
        });
  });
  tearDown(() {
    if (getIt.isRegistered<IWalletBridge>()) getIt.unregister<IWalletBridge>();
    ImagePickerPlatform.instance = originalGallery;
    MobileScannerPlatform.instance = originalCamera;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  Future<void> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: ScanQRPage(),
      ),
    );
    await tester.pump();
  }

  Future<void> scanGallery(WidgetTester tester, String uri) async {
    permission = 1;
    gallery.image = XFile('/test/qr.png');
    camera.capture = BarcodeCapture(barcodes: [Barcode(rawValue: uri)]);
    await open(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> resume(WidgetTester tester) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();
  }

  testWidgets('v1 gallery QR confirms selected exact asset before transfer', (
    tester,
  ) async {
    permission = 1;
    gallery.image = XFile('/test/qr.png');
    camera.capture = const BarcodeCapture(
      barcodes: [
        Barcode(
          rawValue:
              'n42pay://v1/pay?chain=ETH&network=mainnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1.250000',
        ),
      ],
    );
    final wallet = _ExactWallet();
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => [_exactAsset]);
    when(
      () => wallet.requestTransferExact(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
        chain: any(named: 'chain'),
        network: any(named: 'network'),
        assetType: any(named: 'assetType'),
        assetId: any(named: 'assetId'),
      ),
    ).thenAnswer((_) async => TransferResult.failure('declined'));
    getIt.registerSingleton<IWalletBridge>(wallet);
    await open(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('ETH'), findsWidgets);
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle();
    verify(
      () => wallet.requestTransferExact(
        toAddress: '0xrecipient',
        amount: '1.250000',
        token: 'USDT',
        memo: null,
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0xabcdef0123456789abcdef0123456789abcdef01',
      ),
    ).called(1);
    verifyNever(
      () => wallet.requestTransfer(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    );
  });

  for (final scenario in [
    (
      name: 'wrong network',
      uri:
          'n42pay://v1/pay?chain=ETH&network=testnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1',
      assets: const [_exactAsset],
    ),
    (
      name: 'duplicate identity',
      uri:
          'n42pay://v1/pay?chain=ETH&network=mainnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1',
      assets: const [_exactAsset, _exactAsset],
    ),
    (
      name: 'excess precision',
      uri:
          'n42pay://v1/pay?chain=ETH&network=mainnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1.0000001',
      assets: const [_exactAsset],
    ),
  ]) {
    testWidgets('v1 ${scenario.name} is rejected before wallet transfer', (
      tester,
    ) async {
      permission = 1;
      gallery.image = XFile('/test/qr.png');
      camera.capture = BarcodeCapture(
        barcodes: [Barcode(rawValue: scenario.uri)],
      );
      final wallet = _ExactWallet();
      when(
        () => wallet.getSupportedTokens(),
      ).thenAnswer((_) async => scenario.assets);
      getIt.registerSingleton<IWalletBridge>(wallet);
      await open(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Payment asset is unavailable'), findsOneWidget);
      verifyNever(
        () => wallet.requestTransferExact(
          toAddress: any(named: 'toAddress'),
          amount: any(named: 'amount'),
          token: any(named: 'token'),
          memo: any(named: 'memo'),
          chain: any(named: 'chain'),
          network: any(named: 'network'),
          assetType: any(named: 'assetType'),
          assetId: any(named: 'assetId'),
        ),
      );
    });
  }

  testWidgets('manual legacy QR requires a choice between same-symbol assets', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_exactAsset, _otherAsset]);
    when(
      () => wallet.requestTransferExact(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
        chain: any(named: 'chain'),
        network: any(named: 'network'),
        assetType: any(named: 'assetType'),
        assetId: any(named: 'assetId'),
      ),
    ).thenAnswer((_) async => TransferResult.failure('declined'));
    getIt.registerSingleton<IWalletBridge>(wallet);
    await open(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manual Input User ID'));
    await tester.pump();
    await tester.enterText(
      find.byType(TextField),
      'n42pay://pay?to=0xrecipient&amount=1.25&token=USDT',
    );
    await tester.tap(find.text('Add'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('scan_asset_selector')), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
    verifyNever(
      () => wallet.requestTransferExact(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
        chain: any(named: 'chain'),
        network: any(named: 'network'),
        assetType: any(named: 'assetType'),
        assetId: any(named: 'assetId'),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('scan_asset_selector')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.textContaining('0x111111').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    verify(
      () => wallet.requestTransferExact(
        toAddress: '0xrecipient',
        amount: '1.25',
        token: 'USDT',
        memo: null,
        chain: 'ETH',
        network: 'mainnet',
        assetType: 'token',
        assetId: '0x1111111111111111111111111111111111111111',
      ),
    ).called(1);
  });

  testWidgets('v1 asset without selected receiver never calls wallet', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_noReceiverAsset]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://v1/pay?chain=ETH&network=mainnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1',
    );
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
    verifyNever(
      () => wallet.requestTransferExact(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
        chain: any(named: 'chain'),
        network: any(named: 'network'),
        assetType: any(named: 'assetType'),
        assetId: any(named: 'assetId'),
      ),
    );
  });

  testWidgets('fresh asset removal during confirmation prevents transfer', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    var reads = 0;
    when(() => wallet.getSupportedTokens()).thenAnswer(
      (_) async => ++reads == 1 ? const [_exactAsset] : const <TokenInfo>[],
    );
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://v1/pay?chain=ETH&network=mainnet&type=token&to=0xrecipient&contract=0xabcdef0123456789abcdef0123456789abcdef01&amount=1',
    );
    expect(find.byKey(const ValueKey('scan_selected_asset')), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(reads, 2);
    verifyNever(
      () => wallet.requestTransferExact(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
        chain: any(named: 'chain'),
        network: any(named: 'network'),
        assetType: any(named: 'assetType'),
        assetId: any(named: 'assetId'),
      ),
    );
  });

  testWidgets('legacy chain hint cannot use symbol-only bridge', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    when(() => wallet.getSupportedTokens()).thenAnswer(
      (_) async => const [
        TokenInfo(symbol: 'USDT', name: 'Legacy', decimals: 6, chain: 'ETH'),
      ],
    );
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://pay?to=0xrecipient&amount=1&token=USDT&chain=ETH',
    );
    await tester.tap(find.byKey(const ValueKey('scan_asset_selector')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.textContaining('Legacy').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
    verifyNever(
      () => wallet.requestTransfer(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    );
  });

  testWidgets('duplicate identical legacy assets fail before chooser', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_exactAsset, _exactAsset]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://pay?to=0xrecipient&amount=1&token=USDT',
    );
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('colliding abbreviated IDs are fully visible in legacy chooser', (
    tester,
  ) async {
    final wallet = _ExactWallet();
    when(
      () => wallet.getSupportedTokens(),
    ).thenAnswer((_) async => const [_exactAsset, _collisionAsset]);
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://pay?to=0xrecipient&amount=1&token=USDT',
    );
    await tester.tap(find.byKey(const ValueKey('scan_asset_selector')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining(_exactAsset.assetId!), findsOneWidget);
    expect(find.textContaining(_collisionAsset.assetId!), findsOneWidget);
    expect(
      _exactAsset.assetId!.substring(0, 8),
      _collisionAsset.assetId!.substring(0, 8),
    );
    expect(
      _exactAsset.assetId!.substring(_exactAsset.assetId!.length - 6),
      _collisionAsset.assetId!.substring(_collisionAsset.assetId!.length - 6),
    );
  });

  testWidgets('chainless unique legacy asset still uses old bridge', (
    tester,
  ) async {
    final wallet = _LegacyWallet();
    when(() => wallet.getSupportedTokens()).thenAnswer(
      (_) async => const [
        TokenInfo(symbol: 'USDT', name: 'Legacy', decimals: 6),
      ],
    );
    when(
      () => wallet.requestTransfer(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    ).thenAnswer((_) async => TransferResult.failure('declined'));
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://pay?to=0xrecipient&amount=1&token=USDT',
    );
    await tester.tap(find.byKey(const ValueKey('scan_asset_selector')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.textContaining('Legacy').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    verify(
      () => wallet.requestTransfer(
        toAddress: '0xrecipient',
        amount: '1',
        token: 'USDT',
        memo: null,
      ),
    ).called(1);
  });

  testWidgets('case-variant duplicate symbols never use old bridge', (
    tester,
  ) async {
    final wallet = _LegacyWallet();
    when(() => wallet.getSupportedTokens()).thenAnswer(
      (_) async => const [
        TokenInfo(symbol: 'USDT', name: 'One', decimals: 6),
        TokenInfo(symbol: 'usdt', name: 'Two', decimals: 6),
      ],
    );
    getIt.registerSingleton<IWalletBridge>(wallet);
    await scanGallery(
      tester,
      'n42pay://pay?to=0xrecipient&amount=1&token=USDT',
    );
    expect(find.text('Payment asset is unavailable'), findsOneWidget);
    verifyNever(
      () => wallet.requestTransfer(
        toAddress: any(named: 'toAddress'),
        amount: any(named: 'amount'),
        token: any(named: 'token'),
        memo: any(named: 'memo'),
      ),
    );
  });

  testWidgets('denied permission stays usable across repeated resumes', (
    tester,
  ) async {
    await open(tester);
    await tester.pumpAndSettle();
    expect(requests, 1);
    for (var i = 0; i < 3; i++) {
      await resume(tester);
      expect(requests, 1);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Retry'), findsOneWidget);
    }
    await tester.tap(find.text('Manual Input User ID'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    await tester.ensureVisible(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(requests, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('permission dialog resume cannot create a concurrent request', (
    tester,
  ) async {
    requestResult = Completer<Map<int, int>>();
    await open(tester);
    expect(requests, 1);
    await resume(tester);
    expect(checks, 1);
    expect(requests, 1);
    requestResult!.complete({1: 0});
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'passive permission check does not replace controls with loading',
    (tester) async {
      await open(tester);
      await tester.pumpAndSettle();
      checkResult = Completer<int>();
      await resume(tester);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.tap(find.text('Manual Input User ID'));
      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
      checkResult!.complete(0);
      await tester.pumpAndSettle();
      expect(requests, 1);
    },
  );

  testWidgets('granted camera retains controller and resumes preview', (
    tester,
  ) async {
    permission = 1;
    await open(tester);
    await tester.pumpAndSettle();
    final controller = tester
        .widget<MobileScanner>(find.byType(MobileScanner))
        .controller;
    expect(camera.starts, 1);
    await resume(tester);
    await tester.pumpAndSettle();
    expect(
      tester.widget<MobileScanner>(find.byType(MobileScanner)).controller,
      same(controller),
    );
    expect(camera.disposals, 0);
    expect(camera.starts, 2);
    expect(requests, 0);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(camera.disposals, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('gallery works with denied camera permission and no QR result', (
    tester,
  ) async {
    gallery.image = XFile('/test/qr.png');
    await open(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
    await tester.pumpAndSettle();
    expect(gallery.calls, 1);
    expect(camera.analyses, 1);
    expect(camera.starts, 0);
    expect(requests, 1);
    expect(find.text('Invalid QR code'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'picker excludes duplicate taps and camera resume until cancellation',
    (tester) async {
      permission = 1;
      gallery.pending = Completer<XFile?>();
      await open(tester);
      await tester.pumpAndSettle();
      final button = find.byKey(const ValueKey('scan_gallery_button'));
      await tester.tap(button);
      await tester.pump();
      await tester.tap(button);
      await resume(tester);
      expect(gallery.calls, 1);
      expect(camera.starts, 1);
      expect(camera.stops, 1);
      gallery.pending!.complete(null);
      await tester.pumpAndSettle();
      expect(camera.starts, 2);
      expect(camera.analyses, 0);
      expect(find.byType(SnackBar), findsNothing);
    },
  );

  testWidgets(
    'gallery payment QR uses confirmation and resumes after cancellation',
    (tester) async {
      permission = 1;
      gallery.image = XFile('/test/qr.png');
      camera.capture = const BarcodeCapture(
        barcodes: [
          Barcode(rawValue: 'n42pay://pay?to=test-address&amount=1&token=ETH'),
        ],
      );
      final wallet = _ExactWallet();
      when(() => wallet.getSupportedTokens()).thenAnswer(
        (_) async => const [
          TokenInfo(symbol: 'ETH', name: 'Ethereum', decimals: 18),
        ],
      );
      getIt.registerSingleton<IWalletBridge>(wallet);
      await open(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('1 ETH'), findsOneWidget);
      expect(camera.starts, 1);
      Navigator.of(tester.element(find.text('1 ETH'))).pop();
      await tester.pumpAndSettle();
      expect(camera.starts, 2);
      expect(tester.takeException(), isNull);
    },
  );

  for (final stage in ['picker', 'decoder']) {
    testWidgets('$stage failure restores camera and allows retry', (
      tester,
    ) async {
      permission = 1;
      if (stage == 'picker') {
        gallery.error = PlatformException(code: 'photo_access_denied');
      } else {
        gallery.image = XFile('/test/qr.png');
        camera.analysisError = StateError('Unreadable image');
      }
      await open(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
      await tester.pumpAndSettle();
      expect(camera.starts, 2);
      expect(find.byType(SnackBar), findsNothing);
      expect(find.textContaining('Failed to select image'), findsOneWidget);
      expect(
        tester
            .widget<TextButton>(
              find.byKey(const ValueKey('scan_gallery_button')),
            )
            .onPressed,
        isNotNull,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('late gallery selection after leaving page is ignored', (
    tester,
  ) async {
    gallery.pending = Completer<XFile?>();
    await open(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('scan_gallery_button')));
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    gallery.pending!.complete(XFile('/test/qr.png'));
    await tester.pumpAndSettle();
    expect(camera.analyses, 0);
    expect(tester.takeException(), isNull);
  });
}
