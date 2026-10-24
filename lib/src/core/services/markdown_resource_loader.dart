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
  final http.Client _client;
  MarkdownResourceLoader({http.Client? client})
    : _client = client ?? http.Client();
  Future<Uint8List> load(Uri uri) async {
    if (markdownResourceUri(uri.toString()) == null) {
      throw const FormatException('Unsafe resource URL');
    }
    Future<Uint8List> read() async {
      final response = await _client.send(
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

    return read().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        _client.close();
        throw const FormatException('Image timed out');
      },
    );
  }

  void dispose() => _client.close();
}
