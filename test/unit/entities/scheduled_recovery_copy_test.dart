import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/scheduled_recovery_copy.dart';

void main() {
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
