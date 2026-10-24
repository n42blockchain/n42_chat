import 'dart:convert';
import 'dart:io';

import 'package:flutter_vodozemac/flutter_vodozemac.dart' as flutter_vod;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:cryptography/cryptography.dart';
import 'package:n42_chat/src/core/services/text_document_loader.dart';
import 'package:n42_chat/src/core/services/media_telemetry.dart';
import 'package:n42_chat/src/presentation/widgets/chat/safe_markdown_document.dart';

void main() {
  tearDown(() => MediaTelemetry.onEvent = null);
  test(
    'document download is bounded and never follows redirects with credentials',
    () async {
      var status = 302;
      final loader = TextDocumentLoader(
        client: MockClient((request) async {
          expect(request.followRedirects, isFalse);
          expect(request.headers['Authorization'], 'Bearer test-only');
          return http.Response(
            status == 200 ? '# hello' : '',
            status,
            headers: {'location': 'https://evil.test'},
          );
        }),
      );
      addTearDown(loader.dispose);
      await expectLater(
        loader.load(
          'https://media.test/file',
          headers: {'Authorization': 'Bearer test-only'},
        ),
        throwsFormatException,
      );
      status = 200;
      expect(
        await loader.load(
          'https://media.test/file',
          headers: {'Authorization': 'Bearer test-only'},
        ),
        '# hello',
      );
    },
  );
  test(
    'oversize, malformed UTF-8 and invalid encryption fail closed',
    () async {
      var bytes = Uint8List(TextDocumentLoader.maxBytes + 1);
      var calls = 0;
      final loader = TextDocumentLoader(
        client: MockClient((_) async {
          calls++;
          return http.Response.bytes(bytes, 200);
        }),
      );
      addTearDown(loader.dispose);
      await expectLater(
        loader.load('https://media.test/file'),
        throwsFormatException,
      );
      bytes = Uint8List.fromList([0xff]);
      await expectLater(
        loader.load('https://media.test/file'),
        throwsFormatException,
      );
      final previousCalls = calls;
      await expectLater(
        loader.load('https://media.test/file', encryptKey: 'partial'),
        throwsFormatException,
      );
      expect(calls, previousCalls);
      await expectLater(
        loader.load('http://media.test/file'),
        throwsFormatException,
      );
    },
  );
  test(
    'encrypted document validates hash and decrypts before rendering',
    () async {
      final packageConfig = File('.dart_tool/package_config.json');
      final packages =
          (jsonDecode(await packageConfig.readAsString())
                  as Map<String, dynamic>)['packages']
              as List;
      final package = packages.cast<Map<String, dynamic>>().singleWhere(
        (entry) => entry['name'] == 'flutter_vodozemac',
      );
      final root = Directory.fromUri(
        packageConfig.absolute.uri.resolve(package['rootUri'] as String),
      ).uri;
      await flutter_vod.init(
        libraryPath: root
            .resolve(
              'macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/',
            )
            .toFilePath(),
      );
      final clear = utf8.encode('# secret\n你好');
      final keyBytes = List<int>.generate(32, (i) => i);
      final iv = List<int>.filled(16, 0);
      final cipher = AesCtr.with256bits(macAlgorithm: MacAlgorithm.empty);
      final box = await cipher.encrypt(
        clear,
        secretKey: SecretKey(keyBytes),
        nonce: iv,
      );
      final hash = await Sha256().hash(box.cipherText);
      final loader = TextDocumentLoader(
        client: MockClient(
          (_) async => http.Response.bytes(box.cipherText, 200),
        ),
      );
      addTearDown(loader.dispose);
      expect(
        await loader.load(
          'https://media.test/file',
          encryptKey: base64Url.encode(keyBytes),
          encryptIv: base64.encode(iv),
          encryptSha256: base64.encode(hash.bytes),
        ),
        utf8.decode(clear),
      );
      await expectLater(
        loader.load(
          'https://media.test/file',
          encryptKey: base64Url.encode(keyBytes),
          encryptIv: base64.encode(iv),
          encryptSha256: base64.encode(List.filled(32, 0)),
        ),
        throwsFormatException,
      );
    },
    skip: !Platform.isMacOS,
  );
  const payloads = [
    '![remote](https://tracker.invalid/pixel)',
    '![remote](http://tracker.invalid/pixel)',
    '![local](file:///etc/passwd)',
    '![data](data:image/svg+xml;base64,PHN2Zz4=)',
    '<script>fetch("https://tracker.invalid")</script>',
    '<img src="https://tracker.invalid/pixel" onerror="alert(1)">',
    '<iframe src="https://tracker.invalid"></iframe>',
    '[run](javascript:alert(1))',
    '![reference][img]\n\n[img]: https://tracker.invalid/pixel',
    '| Name | Value |\n| --- | --- |\n| Safe | **table** |',
  ];
  for (var i = 0; i < 100; i++) {
    testWidgets('safe Markdown corpus sample $i', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeMarkdownDocument(
              data: '# Sample $i\n\n${payloads[i % payloads.length]}',
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(Image), findsNothing);
      expect(tester.takeException(), isNull);
      // The renderer has no WebView or link launcher; image construction is
      // blocked before an ImageProvider or network request can be created.
      if (i % payloads.length == 9) expect(find.byType(Table), findsOneWidget);
    });
  }
  testWidgets('1MB document pages bounded content and supports navigation', (
    tester,
  ) async {
    final data = '${'# Heading\n' * 104857}end';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SafeMarkdownDocument(data: data)),
      ),
    );
    expect(find.text('1 / 64'), findsOneWidget);
    await tester.tap(find.byTooltip('Next page'));
    await tester.pump();
    expect(find.text('2 / 64'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
