import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/sticker_pack_subscription.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// Explicit standard live references. Never joins rooms or copies private packs.
/// https://spec.matrix.org/v1.19/client-server-api/#user-image-packs
class MatrixStickerSubscriptions {
  static const accountDataType = 'm.image_pack.rooms';
  final MatrixClientManager manager;
  final IAccountBoundDeletionLifecycle lifecycle;
  final _writeTails = HashMap<AuthSessionInvalidation, Future<void>>.identity();

  MatrixStickerSubscriptions(this.manager, this.lifecycle);

  (matrix.Client, void Function(), AuthSessionInvalidation) _session() {
    final client = manager.client;
    final generation = lifecycle.currentAccountGeneration;
    final token = client?.accessToken;
    if (client == null ||
        generation == null ||
        token == null ||
        token.isEmpty) {
      throw StateError('No active account');
    }
    final user = client.userID, device = client.deviceID;
    final server = client.homeserver;
    void check() {
      if (!generation.isCurrent ||
          !identical(lifecycle.currentAccountGeneration, generation) ||
          !generation.matchesClient(client) ||
          !identical(manager.client, client) ||
          user == null ||
          client.userID != user ||
          generation.userId != user ||
          client.deviceID != device ||
          generation.deviceId != device ||
          client.homeserver != server ||
          generation.homeserver != server ||
          client.accessToken != token) {
        throw StateError('Account changed');
      }
    }

    check();
    return (client, check, generation);
  }

  Future<Map<String, dynamic>> _read(matrix.Client client) async {
    try {
      final data = await client.getAccountData(client.userID!, accountDataType);
      if (utf8.encode(jsonEncode(data)).length > 1048576) {
        throw const FormatException('Subscription data too large');
      }
      return data;
    } on matrix.MatrixException catch (error) {
      if (error.errcode == 'M_NOT_FOUND') return {};
      rethrow;
    }
  }

  Future<List<StickerPackSubscription>> getEnabled() async {
    final (client, check, _) = _session();
    final data = await _read(client);
    check();
    final rooms = data['rooms'];
    if (rooms == null) return [];
    if (rooms is! Map) {
      throw const FormatException('Invalid subscription rooms');
    }
    final result = <StickerPackSubscription>[];
    for (final room in rooms.entries) {
      if (room.key is! String || room.value is! Map) continue;
      for (final key in (room.value as Map).keys) {
        if (key is! String || (room.value as Map)[key] is! Map) continue;
        final reference = StickerPackSubscription(
          roomId: room.key as String,
          stateKey: key,
        );
        if (reference.isValid) result.add(reference);
        if (result.length > 512) {
          throw const FormatException('Too many subscriptions');
        }
      }
    }
    return List.unmodifiable(result);
  }

  Future<void> setEnabled(
    StickerPackSubscription reference, {
    required bool enabled,
  }) async {
    if (!reference.isValid) {
      throw const FormatException('Invalid subscription reference');
    }
    // Capture the account before queueing. Waiting work must not adopt a login.
    final (client, check, generation) = _session();
    final previous = _writeTails[generation] ?? Future<void>.value();
    final release = Completer<void>();
    _writeTails[generation] = release.future;
    try {
      await previous;
      check();
      final data = await _read(client);
      check();
      final rawRooms = data['rooms'];
      if (rawRooms != null && rawRooms is! Map<String, dynamic>) {
        throw const FormatException('Invalid subscription rooms');
      }
      final rooms = Map<String, dynamic>.from(rawRooms as Map? ?? {});
      final rawKeys = rooms[reference.roomId];
      if (rawKeys != null && rawKeys is! Map<String, dynamic>) {
        throw const FormatException('Invalid subscribed room');
      }
      final keys = Map<String, dynamic>.from(rawKeys as Map? ?? {});
      final exists = keys.containsKey(reference.stateKey);
      if ((enabled && keys[reference.stateKey] is Map) ||
          (!enabled && !exists)) {
        return;
      }
      if (enabled) {
        // Verify current readability through the homeserver; never auto-join.
        final content = await client.getRoomStateWithKey(
          reference.roomId,
          'm.room.image_pack',
          reference.stateKey,
        );
        check();
        final images = content['images'];
        if (images is! Map ||
            images.isEmpty ||
            images.length > 500 ||
            utf8.encode(jsonEncode(content)).length > 65536) {
          throw const FormatException('Invalid room image pack');
        }
        keys[reference.stateKey] = <String, dynamic>{};
      } else {
        // Unreadable/left rooms must still be removable without a room read.
        keys.remove(reference.stateKey);
      }
      if (keys.isEmpty) {
        rooms.remove(reference.roomId);
      } else {
        rooms[reference.roomId] = keys;
      }
      if (enabled &&
          rooms.values.fold<int>(
                0,
                (sum, value) => sum + (value is Map ? value.length : 0),
              ) >
              512) {
        throw const FormatException('Too many subscriptions');
      }
      final updated = <String, dynamic>{...data, 'rooms': rooms};
      if (utf8.encode(jsonEncode(updated)).length > 1048576) {
        throw const FormatException('Subscription data too large');
      }
      check();
      await client.setAccountData(client.userID!, accountDataType, updated);
      check();
    } finally {
      release.complete();
      if (identical(_writeTails[generation], release.future)) {
        unawaited(_writeTails.remove(generation));
      }
    }
  }
}
