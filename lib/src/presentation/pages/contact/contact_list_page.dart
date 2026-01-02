import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/common_widgets.dart';
import 'contact_tile.dart';
import 'contact_index_bar.dart';

/// 通讯录页面
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

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: widget.showAppBar ? N42AppBar(
        title: '通讯录',
        actions: [
          IconButton(
            icon: Icon(
              _isSearchMode ? Icons.close : Icons.search,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: _toggleSearchMode,
          ),
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
          // 搜索栏
          if (_isSearchMode)
            Container(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: N42SearchBar(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      hintText: '搜索联系人',
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _onGlobalSearch,
                    child: const Text('全局搜索'),
                  ),
                ],
              ),
            ),

          // 联系人列表
          Expanded(
            child: BlocConsumer<ContactBloc, ContactState>(
              listener: (context, state) {
                if (state is ChatStarted) {
                  // 导航到聊天页面
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
                    title: '加载失败',
                    description: state.message,
                    buttonText: '重试',
                    onButtonPressed: () {
                      context.read<ContactBloc>().add(const LoadContacts());
                    },
                  );
                }

                if (state is ContactLoaded) {
                  return _buildContactList(state, isDark);
                }

                return const N42EmptyState(
                  icon: Icons.contacts_outlined,
                  title: '暂无联系人',
                  description: '添加好友开始聊天',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(ContactLoaded state, bool isDark) {
    // 搜索模式
    if (state.searchQuery.isNotEmpty) {
      return _buildSearchResults(state, isDark);
    }

    // 普通列表模式
    if (state.contacts.isEmpty) {
      return const N42EmptyState(
        icon: Icons.contacts_outlined,
        title: '暂无联系人',
        description: '添加好友开始聊天',
      );
    }

    // 准备索引字母的GlobalKey
    _letterKeys.clear();
    for (final letter in state.indexLetters) {
      _letterKeys[letter] = GlobalKey();
    }

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
                      return ContactTile(
                        contact: contacts[index],
                        onTap: () => _onContactTap(contacts[index]),
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
          top: 100,
          bottom: 50,
          child: ContactIndexBar(
            letters: state.indexLetters,
            onLetterTap: _onLetterTap,
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
      return const N42EmptyState(
        icon: Icons.search_off,
        title: '未找到联系人',
        description: '尝试搜索其他关键词或全局搜索',
      );
    }

    return ListView(
      children: [
        // 本地搜索结果
        if (localResults.isNotEmpty) ...[
          _buildSectionHeader('联系人', isDark),
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
          _buildSectionHeader('搜索结果', isDark),
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
    return Column(
      children: [
        // 新朋友（好友请求）
        ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person_add, color: Colors.white),
          ),
          title: const Text('新的朋友'),
          trailing: state.friendRequests.isNotEmpty
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${state.friendRequests.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : null,
          onTap: _showFriendRequestsPage,
        ),

        // 群聊
        ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.group, color: Colors.white),
          ),
          title: const Text('群聊'),
          onTap: _showGroupsPage,
        ),

        Divider(
          height: 1,
          color: isDark ? AppColors.dividerDark : AppColors.divider,
        ),
      ],
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
        '$count位联系人',
        style: TextStyle(
          fontSize: 14,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  void _onContactTap(ContactEntity contact) {
    // 导航到用户资料页
    Navigator.of(context).pushNamed('/profile/${contact.userId}');
  }

  void _showAddContactDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加联系人'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: '输入用户ID',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.pop(context);
                  context.read<ContactBloc>().add(StartChat(value));
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 扫码添加
              Navigator.pop(context);
            },
            child: const Text('扫一扫'),
          ),
        ],
      ),
    );
  }

  void _showFriendRequestsPage() {
    // TODO: 导航到好友请求页面
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('好友请求页面开发中...')),
    );
  }

  void _showGroupsPage() {
    // TODO: 导航到群聊列表页面
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('群聊页面开发中...')),
    );
  }
}

