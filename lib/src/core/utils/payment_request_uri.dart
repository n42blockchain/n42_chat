/// 收款请求二维码载荷（商户收款码）
class PaymentRequestData {
  /// 收款地址
  final String receiverAddress;

  /// 金额（空字符串表示开放金额，由付款方填写）
  final String amount;

  /// 代币符号
  final String token;

  /// 备注 / 订单号
  final String? memo;

  /// 链标识（可选，如 'n42'、'ethereum'）
  final String? chain;

  /// Complete v1 asset identity. Absent on legacy payment links.
  final String? network;
  final String? assetType;
  final String? assetId;

  const PaymentRequestData({
    required this.receiverAddress,
    this.amount = '',
    this.token = '',
    this.memo,
    this.chain,
    this.network,
    this.assetType,
    this.assetId,
  });

  bool get hasAmount => amount.trim().isNotEmpty;

  bool get hasExactIdentity =>
      network != null || assetType != null || assetId != null;

  @override
  bool operator ==(Object other) =>
      other is PaymentRequestData &&
      other.receiverAddress == receiverAddress &&
      other.amount == amount &&
      other.token == token &&
      other.memo == memo &&
      other.chain == chain &&
      other.network == network &&
      other.assetType == assetType &&
      other.assetId == assetId;

  @override
  int get hashCode => Object.hash(
    receiverAddress,
    amount,
    token,
    memo,
    chain,
    network,
    assetType,
    assetId,
  );
}

/// 收款请求二维码 URI 编解码（纯逻辑，便于单测）
///
/// Legacy links use `n42pay://pay`; exact assets use `n42pay://v1/pay`.
/// [tryParse] remains legacy-only until callers adopt exact dispatch.
class PaymentRequestUri {
  PaymentRequestUri._();

  static const String scheme = 'n42pay';
  static const String _host = 'pay';
  static const String _versionHost = 'v1';
  static const Set<String> _v1Keys = {
    'chain',
    'network',
    'type',
    'to',
    'contract',
    'amount',
  };
  static const Set<String> _legacyKeys = {
    'to',
    'amount',
    'token',
    'memo',
    'chain',
  };
  static const Set<String> _legacyN42Keys = {
    'address',
    'amount',
    'token',
    'memo',
    'chain',
  };

  /// 编码为可放进二维码的 URI 字符串。
  static String encode(PaymentRequestData data) {
    if (data.hasExactIdentity) {
      if (!isValidExactData(data)) {
        throw ArgumentError.value(
          data,
          'data',
          'Invalid exact payment request',
        );
      }
      final params = <String, String>{
        'chain': data.chain!,
        'network': data.network!,
        'type': data.assetType!,
        'to': data.receiverAddress,
      };
      if (data.assetType == 'token') params['contract'] = data.assetId!;
      if (data.hasAmount) params['amount'] = data.amount;
      return Uri(
        scheme: scheme,
        host: _versionHost,
        path: '/pay',
        queryParameters: params,
      ).toString();
    }

    final params = <String, String>{'to': data.receiverAddress.trim()};
    if (data.amount.trim().isNotEmpty) params['amount'] = data.amount.trim();
    if (data.token.trim().isNotEmpty) params['token'] = data.token.trim();
    final memo = data.memo?.trim();
    if (memo != null && memo.isNotEmpty) params['memo'] = memo;
    final chain = data.chain?.trim();
    if (chain != null && chain.isNotEmpty) params['chain'] = chain;

    final uri = Uri(scheme: scheme, host: _host, queryParameters: params);
    return uri.toString();
  }

  /// Parse only legacy links. Existing callers use a symbol-only wallet path.
  static PaymentRequestData? tryParse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty || _containsMalformedEscape(trimmed)) return null;

    Uri uri;
    try {
      uri = Uri.parse(trimmed);
    } catch (_) {
      return null;
    }

    final protocol = uri.scheme.toLowerCase();
    if ((protocol != scheme && protocol != 'n42') ||
        !_hasExpectedRoute(uri) ||
        uri.userInfo.isNotEmpty ||
        uri.hasPort ||
        uri.hasFragment) {
      return null;
    }

    final queryStart = trimmed.indexOf('?');
    if (queryStart < 0) return null;
    final params = _parseQuery(trimmed.substring(queryStart + 1));
    final allowedKeys = protocol == 'n42' ? _legacyN42Keys : _legacyKeys;
    if (params == null ||
        params.keys.any((key) => !allowedKeys.contains(key))) {
      return null;
    }
    final to = (params[protocol == 'n42' ? 'address' : 'to'] ?? '').trim();
    if (to.isEmpty) return null;

    return PaymentRequestData(
      receiverAddress: to,
      amount: (params['amount'] ?? '').trim(),
      token: (params['token'] ?? '').trim(),
      memo: _nullIfEmpty(params['memo']),
      chain: _nullIfEmpty(params['chain']),
    );
  }

  /// Parse the host's v1 identity without exposing it to legacy callers.
  static PaymentRequestData? tryParseExact(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty || _containsMalformedEscape(trimmed)) return null;
    Uri uri;
    try {
      uri = Uri.parse(trimmed);
    } on FormatException {
      return null;
    }
    if (uri.scheme.toLowerCase() != scheme ||
        uri.host.toLowerCase() != _versionHost) {
      return null;
    }
    return _tryParseV1(trimmed, uri);
  }

  /// 是否是收款 URI（快速判定，用于扫码分发）
  static bool isPaymentUri(String raw) {
    return tryParse(raw) != null;
  }

  /// A complete v1 request has no symbol or memo extensions on the wire.
  static bool isValidExactData(PaymentRequestData data) {
    if (!_isSafeField(data.receiverAddress) ||
        !_isSafeField(data.chain) ||
        (data.network != 'mainnet' && data.network != 'testnet') ||
        data.token.isNotEmpty ||
        data.memo != null) {
      return false;
    }
    if (data.assetType == 'native') {
      if (data.assetId != null) return false;
    } else if (data.assetType == 'token') {
      if (!_isSafeField(data.assetId)) return false;
    } else {
      return false;
    }
    return data.amount.isEmpty || _isPositiveDecimal(data.amount);
  }

  static PaymentRequestData? _tryParseV1(String raw, Uri uri) {
    if (uri.path != '/pay' ||
        uri.userInfo.isNotEmpty ||
        uri.hasPort ||
        uri.hasFragment) {
      return null;
    }
    final queryStart = raw.indexOf('?');
    if (queryStart < 0) return null;
    final params = _parseQuery(raw.substring(queryStart + 1));
    if (params == null || params.keys.any((key) => !_v1Keys.contains(key))) {
      return null;
    }
    final data = PaymentRequestData(
      receiverAddress: params['to'] ?? '',
      amount: params['amount'] ?? '',
      chain: params['chain'],
      network: params['network'],
      assetType: params['type'],
      assetId: params['contract'],
    );
    return isValidExactData(data) ? data : null;
  }

  static bool _hasExpectedRoute(Uri uri) {
    return uri.host.toLowerCase() == _host &&
        (uri.path.isEmpty || uri.path == '/');
  }

  static String? _nullIfEmpty(String? value) {
    final v = value?.trim();
    return (v == null || v.isEmpty) ? null : v;
  }

  static bool _isSafeField(String? value) =>
      value != null &&
      value.isNotEmpty &&
      !RegExp(r'[\s\u0000-\u001F\u007F]').hasMatch(value);

  static bool _isPositiveDecimal(String value) =>
      RegExp(r'^[0-9]+(?:\.[0-9]+)?$').hasMatch(value) &&
      RegExp(r'[1-9]').hasMatch(value);

  static Map<String, String>? _parseQuery(String raw) {
    final params = <String, String>{};
    for (final pair in raw.split('&')) {
      final separator = pair.indexOf('=');
      if (separator <= 0 || _containsMalformedEscape(pair)) return null;
      try {
        final key = Uri.decodeQueryComponent(pair.substring(0, separator));
        final value = Uri.decodeQueryComponent(pair.substring(separator + 1));
        if (key.isEmpty || params.containsKey(key)) return null;
        params[key] = value;
      } on FormatException {
        return null;
      }
    }
    return params;
  }

  static bool _containsMalformedEscape(String value) {
    for (var index = 0; index < value.length; index++) {
      if (value.codeUnitAt(index) != 0x25) continue;
      if (index + 2 >= value.length ||
          !_isHex(value.codeUnitAt(index + 1)) ||
          !_isHex(value.codeUnitAt(index + 2))) {
        return true;
      }
      index += 2;
    }
    return false;
  }

  static bool _isHex(int value) =>
      value >= 0x30 && value <= 0x39 ||
      value >= 0x41 && value <= 0x46 ||
      value >= 0x61 && value <= 0x66;
}
