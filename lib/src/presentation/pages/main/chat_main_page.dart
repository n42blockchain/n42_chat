import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation/conversation_event.dart';
import '../contact/contact_list_page.dart';
import '../conversation/conversation_list_page.dart';
import '../discover/discover_page.dart';
import '../profile/profile_page.dart';
import '../qrcode/scan_qr_page.dart';

/// 聊天模块主框架页面
/// 
/// 微信风格的底部 Tab 导航，包含：
/// - 聊天（消息列表）
/// - 通讯录
/// - 发现
/// - 我
class ChatMainPage extends StatefulWidget {
  const ChatMainPage({super.key});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  int _currentIndex = 0;
  
  // 使用 PageController 保持页面状态
  late PageController _pageController;
  
  // 各页面的 Bloc
  late ConversationBloc _conversationBloc;
  late ContactBloc _contactBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _conversationBloc = getIt<ConversationBloc>();
    _contactBloc = getIt<ContactBloc>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _conversationBloc.close();
    _contactBloc.close();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _openScanQR() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ScanQRPage()),
    ).then((result) {
      if (result != null && result is Map) {
        // 扫码结果处理
        final roomId = result['roomId'];
        if (roomId != null) {
          // 刷新会话列表
          _conversationBloc.add(const RefreshConversations());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _conversationBloc),
        BlocProvider.value(value: _contactBloc),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // 聊天页面
            ConversationListPage(
              onConversationTap: (conversation) {
                debugPrint('Open conversation: ${conversation.id}');
                // TODO: 导航到聊天详情页
              },
              onSearchTap: () {
                debugPrint('Open search');
                // TODO: 导航到搜索页
              },
            ),
            // 通讯录页面
            const ContactListPage(),
            // 发现页面
            const DiscoverPage(),
            // 我的页面
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(isDark),
      ),
    );
  }

  Widget _buildBottomNavigationBar(bool isDark) {
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final selectedColor = const Color(0xFF07C160);
    final unselectedColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(
                index: 0,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: '聊天',
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
                // TODO: 实际的未读数
                badge: 0,
              ),
              _buildTabItem(
                index: 1,
                icon: Icons.contacts_outlined,
                activeIcon: Icons.contacts,
                label: '通讯录',
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildTabItem(
                index: 2,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: '发现',
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildTabItem(
                index: 3,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: '我',
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color selectedColor,
    required Color unselectedColor,
    int badge = 0,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  color: color,
                  size: 24,
                ),
                if (badge > 0)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 16),
                      child: Text(
                        badge > 99 ? '99+' : '$badge',
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
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

