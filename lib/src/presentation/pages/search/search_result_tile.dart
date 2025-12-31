import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_utils.dart' as chat_date;
import '../../../domain/entities/search_result_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 搜索结果列表项
class SearchResultTile extends StatelessWidget {
  final SearchResultItem item;
  final VoidCallback? onTap;

  const SearchResultTile({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // 头像
              _buildAvatar(),

              const SizedBox(width: 12),

              // 内容
              Expanded(
                child: _buildContent(isDark),
              ),

              // 时间/类型标签
              _buildTrailing(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    IconData? icon;
    Color? iconBgColor;

    switch (item.type) {
      case SearchResultType.contact:
        break;
      case SearchResultType.group:
        icon = Icons.group;
        iconBgColor = AppColors.primary;
        break;
      case SearchResultType.message:
        icon = Icons.chat_bubble_outline;
        iconBgColor = Colors.orange;
        break;
      default:
        break;
    }

    if (icon != null && item.avatarUrl == null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      );
    }

    return N42Avatar(
      imageUrl: item.avatarUrl,
      name: item.title,
      size: 48,
    );
  }

  Widget _buildContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题（带高亮）
        _buildHighlightedText(
          item.title,
          item.matchedKeyword,
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 4),

        // 内容（消息搜索）或副标题
        if (item.type == SearchResultType.message && item.matchedContent != null)
          _buildHighlightedText(
            item.matchedContent!,
            item.matchedKeyword,
            TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            maxLines: 2,
          )
        else if (item.subtitle != null)
          Text(
            item.subtitle!,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildHighlightedText(
    String text,
    String? keyword,
    TextStyle style, {
    int maxLines = 1,
  }) {
    if (keyword == null || keyword.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    final spans = <TextSpan>[];
    var currentIndex = 0;

    while (true) {
      final matchIndex = lowerText.indexOf(lowerKeyword, currentIndex);
      if (matchIndex == -1) {
        // 添加剩余文本
        if (currentIndex < text.length) {
          spans.add(TextSpan(text: text.substring(currentIndex)));
        }
        break;
      }

      // 添加匹配前的文本
      if (matchIndex > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, matchIndex)));
      }

      // 添加高亮文本
      spans.add(TextSpan(
        text: text.substring(matchIndex, matchIndex + keyword.length),
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ));

      currentIndex = matchIndex + keyword.length;
    }

    return RichText(
      text: TextSpan(style: style, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 时间
        if (item.timestamp != null)
          Text(
            chat_date.N42DateUtils.formatConversationTime(item.timestamp!),
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),

        const SizedBox(height: 4),

        // 类型标签
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getTypeColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _getTypeLabel(),
            style: TextStyle(
              fontSize: 10,
              color: _getTypeColor(),
            ),
          ),
        ),
      ],
    );
  }

  String _getTypeLabel() {
    switch (item.type) {
      case SearchResultType.contact:
        return '联系人';
      case SearchResultType.group:
        return '群聊';
      case SearchResultType.conversation:
        return '会话';
      case SearchResultType.message:
        return '消息';
      case SearchResultType.all:
        return '';
    }
  }

  Color _getTypeColor() {
    switch (item.type) {
      case SearchResultType.contact:
        return Colors.blue;
      case SearchResultType.group:
        return AppColors.primary;
      case SearchResultType.conversation:
        return Colors.purple;
      case SearchResultType.message:
        return Colors.orange;
      case SearchResultType.all:
        return Colors.grey;
    }
  }
}

