import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/common_widgets.dart';
import '../chat/chat_page.dart';
import 'contact_tile.dart';
import 'contact_index_bar.dart';

/// 通讯录页面（仿微信）
class ContactListPage extends StatefulWidget {
  /// 是否显示 AppBar（嵌入到主框架时可设为 false）
  final bool showAppBar;
  
  const ContactListPage({
    super.key,
    this.showAppBar = true,
  });

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Map<String, GlobalKey> _letterKeys = {};

  bool _isSearchMode = false;

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(const LoadContacts());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onLetterTap(String letter) {
    final key = _letterKeys[letter];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<ContactBloc>().add(const ClearSearch());
    } else {
      context.read<ContactBloc>().add(SearchContacts(query));
    }
  }

  void _onGlobalSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<ContactBloc>().add(SearchUsers(query));
    }
  }

  void _toggleSearchMode() {
    setState(() {
      _isSearchMode = !_isSearchMode;
      if (!_isSearchMode) {
        _searchController.clear();
        context.read<ContactBloc>().add(const ClearSearch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showAppBar ? N42AppBar(
        title: S.of(context)?.contacts ?? 'Contacts',
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_outlined,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: _showAddContactDialog,
          ),
        ],
      ) : null,
      body: Column(
        children: [
          // 搜索栏（始终显示）
          _buildSearchBar(isDark),

          // 联系人列表
          Expanded(
            child: BlocConsumer<ContactBloc, ContactState>(
              listener: (context, state) {
                if (state is ChatStarted) {
                  Navigator.of(context).pushNamed(
                    '/chat/${state.roomId}',
                  );
                } else if (state is ContactError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ContactLoading) {
                  return const N42Loading();
                }

                if (state is ContactError) {
                  return N42EmptyState(
                    icon: Icons.error_outline,
                    title: S.of(context)?.loadFailed ?? 'Load failed',
                    description: state.message,
                    buttonText: S.of(context)?.retry ?? 'Retry',
                    onButtonPressed: () {
                      context.read<ContactBloc>().add(const LoadContacts());
                    },
                  );
                }

                if (state is ContactLoaded) {
                  return _buildContactList(state, isDark);
                }

                return N42EmptyState(
                  icon: Icons.contacts_outlined,
                  title: S.of(context)?.noContacts ?? 'No contacts',
                  description: S.of(context)?.addFriendsToChat ?? 'Add friends to start chatting',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: S.of(context)?.search ?? 'Search',
            hintStyle: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildContactList(ContactLoaded state, bool isDark) {
    // 搜索模式
    if (state.searchQuery.isNotEmpty) {
      return _buildSearchResults(state, isDark);
    }

    // 准备索引字母的GlobalKey
    _letterKeys.clear();
    for (final letter in state.indexLetters) {
      _letterKeys[letter] = GlobalKey();
    }

    // 完整的索引字母列表
    final fullIndexLetters = ['🔍', '☆', ...state.indexLetters, '#'];

    return Stack(
      children: [
        // 联系人列表
        RefreshIndicator(
          onRefresh: () async {
            context.read<ContactBloc>().add(const RefreshContacts());
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 功能入口
              SliverToBoxAdapter(
                child: _buildFunctionEntries(state, isDark),
              ),

              // 按字母分组的联系人
              for (final letter in state.indexLetters) ...[
                // 字母标题
                SliverToBoxAdapter(
                  key: _letterKeys[letter],
                  child: _buildLetterHeader(letter, isDark),
                ),
                // 该字母下的联系人
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final contacts = state.groupedContacts[letter]!;
                      return Column(
                        children: [
                          ContactTile(
                            contact: contacts[index],
                            onTap: () => _onContactTap(contacts[index]),
                            onLongPress: () => _showContactMenu(contacts[index]),
                          ),
                          if (index < contacts.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(left: 72),
                              child: Divider(
                                height: 1,
                                color: isDark ? AppColors.dividerDark : AppColors.divider,
                              ),
                            ),
                        ],
                      );
                    },
                    childCount: state.groupedContacts[letter]?.length ?? 0,
                  ),
                ),
              ],

              // 底部统计
              SliverToBoxAdapter(
                child: _buildFooter(state.contacts.length, isDark),
              ),
            ],
          ),
        ),

        // 右侧字母索引条
        Positioned(
          right: 2,
          top: 0,
          bottom: 50,
          child: _WeChatIndexBar(
            letters: fullIndexLetters,
            onLetterTap: (letter) {
              if (letter == '🔍') {
                _searchController.clear();
                FocusScope.of(context).unfocus();
              } else if (letter == '☆') {
                // 滚动到顶部
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              } else {
                _onLetterTap(letter);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(ContactLoaded state, bool isDark) {
    final localResults = state.filteredContacts;
    final globalResults = state.searchResults;

    if (localResults.isEmpty &&
        globalResults.isEmpty &&
        !state.isSearching &&
        !state.isGlobalSearching) {
      return N42EmptyState(
        icon: Icons.search_off,
        title: S.of(context)?.contactNotFound ?? 'Contact not found',
        description: S.of(context)?.tryOtherKeywords ?? 'Try other keywords or global search',
      );
    }

    return ListView(
      children: [
        // 本地搜索结果
        if (localResults.isNotEmpty) ...[
          _buildSectionHeader(S.of(context)?.contacts ?? 'Contacts', isDark),
          ...localResults.map((contact) => ContactTile(
                contact: contact,
                onTap: () => _onContactTap(contact),
              )),
        ],

        // 正在搜索指示器
        if (state.isSearching || state.isGlobalSearching)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),

        // 全局搜索结果
        if (globalResults.isNotEmpty) ...[
          _buildSectionHeader(S.of(context)?.searchResults ?? 'Search Results', isDark),
          ...globalResults.map((contact) => ContactTile(
                contact: contact,
                showOnlineStatus: false,
                onTap: () => _onContactTap(contact),
              )),
        ],
      ],
    );
  }

  Widget _buildFunctionEntries(ContactLoaded state, bool isDark) {
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    
    return Container(
      color: surfaceColor,
      child: Column(
        children: [
          // 新的朋友
          _buildFunctionItem(
            isDark: isDark,
            icon: _NewFriendIcon(),
            title: S.of(context)?.newFriends ?? 'New Friends',
            badgeCount: state.friendRequests.length,
            onTap: _showFriendRequestsPage,
          ),
          _buildItemDivider(isDark),
          
          // 仅聊天的朋友
          _buildFunctionItem(
            isDark: isDark,
            icon: _ChatOnlyFriendIcon(),
            title: S.of(context)?.chatOnlyFriends ?? 'Chat-only Friends',
            onTap: () => _showComingSoon(S.of(context)?.chatOnlyFriends ?? 'Chat-only Friends'),
          ),
          
          const SizedBox(height: 8),
          Container(
            color: surfaceColor,
            child: Column(
              children: [
                // 群聊
                _buildFunctionItem(
                  isDark: isDark,
                  icon: _GroupChatIcon(),
                  title: S.of(context)?.groupChat ?? 'Group Chat',
                  onTap: _showGroupsPage,
                ),
                _buildItemDivider(isDark),

                // 标签
                _buildFunctionItem(
                  isDark: isDark,
                  icon: _TagIcon(),
                  title: S.of(context)?.tags ?? 'Tags',
                  onTap: () => _showComingSoon(S.of(context)?.tags ?? 'Tags'),
                ),
                _buildItemDivider(isDark),

                // 公众号
                _buildFunctionItem(
                  isDark: isDark,
                  icon: _OfficialAccountIcon(),
                  title: S.of(context)?.officialAccounts ?? 'Official Accounts',
                  onTap: () => _showComingSoon(S.of(context)?.officialAccounts ?? 'Official Accounts'),
                ),
                _buildItemDivider(isDark),

                // 服务号
                _buildFunctionItem(
                  isDark: isDark,
                  icon: _ServiceAccountIcon(),
                  title: S.of(context)?.serviceAccounts ?? 'Service Accounts',
                  onTap: () => _showComingSoon(S.of(context)?.serviceAccounts ?? 'Service Accounts'),
                ),
                _buildItemDivider(isDark),

                // 企业联系人
                _buildFunctionItem(
                  isDark: isDark,
                  icon: _EnterpriseContactIcon(),
                  title: S.of(context)?.enterpriseContacts ?? 'Enterprise Contacts',
                  onTap: () => _showComingSoon(S.of(context)?.enterpriseContacts ?? 'Enterprise Contacts'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildFunctionItem({
    required bool isDark,
    required Widget icon,
    required String title,
    int badgeCount = 0,
    VoidCallback? onTap,
  }) {
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    
    return Material(
      color: bgColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: icon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
              if (badgeCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$badgeCount',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 72),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  Widget _buildLetterHeader(String letter, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: isDark ? AppColors.backgroundDark : AppColors.background,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isDark ? AppColors.backgroundDark : AppColors.background,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildFooter(int count, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        S.of(context)?.contactCount(count) ?? '$count contacts',
        style: TextStyle(
          fontSize: 14,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.featureComingSoon(feature) ?? '$feature coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onContactTap(ContactEntity contact) {
    _startChatWithContact(contact);
  }
  
  /// 显示联系人操作菜单
  void _showContactMenu(ContactEntity contact) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 联系人信息头部
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    N42Avatar(
                      imageUrl: contact.avatarUrl,
                      name: contact.effectiveDisplayName,
                      size: 48,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.effectiveDisplayName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            contact.userId,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // 发消息
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: Text(S.of(context)?.sendMessage ?? 'Message'),
                onTap: () {
                  Navigator.pop(context);
                  _startChatWithContact(contact);
                },
              ),
              // 推荐给朋友
              ListTile(
                leading: const Icon(Icons.person_add_alt_1_outlined),
                title: Text(S.of(context)?.recommendToFriend ?? 'Recommend to friend'),
                onTap: () {
                  Navigator.pop(context);
                  _recommendToFriend(contact);
                },
              ),
              // 设置备注
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(S.of(context)?.setRemark ?? 'Set remark'),
                onTap: () {
                  Navigator.pop(context);
                  _setContactRemark(contact);
                },
              ),
              // 添加到桌面
              ListTile(
                leading: const Icon(Icons.add_to_home_screen),
                title: Text(S.of(context)?.addToHomeScreen ?? 'Add to home screen'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context)?.featureInDevelopment('') ?? 'Feature in development')),
                  );
                },
              ),
              const SizedBox(height: 8),
              // 取消按钮
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(S.of(context)?.cancel ?? 'Cancel'),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
  
  /// 推荐给朋友
  Future<void> _recommendToFriend(ContactEntity contact) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final selectedContact = await showModalBottomSheet<ContactEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RecommendContactSheet(
        excludeUserId: contact.userId,
        isDark: isDark,
      ),
    );
    
    if (selectedContact == null || !mounted) return;
    
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(S.of(context)?.sendingCard ?? 'Sending card...'),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      
      final contactRepository = getIt<IContactRepository>();
      final roomId = await contactRepository.startDirectChat(selectedContact.userId);
      
      final cardContent = '''[名片]
联系人：${contact.effectiveDisplayName}
ID：${contact.userId}''';
      
      final chatBloc = getIt<ChatBloc>();
      chatBloc.add(InitializeChat(roomId));
      
      await Future.delayed(const Duration(milliseconds: 500));
      chatBloc.add(SendTextMessage(cardContent));
      
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.recommendedCardTo(contact.effectiveDisplayName, selectedContact.effectiveDisplayName) ?? 'Recommended ${contact.effectiveDisplayName}\'s card to ${selectedContact.effectiveDisplayName}'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      debugPrint('Recommend to friend error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.recommendFailed(e.toString()) ?? 'Recommend failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  /// 设置联系人备注
  void _setContactRemark(ContactEntity contact) {
    final controller = TextEditingController(text: contact.remark);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.setRemark ?? 'Set remark'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: S.of(context)?.enterRemarkName ?? 'Enter remark name',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => controller.clear(),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context)?.remarkSetTo(controller.text) ?? 'Remark set to: ${controller.text}'),
                ),
              );
            },
            child: Text(S.of(context)?.confirm ?? 'OK'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _startChatWithContact(ContactEntity contact) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(S.of(context)?.openingChat ?? 'Opening chat...'),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      
      final contactRepository = getIt<IContactRepository>();
      final roomId = await contactRepository.startDirectChat(contact.userId);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      
      final conversation = ConversationEntity(
        id: roomId,
        name: contact.effectiveDisplayName,
        avatarUrl: contact.avatarUrl,
        type: ConversationType.direct,
        lastMessage: null,
        lastMessageTime: null,
        unreadCount: 0,
      );
      
      final contactBloc = context.read<ContactBloc>();
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<ChatBloc>()),
              BlocProvider.value(value: contactBloc),
            ],
            child: ChatPage(
              conversation: conversation,
              onBack: () => Navigator.of(ctx).pop(),
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Start chat error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.openChatFailed(e.toString()) ?? 'Open chat failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showAddContactDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.addContact ?? 'Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context)?.enterUserId ?? 'Enter user ID',
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.pop(dialogContext);
                  context.read<ContactBloc>().add(StartChat(value));
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text(S.of(context)?.scan ?? 'Scan'),
          ),
        ],
      ),
    );
  }

  void _showFriendRequestsPage() {
    final contactBloc = context.read<ContactBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: contactBloc,
          child: const _FriendRequestsPage(),
        ),
      ),
    );
  }

  void _showGroupsPage() {
    final contactBloc = context.read<ContactBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: contactBloc,
          child: const _GroupListPage(),
        ),
      ),
    );
  }
}

// ==================== 微信风格图标组件 ====================

/// 新的朋友图标 - 橙色背景，双人+号
class _NewFriendIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFA9D3B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(44, 44),
        painter: _NewFriendPainter(),
      ),
    );
  }
}

class _NewFriendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    // 主人形
    canvas.drawCircle(Offset(cx - 4, cy - 6), 6, paint);
    final bodyPath = Path()
      ..moveTo(cx - 12, cy + 12)
      ..quadraticBezierTo(cx - 4, cy + 2, cx + 4, cy + 12);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;
    canvas.drawPath(bodyPath, paint);
    
    // 加号
    paint.strokeWidth = 2.5;
    canvas.drawLine(Offset(cx + 10, cy - 2), Offset(cx + 10, cy + 10), paint);
    canvas.drawLine(Offset(cx + 4, cy + 4), Offset(cx + 16, cy + 4), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 仅聊天的朋友图标 - 橙色背景，单人
class _ChatOnlyFriendIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFA9D3B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white, size: 26),
      ),
    );
  }
}

/// 群聊图标 - 绿色背景，双人
class _GroupChatIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF57BE6A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.group, color: Colors.white, size: 26),
      ),
    );
  }
}

/// 标签图标 - 蓝色背景，标签
class _TagIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3E7FE1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(44, 44),
        painter: _TagPainter(),
      ),
    );
  }
}

class _TagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    // 标签形状
    final path = Path()
      ..moveTo(cx - 10, cy - 10)
      ..lineTo(cx + 6, cy - 10)
      ..lineTo(cx + 12, cy - 4)
      ..lineTo(cx + 12, cy + 12)
      ..lineTo(cx - 10, cy + 12)
      ..close();
    canvas.drawPath(path, paint);
    
    // 小圆孔
    paint.color = const Color(0xFF3E7FE1);
    canvas.drawCircle(Offset(cx - 4, cy - 4), 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 公众号图标 - 蓝色背景，文档
class _OfficialAccountIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF576B95),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(44, 44),
        painter: _OfficialAccountPainter(),
      ),
    );
  }
}

class _OfficialAccountPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    // 文档外框
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: 22, height: 26),
      const Radius.circular(2),
    );
    canvas.drawRRect(rect, paint);
    
    // 横线
    canvas.drawLine(Offset(cx - 6, cy - 6), Offset(cx + 6, cy - 6), paint);
    canvas.drawLine(Offset(cx - 6, cy), Offset(cx + 6, cy), paint);
    canvas.drawLine(Offset(cx - 6, cy + 6), Offset(cx + 2, cy + 6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 服务号图标 - 红色背景，信封
class _ServiceAccountIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE64340),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(44, 44),
        painter: _ServiceAccountPainter(),
      ),
    );
  }
}

class _ServiceAccountPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    // 信封外框
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: 24, height: 18),
      const Radius.circular(2),
    );
    canvas.drawRRect(rect, paint);
    
    // 信封V形
    final path = Path()
      ..moveTo(cx - 11, cy - 7)
      ..lineTo(cx, cy + 2)
      ..lineTo(cx + 11, cy - 7);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 企业微信联系人图标 - 蓝色背景，对话框
class _EnterpriseContactIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3E7FE1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(44, 44),
        painter: _EnterpriseContactPainter(),
      ),
    );
  }
}

class _EnterpriseContactPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final cx = size.width / 2;
    final cy = size.height / 2;
    
    // 左对话框
    final leftPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 14, cy - 9, 14, 12),
        const Radius.circular(3),
      ));
    canvas.drawPath(leftPath, paint);
    
    // 右对话框
    final rightPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 2, cy - 3, 12, 10),
        const Radius.circular(3),
      ));
    canvas.drawPath(rightPath, paint);
    
    // 箭头
    canvas.drawLine(Offset(cx - 6, cy + 3), Offset(cx - 6, cy + 9), paint);
    canvas.drawLine(Offset(cx + 6, cy + 7), Offset(cx + 6, cy + 11), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 微信风格字母索引条
class _WeChatIndexBar extends StatefulWidget {
  final List<String> letters;
  final ValueChanged<String> onLetterTap;

  const _WeChatIndexBar({
    required this.letters,
    required this.onLetterTap,
  });

  @override
  State<_WeChatIndexBar> createState() => _WeChatIndexBarState();
}

class _WeChatIndexBarState extends State<_WeChatIndexBar> {
  String? _currentLetter;
  bool _isDragging = false;

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
    _updateLetter(details.localPosition);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _updateLetter(details.localPosition);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      _currentLetter = null;
    });
  }

  void _updateLetter(Offset position) {
    if (widget.letters.isEmpty) return;

    final box = context.findRenderObject() as RenderBox;
    final itemHeight = box.size.height / widget.letters.length;
    final index = (position.dy / itemHeight).floor();

    if (index >= 0 && index < widget.letters.length) {
      final letter = widget.letters[index];
      if (letter != _currentLetter) {
        setState(() {
          _currentLetter = letter;
        });
        widget.onLetterTap(letter);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.letters.isEmpty) return const SizedBox.shrink();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 字母指示器气泡
        if (_isDragging && _currentLetter != null)
          Positioned(
            right: 40,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  _currentLetter!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        // 索引条
        GestureDetector(
          onVerticalDragStart: _onVerticalDragStart,
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          child: Container(
            width: 20,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: _isDragging
                  ? (isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.letters.map((letter) {
                final isActive = letter == _currentLetter;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onLetterTap(letter),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primary : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                          color: isActive
                              ? Colors.white
                              : (isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== 子页面组件 ====================

/// 新的朋友（好友请求）页面
class _FriendRequestsPage extends StatefulWidget {
  const _FriendRequestsPage();

  @override
  State<_FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<_FriendRequestsPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)?.newFriends ?? 'New Friends'),
        backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0.5,
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is! ContactLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final requests = state.friendRequests;

          if (requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add_disabled,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context)?.noFriendRequests ?? 'No friend requests',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: requests.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              indent: 72,
              color: isDark ? AppColors.dividerDark : AppColors.divider,
            ),
            itemBuilder: (context, index) {
              final request = requests[index];
              return _buildRequestItem(request, isDark);
            },
          );
        },
      ),
    );
  }
  
  Widget _buildRequestItem(FriendRequest request, bool isDark) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: _getColorFromName(request.userName),
        backgroundImage: request.userAvatarUrl != null && request.userAvatarUrl!.isNotEmpty
            ? NetworkImage(request.userAvatarUrl!)
            : null,
        child: request.userAvatarUrl == null || request.userAvatarUrl!.isEmpty
            ? Text(
                request.userName.isNotEmpty 
                    ? request.userName[0].toUpperCase() 
                    : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Text(
        request.userName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        request.userId,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.white54 : Colors.black54,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _acceptRequest(request),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(S.of(context)?.accept ?? 'Accept'),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => _rejectRequest(request),
            style: TextButton.styleFrom(
              backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
              foregroundColor: isDark ? Colors.white : Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(S.of(context)?.reject ?? 'Reject'),
          ),
        ],
      ),
    );
  }

  void _acceptRequest(FriendRequest request) {
    context.read<ContactBloc>().add(AcceptFriendRequest(request.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.acceptedFriendRequest(request.userName) ?? 'Accepted ${request.userName}\'s friend request'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectRequest(FriendRequest request) {
    context.read<ContactBloc>().add(RejectFriendRequest(request.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.rejectedFriendRequest(request.userName) ?? 'Rejected ${request.userName}\'s friend request'),
      ),
    );
  }
  
  Color _getColorFromName(String name) {
    final colors = [
      const Color(0xFF1AAD19),
      const Color(0xFF576B95),
      const Color(0xFFFA9D3B),
      const Color(0xFFE64340),
    ];
    if (name.isEmpty) return colors[0];
    final index = name.codeUnits.fold<int>(0, (sum, c) => sum + c) % colors.length;
    return colors[index];
  }
}

/// 群聊列表页面
class _GroupListPage extends StatelessWidget {
  const _GroupListPage();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)?.groupChat ?? 'Group Chat'),
        backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0.5,
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is! ContactLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.group,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context)?.noGroups ?? 'No groups',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context)?.createGroupInDevelopment ?? 'Create group feature in development...')),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: Text(S.of(context)?.createGroup ?? 'Create Group'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 推荐联系人选择弹窗
class _RecommendContactSheet extends StatefulWidget {
  final String excludeUserId;
  final bool isDark;
  
  const _RecommendContactSheet({
    required this.excludeUserId,
    required this.isDark,
  });
  
  @override
  State<_RecommendContactSheet> createState() => _RecommendContactSheetState();
}

class _RecommendContactSheetState extends State<_RecommendContactSheet> {
  String _searchQuery = '';
  List<ContactEntity> _contacts = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadContacts();
  }
  
  Future<void> _loadContacts() async {
    try {
      final contactRepository = getIt<IContactRepository>();
      final contacts = await contactRepository.getContacts();
      if (mounted) {
        setState(() {
          _contacts = contacts.where((c) => c.userId != widget.excludeUserId).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to load contacts: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  List<ContactEntity> get _filteredContacts {
    if (_searchQuery.isEmpty) return _contacts;
    return _contacts.where((c) => 
      c.effectiveDisplayName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      c.userId.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // 顶部标题栏
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.isDark ? Colors.white12 : Colors.black12,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  S.of(context)?.selectFriendToRecommend ?? 'Select friend to recommend',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: S.of(context)?.searchContacts ?? 'Search contacts',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: widget.isDark 
                    ? const Color(0xFF3A3A3C) 
                    : const Color(0xFFF2F2F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // 联系人列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredContacts.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context)?.noContactsFound ?? 'No contacts found',
                          style: TextStyle(
                            color: widget.isDark ? Colors.white54 : Colors.black54,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = _filteredContacts[index];
                          return ListTile(
                            leading: N42Avatar(
                              imageUrl: contact.avatarUrl,
                              name: contact.effectiveDisplayName,
                              size: 44,
                            ),
                            title: Text(
                              contact.effectiveDisplayName,
                              style: TextStyle(
                                color: widget.isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              contact.userId,
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                            onTap: () => Navigator.pop(context, contact),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
