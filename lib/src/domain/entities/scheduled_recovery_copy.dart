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

  /// Bounds untrusted portable files before UTF-8/JSON decoding.
  static const maxImportBytes = 8 * 1024 * 1024;

  /// Validates portable evidence, not executable drafts or sender authenticity.
  /// The caller supplies the authenticated account; the file cannot select it.
  factory ScheduledRecoveryCopy.fromExportBytes(
    Uint8List bytes, {
    required String ownerUserId,
  }) {
    if (ownerUserId.trim().isEmpty ||
        ownerUserId != ownerUserId.trim() ||
        bytes.isEmpty ||
        bytes.length > maxImportBytes) {
      throw const FormatException('Invalid scheduled recovery import');
    }
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map<String, dynamic> ||
        decoded.length != 6 ||
        decoded['format'] != 'n42.scheduled-recovery' ||
        decoded['version'] is! int ||
        decoded['version'] != 1 ||
        decoded['ownerUserId'] != ownerUserId ||
        decoded['attachmentsIncluded'] != false ||
        decoded['raw'] is! String ||
        decoded['sha256'] is! String) {
      throw const FormatException('Unsupported scheduled recovery import');
    }
    final raw = decoded['raw'] as String;
    final digest = sha256.convert(utf8.encode(raw)).toString();
    if (decoded['sha256'] != digest) {
      throw const FormatException('Scheduled recovery digest mismatch');
    }
    return ScheduledRecoveryCopy(id: digest, raw: raw, isIntact: true);
  }

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
