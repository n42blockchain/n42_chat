import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:n42_chat/n42_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置状态栏样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // 初始化N42 Chat
  await N42Chat.initialize(
    N42ChatConfig(
      defaultHomeserver: 'https://matrix.org',
      enableEncryption: true,
      enablePushNotifications: true,
      walletBridge: MockWalletBridge(), // 使用模拟钱包
      onMessageTap: (roomId, eventId) {
        debugPrint('Message tapped: $roomId / $eventId');
      },
    ),
  );

  runApp(const N42ChatExampleApp());
}

/// N42 Chat 示例应用
class N42ChatExampleApp extends StatelessWidget {
  const N42ChatExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N42 Chat Demo',
      debugShowCheckedModeBanner: false,
      theme: N42ChatTheme.wechatLight().toThemeData(),
      darkTheme: N42ChatTheme.wechatDark().toThemeData(),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

/// 主屏幕 - 模拟N42钱包的底部导航结构
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; // 默认显示聊天Tab
  int _unreadCount = 0;

  final List<Widget> _pages = [
    const WalletPage(),
    N42Chat.chatWidget(),
    const DiscoverPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _listenToUnreadCount();
  }

  void _listenToUnreadCount() {
    N42Chat.unreadCountStream.listen((count) {
      if (mounted) {
        setState(() => _unreadCount = count);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFF7F7F7),
          selectedItemColor: const Color(0xFF07C160),
          unselectedItemColor: const Color(0xFF888888),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: 24,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: '钱包',
            ),
            BottomNavigationBarItem(
              icon: _buildChatIcon(false),
              activeIcon: _buildChatIcon(true),
              label: '消息',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: '发现',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '我',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatIcon(bool isActive) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          isActive ? Icons.chat_bubble : Icons.chat_bubble_outline,
        ),
        if (_unreadCount > 0)
          Positioned(
            right: -8,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFFA5151),
                borderRadius: BorderRadius.circular(9),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                _unreadCount > 99 ? '99+' : _unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

/// 钱包页面占位
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('钱包'),
        backgroundColor: const Color(0xFFF7F7F7),
        foregroundColor: const Color(0xFF181818),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF07C160).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                size: 40,
                color: Color(0xFF07C160),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'N42 Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181818),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '钱包功能区域',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  _BalanceItem(label: 'ETH', value: '1.5000'),
                  Divider(height: 24),
                  _BalanceItem(label: 'USDT', value: '100.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceItem extends StatelessWidget {
  final String label;
  final String value;

  const _BalanceItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF181818),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF181818),
          ),
        ),
      ],
    );
  }
}

/// 发现页面占位
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('发现'),
        backgroundColor: const Color(0xFFF7F7F7),
        foregroundColor: const Color(0xFF181818),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildSection([
            _DiscoverItem(
              icon: Icons.qr_code_scanner,
              iconColor: const Color(0xFF3D7CF4),
              title: '扫一扫',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 10),
          _buildSection([
            _DiscoverItem(
              icon: Icons.apps,
              iconColor: const Color(0xFF7D48D8),
              title: 'DApps',
              onTap: () {},
            ),
            _DiscoverItem(
              icon: Icons.swap_horiz,
              iconColor: const Color(0xFF07C160),
              title: 'Swap',
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(List<Widget> items) {
    return Container(
      color: Colors.white,
      child: Column(
        children: List.generate(items.length * 2 - 1, (index) {
          if (index.isOdd) {
            return const Divider(height: 0.5, indent: 56);
          }
          return items[index ~/ 2];
        }),
      ),
    );
  }
}

class _DiscoverItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _DiscoverItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFFCCCCCC),
      ),
      onTap: onTap,
    );
  }
}

/// 个人中心页面占位
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: const Color(0xFFF7F7F7),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFFF7F7F7),
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF07C160),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'N42 User',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF181818),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '@user:matrix.org',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.qr_code,
                      color: Color(0xFF888888),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFCCCCCC),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildSection([
                  _ProfileItem(
                    icon: Icons.settings,
                    title: '设置',
                    onTap: () {},
                  ),
                ]),
                const SizedBox(height: 10),
                _buildSection([
                  _ProfileItem(
                    icon: Icons.info_outline,
                    title: '关于',
                    onTap: () {},
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(List<Widget> items) {
    return Container(
      color: Colors.white,
      child: Column(
        children: List.generate(items.length * 2 - 1, (index) {
          if (index.isOdd) {
            return const Divider(height: 0.5, indent: 56);
          }
          return items[index ~/ 2];
        }),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF07C160)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFFCCCCCC),
      ),
      onTap: onTap,
    );
  }
}

