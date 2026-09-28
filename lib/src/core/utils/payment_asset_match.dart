import '../../integration/wallet_bridge.dart';
import 'payment_request_uri.dart';

enum PaymentAssetResolutionStatus {
  matched,
  requiresSelection,
  ambiguous,
  unavailable,
  invalid,
}

class PaymentAssetResolution {
  final PaymentAssetResolutionStatus status;

  /// Set only for a uniquely matched exact request.
  final TokenInfo? asset;

  /// Legacy choices still require the user to select an asset explicitly.
  final List<TokenInfo> candidates;

  const PaymentAssetResolution(
    this.status, {
    this.asset,
    this.candidates = const [],
  });
}

/// Build a v1 QR request only from a complete, selected wallet asset.
PaymentRequestData? createExactPaymentRequestForAsset(
  TokenInfo asset, {
  String amount = '',
}) {
  final request = PaymentRequestData(
    receiverAddress: asset.receiverAddress ?? '',
    amount: amount,
    chain: asset.chain,
    network: asset.network,
    assetType: asset.assetType,
    assetId: asset.assetId,
  );
  if (!PaymentRequestUri.isValidExactData(request) ||
      !_matchesExactAsset(request, asset) ||
      amount.isNotEmpty &&
          !isValidPaymentAmountForDecimals(amount, asset.decimals)) {
    return null;
  }
  return request;
}

/// Resolve a payment request against the wallet's published assets.
///
/// A legacy URI always requires an explicit user selection, even with one
/// matching symbol. Exact requests must match one complete asset identity.
PaymentAssetResolution resolvePaymentAsset(
  PaymentRequestData request,
  Iterable<TokenInfo> supportedAssets,
) {
  if (request.hasExactIdentity) {
    if (!PaymentRequestUri.isValidExactData(request)) {
      return const PaymentAssetResolution(PaymentAssetResolutionStatus.invalid);
    }
    final matches = supportedAssets
        .where((asset) => _matchesExactAsset(request, asset))
        .toList(growable: false);
    if (matches.isEmpty) {
      return const PaymentAssetResolution(
        PaymentAssetResolutionStatus.unavailable,
      );
    }
    if (matches.length != 1) {
      return const PaymentAssetResolution(
        PaymentAssetResolutionStatus.ambiguous,
      );
    }
    final asset = matches.single;
    if (request.hasAmount &&
        !isValidPaymentAmountForDecimals(request.amount, asset.decimals)) {
      return const PaymentAssetResolution(PaymentAssetResolutionStatus.invalid);
    }
    return PaymentAssetResolution(
      PaymentAssetResolutionStatus.matched,
      asset: asset,
    );
  }

  if (request.receiverAddress.trim().isEmpty ||
      request.hasAmount && !_isPositiveDecimal(request.amount)) {
    return const PaymentAssetResolution(PaymentAssetResolutionStatus.invalid);
  }
  final matches = supportedAssets
      .where(
        (asset) =>
            (request.token.isEmpty ||
                asset.symbol.toUpperCase() == request.token.toUpperCase()) &&
            (request.chain == null || asset.chain == request.chain),
      )
      .toList(growable: false);
  if (matches.isEmpty) {
    return const PaymentAssetResolution(
      PaymentAssetResolutionStatus.unavailable,
    );
  }
  if (matches.length != 1) {
    return PaymentAssetResolution(
      PaymentAssetResolutionStatus.ambiguous,
      candidates: List.unmodifiable(matches),
    );
  }
  if (request.hasAmount &&
      !isValidPaymentAmountForDecimals(
        request.amount,
        matches.single.decimals,
      )) {
    return const PaymentAssetResolution(PaymentAssetResolutionStatus.invalid);
  }
  return PaymentAssetResolution(
    PaymentAssetResolutionStatus.requiresSelection,
    candidates: List.unmodifiable(matches),
  );
}

bool _matchesExactAsset(PaymentRequestData request, TokenInfo asset) {
  if (asset.chain != request.chain ||
      asset.network != request.network ||
      asset.assetType != request.assetType ||
      asset.decimals < 0) {
    return false;
  }
  if (request.assetType == 'native') {
    return asset.isNative &&
        asset.assetId == null &&
        (asset.contractAddress == null || asset.contractAddress!.isEmpty);
  }
  return !asset.isNative &&
      samePaymentAssetId(asset.assetId, request.assetId) &&
      samePaymentAssetId(asset.assetId, asset.contractAddress);
}

/// EVM 40-hex addresses are case insensitive; all other IDs are exact strings.
bool samePaymentAssetId(String? left, String? right) {
  final normalizedLeft = left?.trim();
  final normalizedRight = right?.trim();
  if (normalizedLeft == null ||
      normalizedRight == null ||
      normalizedLeft.isEmpty ||
      normalizedRight.isEmpty) {
    return false;
  }
  final evmAddress = RegExp(r'^0x[0-9a-fA-F]{40}$');
  if (evmAddress.hasMatch(normalizedLeft) &&
      evmAddress.hasMatch(normalizedRight)) {
    return normalizedLeft.toLowerCase() == normalizedRight.toLowerCase();
  }
  return normalizedLeft == normalizedRight;
}

/// Validate decimal text against the selected asset without converting it.
bool isValidPaymentAmountForDecimals(String amount, int decimals) {
  if (decimals < 0 || !_isPositiveDecimal(amount)) {
    return false;
  }
  final point = amount.indexOf('.');
  return point < 0 || amount.length - point - 1 <= decimals;
}

bool _isPositiveDecimal(String amount) =>
    RegExp(r'^[0-9]+(?:\.[0-9]+)?$').hasMatch(amount) &&
    RegExp(r'[1-9]').hasMatch(amount);
