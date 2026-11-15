import 'package:matrix/matrix.dart';

import '../../domain/entities/sticker_pack_origin.dart';

/// Only a Matrix room/event reference is accepted. Never fetch the input URL.
StickerPackOrigin? parseMatrixStickerPackLink(String input) {
  if (input.length > 4096) return null;
  try {
    final uri = Uri.parse(input.trim());
    if (uri.scheme != 'https' ||
        uri.host != 'matrix.to' ||
        uri.userInfo.isNotEmpty ||
        (uri.hasPort && uri.port != 443) ||
        (uri.path.isNotEmpty && uri.path != '/') ||
        uri.query.isNotEmpty ||
        !uri.fragment.startsWith('/')) {
      return null;
    }
    final location = Uri.parse(uri.fragment);
    final ids = location.pathSegments;
    if (location.hasFragment ||
        ids.length != 2 ||
        !StickerPackOrigin.validIdentifier(ids[0], '!') ||
        !StickerPackOrigin.validIdentifier(ids[1], r'$') ||
        location.queryParametersAll.keys.any((key) => key != 'via')) {
      return null;
    }
    final via = location.queryParametersAll['via'] ?? const <String>[];
    if (via.length > 3 ||
        via.any(
          (server) =>
              !('@n42:$server').isValidMatrixIdStrict(strictDomainCheck: true),
        )) {
      return null;
    }
    return StickerPackOrigin(
      roomId: ids[0],
      eventId: ids[1],
      viaServers: List<String>.unmodifiable(via.toSet()),
    );
  } on FormatException {
    return null;
  }
}

bool isMatrixStickerMediaUrl(String value) {
  try {
    final uri = Uri.tryParse(value);
    if (uri == null ||
        uri.scheme != 'mxc' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment ||
        (uri.hasPort && (uri.port < 1 || uri.port > 65535))) {
      return false;
    }
    final segments = uri.pathSegments;
    return segments.length == 1 &&
        segments.single.isNotEmpty &&
        segments.single != '.' &&
        segments.single != '..' &&
        !RegExp(r'[\x00-\x20/\\]').hasMatch(segments.single);
  } on FormatException {
    return false;
  }
}
