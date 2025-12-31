import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/search_result_entity.dart';
import '../../blocs/search/search_bloc.dart';
import '../../blocs/search/search_event.dart';
import '../../blocs/search/search_state.dart';
import '../../widgets/common/common_widgets.dart';
import 'search_result_tile.dart';

/// 全局搜索页面
class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(const LoadSearchHistory());
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<SearchBloc>().add(PerformSearch(query));
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<SearchBloc>().add(const ClearSearch());
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          child: _buildSearchBar(isDark),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SearchLoaded) {
            return _buildSearchResults(state, isDark);
          }

          if (state is SearchError) {
            return Center(
              child: N42EmptyState(
                icon: Icons.error_outline,
                title: '搜索出错',
                description: state.message,
              ),
            );
          }

          // SearchInitial
          if (state is SearchInitial) {
            return _buildSearchHistory(state, isDark);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Row(
        children: [
          // 返回按钮
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: () => Navigator.pop(context),
          ),

          // 搜索框
          Expanded(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark : AppColors.background,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '搜索联系人、群聊、消息',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
                onChanged: _onSearch,
              ),
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildSearchHistory(SearchInitial state, bool isDark) {
    if (state.recentSearches.isEmpty) {
      return const Center(
        child: N42EmptyState(
          icon: Icons.search,
          title: '搜索联系人、群聊和消息',
          description: '输入关键词开始搜索',
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '搜索历史',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<SearchBloc>().add(const ClearSearchHistory());
              },
              child: const Text('清除'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: state.recentSearches.map((query) {
            return GestureDetector(
              onTap: () {
                _searchController.text = query;
                _onSearch(query);
              },
              child: Chip(
                label: Text(query),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  context.read<SearchBloc>().add(DeleteSearchHistoryItem(query));
                },
                backgroundColor:
                    isDark ? AppColors.surfaceDark : AppColors.surface,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults(SearchLoaded state, bool isDark) {
    if (state.results.isEmpty) {
      return Center(
        child: N42EmptyState.noSearchResult(
          description: '没有找到"${state.results.query}"相关的结果',
        ),
      );
    }

    return Column(
      children: [
        // 类型选择器
        _buildTypeSelector(state, isDark),

        // 结果列表
        Expanded(
          child: _buildResultList(state, isDark),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(SearchLoaded state, bool isDark) {
    return Container(
      height: 44,
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildTypeChip(
            '全部',
            SearchResultType.all,
            state.selectedType,
            state.results.totalCount,
            isDark,
          ),
          _buildTypeChip(
            '联系人',
            SearchResultType.contact,
            state.selectedType,
            state.results.contacts.length,
            isDark,
          ),
          _buildTypeChip(
            '群聊',
            SearchResultType.group,
            state.selectedType,
            state.results.groups.length,
            isDark,
          ),
          _buildTypeChip(
            '消息',
            SearchResultType.message,
            state.selectedType,
            state.results.messages.length,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(
    String label,
    SearchResultType type,
    SearchResultType selectedType,
    int count,
    bool isDark,
  ) {
    final isSelected = type == selectedType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: GestureDetector(
        onTap: () {
          context.read<SearchBloc>().add(ChangeSearchType(type));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.backgroundDark : AppColors.background),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : AppColors.textPrimary),
                ),
              ),
              if (count > 0) ...[
                const SizedBox(width: 4),
                Text(
                  '($count)',
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.8)
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultList(SearchLoaded state, bool isDark) {
    final results = state.filteredResults;

    if (results.isEmpty) {
      return const Center(
        child: N42EmptyState(
          icon: Icons.search_off,
          title: '无结果',
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return SearchResultTile(
          item: item,
          onTap: () => _onResultTap(item),
        );
      },
    );
  }

  void _onResultTap(SearchResultItem item) {
    switch (item.type) {
      case SearchResultType.contact:
        Navigator.of(context).pushNamed('/profile/${item.id}');
        break;
      case SearchResultType.group:
      case SearchResultType.conversation:
        Navigator.of(context).pushNamed('/chat/${item.roomId ?? item.id}');
        break;
      case SearchResultType.message:
        if (item.roomId != null) {
          Navigator.of(context).pushNamed(
            '/chat/${item.roomId}',
            arguments: {'highlightEventId': item.id},
          );
        }
        break;
      case SearchResultType.all:
        break;
    }
  }
}

