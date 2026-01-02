import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../widgets/common/common_widgets.dart';

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
          _errorMessage = '聊天服务未连接';
          _isLoading = false;
        });
        return;
      }

      // 搜索用户
      final response = await client.searchUserDirectory(query, limit: 20);
      
      final results = response.results.map((user) {
        // userId 格式: @username:server.com，提取 localpart
        final localpart = user.userId.split(':').first.replaceFirst('@', '');
        return <String, dynamic>{
          'userId': user.userId,
          'displayName': user.displayName ?? localpart,
          'avatarUrl': user.avatarUrl?.toString(),
        };
      }).toList();
      
      setState(() {
        _searchResults = results;
        _isLoading = false;
        _isSearching = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '搜索失败: $e';
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
        _showError('聊天服务未连接');
        return;
      }

      // 创建或获取私聊房间
      final roomId = await client.startDirectChat(userId);
      
      if (mounted) {
        Navigator.of(context).pop(roomId);
      }
    } catch (e) {
      _showError('创建会话失败: $e');
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '添加好友',
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
                  '输入用户 ID 或用户名搜索',
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
                            hintText: '@username:matrix.n42.network',
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
                          : const Text('搜索'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 错误信息
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.error.withOpacity(0.1),
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
      return const N42Loading(message: '搜索中...');
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
              '搜索用户开始聊天',
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '可以输入完整的 Matrix ID\n例如: @user:matrix.n42.network',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark.withOpacity(0.7) : AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return N42EmptyState.noSearchResult(
        description: '未找到用户 "${_searchController.text}"',
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
        child: const Text('聊天'),
      ),
    );
  }
}

