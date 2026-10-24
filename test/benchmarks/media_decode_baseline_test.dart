import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final corpus = Platform.environment['N42_MEDIA_CORPUS'];
  test(
    'measure 200 manifested images through the Flutter image decoder',
    () async {
      final root = Directory(corpus!);
      final manifest = jsonDecode(
        File('${root.path}/manifest.json').readAsStringSync(),
      ) as List;
      expect(manifest.length, greaterThanOrEqualTo(200));
      final output = <Map<String, Object>>[];
      for (final item in manifest.cast<Map<String, dynamic>>()) {
        final bytes = File('${root.path}/${item['file']}').readAsBytesSync();
        expect(sha256.convert(bytes).toString(), item['sha256']);
        final watch = Stopwatch()..start();
        final before = ProcessInfo.currentRss;
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        expect(frame.image.width, item['width']);
        expect(frame.image.height, item['height']);
        watch.stop();
        output.add({
          'sample': item['file'] as String,
          'bytes': bytes.length,
          'firstFrameMicroseconds': watch.elapsedMicroseconds,
          'rssAfter': ProcessInfo.currentRss,
          'rssBefore': before,
          'outcome': 'succeeded',
        });
        frame.image.dispose();
        codec.dispose();
      }
      final times =
          output.map((r) => r['firstFrameMicroseconds'] as int).toList()
            ..sort();
      File('${root.path}/decode-results.json').writeAsStringSync(
        jsonEncode({
          'environment': 'Flutter host test / synthetic still images',
          'samples': output,
          'p95Microseconds': times[(times.length * .95).ceil() - 1],
          'limitations': 'RSS snapshots are not peak RSS; no video, HDR/P3 color accuracy, network or production failure-rate evidence.',
        }),
      );
    },
    skip: corpus == null
        ? 'Set N42_MEDIA_CORPUS to a generated corpus directory.'
        : false,
  );
}
