import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/mini_app_bridge_service.dart';
import 'package:n42_chat/src/domain/entities/mini_app_entity.dart';

import '../../mocks/mock_wallet_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MiniAppEntity buildApp(List<MiniAppPermission> permissions) {
    return MiniAppEntity(
      id: 'app',
      name: 'Test App',
      description: 'desc',
      url: 'https://example.com',
      iconUrl: 'icon',
      category: MiniAppCategory.tools,
      permissions: permissions,
    );
  }

  test('initScript disables chat bridge methods when app lacks chat permissions', () {
    final service = MiniAppBridgeService(
      walletBridge: MockWalletBridge(),
      roomId: '!room:server',
      app: buildApp(const [MiniAppPermission.walletAddress]),
    );

    expect(service.initScript, contains('var _canChatRead = false;'));
    expect(service.initScript, contains('var _canChatSend = false;'));
    expect(service.initScript, contains('if (!_canChatRead) return null;'));
    expect(
      service.initScript,
      contains("if (!_canChatSend || typeof text !== 'string' || !text.trim()) return false;"),
    );
  });

  test('initScript enables chat bridge methods when app declares chat permissions', () {
    final service = MiniAppBridgeService(
      walletBridge: MockWalletBridge(),
      roomId: '!room:server',
      app: buildApp(const [
        MiniAppPermission.chatRead,
        MiniAppPermission.chatSend,
      ]),
    );

    expect(service.initScript, contains('var _canChatRead = true;'));
    expect(service.initScript, contains('var _canChatSend = true;'));
  });

  test('initScript defaults chat permissions to disabled when app metadata is missing', () {
    final service = MiniAppBridgeService(
      walletBridge: MockWalletBridge(),
      roomId: '!room:server',
    );

    expect(service.initScript, contains('var _canChatRead = false;'));
    expect(service.initScript, contains('var _canChatSend = false;'));
  });
}
