import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../widgets/common/common_widgets.dart';
import 'phone_contacts_page.dart';

/// 添加好友页面
class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  bool _isSearching = false;
  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _searchUser() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _searchResults = [];
    });

    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client == null) {
        setState(() {
          _errorMessage = S.of(context)?.commonChatServiceNotConnected ?? 'Chat service not connected';
          _isLoading = false;
        });
        return;
      }

      final List<Map<String, dynamic>> results = [];
      
      // 检查是否是完整的 Matrix ID 格式 (@user:server)
      if (query.startsWith('@') && query.contains(':')) {
        // 直接尝试获取该用户的资料
        try {
          final profile = await client.getProfileFromUserId(query);
          final localpart = query.split(':').first.replaceFirst('@', '');
          results.add({
            'userId': query,
            'displayName': profile.displayName ?? localpart,
            'avatarUrl': profile.avatarUrl?.toString(),
          });
        } catch (e) {
          debugPrint('Failed to get profile for $query: $e');
        }
      } else {
        // 构建可能的 Matrix ID
        final homeserver = client.homeserver?.host ?? '';
        String fullUserId = query;
        
        // 如果输入不包含 @，添加 @
        if (!query.startsWith('@')) {
          fullUserId = '@$query';
        }
        
        // 如果不包含 :server，添加当前服务器
        if (!fullUserId.contains(':') && homeserver.isNotEmpty) {
          fullUserId = '$fullUserId:$homeserver';
        }
        
        // 尝试直接获取用户资料
        if (fullUserId.contains(':')) {
          try {
            final profile = await client.getProfileFromUserId(fullUserId);
            final localpart = fullUserId.split(':').first.replaceFirst('@', '');
            results.add({
              'userId': fullUserId,
              'displayName': profile.displayName ?? localpart,
              'avatarUrl': profile.avatarUrl?.toString(),
            });
          } catch (e) {
            debugPrint('Failed to get profile for $fullUserId: $e');
          }
        }
        
        // 同时搜索用户目录
        try {
          final response = await client.searchUserDirectory(query, limit: 20);
          
          for (final user in response.results) {
            // 避免重复添加
            final exists = results.any((r) => r['userId'] == user.userId);
            if (!exists) {
              final localpart = user.userId.split(':').first.replaceFirst('@', '');
              results.add({
                'userId': user.userId,
                'displayName': user.displayName ?? localpart,
                'avatarUrl': user.avatarUrl?.toString(),
              });
            }
          }
        } catch (e) {
          debugPrint('Search user directory failed: $e');
        }
      }
      
      setState(() {
        _searchResults = results;
        _isLoading = false;
        _isSearching = true;
        if (results.isEmpty) {
          _errorMessage = S.of(context)?.contactUserNotFoundHint(query) ?? 'User "$query" not found\n\nTips:\n• Try entering full user ID, e.g. @username:server.com\n• Check the username spelling';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = S.of(context)?.contactSearchFailed(e.toString()) ?? 'Search failed: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _startDirectChat(String userId) async {
    setState(() => _isLoading = true);

    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client == null) {
        _showError(S.of(context)?.commonChatServiceNotConnected ?? 'Chat service not connected');
        return;
      }

      // 创建或获取私聊房间
      final roomId = await client.startDirectChat(userId);
      
      if (mounted) {
        Navigator.of(context).pop(roomId);
      }
    } catch (e) {
      if (!mounted) return;
      _showError(S.of(context)?.contactCreateChatFailed(e.toString()) ?? 'Failed to create chat: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _openPhoneContacts() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const PhoneContactsPage(),
      ),
    );

    // 如果从通讯录页面返回了房间 ID，关闭当前页面并返回
    if (result != null && mounted) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.commonAddFriend ?? 'Add Friend',
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 搜索栏
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context)?.contactEnterUserIdOrUsername ?? 'Enter user ID or username to search',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.backgroundDark : AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: S.of(context)?.commonMatrixIdHint ?? '@username:server.com',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                          onSubmitted: (_) => _searchUser(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _searchUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(72, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(S.of(context)?.commonSearch ?? 'Search'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 从通讯录导入选项
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            margin: const EdgeInsets.only(top: 8),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.contacts,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              title: Text(
                'From Contacts',
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'Find friends from your phone contacts',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
              onTap: () => _openPhoneContacts(),
            ),
          ),

          // 错误信息
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.error.withValues(alpha: 0.1),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: AppColors.error, fontSize: 13),
              ),
            ),

          // 搜索结果
          Expanded(
            child: _buildContent(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    if (_isLoading) {
      return N42Loading(message: S.of(context)?.contactSearching ?? 'Searching...');
    }

    if (!_isSearching) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search,
              size: 64,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context)?.contactSearchUserToChat ?? 'Search user to start chatting',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context)?.contactMatrixIdExample ?? 'You can enter a full Matrix ID\ne.g. @user:matrix.n42.network',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.7) : AppColors.textSecondary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return N42EmptyState.noSearchResult(
        description: S.of(context)?.contactUserNotFound(_searchController.text) ?? 'User "${_searchController.text}" not found',
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return _buildUserTile(user, isDark);
      },
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user, bool isDark) {
    final displayName = user['displayName'] as String? ?? '';
    final userId = user['userId'] as String;
    final avatarUrl = user['avatarUrl'] as String?;

    return ListTile(
      leading: N42Avatar(
        imageUrl: avatarUrl,
        name: displayName.isNotEmpty ? displayName : userId,
        size: 48,
      ),
      title: Text(
        displayName.isNotEmpty ? displayName : userId.split(':').first.replaceFirst('@', ''),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        userId,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
      trailing: OutlinedButton(
        onPressed: () => _startDirectChat(userId),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(S.of(context)?.commonChat ?? 'Chat'),
      ),
    );
  }
}

