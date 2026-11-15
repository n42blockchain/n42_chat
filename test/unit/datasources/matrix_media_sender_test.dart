import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_media_sender.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_media_uploader.dart';

class _MockMatrixClientManager extends Mock implements MatrixClientManager {}

class _MockClient extends Mock implements matrix.Client {}

class _MockRoom extends Mock implements matrix.Room {}

class _MockMediaUploader extends Mock implements MatrixMediaUploader {}

void main() {
  late _MockMatrixClientManager clientManager;
  late _MockClient client;
  late _MockRoom room;
  late _MockMediaUploader uploader;
  late MatrixMediaSender sender;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(
      matrix.MatrixFile(bytes: Uint8List(0), name: 'fallback'),
    );
  });

  setUp(() {
    clientManager = _MockMatrixClientManager();
    client = _MockClient();
    room = _MockRoom();
    uploader = _MockMediaUploader();
    sender = MatrixMediaSender(clientManager, uploader);

    when(() => clientManager.client).thenReturn(client);
    when(() => client.isLogged()).thenReturn(true);
    when(() => client.getRoomById('!room:test')).thenReturn(room);
  });

  test(
    'rejects oversized encrypted attachments before reading or uploading',
    () async {
      when(() => room.encrypted).thenReturn(true);
      when(() => client.fileEncryptionEnabled).thenReturn(true);

      await expectLater(
        () => sender.sendFileMessage(
          '!room:test',
          filename: 'secret.bin',
          filePath: '/tmp/secret.bin',
          fileSize: 51 * 1024 * 1024,
        ),
        throwsStateError,
      );

      verifyNever(
        () => uploader.uploadFileAuthenticated(
          any(),
          contentLength: any(named: 'contentLength'),
          filename: any(named: 'filename'),
          contentType: any(named: 'contentType'),
        ),
      );
    },
  );
  for (final video in [false, true]) {
    for (final fail in [false, true]) {
      test(
        '${video ? "video" : "image"} encrypts after room encryption changes; failure=$fail',
        () async {
          // Model an encryption state arriving while prepareRoomForSending awaits.
          var reads = 0;
          when(() => room.encrypted).thenAnswer((_) => ++reads > 1);
          when(() => client.fileEncryptionEnabled).thenReturn(true);
          matrix.MatrixFile? sent;
          matrix.MatrixImageFile? thumbnail;
          when(
            () => room.sendFileEvent(
              any(),
              thumbnail: any(named: 'thumbnail'),
              extraContent: any(named: 'extraContent'),
            ),
          ).thenAnswer((invocation) async {
            sent = invocation.positionalArguments.first as matrix.MatrixFile;
            thumbnail =
                invocation.namedArguments[#thumbnail]
                    as matrix.MatrixImageFile?;
            if (fail) throw StateError('Encrypted upload failed');
            return r'$event';
          });
          final operation = video
              ? sender.sendVideoMessage(
                  '!room:test',
                  videoBytes: Uint8List.fromList([1, 2]),
                  filename: 'clip.mp4',
                  thumbnailBytes: Uint8List.fromList([3]),
                )
              : sender.sendImageMessage(
                  '!room:test',
                  imageBytes: Uint8List.fromList([1, 2]),
                  filename: 'photo.png',
                );
          if (fail) {
            await expectLater(operation, throwsStateError);
          } else {
            expect(await operation, r'$event');
          }
          expect(
            sent,
            video
                ? isA<matrix.MatrixVideoFile>()
                : isA<matrix.MatrixImageFile>(),
          );
          if (video) expect(thumbnail, isNotNull);
          verifyZeroInteractions(uploader);
          verifyNever(
            () => client.uploadContent(
              any(),
              filename: any(named: 'filename'),
              contentType: any(named: 'contentType'),
            ),
          );
        },
      );
    }
  }
  for (final kind in ['file', 'image', 'video']) {
    for (final changed in ['account', 'encryption']) {
      test(
        '$kind does not publish after $changed changes during upload',
        () async {
          when(() => room.encrypted).thenReturn(false);
          when(() => client.accessToken).thenReturn('first');
          Future<Uri> uploaded() async {
            if (changed == 'account') {
              when(() => client.accessToken).thenReturn('second');
            } else {
              when(() => room.encrypted).thenReturn(true);
            }
            return Uri.parse('mxc://fixture/file');
          }

          when(
            () => uploader.uploadFileAuthenticated(
              any(),
              contentLength: any(named: 'contentLength'),
              filename: any(named: 'filename'),
              contentType: any(named: 'contentType'),
            ),
          ).thenAnswer((_) => uploaded());
          when(
            () => uploader.uploadContentAuthenticated(
              any(),
              filename: any(named: 'filename'),
              contentType: any(named: 'contentType'),
            ),
          ).thenAnswer((_) => uploaded());
          when(
            () => client.uploadContent(
              any(),
              filename: any(named: 'filename'),
              contentType: any(named: 'contentType'),
            ),
          ).thenAnswer((_) => uploaded());
          final bytes = Uint8List.fromList([1, 2]);
          final operation = switch (kind) {
            'image' => sender.sendImageMessage(
              '!room:test',
              imageBytes: bytes,
              filename: 'photo.png',
            ),
            'video' => sender.sendVideoMessage(
              '!room:test',
              videoBytes: bytes,
              filename: 'clip.mp4',
            ),
            _ => sender.sendFileMessage(
              '!room:test',
              filePath: '/tmp/mock-source',
              fileSize: 2,
              filename: 'file.bin',
            ),
          };
          await expectLater(operation, throwsStateError);
          verifyNever(() => room.sendEvent(any()));
        },
      );
    }
  }
}
