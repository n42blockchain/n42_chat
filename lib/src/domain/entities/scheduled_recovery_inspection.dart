import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'scheduled_message_draft.dart';
import 'scheduled_recovery_copy.dart';

enum ScheduledRecoveryIssue {
  invalidDocument,
  invalidRoom,
  invalidEntry,
  roomMismatch,
  duplicateIdentity,
  limitExceeded,
}

/// A source location in saved evidence, never an instruction to dispatch.
class ScheduledRecoveryEntry {
  final String roomId;
  final int index;
  final ScheduledMessageDraft? draft;
  final ScheduledRecoveryIssue? issue;

  const ScheduledRecoveryEntry({
    required this.roomId,
    required this.index,
    this.draft,
    this.issue,
  });
}

/// Best-effort inspection preserves failures alongside valid siblings. It does
/// not guess broken JSON, assign legacy ownership, repair payloads, or reset
/// delivery receipts/retry state. A parsed draft is not necessarily safe to send.
class ScheduledRecoveryInspection {
  static const maxEntries = 10000;
  final List<ScheduledRecoveryEntry> entries;
  final ScheduledRecoveryIssue? documentIssue;

  ScheduledRecoveryInspection._(
    List<ScheduledRecoveryEntry> entries,
    this.documentIssue,
  ) : entries = List.unmodifiable(entries);

  factory ScheduledRecoveryInspection.inspect(ScheduledRecoveryCopy copy) {
    final raw = copy.raw;
    // Validate the copy's digest again rather than trusting its mutable source
    // or an isIntact flag set by a caller. This does not authenticate an author.
    try {
      if (raw == null || !copy.isIntact) {
        return ScheduledRecoveryInspection._(
          [],
          ScheduledRecoveryIssue.invalidDocument,
        );
      }
      if (utf8.encode(raw).length > ScheduledRecoveryCopy.maxImportBytes) {
        return ScheduledRecoveryInspection._(
          [],
          ScheduledRecoveryIssue.limitExceeded,
        );
      }
      if (copy.id != sha256.convert(utf8.encode(raw)).toString()) {
        return ScheduledRecoveryInspection._(
          [],
          ScheduledRecoveryIssue.invalidDocument,
        );
      }
      final document = jsonDecode(raw);
      if (document is! Map<String, dynamic>) {
        return ScheduledRecoveryInspection._(
          [],
          ScheduledRecoveryIssue.invalidDocument,
        );
      }
      final entries = <ScheduledRecoveryEntry>[];
      final identities = <(String, String), List<int>>{};
      ScheduledRecoveryInspection finish(ScheduledRecoveryIssue? issue) {
        for (final positions in identities.values.where(
          (items) => items.length > 1,
        )) {
          for (final position in positions) {
            final entry = entries[position];
            entries[position] = ScheduledRecoveryEntry(
              roomId: entry.roomId,
              index: entry.index,
              issue: ScheduledRecoveryIssue.duplicateIdentity,
            );
          }
        }
        return ScheduledRecoveryInspection._(entries, issue);
      }

      for (final room in document.entries) {
        if (entries.length >= maxEntries) {
          return finish(ScheduledRecoveryIssue.limitExceeded);
        }
        if (room.key.trim().isEmpty || room.value is! List) {
          entries.add(
            ScheduledRecoveryEntry(
              roomId: room.key,
              index: -1,
              issue: ScheduledRecoveryIssue.invalidRoom,
            ),
          );
          continue;
        }
        final items = room.value as List;
        for (var i = 0; i < items.length; i++) {
          if (entries.length >= maxEntries) {
            return finish(ScheduledRecoveryIssue.limitExceeded);
          }
          ScheduledMessageDraft? draft;
          ScheduledRecoveryIssue? issue;
          final item = items[i];
          // Include malformed siblings' declared identities in duplicate
          // detection, so a valid-looking duplicate is not offered as unique.
          if (item is Map && item['messageId'] is String) {
            identities
                .putIfAbsent((room.key, item['messageId'] as String), () => [])
                .add(entries.length);
          }
          try {
            if (item is! Map<String, dynamic>) {
              throw const FormatException('Invalid entry');
            }
            draft = ScheduledMessageDraft.fromJson(item);
            if (draft.roomId != null && draft.roomId != room.key) {
              issue = ScheduledRecoveryIssue.roomMismatch;
              draft = null;
            } else {
              draft = draft.copyWith(roomId: room.key);
            }
          } catch (_) {
            issue = ScheduledRecoveryIssue.invalidEntry;
          }
          entries.add(
            ScheduledRecoveryEntry(
              roomId: room.key,
              index: i,
              draft: draft,
              issue: issue,
            ),
          );
        }
      }
      return finish(null);
    } catch (_) {
      return ScheduledRecoveryInspection._(
        [],
        ScheduledRecoveryIssue.invalidDocument,
      );
    }
  }
}
