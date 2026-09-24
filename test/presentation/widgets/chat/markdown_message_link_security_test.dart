import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/widgets/chat/markdown_message_widget.dart';

void main() {
  testWidgets('message links launch only over HTTP or HTTPS', (tester) async {
    const urlLauncherChannel = MethodChannel('plugins.flutter.io/url_launcher');
    final launchedUrls = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      urlLauncherChannel,
      (call) async {
        if (call.method == 'launch') {
          launchedUrls.add(
            (call.arguments as Map<Object?, Object?>)['url'] as String,
          );
          return true;
        }
        return false;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        urlLauncherChannel,
        null,
      ),
    );

    Future<void> showMessage(String text) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownMessageWidget(text: text, isSelf: false),
          ),
        ),
      );
    }

    await showMessage('[safe](https://example.com)');
    await tester.tap(find.text('safe', findRichText: true));
    await tester.pump();
    expect(launchedUrls, ['https://example.com']);

    await showMessage('[unsafe](javascript:alert%281%29)');
    await tester.tap(find.text('unsafe', findRichText: true));
    await tester.pump();
    expect(launchedUrls, ['https://example.com']);
    expect(tester.takeException(), isNull);
  });
}
