import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/streaming_attachment_encryptor.dart';

void main() {
  late Directory temp;
  setUp(
    () async =>
        temp = await Directory.systemTemp.createTemp('n42-stream-test-'),
  );
  tearDown(() async => temp.delete(recursive: true));
  test(
    'cross-block ciphertext decrypts and hashes to Matrix v2 descriptor',
    () async {
      final clear = Uint8List.fromList(
        List.generate(256 * 1024 + 19, (i) => i % 251),
      );
      final result = await StreamingAttachmentEncryptor().encrypt(
        Stream.fromIterable([
          clear.sublist(0, 7),
          clear.sublist(7, 65549),
          clear.sublist(65549),
        ]),
        maxBytes: clear.length,
        expectedBytes: clear.length,
        temporaryDirectory: temp,
      );
      final encrypted = await result.file.readAsBytes();
      expect(encrypted, isNot(clear));
      final hash = await Sha256().hash(encrypted);
      expect(base64.normalize(result.sha256Hash), base64.encode(hash.bytes));
      final decrypted =
          await AesCtr.with256bits(macAlgorithm: MacAlgorithm.empty).decrypt(
            SecretBox(
              encrypted,
              nonce: base64.decode(base64.normalize(result.iv)),
              mac: Mac.empty,
            ),
            secretKey: SecretKey(
              base64Url.decode(base64Url.normalize(result.key)),
            ),
          );
      expect(decrypted, clear);
      final descriptor = result.descriptor(Uri.parse('mxc://test/ciphertext'));
      expect(descriptor['v'], 'v2');
      expect(descriptor['url'], 'mxc://test/ciphertext');
      expect((descriptor['key'] as Map)['alg'], 'A256CTR');
      await result.dispose();
      expect(await temp.list().isEmpty, isTrue);
    },
  );
  test(
    'unknown-size stream exceeding limit removes partial ciphertext',
    () async {
      await expectLater(
        StreamingAttachmentEncryptor().encrypt(
          Stream.fromIterable([List.filled(64, 1), List.filled(64, 2)]),
          maxBytes: 100,
          temporaryDirectory: temp,
        ),
        throwsStateError,
      );
      expect(await temp.list().isEmpty, isTrue);
    },
  );
  test(
    'declared size mismatch and session cancellation clean temporary files',
    () async {
      for (final active in [true, false]) {
        await expectLater(
          StreamingAttachmentEncryptor().encrypt(
            Stream.value([1, 2, 3]),
            maxBytes: 100,
            expectedBytes: 4,
            isActive: () => active,
            temporaryDirectory: temp,
          ),
          throwsStateError,
        );
        expect(await temp.list().isEmpty, isTrue);
      }
    },
  );
  test('stream failure never leaves a completed attachment', () async {
    await expectLater(
      StreamingAttachmentEncryptor().encrypt(
        Stream<List<int>>.error(StateError('source closed')),
        maxBytes: 100,
        temporaryDirectory: temp,
      ),
      throwsStateError,
    );
    expect(await temp.list().isEmpty, isTrue);
  });
  test(
    'large stream is consumed incrementally without requiring whole-file bytes',
    () async {
      const count = 1024;
      var produced = 0;
      Stream<List<int>> source() async* {
        for (var i = 0; i < count; i++) {
          produced++;
          yield Uint8List(65536);
        }
      }

      final result = await StreamingAttachmentEncryptor().encrypt(
        source(),
        maxBytes: 64 * 1024 * 1024,
        expectedBytes: 64 * 1024 * 1024,
        temporaryDirectory: temp,
      );
      expect(produced, count);
      expect(await result.file.length(), 64 * 1024 * 1024);
      await result.dispose();
    },
  );
}
