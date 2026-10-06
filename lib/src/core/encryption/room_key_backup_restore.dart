import 'package:matrix/matrix.dart';

class RoomKeyRestoreFailure {
  const RoomKeyRestoreFailure({required this.roomId, required this.sessionId});

  final String roomId;
  final String sessionId;
}

class RoomKeyRestoreReport {
  const RoomKeyRestoreReport({
    required this.totalSessions,
    required this.restoredSessions,
    required this.failures,
  });

  final int totalSessions;
  final int restoredSessions;
  final List<RoomKeyRestoreFailure> failures;

  bool get isComplete => failures.isEmpty;
}

/// Restore and verify the downloaded sessions. The SDK may silently skip
/// locked, mismatched or undecryptable backups, so a completed HTTP request is
/// not by itself evidence that historical messages can be decrypted.
Future<int> restoreRoomKeyBackup(Client client) async {
  final report = await restoreRoomKeyBackupWithReport(client);
  if (!report.isComplete) {
    throw StateError(
      'Restored ${report.restoredSessions} of ${report.totalSessions} room keys',
    );
  }
  return report.restoredSessions;
}

/// Restore every usable key and report failures without hiding partial success.
Future<RoomKeyRestoreReport> restoreRoomKeyBackupWithReport(
  Client client,
) async {
  final keys = client.encryption?.keyManager;
  if (keys == null || !await keys.isCached()) {
    throw StateError('Unlock the room-key backup before restoring messages');
  }
  final info = await keys.getRoomKeysBackupInfo(false);
  final backup = await client.getRoomKeys(info.version);
  await keys.loadFromResponse(backup);
  var restored = 0;
  final failures = <RoomKeyRestoreFailure>[];
  final total = backup.rooms.values.fold<int>(
    0,
    (count, room) => count + room.sessions.length,
  );
  for (final room in backup.rooms.entries) {
    for (final sessionId in room.value.sessions.keys) {
      try {
        final session = await keys.loadInboundGroupSession(room.key, sessionId);
        if (session?.isValid != true) {
          failures.add(
            RoomKeyRestoreFailure(roomId: room.key, sessionId: sessionId),
          );
          continue;
        }
        restored++;
        // Importing an already-known session may not emit the SDK notification.
        // Retry undecryptable events in open timelines even in that case.
        final updates = client.getRoomById(room.key)?.onSessionKeyReceived;
        if (updates != null && !updates.isClosed) updates.add(sessionId);
      } catch (_) {
        failures.add(
          RoomKeyRestoreFailure(roomId: room.key, sessionId: sessionId),
        );
      }
    }
  }
  return RoomKeyRestoreReport(
    totalSessions: total,
    restoredSessions: restored,
    failures: List.unmodifiable(failures),
  );
}
