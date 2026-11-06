import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// An account-scoped saved queue. Damaged copies remain visible but are never
/// treated as verified recovery input. The original stored value is untouched.
class ScheduledRecoveryCopy {
  final String id;
  final String? raw;
  final bool isIntact;

  const ScheduledRecoveryCopy({
    required this.id,
    required this.raw,
    required this.isIntact,
  });

  /// Portable evidence only: importing this file must never schedule or send it.
  Uint8List exportBytes(String ownerUserId) {
    if (ownerUserId.trim().isEmpty ||
        ownerUserId != ownerUserId.trim() ||
        !isIntact ||
        raw == null ||
        id != sha256.convert(utf8.encode(raw!)).toString()) {
      throw StateError('Invalid scheduled recovery export');
    }
    return Uint8List.fromList(
      utf8.encode(
        jsonEncode({
          'format': 'n42.scheduled-recovery',
          'version': 1,
          'ownerUserId': ownerUserId,
          'sha256': id,
          'raw': raw,
          'attachmentsIncluded': false,
        }),
      ),
    );
  }
}
