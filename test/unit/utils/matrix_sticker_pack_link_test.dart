import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/matrix_sticker_pack_link.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_origin.dart';

void main() {
  test('Matrix room/event links preserve source and routing hints', () {
    final original = StickerPackOrigin(
      roomId: '!room:example.org',
      eventId: r'$event',
      viaServers: ['example.org'],
    );
    final parsed = parseMatrixStickerPackLink(original.shareUrl);
    expect(parsed, original);
    expect(
      parseMatrixStickerPackLink('https://matrix.to/#/!new_v12/\$event'),
      isNotNull,
    );
    expect(StickerPackOrigin.tryFromJson(original.toJson()), original);
  });
  test('reject arbitrary downloads and ambiguous Matrix references', () {
    for (final link in [
      'http://matrix.to/#/!room/\$event',
      'https://matrix.to.evil/#/!room/\$event',
      'https://user@matrix.to/#/!room/\$event',
      'https://matrix.to:444/#/!room/\$event',
      'https://matrix.to/#/!room',
      'https://matrix.to/#/!room/\$event/extra',
      'https://matrix.to/#/@user:example.org/\$event',
      'https://matrix.to/#/!room/\$event?via=https%3A%2F%2Fevil',
      'javascript:alert(1)',
      'mxc://server/manifest',
    ]) {
      expect(parseMatrixStickerPackLink(link), isNull, reason: link);
    }
  });
  test('media references never become arbitrary network requests', () {
    expect(isMatrixStickerMediaUrl('mxc://example.org/media'), isTrue);
    for (final value in [
      'https://example.org/media',
      'mxc://user@example.org/media',
      'mxc://example.org/a/b',
      'mxc://example.org/media?token=x',
      'mxc://example.org/%FF',
      'mxc://example.org/%2Fpath',
      'mxc://example.org/..',
    ]) {
      expect(isMatrixStickerMediaUrl(value), isFalse, reason: value);
    }
  });
}
