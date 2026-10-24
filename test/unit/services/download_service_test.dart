import 'dart:convert';

import 'package:cryptography/cryptography.dart' as crypto;
import 'package:crypto/crypto.dart' as digest;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/download_service.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('download_service_test');
  });

  tearDown(() async {
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('forwards custom headers to protected downloads', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));

    server.listen((request) async {
      expect(request.headers.value('Authorization'), 'Bearer test-token');
      request.response.statusCode = HttpStatus.ok;
      request.response.contentLength = 4;
      request.response.add(const [1, 2, 3, 4]);
      await request.response.close();
    });

    final service = DownloadService();
    final savePath = '${tempDir.path}/protected.bin';
    final taskId = await service.download(
      url: 'http://${server.address.host}:${server.port}/protected.bin',
      savePath: savePath,
      fileName: 'protected.bin',
      headers: const {'Authorization': 'Bearer test-token'},
    );

    final completedTask = await service.waitForTaskCompletion(taskId);

    expect(completedTask.status, DownloadStatus.completed);
    expect(File(savePath).readAsBytesSync(), const [1, 2, 3, 4]);
  });
  for (final corrupt in [false, true]) {
    test(
      'streams and validates encrypted downloads; corrupt=$corrupt',
      () async {
        final key = List<int>.generate(32, (i) => i);
        final iv = List<int>.filled(16, 0);
        final plain = List<int>.generate(150000, (i) => i % 251);
        final box = await crypto.AesCtr.with256bits(
          macAlgorithm: crypto.MacAlgorithm.empty,
        ).encrypt(plain, secretKey: crypto.SecretKey(key), nonce: iv);
        final hash = base64.encode(digest.sha256.convert(box.cipherText).bytes);
        final bytes = List<int>.of(box.cipherText);
        if (corrupt) bytes[100] ^= 1;
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));
        server.listen((request) async {
          request.response.contentLength = bytes.length;
          request.response.add(bytes);
          await request.response.close();
        });
        final service = DownloadService();
        final savePath = '${tempDir.path}/decrypted.bin';
        final id = await service.download(
          url: 'http://${server.address.host}:${server.port}/file',
          savePath: savePath,
          encryptKey: base64Url.encode(key),
          encryptIv: base64.encode(iv),
          encryptSha256: hash,
        );
        final task = await service.waitForTaskCompletion(id);
        expect(
          task.status,
          corrupt ? DownloadStatus.failed : DownloadStatus.completed,
        );
        if (corrupt) {
          expect(File(savePath).existsSync(), isFalse);
        } else {
          expect(await File(savePath).readAsBytes(), plain);
          expect(tempDir.listSync().length, 1);
        }
      },
    );
  }

  test('rejects incomplete metadata before any request and never follows redirects', () async {
    var requests = 0;
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      requests++;
      request.response.statusCode = 302;
      request.response.headers.set('location', '/target');
      await request.response.close();
    });
    final service = DownloadService();
    final url = 'http://${server.address.host}:${server.port}/file';
    final savePath = '${tempDir.path}/file';
    final incomplete = await service.download(
      url: url,
      savePath: savePath,
      encryptKey: 'incomplete',
    );
    expect(
      (await service.waitForTaskCompletion(incomplete)).status,
      DownloadStatus.failed,
    );
    expect(requests, 0);
    final redirect = await service.download(
      url: url,
      savePath: savePath,
      headers: {'Authorization': 'Bearer fixture'},
    );
    expect(
      (await service.waitForTaskCompletion(redirect)).status,
      DownloadStatus.failed,
    );
    expect(requests, 1);
    expect(File(savePath).existsSync(), isFalse);
  });
}
