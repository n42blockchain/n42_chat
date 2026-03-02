import 'package:dio/dio.dart';

import '../../domain/entities/bot_command_entity.dart';
import '../../integration/wallet_bridge.dart';
import '../utils/debug_log.dart';

/// Bot 命令处理器
///
/// 解析并执行聊天室内的斜杠命令（/price、/balance、/chains、/help 等）。
/// 纯本地处理，不需要外部服务器，结果通过 [BotCommandResult] 返回给 UI。
class BotCommandProcessor {
  final IWalletBridge _walletBridge;
  final Dio _dio;

  /// CoinGecko 免费公共 API（无需 API Key）
  static const _priceApiBase = 'https://api.coingecko.com/api/v3';

  /// N42 支持的链数量
  static const _chainCount = 236;

  /// N42 代表性链列表（用于 /chains 命令展示）
  static const _featuredChains = [
    'Ethereum', 'BNB Smart Chain', 'Polygon', 'Arbitrum', 'Optimism',
    'Avalanche', 'Solana', 'Base', 'Fantom', 'Cronos',
    'zkSync Era', 'Linea', 'Scroll', 'Starknet', 'Aptos',
    'Sui', 'Near', 'Cosmos', 'Polkadot', 'Tron',
    'Bitcoin (wrapped)', 'Litecoin (wrapped)', 'TON', '... and 213+ more',
  ];

  BotCommandProcessor({
    required IWalletBridge walletBridge,
    Dio? dio,
  })  : _walletBridge = walletBridge,
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ));

  /// 解析命令字符串并执行
  ///
  /// [rawText] 是以 '/' 开头的原始输入文本，例如 "/price BTC"
  Future<BotCommandResult> processRaw(String rawText) async {
    final trimmed = rawText.trim();
    if (!trimmed.startsWith('/')) return const BotCommandResult.unknown();

    final parts = trimmed.substring(1).split(RegExp(r'\s+'));
    final command = parts.first.toLowerCase();
    final args = parts.skip(1).toList();

    return process(command: command, args: args);
  }

  /// 执行指定命令
  Future<BotCommandResult> process({
    required String command,
    List<String> args = const [],
  }) async {
    switch (command) {
      case 'help':
        return _handleHelp();
      case 'price':
        return _handlePrice(args);
      case 'balance':
        return _handleBalance();
      case 'chains':
        return _handleChains();
      case 'announce':
        return _handleAnnounce(args);
      default:
        // 未知命令
        final known = BuiltInBotCommands.find(command);
        if (known != null) {
          // 已知但需要特殊处理（poll/welcome 由 UI 层处理）
          return const BotCommandResult.dismiss();
        }
        return BotCommandResult.error(
          'Unknown command: /$command\nType /help to see available commands.',
        );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Command Handlers
  // ─────────────────────────────────────────────────────────────────────────

  BotCommandResult _handleHelp() {
    final buffer = StringBuffer();
    buffer.writeln('📋 Available Commands\n');
    for (final cmd in BuiltInBotCommands.all) {
      final adminTag = cmd.adminOnly ? ' 🔒' : '';
      buffer.writeln('/${cmd.usage.replaceFirst('/', '')}$adminTag');
      buffer.writeln('  ${cmd.description}\n');
    }
    buffer.writeln('💡 N42 supports ${_chainCount}+ chains — more than any other chat platform.');
    return BotCommandResult.showPanel(
      title: '🤖 Bot Commands',
      content: buffer.toString(),
    );
  }

  Future<BotCommandResult> _handlePrice(List<String> args) async {
    if (args.isEmpty) {
      return const BotCommandResult.error('Usage: /price <token>\nExample: /price bitcoin');
    }

    final symbol = args.first.toLowerCase();

    // 尝试映射常见符号到 CoinGecko ID
    final coinId = _symbolToId(symbol);

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_priceApiBase/simple/price',
        queryParameters: {
          'ids': coinId,
          'vs_currencies': 'usd',
          'include_24hr_change': true,
          'include_market_cap': true,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey(coinId)) {
          final info = data[coinId] as Map<String, dynamic>;
          final price = info['usd'] as num?;
          final change = info['usd_24h_change'] as num?;
          final mcap = info['usd_market_cap'] as num?;

          if (price != null) {
            final changeStr = change != null
                ? (change >= 0
                    ? '📈 +${change.toStringAsFixed(2)}%'
                    : '📉 ${change.toStringAsFixed(2)}%')
                : '';

            final formattedPrice = price >= 1
                ? '\$${_formatNumber(price.toDouble())}'
                : '\$${price.toStringAsFixed(6)}';

            final mcapStr = mcap != null
                ? '\nMarket Cap: \$${_formatLargeNumber(mcap.toDouble())}'
                : '';

            return BotCommandResult.showPanel(
              title: '💰 ${symbol.toUpperCase()} Price',
              content:
                  'Price: $formattedPrice\n24h Change: $changeStr$mcapStr\n\nPowered by CoinGecko',
            );
          }
        }
        return BotCommandResult.error('Token "$symbol" not found.\nTry using the full name (e.g., /price bitcoin)');
      }
    } catch (e) {
      debugLog('BotCommandProcessor price error: $e');
      return BotCommandResult.error('Failed to fetch price. Please try again.');
    }

    return BotCommandResult.error('Could not retrieve price data.');
  }

  BotCommandResult _handleBalance() {
    final address = _walletBridge.walletAddress;
    if (address == null || address.isEmpty) {
      return const BotCommandResult.error(
        'No wallet connected.\nConnect your wallet to check balance.',
      );
    }

    final shortAddr = '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
    return BotCommandResult.showPanel(
      title: '👛 Wallet',
      content: 'Address: $shortAddr\n\nOpen N42 Wallet to view full balances across ${_chainCount}+ chains.',
    );
  }

  BotCommandResult _handleChains() {
    final buffer = StringBuffer();
    buffer.writeln('⛓️ N42 supports $_chainCount+ chains\n');
    buffer.writeln('Featured networks:\n');
    for (final chain in _featuredChains) {
      buffer.writeln('• $chain');
    }
    buffer.writeln('\n🏆 More than Telegram TON (1 chain)\n');
    buffer.writeln('Use /balance to check your assets across all chains.');
    return BotCommandResult.showPanel(
      title: '⛓️ Supported Chains ($_chainCount+)',
      content: buffer.toString(),
    );
  }

  BotCommandResult _handleAnnounce(List<String> args) {
    if (args.isEmpty) {
      return const BotCommandResult.error('Usage: /announce <message>');
    }
    final message = args.join(' ');
    return BotCommandResult.sendMessage('📢 **Announcement**\n\n$message');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────────────────

  /// 将常见 token 符号转换为 CoinGecko ID
  String _symbolToId(String symbol) {
    const map = {
      'btc': 'bitcoin',
      'eth': 'ethereum',
      'bnb': 'binancecoin',
      'sol': 'solana',
      'matic': 'matic-network',
      'avax': 'avalanche-2',
      'ton': 'the-open-network',
      'ada': 'cardano',
      'dot': 'polkadot',
      'link': 'chainlink',
      'uni': 'uniswap',
      'ltc': 'litecoin',
      'xlm': 'stellar',
      'atom': 'cosmos',
      'near': 'near',
      'apt': 'aptos',
      'sui': 'sui',
      'arb': 'arbitrum',
      'op': 'optimism',
      'ftm': 'fantom',
    };
    return map[symbol.toLowerCase()] ?? symbol.toLowerCase();
  }

  String _formatNumber(double value) {
    if (value >= 1000) {
      return value.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return value.toStringAsFixed(2);
  }

  String _formatLargeNumber(double value) {
    if (value >= 1e12) return '${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '${(value / 1e9).toStringAsFixed(2)}B';
    if (value >= 1e6) return '${(value / 1e6).toStringAsFixed(2)}M';
    return value.toStringAsFixed(0);
  }
}
