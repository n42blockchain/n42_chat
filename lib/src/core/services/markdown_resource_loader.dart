import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../utils/secure_uri.dart';

Uri? markdownResourceUri(String raw) {
  final uri = parseSecureUri(raw);
  if (uri == null ||
      uri.host == 'localhost' ||
      uri.host.endsWith('.localhost') ||
      uri.host.endsWith('.local') ||
      uri.host.contains(':') ||
      RegExp(r'^[0-9.]+$').hasMatch(uri.host)) {
    return null;
  }
  return uri;
}

/// Fetch only after explicit per-resource consent; never forward app credentials.
class MarkdownResourceLoader {
  final http.Client Function() _clientFactory;
  final Duration timeout;
  final Set<http.Client> _active = {};
  bool _disposed = false;
  MarkdownResourceLoader({
    http.Client? client,
    http.Client Function()? clientFactory,
    this.timeout = const Duration(seconds: 15),
  }) : assert(client == null || clientFactory == null),
       _clientFactory = clientFactory ?? (() => client ?? http.Client());
  Future<Uint8List> load(Uri uri) async {
    if (_disposed) throw StateError('Image loader disposed');
    if (markdownResourceUri(uri.toString()) == null) {
      throw const FormatException('Unsafe resource URL');
    }
    final client = _clientFactory();
    _active.add(client);
    Future<Uint8List> read() async {
      final response = await client.send(
        http.Request('GET', uri)..followRedirects = false,
      );
      if (response.statusCode != 200 ||
          (response.contentLength ?? 0) > 2 * 1024 * 1024) {
        throw const FormatException('Image unavailable');
      }
      final bytes = BytesBuilder(copy: false);
      await for (final chunk in response.stream) {
        if (bytes.length + chunk.length > 2 * 1024 * 1024) {
          throw const FormatException('Image exceeds 2MB');
        }
        bytes.add(chunk);
      }
      return bytes.takeBytes();
    }

    try {
      return await read().timeout(timeout);
    } finally {
      client.close();
      _active.remove(client);
    }
  }

  void dispose() {
    _disposed = true;
    for (final client in _active) {
      client.close();
    }
    _active.clear();
  }
}
