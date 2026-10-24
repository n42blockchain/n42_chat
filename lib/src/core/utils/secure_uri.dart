/// Parse security-sensitive URLs before Uri normalization can hide ambiguity.
Uri? parseSecureUri(String? raw, {bool requireHttps = true}) {
  if (raw == null ||
      raw.isEmpty ||
      raw.length > 8192 ||
      RegExp(r'[\x00-\x20\x7f\\]').hasMatch(raw) ||
      RegExp(r'%(?![0-9a-fA-F]{2})').hasMatch(raw))
    return null;
  try {
    final decoded = Uri.decodeComponent(raw);
    if (RegExp(r'[\x00-\x1f\x7f\\]').hasMatch(decoded) ||
        RegExp(r'%[0-9a-fA-F]{2}').hasMatch(decoded))
      return null;
    final uri = Uri.parse(raw);
    if (requireHttps && uri.scheme != 'https') return null;
    if (!uri.hasScheme ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.authority.contains('@') ||
        uri.host.endsWith('.') ||
        (uri.hasPort && uri.port < 1) ||
        uri.port > 65535)
      return null;
    // Inspect the original authority too: Uri can normalize an empty userinfo.
    final authority = raw
        .substring(raw.indexOf('://') + 3)
        .split(RegExp(r'[/#?]'))
        .first;
    if (!raw.contains('://') ||
        authority.contains('@') ||
        authority.contains('%'))
      return null;
    final rawPath = raw
        .substring(raw.indexOf('://') + 3)
        .replaceFirst(RegExp(r'^[^/\?#]*'), '')
        .split(RegExp(r'[?#]'))
        .first;
    if (rawPath
            .split('/')
            .any(
              (part) =>
                  part == '.' ||
                  part == '..' ||
                  Uri.decodeComponent(part) == '.' ||
                  Uri.decodeComponent(part) == '..',
            ) ||
        RegExp(r'%(2f|5c)', caseSensitive: false).hasMatch(rawPath))
      return null;
    final names = <String>{};
    for (final key in uri.queryParametersAll.keys) {
      if (!names.add(key.toLowerCase()) ||
          uri.queryParametersAll[key]!.length != 1)
        return null;
    }
    return uri;
  } on FormatException {
    return null;
  } on ArgumentError {
    return null;
  }
}

bool matchesOAuthRedirect(String candidate, String expected) {
  final actual = parseSecureUri(candidate, requireHttps: false);
  final target = parseSecureUri(expected, requireHttps: false);
  if (actual == null || target == null || target.hasQuery || target.hasFragment)
    return false;
  return actual.scheme == target.scheme &&
      actual.host == target.host &&
      actual.port == target.port &&
      actual.path == target.path;
}

Uri? normalizeTrustedMiniAppUri(String? rawUrl) {
  final uri = parseSecureUri(rawUrl);
  if (uri == null) return null;
  const forbidden = {
    'redirect',
    'redirect_uri',
    'redirect_url',
    'return_url',
    'returnto',
    'next',
    'url',
    'access_token',
    'id_token',
    'token',
    'authorization',
  };
  if (uri.queryParameters.keys.any(
    (key) => forbidden.contains(key.toLowerCase()),
  ))
    return null;
  return uri;
}
