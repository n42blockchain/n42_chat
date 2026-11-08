import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../domain/entities/sticker_pack_entity.dart';

/// Binds a publication receipt to the reviewed media, labels and attribution.
/// Local usage, installation state and resolved HTTP URLs are not content.
String stickerPackFingerprint(StickerPack pack) => sha256
    .convert(
      utf8.encode(
        jsonEncode({
          'id': pack.id,
          'name': pack.name,
          'description': pack.description,
          'author': pack.author,
          'avatar': pack.avatarUrl,
          'stickers': [
            for (final sticker in pack.stickers)
              {
                'id': sticker.id,
                'url': sticker.url,
                'name': sticker.name,
                'emoji': sticker.emoji,
                'width': sticker.width,
                'height': sticker.height,
                'mime': sticker.mimeType,
                'size': sticker.size,
              },
          ],
        }),
      ),
    )
    .toString();
