import 'dart:math';
import 'dart:async';

/// No URLs, names, room/user IDs, message content, tokens or error text.
enum MediaStage { send, upload, download, decrypt, preview }

enum MediaOutcome { succeeded, failed, cancelled }

class MediaStageEvent {
  final String operationId;
  final String eventId;
  final MediaStage stage;
  final MediaOutcome outcome;
  final int elapsedMicroseconds;
  final int bytes;
  const MediaStageEvent({
    required this.operationId,
    required this.eventId,
    required this.stage,
    required this.outcome,
    required this.elapsedMicroseconds,
    required this.bytes,
  });

  Map<String, Object> toJson() => {
    'operationId': operationId,
    'eventId': eventId,
    'stage': stage.name,
    'outcome': outcome.name,
    'elapsedMicroseconds': elapsedMicroseconds,
    'bytes': bytes,
  };
}

/// Host opt-in sink. Delivery failures never change media results.
class MediaTelemetry {
  static void Function(MediaStageEvent)? onEvent;
  static MediaMeasurement start(MediaStage stage, {String? operationId}) =>
      MediaMeasurement._(
        stage,
        operationId ??
            Zone.current[#n42MediaOperation] as String? ??
            newOperationId(),
      );
  static Future<T> trace<T>(
    MediaStage stage,
    Future<T> Function() action, {
    int bytes = 0,
    bool nullIsFailure = true,
  }) {
    final measurement = start(stage);
    return runZoned(() async {
      try {
        final result = await action();
        measurement.finish(
          result == null && nullIsFailure
              ? MediaOutcome.failed
              : MediaOutcome.succeeded,
          bytes: bytes,
        );
        return result;
      } catch (_) {
        measurement.finish(MediaOutcome.failed, bytes: bytes);
        rethrow;
      }
    }, zoneValues: {#n42MediaOperation: measurement.operationId});
  }

  static String newOperationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }
}

class MediaMeasurement {
  final MediaStage stage;
  final String operationId;
  final Stopwatch _watch = Stopwatch()..start();
  bool _finished = false;
  MediaMeasurement._(this.stage, this.operationId);
  void finish(MediaOutcome outcome, {int bytes = 0}) {
    if (_finished) return;
    _finished = true;
    _watch.stop();
    try {
      MediaTelemetry.onEvent?.call(
        MediaStageEvent(
          operationId: operationId,
          eventId: MediaTelemetry.newOperationId(),
          stage: stage,
          outcome: outcome,
          elapsedMicroseconds: _watch.elapsedMicroseconds,
          bytes: bytes < 0 ? 0 : bytes,
        ),
      );
    } catch (_) {
      /* Observability must never break an attachment operation. */
    }
  }
}
