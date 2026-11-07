import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/preference_write_utils.dart';

/// Local timeline visibility only; this does not redact server events or erase
/// archives. The caller must apply the returned boundary to every history path.
class ChatHistoryClearStore {
  final Future<SharedPreferences> Function() _preferences;
  static Future<void> _tail = Future<void>.value();
  // Shared across store instances in this isolate; emitted only after durable
  // acknowledgement. Consumers reread rather than trusting an event payload.
  static final _changes = StreamController<String>.broadcast();

  Stream<void> watch({required String ownerUserId, required String roomId}) {
    final key = _key(ownerUserId, roomId);
    return _changes.stream.where((changed) => changed == key).map<void>((_) {});
  }

  ChatHistoryClearStore({Future<SharedPreferences> Function()? preferences})
    : _preferences = preferences ?? SharedPreferences.getInstance;

  String _key(String ownerUserId, String roomId) {
    if (ownerUserId.isEmpty ||
        ownerUserId.trim() != ownerUserId ||
        roomId.isEmpty ||
        roomId.trim() != roomId) {
      throw ArgumentError('History owner and room are required');
    }
    final scope = jsonEncode([ownerUserId, roomId]);
    return 'n42_chat_history_clear_v1_${sha256.convert(utf8.encode(scope))}';
  }

  Future<T> _serialized<T>(Future<T> Function() operation) {
    final result = _tail.then((_) => operation());
    _tail = result.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return result;
  }

  DateTime? _decode(String? value) {
    if (value == null) return null;
    final record = jsonDecode(value);
    if (record is! Map<String, dynamic> ||
        record['version'] != 1 ||
        record['beforeMs'] is! int ||
        (record['beforeMs'] as int) < 0) {
      throw const FormatException('Invalid history clear boundary');
    }
    return DateTime.fromMillisecondsSinceEpoch(
      record['beforeMs'] as int,
      isUtc: true,
    );
  }

  Future<DateTime?> read({
    required String ownerUserId,
    required String roomId,
    required bool Function() isCurrent,
  }) => _serialized(() async {
    final key = _key(ownerUserId, roomId);
    if (!isCurrent()) throw StateError('History session changed');
    final preferences = await _preferences();
    await preferences.reload();
    if (!isCurrent()) throw StateError('History session changed');
    return _decode(preferences.getString(key));
  });

  /// Persist a monotonic boundary. Completion means the platform acknowledged
  /// the write, not that any server-side content was deleted.
  Future<DateTime> clearThrough({
    required String ownerUserId,
    required String roomId,
    required DateTime boundary,
    required bool Function() isCurrent,
  }) => _serialized(() async {
    final key = _key(ownerUserId, roomId);
    if (boundary.millisecondsSinceEpoch < 0) {
      throw ArgumentError('History boundary must be nonnegative');
    }
    if (!isCurrent()) throw StateError('History session changed');
    final preferences = await _preferences();
    await preferences.reload();
    if (!isCurrent()) throw StateError('History session changed');
    final previous = _decode(preferences.getString(key));
    final next = previous != null && previous.isAfter(boundary)
        ? previous
        : boundary.toUtc();
    await saveStringPreference(
      preferences,
      key,
      jsonEncode({'version': 1, 'beforeMs': next.millisecondsSinceEpoch}),
    );
    // A successful old-owner write remains in that owner's namespace. A stale
    // caller must not announce success or apply it to the newly selected room.
    if (!isCurrent()) throw StateError('History session changed');
    _changes.add(key);
    return next;
  });
}
