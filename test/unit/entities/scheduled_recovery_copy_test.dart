import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/scheduled_recovery_copy.dart';

void main() {
  Uint8List exported() {
    const raw = '{broken queue: 😀';
    return ScheduledRecoveryCopy(
      id: sha256.convert(utf8.encode(raw)).toString(),
      raw: raw,
      isIntact: true,
    ).exportBytes('@me:test');
  }

  test(
    'portable recovery roundtrip preserves damaged raw text without repair',
    () {
      final bytes = exported();
      final copy = ScheduledRecoveryCopy.fromExportBytes(
        bytes,
        ownerUserId: '@me:test',
      );
      expect(copy.exportBytes('@me:test'), bytes);
      expect(copy.raw, '{broken queue: 😀');
    },
  );
  for (final change in <String, Object?>{
    'format': 'other',
    'version': 2,
    'ownerUserId': '@other:test',
    'sha256': 'invalid',
    'raw': 'substituted',
    'attachmentsIncluded': true,
    'unknownField': 'unexpected',
  }.entries) {
    test('reject changed portable field ${change.key}', () {
      final data = jsonDecode(utf8.decode(exported())) as Map<String, dynamic>;
      data[change.key] = change.value;
      expect(
        () => ScheduledRecoveryCopy.fromExportBytes(
          Uint8List.fromList(utf8.encode(jsonEncode(data))),
          ownerUserId: '@me:test',
        ),
        throwsFormatException,
      );
    });
  }
  test('reject malformed, oversized and foreign imports', () {
    for (final bytes in [
      Uint8List(0),
      Uint8List.fromList([255]),
      Uint8List.fromList(utf8.encode('[]')),
      Uint8List(ScheduledRecoveryCopy.maxImportBytes + 1),
    ]) {
      expect(
        () => ScheduledRecoveryCopy.fromExportBytes(
          bytes,
          ownerUserId: '@me:test',
        ),
        throwsFormatException,
      );
    }
    for (final owner in ['', ' @me:test', '@other:test']) {
      expect(
        () => ScheduledRecoveryCopy.fromExportBytes(
          exported(),
          ownerUserId: owner,
        ),
        throwsFormatException,
      );
    }
  });
  test(
    'export preserves invalid queue bytes as evidence, not executable drafts',
    () {
      final raw = '{invalid queue\n${'😀' * 9000}';
      final id = sha256.convert(utf8.encode(raw)).toString();
      final copy = ScheduledRecoveryCopy(id: id, raw: raw, isIntact: true);
      final data = jsonDecode(utf8.decode(copy.exportBytes('@me:test')));
      expect(data, {
        'format': 'n42.scheduled-recovery',
        'version': 1,
        'ownerUserId': '@me:test',
        'sha256': id,
        'raw': raw,
        'attachmentsIncluded': false,
      });
      for (final owner in ['', ' ', ' @me:test', '@me:test ']) {
        expect(() => copy.exportBytes(owner), throwsStateError);
      }
    },
  );
  test('export rejects missing, damaged and mismatched content', () {
    for (final copy in [
      ScheduledRecoveryCopy(
        id: sha256.convert(utf8.encode('raw')).toString(),
        raw: 'raw',
        isIntact: false,
      ),
      const ScheduledRecoveryCopy(id: 'bad', raw: 'raw', isIntact: true),
      const ScheduledRecoveryCopy(id: 'bad', raw: null, isIntact: true),
    ]) {
      expect(() => copy.exportBytes('@me:test'), throwsStateError);
    }
  });
}
