import 'dart:async';

import 'package:drift/drift.dart' show Value;

import '../../data/datasources/local/archive_database.dart';
import 'archive_account_access.dart';

/// Metadata-only preview. It deliberately does not expose old message bodies.
class LegacyArchivePreview {
  final ArchiveAccountLease _target;
  final ArchiveDatabase _source;
  final Map<String, int> roomMessageCounts;

  LegacyArchivePreview._(this._target, this._source, Map<String, int> rooms)
    : roomMessageCounts = Map.unmodifiable(rooms);

  String get targetUserId => _target.userId;

  bool get isCurrent {
    try {
      _target.ensureCurrent();
      return true;
    } on StateError {
      return false;
    }
  }
}

/// Copies selected unowned history only after explicit ownership confirmation.
/// Source history is never deleted, renamed, or automatically assigned.
class LegacyArchiveRecoveryService {
  final ArchiveAccountAccess _access;
  final Future<ArchiveDatabase> Function() _openLegacy;

  LegacyArchiveRecoveryService({
    required ArchiveAccountAccess access,
    Future<ArchiveDatabase> Function()? openLegacy,
  }) : _access = access,
       _openLegacy = openLegacy ?? ArchiveDatabase.getInstance;

  Future<LegacyArchivePreview> preview() async {
    final target = await _access.capture();
    final source = await _openLegacy();
    target.ensureCurrent();
    final counts = await source.transaction(() async {
      final rooms = await source.getArchivedRoomIds();
      final result = <String, int>{};
      for (final room in rooms) {
        target.ensureCurrent();
        result[room] = await source.getMessageCount(room);
      }
      return result;
    });
    target.ensureCurrent();
    return LegacyArchivePreview._(target, source, counts);
  }

  Future<int> recover(
    LegacyArchivePreview preview, {
    required Set<String> roomIds,
    required bool ownershipConfirmed,
    bool Function()? isCurrent,
    void Function(double)? onProgress,
  }) async {
    if (!ownershipConfirmed) {
      throw ArgumentError('Legacy archive ownership must be confirmed');
    }
    final selected = roomIds.toList()..sort();
    if (selected.isEmpty ||
        selected.any((room) => !preview.roomMessageCounts.containsKey(room))) {
      throw ArgumentError('Select rooms from the legacy archive preview');
    }
    final target = preview._target;
    final source = preview._source;
    void ensureCurrent() {
      if (isCurrent?.call() == false) {
        throw StateError('Legacy recovery confirmation changed');
      }
      target.ensureCurrent();
    }

    ensureCurrent();
    if (identical(source, target.database)) {
      throw StateError('Legacy recovery requires a separate account database');
    }
    return source.transaction(() async {
      // Drift resolves a transaction through its zone. Re-enter the source
      // zone for source reads while the target transaction is active.
      final sourceZone = Zone.current;
      // Establish a consistent source snapshot and reject changed preview counts.
      for (final room in selected) {
        if (await source.getMessageCount(room) !=
            preview.roomMessageCounts[room]) {
          throw StateError('Legacy archive changed; review a new preview');
        }
      }
      ensureCurrent();
      final copied = await target.database.transaction(() async {
        var inserted = 0;
        var processed = 0;
        final total = selected.fold<int>(
          0,
          (sum, room) => sum + preview.roomMessageCounts[room]!,
        );
        for (final room in selected) {
          int? timestamp;
          String? eventId;
          while (true) {
            ensureCurrent();
            final rows = await sourceZone.run(
              () => source.getMessages(
                room,
                beforeTimestamp: timestamp,
                beforeEventId: eventId,
                limit: 500,
              ),
            );
            ensureCurrent();
            if (rows.isEmpty) break;
            inserted += await target.database.insertMessages(
              rows.map((row) => row.toCompanion(true)).toList(),
            );
            processed += rows.length;
            onProgress?.call(total == 0 ? 1 : processed / total);
            ensureCurrent();
            timestamp = rows.last.originServerTs;
            eventId = rows.last.eventId;
          }
          final latest = (await target.database.getMessages(
            room,
            limit: 1,
          )).firstOrNull;
          await target.database.updateMetadata(
            ArchiveMetadataCompanion(
              roomId: Value(room),
              lastArchivedEventId: Value(latest?.eventId),
              lastArchivedTs: Value(latest?.originServerTs ?? 0),
              totalArchived: Value(await target.database.getMessageCount(room)),
              lastArchiveTime: Value(DateTime.now()),
            ),
          );
        }
        ensureCurrent();
        return inserted;
      });
      ensureCurrent();
      return copied;
    });
  }
}
