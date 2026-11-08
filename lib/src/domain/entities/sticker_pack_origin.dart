import 'package:equatable/equatable.dart';

/// Provenance of an immutable room image-pack snapshot, not room membership.
class StickerPackOrigin extends Equatable {
  final String roomId;
  final String eventId;
  final String stateKey;
  final String? roomName;
  final List<String> viaServers;

  StickerPackOrigin({
    required this.roomId,
    required this.eventId,
    this.stateKey = '',
    this.roomName,
    List<String> viaServers = const [],
  }) : viaServers = List<String>.unmodifiable(viaServers);

  String get shareUrl {
    final path =
        '${Uri.encodeComponent(roomId)}/${Uri.encodeComponent(eventId)}';
    final query = viaServers
        .map((server) => 'via=${Uri.encodeQueryComponent(server)}')
        .join('&');
    return 'https://matrix.to/#/$path${query.isEmpty ? '' : '?$query'}';
  }

  Map<String, dynamic> toJson() => {
    'room_id': roomId,
    'event_id': eventId,
    'state_key': stateKey,
    if (roomName != null) 'room_name': roomName,
    if (viaServers.isNotEmpty) 'via': viaServers,
  };

  static bool validIdentifier(Object? value, String sigil) =>
      value is String &&
      value.length > 1 &&
      value.length <= 255 &&
      value.startsWith(sigil) &&
      !RegExp(r'[\x00-\x20/\\?#]').hasMatch(value);

  static StickerPackOrigin? tryFromJson(Object? value) {
    if (value is! Map ||
        !validIdentifier(value['room_id'], '!') ||
        !validIdentifier(value['event_id'], r'$')) {
      return null;
    }
    final key = value['state_key'] ?? '';
    final via = value['via'] ?? const <String>[];
    if (key is! String ||
        key.length > 4096 ||
        via is! List ||
        via.length > 3 ||
        via.any(
          (server) =>
              server is! String ||
              server.isEmpty ||
              server.length > 255 ||
              RegExp(r'[\x00-\x20]').hasMatch(server),
        )) {
      return null;
    }
    return StickerPackOrigin(
      roomId: value['room_id'] as String,
      eventId: value['event_id'] as String,
      stateKey: key,
      roomName:
          value['room_name'] is String &&
              (value['room_name'] as String).length <= 512
          ? value['room_name'] as String
          : null,
      viaServers: List<String>.unmodifiable(via.cast<String>()),
    );
  }

  @override
  List<Object?> get props => [roomId, eventId, stateKey, roomName, viaServers];
}
