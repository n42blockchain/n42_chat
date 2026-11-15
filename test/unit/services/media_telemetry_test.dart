import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/media_telemetry.dart';

void main() {
  tearDown(() => MediaTelemetry.onEvent = null);
  test(
    'successful void decryption is not classified as a null failure',
    () async {
      final events = <MediaStageEvent>[];
      MediaTelemetry.onEvent = events.add;
      await MediaTelemetry.trace<void>(
        MediaStage.decrypt,
        () async {},
        nullIsFailure: false,
      );
      expect(events.single.outcome, MediaOutcome.succeeded);
    },
  );
  test('terminal events are emitted once with bounded fields', () {
    final events = <MediaStageEvent>[];
    MediaTelemetry.onEvent = events.add;
    final measurement = MediaTelemetry.start(MediaStage.download);
    measurement.finish(MediaOutcome.succeeded, bytes: 42);
    measurement.finish(MediaOutcome.failed, bytes: 43);
    expect(events.length, 1);
    expect(events.single.bytes, 42);
    expect(
      events.single.toJson().keys,
      unorderedEquals([
        'operationId',
        'eventId',
        'stage',
        'outcome',
        'elapsedMicroseconds',
        'bytes',
      ]),
    );
  });
  test('nested stages share operation id but have unique event ids', () async {
    final events = <MediaStageEvent>[];
    MediaTelemetry.onEvent = events.add;
    await MediaTelemetry.trace(
      MediaStage.send,
      () =>
          MediaTelemetry.trace(MediaStage.upload, () async => 'ok', bytes: 99),
    );
    expect(events.length, 2);
    expect(events.map((e) => e.operationId).toSet().length, 1);
    expect(events.map((e) => e.eventId).toSet().length, 2);
  });
  test('failed and null operations are not recorded as success', () async {
    final events = <MediaStageEvent>[];
    MediaTelemetry.onEvent = events.add;
    await expectLater(
      MediaTelemetry.trace(
        MediaStage.upload,
        () async => throw StateError('private data'),
      ),
      throwsStateError,
    );
    await MediaTelemetry.trace(MediaStage.upload, () async => null);
    expect(events.map((e) => e.outcome), everyElement(MediaOutcome.failed));
    expect(
      events.map((e) => e.toJson().toString()).join(),
      isNot(contains('private data')),
    );
  });
  test('sink failure does not change the media outcome', () async {
    MediaTelemetry.onEvent = (_) => throw StateError('sink unavailable');
    expect(
      await MediaTelemetry.trace(MediaStage.upload, () async => 'ok'),
      'ok',
    );
  });
}
