import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/attachment_size_policy.dart';

class _Client extends Mock implements Client {}

void main() {
  setUpAll(() => registerFallbackValue(Duration.zero));
  test('negotiates client/server minimum and never treats missing config as unlimited', () async {
    final client = _Client();
    when(
      () => client.getConfig(
        cacheLifetime: any(named: 'cacheLifetime'),
        throwOnUpdateFailure: true,
      ),
    ).thenAnswer((_) async => MediaConfig(mUploadSize: 100 * 1024 * 1024));
    expect(
      await AttachmentSizePolicy.effectiveLimit(
        client,
        configuredLimit: AttachmentSizePolicy.maximumLimit,
      ),
      100 * 1024 * 1024,
    );
    expect(
      await AttachmentSizePolicy.effectiveLimit(
        client,
        configuredLimit: 20 * 1024 * 1024,
      ),
      20 * 1024 * 1024,
    );
    expect(
      await AttachmentSizePolicy.effectiveLimit(
        null,
        configuredLimit: AttachmentSizePolicy.maximumLimit,
      ),
      AttachmentSizePolicy.conservativeLimit,
    );
  });
}
