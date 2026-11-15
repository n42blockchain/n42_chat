import 'dart:math' as math;

import 'package:matrix/matrix.dart' as matrix;

class AttachmentSizePolicy {
  static const conservativeLimit = 50 * 1024 * 1024;
  static const maximumLimit = 1024 * 1024 * 1024;
  static Future<int> effectiveLimit(
    matrix.Client? client, {
    required int configuredLimit,
  }) async {
    final local = configuredLimit > 0
        ? math.min(configuredLimit, maximumLimit)
        : conservativeLimit;
    try {
      final config = await client
          ?.getConfig(
            cacheLifetime: const Duration(minutes: 5),
            throwOnUpdateFailure: true,
          )
          .timeout(const Duration(seconds: 8));
      final remote = config?.mUploadSize;
      if (remote != null && remote > 0) return math.min(local, remote);
    } catch (_) {
      /* Do not infer unlimited capacity from an unavailable server. */
    }
    return math.min(local, conservativeLimit);
  }
}
