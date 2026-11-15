import 'dart:convert';

import 'package:matrix/matrix.dart' as matrix;
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/matrix_sticker_pack_link.dart';
import '../../domain/entities/sticker_pack_entity.dart';
import '../../domain/entities/sticker_pack_origin.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// Explicit publication only. Room state and media are not E2EE.
class MatrixStickerPublication {
  final MatrixClientManager manager;

  final IAccountBoundDeletionLifecycle lifecycle;

  MatrixStickerPublication(this.manager, this.lifecycle);

  Future<StickerPackOrigin> publish(StickerPack pack, String roomId) async {
    final generation = lifecycle.currentAccountGeneration;
    final client = manager.client;
    final user = client?.userID;
    final token = client?.accessToken;
    final device = client?.deviceID;
    final server = client?.homeserver;
    if (generation == null ||
        client == null ||
        user == null ||
        token == null ||
        token.isEmpty) {
      throw StateError('No authenticated account');
    }
    void check() {
      if (!generation.isCurrent ||
          !identical(lifecycle.currentAccountGeneration, generation) ||
          generation.userId != user ||
          generation.deviceId != device ||
          generation.homeserver != server ||
          !generation.matchesClient(client) ||
          !identical(manager.client, client) ||
          client.userID != user ||
          client.accessToken != token ||
          client.deviceID != device ||
          client.homeserver != server) {
        throw StateError('Account changed');
      }
    }

    check();
    if (!StickerPackOrigin.validIdentifier(roomId, '!') ||
        pack.source != StickerPackSource.custom ||
        pack.stickers.isEmpty ||
        pack.stickers.length > 500) {
      throw const FormatException('Invalid owned sticker pack');
    }
    final images = <String, dynamic>{};
    for (final sticker in pack.stickers) {
      // Local legacy IDs need not be valid Matrix shortcodes. Keep the local
      // record untouched and give its published copy a deterministic safe key.
      final shortcode = RegExp(r'^[A-Za-z0-9_-]{1,100}$').hasMatch(sticker.id)
          ? sticker.id
          : 'image_${sha256.convert(utf8.encode(sticker.id))}';
      if (sticker.id.isEmpty ||
          images.containsKey(shortcode) ||
          !isMatrixStickerMediaUrl(sticker.url) ||
          (sticker.mimeType != null &&
              !sticker.mimeType!.startsWith('image/'))) {
        throw const FormatException('Invalid sticker media');
      }
      images[shortcode] = {
        'url': sticker.url,
        'body': sticker.name ?? sticker.emoji ?? sticker.id,
        if (sticker.emoji != null) 'n42.emoji': sticker.emoji,
        'info': {
          if (sticker.mimeType != null) 'mimetype': sticker.mimeType,
          if (sticker.width != null) 'w': sticker.width,
          if (sticker.height != null) 'h': sticker.height,
          if (sticker.size != null) 'size': sticker.size,
        },
      };
    }
    if (pack.avatarUrl != null && !isMatrixStickerMediaUrl(pack.avatarUrl!)) {
      throw const FormatException('Invalid pack avatar');
    }
    final content = <String, dynamic>{
      'pack': {
        'display_name': pack.name,
        'usage': ['sticker'],
        if (pack.description != null) 'description': pack.description,
        if (pack.author != null) 'attribution': pack.author,
        if (pack.avatarUrl != null) 'avatar_url': pack.avatarUrl,
      },
      'images': images,
    };
    if (utf8.encode(jsonEncode(content)).length > 65536) {
      throw const FormatException('Pack too large');
    }
    final members = await client.getJoinedMembersByRoom(roomId);
    check();
    if (members == null || !members.containsKey(user)) {
      throw StateError('Joined membership required');
    }
    final power = await client.getRoomStateWithKey(
      roomId,
      matrix.EventTypes.RoomPowerLevels,
      '',
    );
    check();
    final room = client.getRoomById(roomId);
    final version = int.tryParse(room?.roomVersion ?? '');
    final creator =
        version != null && version >= 12 && room!.creatorUserIds.contains(user);
    final users = power['users'];
    final events = power['events'];
    final own = users is Map ? users[user] : null;
    final level = own is int ? own : (power['users_default'] as int? ?? 0);
    final event = events is Map ? events['m.room.image_pack'] : null;
    final required = event is int
        ? event
        : (power['state_default'] as int? ?? 50);
    if (!creator && level < required) {
      throw StateError('Room state permission required');
    }
    check();
    // A fresh key never overwrites another pack. An uncertain write is not retried.
    final key = 'n42_${const Uuid().v4()}';
    final eventId = await client.setRoomStateWithKey(
      roomId,
      'm.room.image_pack',
      key,
      content,
    );
    check();
    if (!StickerPackOrigin.validIdentifier(eventId, r'$')) {
      throw StateError('Invalid publication receipt');
    }
    return StickerPackOrigin(roomId: roomId, eventId: eventId, stateKey: key);
  }
}
