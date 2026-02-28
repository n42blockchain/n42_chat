import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/mini_app_entity.dart';
import '../../integration/wallet_bridge.dart';

/// Mini App <-> Native 通信消息
class _BridgeMessage {
  final String method;
  final String? id;
  final Map<String, dynamic>? params;

  _BridgeMessage({required this.method, this.id, this.params});

  factory _BridgeMessage.fromJson(String raw) {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return _BridgeMessage(
      method: map['method'] as String,
      id: map['id']?.toString(),
      params: map['params'] as Map<String, dynamic>?,
    );
  }
}

/// Mini App JS Bridge 服务
///
/// 向 WebView 注入 `window.n42` API，提供 Mini App 与原生钱包/聊天的通信通道。
///
/// ## JavaScript API
/// ```js
/// // 钱包
/// const addr = await window.n42.wallet.getAddress();
/// const tx   = await window.n42.wallet.requestTransaction({to, value, data});
///
/// // 聊天
/// window.n42.chat.sendMessage('Hello!');
/// window.n42.chat.close();
/// const roomId = window.n42.chat.getRoomId();
/// ```
class MiniAppBridgeService {
  final IWalletBridge _walletBridge;
  final String _roomId;
  final MiniAppEntity? _app;

  /// 外部回调：Mini App 要发送消息到聊天室
  final void Function(String text)? onSendMessage;

  /// 外部回调：Mini App 请求关闭
  final VoidCallback? onClose;

  MiniAppBridgeService({
    required IWalletBridge walletBridge,
    required String roomId,
    MiniAppEntity? app,
    this.onSendMessage,
    this.onClose,
  })  : _walletBridge = walletBridge,
        _roomId = roomId,
        _app = app;

  /// 检查 Mini App 是否拥有指定权限
  bool _hasPermission(MiniAppPermission permission) {
    if (_app == null) return true; // 未指定 app 时默认允许
    return _app.permissions.contains(permission);
  }

  /// 向 WebViewController 注册所有 JS Channel
  void registerChannels(WebViewController controller, BuildContext context) {
    controller
      ..addJavaScriptChannel(
        'N42WalletChannel',
        onMessageReceived: (msg) =>
            _handleWalletMessage(controller, msg, context),
      )
      ..addJavaScriptChannel(
        'N42ChatChannel',
        onMessageReceived: (msg) => _handleChatMessage(msg),
      );
  }

  /// 初始化注入脚本 —— 在页面加载完成后执行
  String get initScript => '''
(function() {
  if (window.n42) return; // 防止重复注入

  // ─── Promise 响应追踪 ───
  var _pendingCallbacks = {};
  function _nextId() { return '_n42_' + Date.now() + '_' + Math.random().toString(36).slice(2); }

  function _makeWalletCall(method, params) {
    return new Promise(function(resolve, reject) {
      var id = _nextId();
      _pendingCallbacks[id] = {resolve: resolve, reject: reject};
      N42WalletChannel.postMessage(JSON.stringify({method: method, id: id, params: params || {}}));
    });
  }

  // ─── 接收 Native 回调 ───
  window._n42NativeCallback = function(id, success, data) {
    var cb = _pendingCallbacks[id];
    if (!cb) return;
    delete _pendingCallbacks[id];
    if (success) cb.resolve(data);
    else cb.reject(new Error(data));
  };

  // ─── Public API ───
  window.n42 = {
    version: '1.0',
    chainCount: 236,

    wallet: {
      getAddress: function() {
        return _makeWalletCall('getAddress');
      },
      getBalance: function(chainId) {
        return _makeWalletCall('getBalance', {chainId: chainId});
      },
      requestTransaction: function(params) {
        return _makeWalletCall('requestTransaction', params);
      },
    },

    chat: {
      getRoomId: function() { return '${_roomId.replaceAll("'", "\\'")}'; },
      sendMessage: function(text) {
        N42ChatChannel.postMessage(JSON.stringify({method: 'sendMessage', params: {text: text}}));
      },
      close: function() {
        N42ChatChannel.postMessage(JSON.stringify({method: 'close'}));
      },
    },

    lifecycle: {
      onPause: null,
      onResume: null,
      onDestroy: null,
    },
  };

  console.log('[N42 MiniApp Bridge] Initialized. Chains: 236+');
})();
''';

  // ─────────────────────────────────────────────────────────────────────────
  // Message Handlers
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _handleWalletMessage(
    WebViewController controller,
    JavaScriptMessage msg,
    BuildContext context,
  ) async {
    try {
      final message = _BridgeMessage.fromJson(msg.message);

      switch (message.method) {
        case 'getAddress':
          if (!_hasPermission(MiniAppPermission.walletAddress)) {
            await _resolveCallback(controller, message.id, false,
                '"Permission denied: walletAddress"');
            break;
          }
          final address = _walletBridge.walletAddress ?? '';
          await _resolveCallback(controller, message.id, true, '"$address"');

        case 'getBalance':
          if (!_hasPermission(MiniAppPermission.walletBalance)) {
            await _resolveCallback(controller, message.id, false,
                '"Permission denied: walletBalance"');
            break;
          }
          try {
            final chainId = message.params?['chainId'] as String? ?? 'ETH';
            final balance = await _walletBridge.getBalance(chainId);
            await _resolveCallback(
              controller, message.id, true, '"$balance"',
            );
          } catch (e) {
            debugPrint('MiniAppBridge: getBalance error: $e');
            await _resolveCallback(
              controller, message.id, false, '"Failed to get balance: $e"',
            );
          }

        case 'requestTransaction':
          if (!_hasPermission(MiniAppPermission.walletTransaction)) {
            await _resolveCallback(controller, message.id, false,
                '"Permission denied: walletTransaction"');
            break;
          }
          if (!context.mounted) break;
          final confirmed = await _showTransactionConfirmDialog(
            context,
            message.params,
          );
          if (confirmed) {
            try {
              final toAddress = message.params?['to'] as String? ?? '';
              final amount = message.params?['amount'] as String? ?? '0';
              final token = message.params?['token'] as String? ?? 'ETH';
              final memo = message.params?['memo'] as String?;
              final result = await _walletBridge.requestTransfer(
                toAddress: toAddress,
                amount: amount,
                token: token,
                memo: memo,
              );
              if (result.success) {
                final txHash = result.transactionHash ?? '';
                await _resolveCallback(
                  controller,
                  message.id,
                  true,
                  '{"status":"confirmed","txHash":"$txHash"}',
                );
              } else {
                await _resolveCallback(
                  controller,
                  message.id,
                  false,
                  '"${result.errorMessage ?? 'Transaction failed'}"',
                );
              }
            } catch (e) {
              debugPrint('MiniAppBridge: requestTransaction error: $e');
              await _resolveCallback(
                controller,
                message.id,
                false,
                '"Transaction failed: $e"',
              );
            }
          } else {
            await _resolveCallback(
              controller,
              message.id,
              false,
              '"User rejected transaction"',
            );
          }
      }
    } catch (e) {
      debugPrint('MiniAppBridge: wallet message error: $e');
    }
  }

  void _handleChatMessage(JavaScriptMessage msg) {
    try {
      final message = _BridgeMessage.fromJson(msg.message);
      switch (message.method) {
        case 'sendMessage':
          final text = message.params?['text'] as String?;
          if (text != null && text.isNotEmpty) onSendMessage?.call(text);
        case 'close':
          onClose?.call();
      }
    } catch (e) {
      debugPrint('MiniAppBridge: chat message error: $e');
    }
  }

  Future<void> _resolveCallback(
    WebViewController controller,
    String? id,
    bool success,
    String dataJson,
  ) async {
    if (id == null) return;
    final escapedId = id.replaceAll("'", "\\'");
    await controller.runJavaScript(
      "window._n42NativeCallback('$escapedId', $success, $dataJson);",
    );
  }

  Future<bool> _showTransactionConfirmDialog(
    BuildContext context,
    Map<String, dynamic>? params,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Confirm Transaction'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A Mini App is requesting to send a transaction on your behalf.',
              style: TextStyle(fontSize: 14),
            ),
            if (params != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  params.entries
                      .map((e) => '${e.key}: ${e.value}')
                      .join('\n'),
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Reject'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
