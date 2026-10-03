import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/pages/chat/picked_file_upload_source.dart';

void main() {
  test(
    'keeps picked file uploads streamed with their exact reported size',
    () async {
      final bytes = Uint8List.fromList([0, 1, 127, 255]);
      final file = _TestPlatformFile(bytes, bytes.length);

      final source = await PickedFileUploadSource.from(file);

      expect(source.filename, 'picked.bin');
      expect(source.filePath, '/tmp/picked.bin');
      expect(source.fileSize, 4);
      expect(await source.fileStream.expand((chunk) => chunk).toList(), bytes);
    },
  );

  test('rejects picked files whose size cannot be determined', () async {
    final file = _TestPlatformFile(Uint8List.fromList([1]), null);

    await expectLater(
      PickedFileUploadSource.from(file),
      throwsA(isA<StateError>()),
    );
    expect(file.streamReads, 0);
  });
}

base class _TestPlatformFile extends PlatformFile {
  _TestPlatformFile(this.bytes, int? length) : _length = length;

  final Uint8List bytes;
  final int? _length;
  int streamReads = 0;

  @override
  String get name => 'picked.bin';

  @override
  Uri get uri => Uri.file('/tmp/picked.bin');

  @override
  int? lengthSync() => _length;

  @override
  Future<int?> length() async => _length;

  @override
  Future<Uint8List> readAsBytes() async => bytes;

  @override
  Stream<Uint8List> readAsByteStream() {
    streamReads++;
    return Stream.value(bytes);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
