import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/src/core/utils/matrix_utils.dart';

void main() {
  final client = matrix.Client('matrix-utils-test', database: _FakeDatabase())
    ..homeserver = Uri.parse('https://matrix.example.org');

  group('MatrixUtils media URLs', () {
    test('preserves server ports and encodes media identifiers', () {
      expect(
        MatrixUtils.getMediaDownloadUrl(
          'mxc://media.example.org:8448/a%2Bb',
          client: client,
        ),
        'https://matrix.example.org/_matrix/client/v1/media/download/media.example.org%3A8448/a%2Bb',
      );
    });

    test('malformed MXC references cannot change media endpoint routing', () {
      for (final uri in [
        'mxc://user@media.example.org/id',
        'mxc://media.example.org/a/b',
        'mxc://media.example.org/id?token=x',
        'mxc://media.example.org/%2Fpath',
        'mxc://media.example.org/..',
      ]) {
        expect(MatrixUtils.getMediaDownloadUrl(uri, client: client), isNull);
      }
    });

    test('converts an avatar mxc URI to an authenticated thumbnail URL', () {
      expect(
        MatrixUtils.getAvatarUrl(
          'mxc://media.example.org/avatar-id',
          client: client,
          size: 96,
        ),
        'https://matrix.example.org/_matrix/client/v1/media/thumbnail/'
        'media.example.org/avatar-id?width=96&height=96&method=crop',
      );
    });

    test('does not expose authorization headers to another origin', () {
      client.accessToken = 'test-token';

      expect(
        MatrixUtils.buildAuthenticatedMediaHeaders(
          'https://cdn.example.org/avatar.png',
          client: client,
        ),
        isEmpty,
      );
      expect(
        MatrixUtils.buildAuthenticatedMediaHeaders(
          'https://matrix.example.org/_matrix/client/v1/media/download/'
          'media.example.org/avatar-id',
          client: client,
        ),
        {'Authorization': 'Bearer test-token'},
      );
    });
  });
}

class _FakeDatabase implements matrix.DatabaseApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
