import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:n42_chat/src/core/services/mini_app_bridge_service.dart';
import 'package:n42_chat/src/domain/entities/mini_app_entity.dart';

import '../mocks/mock_wallet_bridge.dart';

class _Controller extends Mock implements WebViewController {}

void main() {
  setUpAll(() => registerFallbackValue((JavaScriptMessage _) {}));
  testWidgets(
    'native chat channel rejects stale documents, foreign frames and revoked policy',
    (tester) async {
      final controller = _Controller();
      final callbacks = <String, void Function(JavaScriptMessage)>{};
      when(
        () => controller.addJavaScriptChannel(
          any(),
          onMessageReceived: any(named: 'onMessageReceived'),
        ),
      ).thenAnswer((call) async {
        callbacks[call.positionalArguments.single as String] =
            call.namedArguments[#onMessageReceived]
                as void Function(JavaScriptMessage);
      });
      var origin = 'https://mini.n42.world';
      when(() => controller.currentUrl()).thenAnswer((_) async => origin);
      when(() => controller.runJavaScript(any())).thenAnswer((_) async {});
      var allowed = true;
      final sent = <String>[];
      final service = MiniAppBridgeService(
        walletBridge: MockWalletBridge(),
        roomId: '!room:test',
        app: const MiniAppEntity(
          id: 'test',
          name: 'Test',
          description: '',
          url: 'https://mini.n42.world',
          iconUrl: '',
          category: MiniAppCategory.tools,
          permissions: [MiniAppPermission.chatSend],
        ),
        isSessionAllowed: () => allowed,
        onSendMessage: sent.add,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              service.registerChannels(controller, context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      String nonce() =>
          RegExp("var _bridgeNonce = '([a-f0-9]+)'")
              .firstMatch(service.initScript)!
              .group(1)!;
      void send(String? token) => callbacks['N42ChatChannel']!(
        JavaScriptMessage(
          message: jsonEncode({
            'method': 'sendMessage',
            'nonce': token,
            'params': {'text': 'hello'},
          }),
        ),
      );
      send(
        null,
      ); // A subframe can call the platform channel but lacks the secret.
      await tester.pump();
      expect(sent, isEmpty);
      final old = nonce();
      send(old);
      await tester.pump();
      expect(sent, ['hello']);
      service.invalidateDocument();
      send(old);
      await tester.pump();
      expect(sent.length, 1);
      origin = 'https://evil.test';
      send(nonce());
      await tester.pump();
      expect(sent.length, 1);
      origin = 'https://mini.n42.world';
      allowed = false;
      send(nonce());
      await tester.pump();
      expect(sent.length, 1);
      allowed = true;
      when(() => controller.currentUrl()).thenAnswer((_) async {
        service.invalidateDocument();
        return origin;
      });
      send(nonce()); // Navigation races with the async origin lookup.
      await tester.pump();
      expect(sent.length, 1);
    },
  );
}
