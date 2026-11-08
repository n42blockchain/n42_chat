import 'package:equatable/equatable.dart';

import 'sticker_pack_origin.dart';

/// A live room/state-key reference, distinct from a copied immutable snapshot.
class StickerPackSubscription extends Equatable {
  final String roomId;
  final String stateKey;

  const StickerPackSubscription({required this.roomId, this.stateKey = ''});

  bool get isValid =>
      StickerPackOrigin.validIdentifier(roomId, '!') && stateKey.length <= 4096;

  @override
  List<Object?> get props => [roomId, stateKey];
}
