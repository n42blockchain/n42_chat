import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/export.dart';

/// Verify Matrix v2 ciphertext before writing any plaintext. The caller owns
/// the private temporary directory and publishes the output only on success.
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
    final ivBytes = base64.decode(base64.normalize(iv));
    final expected = base64.decode(base64.normalize(sha256));
    if (keyBytes.length != 32 ||
        ivBytes.length != 16 ||
        expected.length != 32) {
      throw const FormatException('Invalid attachment encryption metadata');
    }
    final length = await source.length();
    if (length > maxBytes || length <= 0) {
      throw const FormatException('Attachment exceeds the download limit');
    }
    final actual = await crypto.sha256.bind(source.openRead()).first;
    var difference = 0;
    for (var i = 0; i < expected.length; i++) {
      difference |= expected[i] ^ actual.bytes[i];
    }
    if (difference != 0 || isActive?.call() == false) {
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
    var written = 0;
    try {
      await for (final chunk in source.openRead()) {
        if (isActive?.call() == false || written + chunk.length > maxBytes) {
          throw StateError('Attachment download cancelled or too large');
        }
        await output.writeFrom(cipher.process(Uint8List.fromList(chunk)));
        written += chunk.length;
      }
      if (written != length || isActive?.call() == false) {
        throw StateError('Attachment size or session changed');
      }
    } finally {
      await output.close();
      keyBytes.fillRange(0, keyBytes.length, 0);
      cipher.reset();
    }
  }
}
