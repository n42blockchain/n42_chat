import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;

/// Synthetic, reproducible decode corpus. It does not replace camera HDR,
/// wide-gamut, animation, malformed-video and device codec acceptance.
void main(List<String> args) {
  if (args.length != 1) throw ArgumentError('Pass an output directory');
  final directory = Directory(args.single)..createSync(recursive: true);
  final manifest = <Map<String, Object>>[];
  for (var i = 0; i < 200; i++) {
    final width = [32, 64, 128, 256, 512][i % 5];
    final height = [24, 48, 96, 192, 384][(i ~/ 5) % 5];
    final format = i ~/ 40;
    final image = img.Image(
      width: width,
      height: height,
      numChannels: format == 1 ? 4 : 3,
    );
    for (final pixel in image) {
      pixel.setRgba(
        (pixel.x * 3 + i) % 256,
        (pixel.y * 7 + i) % 256,
        (pixel.x + pixel.y + i * 11) % 256,
        format == 1 ? (pixel.x * 13) % 256 : 255,
      );
    }
    late List<int> bytes;
    late String extension;
    switch (format) {
      case 0:
        bytes = img.encodePng(image);
        extension = 'png';
      case 1:
        bytes = img.encodePng(image);
        extension = 'png';
      case 2:
        bytes = img.encodeJpg(image, quality: 80 + i % 20);
        extension = 'jpg';
      case 3:
        bytes = img.encodeGif(image);
        extension = 'gif';
      default:
        bytes = img.encodeBmp(image);
        extension = 'bmp';
    }
    final name = 'sample_${i.toString().padLeft(3, '0')}.$extension';
    File('${directory.path}/$name').writeAsBytesSync(bytes);
    manifest.add({
      'file': name,
      'sha256': sha256.convert(bytes).toString(),
      'width': width,
      'height': height,
      'bytes': bytes.length,
      'encoding': extension,
      'colorSpace': 'synthetic RGB',
      'alpha': format == 1,
    });
  }
  File('${directory.path}/manifest.json')
      .writeAsStringSync(jsonEncode(manifest));
  stdout.writeln('Generated ${manifest.length} synthetic still-image samples.');
}
