import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Local cleanup only. Presence means the Matrix server already confirmed
/// deactivation; it carries no credentials and never authorizes a new request.
class MatrixPendingDeletionEntry {
  const MatrixPendingDeletionEntry({
    required this.userId,
    required this.homeserver,
    required this.deviceId,
  });

  final String userId;
  final Uri homeserver;
  final String deviceId;
  int get version => 1;
}

class MatrixPendingDeletionStore {
  static const key = 'n42_chat_pending_deletion_cleanup_v1';
  static Future<void> _writeTail = Future<void>.value();

  Future<void> _withWrite(Future<void> Function() action) {
    final previous = _writeTail;
    final done = Completer<void>();
    _writeTail = done.future;
    return () async {
      await previous;
      try {
        await action();
      } finally {
        done.complete();
      }
    }();
  }

  Future<List<MatrixPendingDeletionEntry>> list() async {
    final raw = (await SharedPreferences.getInstance()).getString(key);
    if (raw == null) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is! Map ||
        decoded['version'] != 1 ||
        decoded['entries'] is! List) {
      throw const FormatException('Invalid pending Matrix deletion journal');
    }
    return (decoded['entries'] as List)
        .map((entry) {
          if (entry is! Map ||
              entry['userId'] is! String ||
              entry['homeserver'] is! String ||
              entry['deviceId'] is! String) {
            throw const FormatException(
              'Invalid pending Matrix deletion entry',
            );
          }
          final userId = entry['userId'] as String;
          final homeserver = Uri.tryParse(entry['homeserver'] as String);
          final deviceId = entry['deviceId'] as String;
          if (userId.isEmpty ||
              homeserver == null ||
              homeserver.host.isEmpty ||
              deviceId.isEmpty) {
            throw const FormatException(
              'Invalid pending Matrix deletion identity',
            );
          }
          return MatrixPendingDeletionEntry(
            userId: userId,
            homeserver: homeserver,
            deviceId: deviceId,
          );
        })
        .toList(growable: false);
  }

  Future<void> markPending({
    required String userId,
    required Uri homeserver,
    required String deviceId,
  }) => _withWrite(() async {
    if (userId.isEmpty || homeserver.host.isEmpty || deviceId.isEmpty) {
      throw ArgumentError('Invalid pending Matrix deletion identity');
    }
    final entries = await list();
    if (entries.any(
      (entry) =>
          entry.userId == userId &&
          entry.homeserver == homeserver &&
          entry.deviceId == deviceId,
    )) {
      return;
    }
    await _save([
      ...entries,
      MatrixPendingDeletionEntry(
        userId: userId,
        homeserver: homeserver,
        deviceId: deviceId,
      ),
    ]);
  });

  Future<void> complete({
    required String userId,
    required Uri homeserver,
    required String deviceId,
  }) => _withWrite(() async {
    final entries = await list();
    await _save(
      entries
          .where(
            (entry) =>
                entry.userId != userId ||
                entry.homeserver != homeserver ||
                entry.deviceId != deviceId,
          )
          .toList(),
    );
  });

  Future<void> _save(List<MatrixPendingDeletionEntry> entries) async {
    final saved = await (await SharedPreferences.getInstance()).setString(
      key,
      jsonEncode({
        'version': 1,
        'entries': [
          for (final entry in entries)
            {
              'userId': entry.userId,
              'homeserver': entry.homeserver.toString(),
              'deviceId': entry.deviceId,
            },
        ],
      }),
    );
    if (!saved) throw StateError('Unable to save pending Matrix cleanup');
  }
}
