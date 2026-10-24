import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/streaming_attachment_encryptor.dart';
import 'package:n42_chat/src/core/services/streaming_attachment_decryptor.dart';

class _File extends Mock implements File {}

void main() {
  test(
    'rejects ciphertext replaced between verification and decryption',
    () async {
      final encrypted = await StreamingAttachmentEncryptor().encrypt(
        Stream.value([1, 2, 3, 4]),
        maxBytes: 4,
      );
      addTearDown(encrypted.dispose);
      final output = File('${encrypted.file.parent.path}/plain');
      final source = _File();
      var opens = 0;
      when(() => source.openRead()).thenAnswer((_) {
        if (++opens == 2) {
          final bytes = encrypted.file.readAsBytesSync();
          bytes[0] ^= 1;
          encrypted.file.writeAsBytesSync(bytes);
        }
        return encrypted.file.openRead();
      });
      await expectLater(
        StreamingAttachmentDecryptor().decrypt(
          source: source,
          destination: output,
          key: encrypted.key,
          iv: encrypted.iv,
          sha256: encrypted.sha256Hash,
          maxBytes: 4,
        ),
        throwsFormatException,
      );
      expect(opens, 2);
      expect(await output.exists(), isFalse);
    },
  );

  test(
    'hash verification enforces byte and cancellation bounds before plaintext',
    () async {
      final encrypted = await StreamingAttachmentEncryptor().encrypt(
        Stream.value([1, 2, 3, 4]),
        maxBytes: 4,
      );
      addTearDown(encrypted.dispose);
      final output = File('${encrypted.file.parent.path}/plain');
      for (final limit in [3, 4]) {
        await expectLater(
          StreamingAttachmentDecryptor().decrypt(
            source: encrypted.file,
            destination: output,
            key: encrypted.key,
            iv: encrypted.iv,
            sha256: encrypted.sha256Hash,
            maxBytes: limit,
            isActive: () => limit == 3,
          ),
          throwsStateError,
        );
        expect(await output.exists(), isFalse);
      }
    },
  );
}
