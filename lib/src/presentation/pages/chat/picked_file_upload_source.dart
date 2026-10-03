import 'package:file_picker/file_picker.dart';

/// File input for sending a selected attachment without eagerly buffering it.
class PickedFileUploadSource {
  const PickedFileUploadSource({
    required this.filename,
    required this.filePath,
    required this.fileSize,
    required this.fileStream,
  });

  final String filename;
  final String? filePath;
  final int fileSize;
  final Stream<List<int>> fileStream;

  static Future<PickedFileUploadSource> from(PlatformFile file) async {
    final fileSize = await file.length();
    if (fileSize == null) {
      throw StateError('Unable to determine the selected file size');
    }

    return PickedFileUploadSource(
      filename: file.name,
      filePath: file.path,
      fileSize: fileSize,
      fileStream: file.readAsByteStream(),
    );
  }
}
