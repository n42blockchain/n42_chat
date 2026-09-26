import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/notifications/push_recipient_binding_store.dart';

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
    PushRecipientBindingStore? bindingStore,
    DateTime Function()? now,
  }) : _storage =
           storage ??
           const FlutterSecureStorage(
             aOptions: AndroidOptions(),
             iOptions: IOSOptions(
               accessibility: KeychainAccessibility.first_unlock_this_device,
             ),
           ),
       _bindingStore = bindingStore ?? PushRecipientBindingStore(),
       _now = now ?? DateTime.now;

  static const _prefix = 'n42_chat.missed_call_callback.v2.';
  static const _ttl = Duration(hours: 24);
  static const _capacity = 64;
  final String? Function() currentAccountId;
  final FlutterSecureStorage _storage;
  final PushRecipientBindingStore _bindingStore;
  final DateTime Function() _now;
  Future<void> _queue = Future<void>.value();

  Future<T> _serialized<T>(Future<T> Function() action) {
    final result = _queue.then((_) => action());
    _queue = result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return result;
  }

  static String _key(String accountId, String callId) =>
      '$_prefix${sha256.convert(utf8.encode('$accountId\u0000$callId'))}';

  static bool _validRoute(MissedCallRoute route) =>
      route.callId.isNotEmpty &&
      route.roomId.isNotEmpty &&
      route.callerId.isNotEmpty;

  Future<bool> _write(
    MissedCallRoute route,
    String account, {
    String? bindingId,
  }) async {
    if (!_validRoute(route)) return false;
    try {
      await _storage.write(
        key: _key(account, route.callId),
        value: jsonEncode({
          'accountId': account,
          'callId': route.callId,
          'roomId': route.roomId,
          'callerId': route.callerId,
          'isVideo': route.isVideo,
          if (bindingId != null) 'bindingId': bindingId,
          'expiresAt': _now().add(_ttl).millisecondsSinceEpoch,
        }),
      );
      // Distinct keys prevent an isolate from overwriting another call record.
      await _prune(account);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _prune(String account) async {
    final all = await _storage.readAll();
    final live = <(String, int, int)>[];
    final now = _now().millisecondsSinceEpoch;
    for (final entry in all.entries) {
      if (!entry.key.startsWith(_prefix)) continue;
      Object? parsed;
      try {
        parsed = jsonDecode(entry.value);
      } catch (_) {
        continue;
      }
      if (parsed is! Map || parsed['accountId'] != account) continue;
      final expiresAt = parsed['expiresAt'];
      if (expiresAt is! int || expiresAt <= now) {
        await _storage.delete(key: entry.key);
      } else {
        live.add((entry.key, expiresAt, live.length));
      }
    }
    if (live.length <= _capacity) return;
    live.sort((a, b) {
      final expiryOrder = a.$2.compareTo(b.$2);
      return expiryOrder != 0 ? expiryOrder : a.$3.compareTo(b.$3);
    });
    for (final entry in live.take(live.length - _capacity)) {
      await _storage.delete(key: entry.$1);
    }
  }

  Future<bool> remember(MissedCallRoute route) {
    final account = currentAccountId();
    return _serialized(() async {
      if (account == null || account != currentAccountId()) return false;
      final written = await _write(route, account);
      return written && account == currentAccountId();
    });
  }

  /// Store a background route only for a locally verified pusher generation.
  Future<bool> rememberBound(
    MissedCallRoute route, {
    required String accountId,
    required String bindingId,
  }) async {
    if (!await _bindingStore.matches(accountId, bindingId)) return false;
    if (!await _write(route, accountId, bindingId: bindingId)) return false;
    return _bindingStore.matches(accountId, bindingId);
  }

  Future<MissedCallRoute?> consume(String callId) {
    final account = currentAccountId();
    return _serialized(() async {
      if (account == null || account != currentAccountId()) return null;
      final key = _key(account, callId);
      try {
        final raw = await _storage.read(key: key);
        if (raw == null || account != currentAccountId()) return null;
        final entry = jsonDecode(raw);
        if (entry is! Map ||
            entry['accountId'] != account ||
            entry['callId'] != callId ||
            entry['roomId'] is! String ||
            (entry['roomId'] as String).isEmpty ||
            entry['callerId'] is! String ||
            (entry['callerId'] as String).isEmpty ||
            entry['isVideo'] is! bool ||
            entry['expiresAt'] is! int ||
            (entry['expiresAt'] as int) <= _now().millisecondsSinceEpoch) {
          return null;
        }
        final bindingId = entry['bindingId'];
        if (bindingId != null &&
            (bindingId is! String ||
                !await _bindingStore.matches(account, bindingId))) {
          return null;
        }
        // Persist consumption before dispatch; storage errors must never dial.
        await _storage.delete(key: key);
        if (account != currentAccountId()) return null;
        if (bindingId is String &&
            !await _bindingStore.matches(account, bindingId)) {
          return null;
        }
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
        await _storage.delete(key: _key(account, callId));
      } catch (_) {
        // A later consume still validates account, binding and expiry.
      }
    });
  }
}
