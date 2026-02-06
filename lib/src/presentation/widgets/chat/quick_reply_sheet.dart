import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../domain/entities/quick_reply_entity.dart';

/// 快捷回复选择弹窗
class QuickReplySheet extends StatefulWidget {
  /// 选择回复后的回调
  final void Function(String content) onSelect;

  /// 跳转到管理页面的回调
  final VoidCallback? onManage;

  /// 安全存储数据源
  final SecureStorageDataSource storageDataSource;

  const QuickReplySheet({
    super.key,
    required this.onSelect,
    this.onManage,
    required this.storageDataSource,
  });

  @override
  State<QuickReplySheet> createState() => _QuickReplySheetState();
}

class _QuickReplySheetState extends State<QuickReplySheet> {
  List<QuickReplyEntity> _replies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReplies();
  }

  Future<void> _loadReplies() async {
    try {
      final data = await widget.storageDataSource.getQuickReplies();
      setState(() {
        _replies = data.map((e) => QuickReplyEntity.fromJson(e)).toList();
        // 按使用频率和顺序排序
        _replies.sort((a, b) {
          // 最近使用的排前面
          if (a.lastUsed != null && b.lastUsed != null) {
            return b.lastUsed!.compareTo(a.lastUsed!);
          }
          if (a.lastUsed != null) return -1;
          if (b.lastUsed != null) return 1;
          // 然后按顺序
          return a.order.compareTo(b.order);
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _replies = QuickReplyEntity.createDefaultReplies();
        _isLoading = false;
      });
    }
  }

  void _onSelectReply(QuickReplyEntity reply) {
    // 更新最后使用时间
    widget.storageDataSource.updateQuickReplyLastUsed(reply.id);
    // 关闭弹窗
    Navigator.pop(context);
    // 回调
    widget.onSelect(reply.content);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖动指示器
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 标题栏
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n?.quickReply ?? 'Quick Reply',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                if (widget.onManage != null)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onManage?.call();
                    },
                    child: Text(
                      l10n?.manageQuickReplies ?? 'Manage',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 快捷回复列表
          Flexible(
            child: _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _replies.isEmpty
                    ? _buildEmptyState(isDark, l10n)
                    : _buildReplyList(isDark),
          ),

          // 底部安全区域
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, S? l10n) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flash_on_outlined,
            size: 48,
            color: isDark ? Colors.white38 : Colors.black26,
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.noQuickReplies ?? 'No quick replies',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyList(bool isDark) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _replies.length,
      itemBuilder: (context, index) {
        final reply = _replies[index];
        return _buildReplyItem(reply, isDark);
      },
    );
  }

  Widget _buildReplyItem(QuickReplyEntity reply, bool isDark) {
    return InkWell(
      onTap: () => _onSelectReply(reply),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                reply.content,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            if (reply.isSystem)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Default',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 显示快捷回复弹窗
Future<void> showQuickReplySheet({
  required BuildContext context,
  required void Function(String content) onSelect,
  VoidCallback? onManage,
  required SecureStorageDataSource storageDataSource,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => QuickReplySheet(
      onSelect: onSelect,
      onManage: onManage,
      storageDataSource: storageDataSource,
    ),
  );
}
