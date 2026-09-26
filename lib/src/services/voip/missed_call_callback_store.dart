import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal, account-bound routing for CallKit 3's id-only callbacks.
class MissedCallRoute {
  const MissedCallRoute({
    required this.callId,
    required this.roomId,
    required this.callerId,
    required this.isVideo,
  });
  final String callId;
  final String roomId;
  final String callerId;
  final bool isVideo;
}

class MissedCallCallbackStore {
  MissedCallCallbackStore({
    required this.currentAccountId,
    FlutterSecureStorage? storage,
    DateTime Function()? now,
  }) : _storage =
           storage ??
           const FlutterSecureStorage(
             aOptions: AndroidOptions(),
             iOptions: IOSOptions(
               accessibility: KeychainAccessibility.first_unlock_this_device,
             ),
           ),
       _now = now ?? DateTime.now;

  static const _key = 'n42_chat_missed_call_callbacks_v1';
  static const _ttl = Duration(hours: 24);
  final String? Function() currentAccountId;
  final FlutterSecureStorage _storage;
  final DateTime Function() _now;
  Future<void> _queue = Future<void>.value();

  Future<T> _serialized<T>(Future<T> Function() action) {
    final result = _queue.then((_) => action());
    _queue = result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return result;
  }

  Future<List<Map<String, dynamic>>> _read() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List;
    final now = _now().millisecondsSinceEpoch;
    return decoded
        .map((e) => Map<String, dynamic>.from(e as Map))
        .where(
          (e) =>
              e['expiresAt'] is int &&
              (e['expiresAt'] as int) > now &&
              e['accountId'] is String &&
              e['callId'] is String &&
              e['roomId'] is String &&
              e['callerId'] is String &&
              e['isVideo'] is bool,
        )
        .toList();
  }

  Future<void> _write(List<Map<String, dynamic>> entries) =>
      _storage.write(key: _key, value: jsonEncode(entries));

  Future<bool> remember(MissedCallRoute route) {
    final account = currentAccountId();
    return _serialized(() async {
      if (account == null ||
          account != currentAccountId() ||
          route.callId.isEmpty ||
          route.roomId.isEmpty ||
          route.callerId.isEmpty)
        return false;
      try {
        final entries = await _read();
        if (account != currentAccountId()) return false;
        entries.removeWhere((e) => e['callId'] == route.callId);
        entries.add({
          'accountId': account,
          'callId': route.callId,
          'roomId': route.roomId,
          'callerId': route.callerId,
          'isVideo': route.isVideo,
          'expiresAt': _now().add(_ttl).millisecondsSinceEpoch,
        });
        if (entries.length > 64) entries.removeRange(0, entries.length - 64);
        await _write(entries);
        return account == currentAccountId();
      } catch (_) {
        return false;
      }
    });
  }

  Future<MissedCallRoute?> consume(String callId) {
    final account = currentAccountId();
    return _serialized(() async {
      if (account == null || account != currentAccountId()) return null;
      try {
        final entries = await _read();
        if (account != currentAccountId()) return null;
        final matches = entries.where(
          (e) => e['callId'] == callId && e['accountId'] == account,
        );
        final entry = matches.firstOrNull;
        entries.removeWhere(
          (e) => e['callId'] == callId && e['accountId'] == account,
        );
        // Persist consumption before dispatch; storage errors must never dial.
        await _write(entries);
        if (entry == null || account != currentAccountId()) return null;
        return MissedCallRoute(
          callId: callId,
          roomId: entry['roomId'] as String,
          callerId: entry['callerId'] as String,
          isVideo: entry['isVideo'] as bool,
        );
      } catch (_) {
        return null;
      }
    });
  }

  Future<void> remove(String callId) {
    final account = currentAccountId();
    return _serialized(() async {
      if (account == null || account != currentAccountId()) return;
      try {
        final entries = await _read();
        if (account != currentAccountId()) return;
        entries.removeWhere(
          (e) => e['callId'] == callId && e['accountId'] == account,
        );
        await _write(entries);
      } catch (_) {
        /* A later consume still validates account and expiry. */
      }
    });
  }
}
