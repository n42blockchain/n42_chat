import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/storage_manager_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/common_widgets.dart';

/// 存储管理页面
class StorageManagementPage extends StatefulWidget {
  const StorageManagementPage({super.key});

  @override
  State<StorageManagementPage> createState() => _StorageManagementPageState();
}

class _StorageManagementPageState extends State<StorageManagementPage> {
  final StorageManagerService _storageService = GetIt.instance<StorageManagerService>();
  StorageInfo? _storageInfo;
  bool _isLoading = true;
  bool _isClearing = false;

  @override
  void initState() {
    super.initState();
    _loadStorageInfo();
  }

  Future<void> _loadStorageInfo() async {
    setState(() => _isLoading = true);
    try {
      final info = await _storageService.getStorageUsage();
      if (mounted) {
        setState(() {
          _storageInfo = info;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _clearCache() async {
    setState(() => _isClearing = true);
    try {
      await _storageService.clearCache();
      await _loadStorageInfo();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.cacheCleared ?? 'Cache cleared'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.clearCacheFailed ?? 'Failed to clear cache'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isClearing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        title: Text(
          S.of(context)?.storageManagement ?? 'Storage',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: N42Loading())
          : _buildContent(isDark),
    );
  }

  Widget _buildContent(bool isDark) {
    final info = _storageInfo;
    if (info == null) return const SizedBox.shrink();

    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return ListView(
      children: [
        // 总用量
        Container(
          color: cardColor,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                info.formattedTotal,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                S.of(context)?.totalUsage ?? 'Total Usage',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // 分类详情
        Container(
          color: cardColor,
          child: Column(
            children: [
              _buildStorageItem(
                icon: Icons.photo_library,
                color: Colors.blue,
                title: S.of(context)?.mediaFiles ?? 'Media',
                size: info.formattedMedia,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
              Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
              _buildStorageItem(
                icon: Icons.insert_drive_file,
                color: Colors.orange,
                title: S.of(context)?.files ?? 'Files',
                size: info.formattedFile,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
              Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
              _buildStorageItem(
                icon: Icons.cached,
                color: Colors.green,
                title: S.of(context)?.cache ?? 'Cache',
                size: info.formattedCache,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
              Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
              _buildStorageItem(
                icon: Icons.more_horiz,
                color: Colors.grey,
                title: S.of(context)?.other ?? 'Other',
                size: info.formattedOther,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // 清理按钮
        Container(
          color: cardColor,
          child: ListTile(
            leading: const Icon(Icons.cleaning_services, color: AppColors.primary),
            title: Text(
              S.of(context)?.clearCache ?? 'Clear Cache',
              style: TextStyle(color: textColor),
            ),
            subtitle: Text(
              info.formattedCache,
              style: TextStyle(color: secondaryColor, fontSize: 12),
            ),
            trailing: _isClearing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_right),
            onTap: _isClearing ? null : () => _confirmClearCache(),
          ),
        ),
      ],
    );
  }

  Widget _buildStorageItem({
    required IconData icon,
    required Color color,
    required String title,
    required String size,
    required Color textColor,
    required Color secondaryColor,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: TextStyle(color: textColor, fontSize: 15)),
      trailing: Text(size, style: TextStyle(color: secondaryColor, fontSize: 14)),
    );
  }

  void _confirmClearCache() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.clearCache ?? 'Clear Cache'),
        content: Text(S.of(context)?.confirmClearCache ?? 'Are you sure you want to clear cache?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _clearCache();
            },
            child: Text(S.of(context)?.commonConfirm ?? 'OK'),
          ),
        ],
      ),
    );
  }
}
