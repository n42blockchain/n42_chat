Uri? parseSafeExternalUri(
  String rawUrl, {
  Set<String> allowedSchemes = const {'http', 'https'},
}) {
  final normalized = rawUrl.trim();
  if (normalized.isEmpty) {
    return null;
  }

  final uri = Uri.tryParse(normalized);
  if (uri == null || uri.host.isEmpty) {
    return null;
  }
  if (!allowedSchemes.contains(uri.scheme)) {
    return null;
  }
  if (isPrivateNetworkHost(uri.host)) {
    return null;
  }
  return uri;
}

bool isPrivateNetworkHost(String rawHost) {
  final host = rawHost.toLowerCase();

  if (host == 'localhost' || host == '::1') {
    return true;
  }
  if (host.endsWith('.local') || host.endsWith('.internal')) {
    return true;
  }

  final ipv4Parts = host.split('.');
  if (ipv4Parts.length == 4) {
    final first = int.tryParse(ipv4Parts[0]);
    final second = int.tryParse(ipv4Parts[1]);
    if (first == 127) return true;
    if (first == 10) return true;
    if (first == 172 && second != null && second >= 16 && second <= 31) {
      return true;
    }
    if (first == 192 && second == 168) return true;
    if (first == 169 && second == 254) return true;
    if (first == 0) return true;
  }

  // IPv6 link-local and ULA (Unique Local Address) ranges.
  // ULA addresses start with fc00::/7 (i.e. fc00:: - fdff::).
  // Only match when the host contains a colon (IPv6 format) to avoid
  // false positives on domain names like "facebook.com".
  if (host.contains(':')) {
    if (host.startsWith('fe80:') ||
        host.startsWith('fc') ||
        host.startsWith('fd')) {
      return true;
    }
  }

  return false;
}
