import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/export.dart';

class _DigestSink implements Sink<crypto.Digest> {
  crypto.Digest? value;
  @override
  void add(crypto.Digest data) => value = data;
  @override
  void close() {}
}

/// Verify ciphertext before writing private temporary plaintext, then verify the
/// bytes actually decrypted again before the caller may publish the output.
class StreamingAttachmentDecryptor {
  Future<void> decrypt({
    required File source,
    required File destination,
    required String key,
    required String iv,
    required String sha256,
    required int maxBytes,
    bool Function()? isActive,
  }) async {
    final keyBytes = base64Url.decode(base64Url.normalize(key));
    try {
      final ivBytes = base64.decode(base64.normalize(iv));
      final expected = base64.decode(base64.normalize(sha256));
      if (keyBytes.length != 32 ||
          ivBytes.length != 16 ||
          expected.length != 32) {
        throw const FormatException('Invalid attachment encryption metadata');
      }
      Stream<List<int>> boundedSource() async* {
        var count = 0;
        await for (final chunk in source.openRead()) {
          count += chunk.length;
          if (count > maxBytes || isActive?.call() == false) {
            throw StateError('Attachment download cancelled or too large');
          }
          yield chunk;
        }
        if (count == 0) {
          throw const FormatException('Empty encrypted attachment');
        }
      }

      bool matches(crypto.Digest digest) {
        var difference = 0;
        for (var i = 0; i < expected.length; i++) {
          difference |= expected[i] ^ digest.bytes[i];
        }
        return difference == 0;
      }

      final actual = await crypto.sha256.bind(boundedSource()).first;
      if (!matches(actual) || isActive?.call() == false) {
        throw const FormatException(
          'Attachment integrity or session check failed',
        );
      }
      final cipher = SICStreamCipher(AESEngine())
        ..init(
          false,
          ParametersWithIV<KeyParameter>(KeyParameter(keyBytes), ivBytes),
        );
      final output = await destination.open(mode: FileMode.write);
      final verified = _DigestSink();
      final hasher = crypto.sha256.startChunkedConversion(verified);
      var succeeded = false;
      try {
        await for (final chunk in boundedSource()) {
          hasher.add(chunk);
          await output.writeFrom(cipher.process(Uint8List.fromList(chunk)));
        }
        hasher.close();
        if (!matches(verified.value!) || isActive?.call() == false) {
          throw const FormatException('Attachment changed during decryption');
        }
        succeeded = true;
      } finally {
        try {
          await output.close();
        } finally {
          cipher.reset();
          if (!succeeded && await destination.exists()) {
            await destination.delete();
          }
        }
      }
    } finally {
      keyBytes.fillRange(0, keyBytes.length, 0);
    }
  }
}
