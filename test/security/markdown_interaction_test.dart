import 'package:n42_chat/src/core/services/text_document_loader.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:n42_chat/src/core/services/markdown_resource_loader.dart';
import 'package:n42_chat/src/presentation/widgets/chat/safe_markdown_document.dart';

void main() {
  test(
    'resource loader rejects redirects and sends no application authorization',
    () async {
      final loader = MarkdownResourceLoader(
        client: MockClient((request) async {
          expect(request.followRedirects, isFalse);
          expect(request.headers.containsKey('authorization'), isFalse);
          return http.Response(
            '',
            302,
            headers: {'location': 'https://other.test'},
          );
        }),
      );
      addTearDown(loader.dispose);
      await expectLater(
        loader.load(Uri.parse('https://image.test/a.png')),
        throwsFormatException,
      );
      for (final value in [
        'http://image.test/a',
        'https://127.0.0.1/a',
        'https://localhost/a',
        'file:///a',
      ]) {
        expect(markdownResourceUri(value), isNull);
      }
    },
  );

  test('image retry creates a fresh transport after a timeout', () async {
    var clients = 0;
    final stalled = Completer<http.Response>();
    final loader = MarkdownResourceLoader(
      timeout: const Duration(milliseconds: 10),
      clientFactory: () {
        final attempt = ++clients;
        return MockClient(
          (_) async =>
              attempt == 1 ? stalled.future : http.Response.bytes([1, 2], 200),
        );
      },
    );
    await expectLater(
      loader.load(Uri.parse('https://image.test/a')),
      throwsA(isA<TimeoutException>()),
    );
    expect(await loader.load(Uri.parse('https://image.test/a')), [1, 2]);
    expect(clients, 2);
    loader.dispose();
    stalled.complete(http.Response('', 200));
  });
  test('document retry uses a fresh transport after timeout', () async {
    var clients = 0;
    final stalled = Completer<http.Response>();
    final loader = TextDocumentLoader(
      timeout: const Duration(milliseconds: 10),
      clientFactory: () {
        final attempt = ++clients;
        return MockClient(
          (_) async =>
              attempt == 1 ? stalled.future : http.Response('recovered', 200),
        );
      },
    );
    await expectLater(
      loader.load('https://docs.test/a.md'),
      throwsA(isA<TimeoutException>()),
    );
    expect(await loader.load('https://docs.test/a.md'), 'recovered');
    expect(clients, 2);
    loader.dispose();
    stalled.complete(http.Response('', 200));
  });
  testWidgets(
    'failed external launch is reported without an unhandled future',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeMarkdownDocument(
              data: '[Docs](https://docs.example.test/read)',
              openLink: (_) async => throw StateError('No handler'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Docs'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Unable to open this link.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'external link requires explicit confirmation and source is readable',
    (tester) async {
      final opened = <Uri>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeMarkdownDocument(
              data: '[Docs](https://docs.example.test/read)',
              openLink: (uri) async {
                opened.add(uri);
                return true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text('Docs'));
      await tester.pumpAndSettle();
      expect(find.text('https://docs.example.test/read'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(opened, isEmpty);
      await tester.tap(find.text('Docs'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(opened.single.host, 'docs.example.test');
      await tester.tap(find.text('View source'));
      await tester.pumpAndSettle();
      expect(
        find.text('[Docs](https://docs.example.test/read)'),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'image makes no request until clicked and does not reuse consent for another URL',
    (tester) async {
      var loads = 0;
      Future<Uint8List> load(Uri _) async {
        loads++;
        return base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
        );
      }

      Widget page(String url) => MaterialApp(
        home: Scaffold(
          body: ConsentedMarkdownImage(uri: Uri.parse(url), loadImage: load),
        ),
      );
      await tester.pumpWidget(page('https://images.test/one.png'));
      expect(loads, 0);
      await tester.tap(find.text('Load image from images.test'));
      await tester.pumpAndSettle();
      expect(loads, 1);
      expect(find.byType(Image), findsOneWidget);
      await tester.pumpWidget(page('https://images.test/two.png'));
      expect(loads, 1);
      expect(find.byType(Image), findsNothing);
    },
  );
}
