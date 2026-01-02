import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation/conversation_event.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/transfer/transfer_bloc.dart';
import '../chat/chat_page.dart';
import '../contact/add_friend_page.dart';
import '../contact/contact_list_page.dart';
import '../conversation/conversation_list_page.dart';
import '../discover/discover_page.dart';
import '../group/create_group_page.dart';
import '../profile/profile_page.dart';
import '../qrcode/scan_qr_page.dart';
import '../transfer/receive_page.dart';

/// 聊天模块主框架页面
/// 
/// 微信风格的底部 Tab 导航，包含：
/// - 聊天（消息列表）
/// - 通讯录
/// - 发现
/// - 我
/// 
/// 左上角有返回按钮，可返回主应用
class ChatMainPage extends StatefulWidget {
  /// 返回主应用的回调
  final VoidCallback? onBackToMain;
  
  const ChatMainPage({
    super.key,
    this.onBackToMain,
  });

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

  /// 显示微信风格的 "+" 弹出菜单
  void _showAddMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    
    // 计算菜单位置 - 右上角
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(button.size.width - 160, 50), ancestor: overlay),
        button.localToGlobal(Offset(button.size.width, 50), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      color: isDark ? const Color(0xFF4C4C4C) : Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: [
        _buildPopupMenuItem(
          value: 'group',
          icon: Icons.chat_bubble_outline,
          text: '发起群聊',
          isDark: isDark,
        ),
        _buildPopupMenuItem(
          value: 'add_friend',
          icon: Icons.person_add_outlined,
          text: '添加朋友',
          isDark: isDark,
        ),
        _buildPopupMenuItem(
          value: 'scan',
          icon: Icons.qr_code_scanner,
          text: '扫一扫',
          isDark: isDark,
        ),
        _buildPopupMenuItem(
          value: 'payment',
          icon: Icons.payment_outlined,
          text: '收付款',
          isDark: isDark,
        ),
      ],
    ).then((value) {
      if (value == null) return;
      switch (value) {
        case 'group':
          _navigateToCreateGroup();
          break;
        case 'add_friend':
          _navigateToAddFriend();
          break;
        case 'scan':
          _openScanQR();
          break;
        case 'payment':
          _navigateToPayment();
          break;
      }
    });
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required IconData icon,
    required String text,
    required bool isDark,
  }) {
    final textColor = isDark ? Colors.white : Colors.black87;
    return PopupMenuItem<String>(
      value: value,
      height: 48,
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 22),
          const SizedBox(width: 14),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateGroup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ContactBloc>()..add(const LoadContacts())),
            BlocProvider(create: (_) => getIt<GroupBloc>()),
          ],
          child: const CreateGroupPage(),
        ),
      ),
    ).then((_) {
      _conversationBloc.add(const RefreshConversations());
    });
  }

  void _navigateToAddFriend() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddFriendPage()),
    ).then((_) {
      _conversationBloc.add(const RefreshConversations());
    });
  }

  void _navigateToPayment() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<TransferBloc>(),
          child: const ReceivePage(),
        ),
      ),
    );
  }

  void _handleBack() {
    if (widget.onBackToMain != null) {
      widget.onBackToMain!();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  // 获取当前 Tab 的标题
  String get _currentTitle {
    switch (_currentIndex) {
      case 0:
        return '消息';
      case 1:
        return '通讯录';
      case 2:
        return '发现';
      case 3:
        return '我';
      default:
        return 'N42 Chat';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _conversationBloc),
        BlocProvider.value(value: _contactBloc),
      ],
      child: Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: textColor,
              size: 20,
            ),
            onPressed: _handleBack,
          ),
          title: Text(
            _currentTitle,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            // 根据当前 Tab 显示不同的操作按钮
            if (_currentIndex == 0) ...[
              IconButton(
                icon: Icon(Icons.search, color: textColor, size: 22),
                onPressed: () {
                  debugPrint('Open search');
                },
              ),
              Builder(
                builder: (ctx) => IconButton(
                  icon: Icon(Icons.add_circle_outline, color: textColor, size: 22),
                  onPressed: () => _showAddMenu(ctx),
                ),
              ),
            ],
            if (_currentIndex == 1)
              IconButton(
                icon: Icon(Icons.person_add_outlined, color: textColor, size: 22),
                onPressed: _navigateToAddFriend,
              ),
            const SizedBox(width: 8),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // 聊天页面 - 不需要自带 AppBar
            _ChatTabContent(
              conversationBloc: _conversationBloc,
              contactBloc: _contactBloc,
            ),
            // 通讯录页面 - 不需要自带 AppBar
            const _ContactTabContent(),
            // 发现页面 - 不需要自带 AppBar
            const _DiscoverTabContent(),
            // 我的页面 - 不需要自带 AppBar
            const _ProfileTabContent(),
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

// ============================================
// 各 Tab 的内容 Widget（不带 AppBar）
// ============================================

/// 聊天 Tab 内容
class _ChatTabContent extends StatelessWidget {
  final ConversationBloc conversationBloc;
  final ContactBloc contactBloc;
  
  const _ChatTabContent({
    required this.conversationBloc,
    required this.contactBloc,
  });

  void _navigateToChat(BuildContext context, ConversationEntity conversation) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ChatBloc>()),
            BlocProvider.value(value: contactBloc),
          ],
          child: ChatPage(
            conversation: conversation,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    ).then((_) {
      // 返回后刷新会话列表
      conversationBloc.add(const RefreshConversations());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: conversationBloc,
      child: ConversationListPage(
        onConversationTap: (conversation) => _navigateToChat(context, conversation),
        onSearchTap: () {
          debugPrint('Open search');
        },
        showAppBar: false, // 不显示 AppBar
      ),
    );
  }
}

/// 通讯录 Tab 内容
class _ContactTabContent extends StatelessWidget {
  const _ContactTabContent();

  @override
  Widget build(BuildContext context) {
    return const ContactListPage(showAppBar: false);
  }
}

/// 发现 Tab 内容
class _DiscoverTabContent extends StatelessWidget {
  const _DiscoverTabContent();

  @override
  Widget build(BuildContext context) {
    return const DiscoverPage(showAppBar: false);
  }
}

/// 我 Tab 内容
class _ProfileTabContent extends StatelessWidget {
  const _ProfileTabContent();

  @override
  Widget build(BuildContext context) {
    return const ProfilePage(showAppBar: false);
  }
}

