import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart'
    show EncryptedFile, decryptFileImplementation;

import '../utils/secure_uri.dart';
import 'media_telemetry.dart';

/// Bounded, authenticated document fetch. Redirects never receive credentials.
class TextDocumentLoader {
  static const maxBytes = 2 * 1024 * 1024;
  final http.Client _client;
  final String operationId = MediaTelemetry.newOperationId();
  TextDocumentLoader({http.Client? client}) : _client = client ?? http.Client();

  Future<String> load(
    String url, {
    Map<String, String>? headers,
    String? encryptKey,
    String? encryptIv,
    String? encryptSha256,
  }) async {
    final measurement = MediaTelemetry.start(
      MediaStage.download,
      operationId: operationId,
    );
    var length = 0;
    try {
      final uri = parseSecureUri(url);
      if (uri == null) {
        throw const FormatException('A valid HTTPS document URL is required.');
      }
      final encrypted =
          encryptKey != null || encryptIv != null || encryptSha256 != null;
      if (encrypted &&
          (encryptKey == null || encryptIv == null || encryptSha256 == null)) {
        throw const FormatException(
          'Encrypted document metadata is incomplete.',
        );
      }
      Future<Uint8List> read() async {
        final request = http.Request('GET', uri)..followRedirects = false;
        if (headers != null) request.headers.addAll(headers);
        final response = await _client.send(request);
        if (response.statusCode != 200) {
          throw const FormatException('Document download failed.');
        }
        if ((response.contentLength ?? 0) > maxBytes) {
          throw const FormatException('Preview limit exceeded (max 2MB).');
        }
        final builder = BytesBuilder(copy: false);
        await for (final chunk in response.stream) {
          length += chunk.length;
          if (length > maxBytes) {
            throw const FormatException('Preview limit exceeded (max 2MB).');
          }
          builder.add(chunk);
        }
        return builder.takeBytes();
      }

      var bytes = await read().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _client.close();
          throw const FormatException('Document download timed out.');
        },
      );
      measurement.finish(MediaOutcome.succeeded, bytes: length);
      if (encrypted) {
        final decrypt = MediaTelemetry.start(
          MediaStage.decrypt,
          operationId: measurement.operationId,
        );
        try {
          final result = await decryptFileImplementation(
            EncryptedFile(
              data: bytes,
              k: encryptKey!,
              iv: encryptIv!,
              sha256: encryptSha256!,
            ),
          );
          if (result == null) {
            throw const FormatException(
              'Encrypted document validation failed.',
            );
          }
          bytes = result;
          decrypt.finish(MediaOutcome.succeeded, bytes: bytes.length);
        } catch (_) {
          decrypt.finish(MediaOutcome.failed, bytes: bytes.length);
          throw const FormatException('Encrypted document validation failed.');
        }
      }
      return utf8.decode(bytes, allowMalformed: false);
    } catch (_) {
      measurement.finish(MediaOutcome.failed, bytes: length);
      rethrow;
    }
  }

  void dispose() => _client.close();
}
