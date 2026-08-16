import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/timed_status_utils.dart';

void main() {
  group('TimedStatusMetadata', () {
    test('serializes and parses message and expiry', () {
      final expiresAt = DateTime.now().toUtc().add(const Duration(hours: 1));
      final metadata = TimedStatusMetadata(
        message: 'Gaming',
        expiresAt: expiresAt,
      );

      final parsed = TimedStatusMetadata.fromJson(metadata.toJson());

      expect(parsed.message, 'Gaming');
      expect(parsed.expiresAt, expiresAt);
      expect(parsed.isExpired, isFalse);
    });

    test('treats blank message as empty', () {
      final parsed = TimedStatusMetadata.fromJson({
        'message': '   ',
        'expiresAt': null,
      });

      expect(parsed.hasMessage, isFalse);
      expect(parsed.message, isNull);
    });

    test('marks past expiry as expired', () {
      final parsed = TimedStatusMetadata.fromJson({
        'message': 'Busy',
        'expiresAt': DateTime.now()
            .toUtc()
            .subtract(const Duration(minutes: 1))
            .toIso8601String(),
      });

      expect(parsed.isExpired, isTrue);
    });
  });
}
