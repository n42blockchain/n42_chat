import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A local copy of a Matrix pusher binding confirmed by getPushers().
/// Background isolates use this to reject unowned or superseded push payloads.
class PushRecipientBindingStore {
  PushRecipientBindingStore({
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

  static const _prefix = 'n42_chat.push_recipient_binding.v1.';
  static const _ttl = Duration(days: 30);
  final FlutterSecureStorage _storage;
  final DateTime Function() _now;

  static String _key(String accountId) =>
      '$_prefix${sha256.convert(utf8.encode(accountId))}';

  static bool _validAccount(String accountId) =>
      accountId.startsWith('@') && accountId.contains(':');

  static bool _valid(String accountId, String bindingId) =>
      _validAccount(accountId) && bindingId.isNotEmpty;

  Future<bool> activate(String accountId, String bindingId) async {
    if (!_valid(accountId, bindingId)) return false;
    try {
      await _storage.write(
        key: _key(accountId),
        value: jsonEncode({
          'accountId': accountId,
          'bindingId': bindingId,
          'expiresAt': _now().add(_ttl).millisecondsSinceEpoch,
        }),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> activeBinding(String accountId) async {
    if (!_validAccount(accountId)) return null;
    try {
      final raw = await _storage.read(key: _key(accountId));
      if (raw == null) return null;
      final value = jsonDecode(raw);
      if (value is Map &&
          value['accountId'] == accountId &&
          value['bindingId'] is String &&
          (value['bindingId'] as String).isNotEmpty &&
          value['expiresAt'] is int &&
          (value['expiresAt'] as int) > _now().millisecondsSinceEpoch) {
        return value['bindingId'] as String;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> matches(String accountId, String bindingId) async =>
      _valid(accountId, bindingId) &&
      await activeBinding(accountId) == bindingId;

  Future<void> revoke(String accountId, String bindingId) async {
    if (await matches(accountId, bindingId)) {
      try {
        await _storage.delete(key: _key(accountId));
      } catch (_) {
        // A failed delete does not make an unmatched incoming binding valid.
      }
    }
  }

  Future<bool> revokeAccount(String accountId) async {
    if (accountId.isEmpty) return false;
    try {
      await _storage.delete(key: _key(accountId));
      return true;
    } catch (_) {
      return false;
    }
  }
}
