import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart' hide Digest;

class _HashSink implements Sink<Digest> {
  Digest? digest;
  @override
  void add(Digest data) => digest = data;
  @override
  void close() {}
}

class EncryptedAttachmentFile {
  final File file;
  final int size;
  final String key;
  final String iv;
  final String sha256Hash;
  final Directory _directory;
  EncryptedAttachmentFile._(
    this.file,
    this.size,
    this.key,
    this.iv,
    this.sha256Hash,
    this._directory,
  );
  Map<String, dynamic> descriptor(Uri mxc) => {
    'url': mxc.toString(),
    'v': 'v2',
    'key': {
      'kty': 'oct',
      'key_ops': ['encrypt', 'decrypt'],
      'alg': 'A256CTR',
      'k': key,
      'ext': true,
    },
    'iv': iv,
    'hashes': {'sha256': sha256Hash},
  };
  Future<void> dispose() => _directory.delete(recursive: true);
}

/// Matrix AES-256-CTR v2 attachment encryption with <=64 KiB working blocks.
/// Only ciphertext is written to the temporary file; no plaintext fallback.
class StreamingAttachmentEncryptor {
  Future<EncryptedAttachmentFile> encrypt(
    Stream<List<int>> source, {
    required int maxBytes,
    int? expectedBytes,
    bool Function()? isActive,
    Directory? temporaryDirectory,
  }) async {
    if (maxBytes <= 0 ||
        (expectedBytes != null &&
            (expectedBytes <= 0 || expectedBytes > maxBytes))) {
      throw StateError('Attachment exceeds the upload limit.');
    }
    final directory = await (temporaryDirectory ?? Directory.systemTemp)
        .createTemp('n42-encrypted-');
    final file = File('${directory.path}/content.bin');
    late final RandomAccessFile output;
    try {
      output = await file.open(mode: FileMode.write);
    } catch (_) {
      await directory.delete(recursive: true);
      rethrow;
    }
    final random = Random.secure();
    final key = Uint8List.fromList(
      List.generate(32, (_) => random.nextInt(256)),
    );
    // Matrix uses a random 64-bit prefix and a zero 64-bit initial counter.
    final iv = Uint8List(16);
    for (var i = 0; i < 8; i++) {
      iv[i] = random.nextInt(256);
    }
    final cipher = SICStreamCipher(AESEngine())
      ..init(true, ParametersWithIV<KeyParameter>(KeyParameter(key), iv));
    final hashSink = _HashSink();
    final hasher = sha256.startChunkedConversion(hashSink);
    var count = 0;
    var closed = false;
    try {
      await for (final chunk in source) {
        if (isActive?.call() == false) {
          throw StateError('Attachment session ended.');
        }
        if (count + chunk.length > maxBytes) {
          throw StateError('Attachment exceeds the upload limit.');
        }
        for (var offset = 0; offset < chunk.length; offset += 65536) {
          final end = min(offset + 65536, chunk.length);
          final block = chunk is Uint8List
              ? Uint8List.sublistView(chunk, offset, end)
              : Uint8List.fromList(chunk.sublist(offset, end));
          final encrypted = cipher.process(block);
          hasher.add(encrypted);
          await output.writeFrom(encrypted);
          count += block.length;
        }
      }
      if (isActive?.call() == false ||
          count == 0 ||
          (expectedBytes != null && count != expectedBytes)) {
        throw StateError('Attachment size or session changed.');
      }
      hasher.close();
      await output.close();
      closed = true;
      return EncryptedAttachmentFile._(
        file,
        count,
        base64Url.encode(key).replaceAll('=', ''),
        base64.encode(iv).replaceAll('=', ''),
        base64.encode(hashSink.digest!.bytes).replaceAll('=', ''),
        directory,
      );
    } catch (_) {
      try {
        if (!closed) {
          await output.close();
          closed = true;
        }
      } finally {
        await directory.delete(recursive: true);
      }
      rethrow;
    } finally {
      key.fillRange(0, key.length, 0);
      cipher.reset();
    }
  }
}
