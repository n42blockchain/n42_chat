import 'sticker_subscriptions_page.dart';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../widgets/chat/sticker_thumb.dart';
import 'sticker_import_page.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/ai_sticker_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../../domain/repositories/sticker_repository.dart';
import 'ai_sticker_generate_page.dart';
import 'custom_sticker_pack_page.dart';
import '../../../core/theme/app_dimensions.dart';

/// 贴纸商店页面
class StickerStorePage extends StatefulWidget {
  const StickerStorePage({super.key});

  @override
  State<StickerStorePage> createState() => _StickerStorePageState();
}

class _StickerStorePageState extends State<StickerStorePage>
    with SingleTickerProviderStateMixin {
  late final IStickerRepository _repository;
  late final TabController _tabController;

  List<StickerCategory> _categories = [];
  List<StickerPack> _installedPacks = [];
  List<StickerPack> _storePacks = [];
  String? _selectedCategory;
  bool _isLoading = true;

  /// Packs with an install request in flight (blocks double taps).
  final Set<String> _installingIds = {};

  @override
  void initState() {
    super.initState();
    _repository = getIt<IStickerRepository>();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final categories = await _repository.getCategories();
      final installed = await _repository.getInstalledPacks();
      final store = await _repository.getStorePacks();

      if (!mounted) return;
      setState(() {
        _categories = categories;
        _installedPacks = installed;
        _storePacks = store;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _openImport() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => const StickerImportPage()),
    );
    if (mounted) await _loadData();
  }

  Future<void> _openAiGenerate() async {
    final added = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => const AiStickerGeneratePage()),
    );
    if (added == true && mounted) {
      await _loadData(); // 新 AI 贴纸入「My Stickers」后刷新
    }
  }

  /// 新建自定义贴纸包（输入名称 → 创建 → 进入管理页上传贴纸）。
  Future<void> _createPack() async {
    final controller = TextEditingController();
    final s = S.of(context);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.ui3StickerNewPack ?? 'New sticker pack'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: s?.ui3StickerPackName ?? 'Pack name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(s?.ui3StickerCreate ?? 'Create'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || !mounted) return;
    final pack = await _repository.createCustomPack(name: name);
    if (!mounted) return;
    if (pack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.ui3StickerCreateFailed ?? 'Failed to create pack',
          ),
        ),
      );
      return;
    }
    await _openCustomPack(pack.id);
  }

  /// 打开自定义包管理页；返回后刷新（贴纸增删/删包都会反映）。
  Future<void> _openCustomPack(String packId) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => CustomStickerPackPage(packId: packId),
      ),
    );
    if (mounted) await _loadData();
  }

  Future<void> _installPack(StickerPack pack) async {
    if (_installingIds.contains(pack.id)) return;
    setState(() => _installingIds.add(pack.id));
    final bool success;
    try {
      success = await _repository.installPack(pack.id);
    } finally {
      if (mounted) setState(() => _installingIds.remove(pack.id));
    }
    if (!mounted) return;
    if (success) {
      setState(() {
        _installedPacks.add(pack.copyWith(isInstalled: true));
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context)?.ui3StickerInstalled(pack.name) ??
                  'Installed "${pack.name}"',
            ),
          ),
        );
      }
    }
  }

  Future<void> _uninstallPack(StickerPack pack) async {
    final s = S.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.ui3StickerRemovePackTitle ?? 'Remove Sticker Pack'),
        content: Text(
          s?.ui3StickerRemovePackConfirm(pack.name) ??
              'Remove "${pack.name}" from your stickers?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              s?.commonRemove ?? 'Remove',
              style: TextStyle(
                color: ChatContrast.onTint(
                  AppColors.error,
                  [Theme.of(ctx).colorScheme.surface],
                  dark: Theme.of(ctx).brightness == Brightness.dark,
                  alpha: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await _repository.uninstallPack(pack.id);
    if (!mounted) return;
    if (success) {
      setState(() {
        _installedPacks.removeWhere((p) => p.id == pack.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context)?.ui3StickerRemoved(pack.name) ??
                  'Removed "${pack.name}"',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: Text(
          S.of(context)?.profileStickers ?? 'Stickers',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: context.surfaceColor,
        actions: [
          IconButton(
            key: const ValueKey('sticker_store_subscriptions'),
            tooltip:
                S.of(context)?.stickerSubscriptions ?? 'Sticker subscriptions',
            icon: const Icon(Icons.sync),
            onPressed: () async {
              await Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => const StickerSubscriptionsPage(),
                ),
              );
              if (mounted) await _loadData();
            },
          ),
          IconButton(
            key: const ValueKey('sticker_store_import'),
            tooltip: S.of(context)?.stickerImportTitle ?? 'Import sticker pack',
            icon: const Icon(Icons.file_download_outlined),
            onPressed: _openImport,
          ),
          IconButton(
            tooltip: S.of(context)?.ui3StickerNewPack ?? 'New sticker pack',
            icon: const Icon(Icons.create_new_folder_outlined),
            onPressed: _createPack,
          ),
          if (getIt<AiStickerService>().isAvailable)
            IconButton(
              tooltip: S.of(context)?.ui3StickerAiSticker ?? 'AI Sticker',
              icon: const Icon(Icons.auto_awesome),
              onPressed: _openAiGenerate,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryOnTintOf(context),
          unselectedLabelColor: context.textSecondary,
          indicatorColor: AppColors.primaryOf(context),
          tabs: [
            Tab(text: S.of(context)?.ui3StickerStoreTab ?? 'Store'),
            Tab(text: S.of(context)?.ui3StickerMyStickersTab ?? 'My Stickers'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildStoreTab(isDark), _buildMyStickersTab(isDark)],
            ),
    );
  }

  Widget _buildStoreTab(bool isDark) {
    return Column(
      children: [
        // 分类标签
        _buildCategoryTabs(isDark),

        // 贴纸包列表
        Expanded(child: _buildStoreList(isDark)),
      ],
    );
  }

  Widget _buildCategoryTabs(bool isDark) {
    return Container(
      height: 44,
      color: context.surfaceColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingS),
        itemCount: _categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCategoryChip(
              S.of(context)?.commonAll ?? 'All',
              '🌟',
              _selectedCategory == null,
              () => setState(() => _selectedCategory = null),
              isDark,
            );
          }

          final category = _categories[index - 1];
          return _buildCategoryChip(
            category.name,
            category.icon ?? '📦',
            _selectedCategory == category.id,
            () => setState(() => _selectedCategory = category.id),
            isDark,
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    String icon,
    bool isSelected,
    VoidCallback onTap,
    bool isDark,
  ) {
    // The 6pt vertical padding is inside the tap target so the whole 44pt bar
    // height is hittable; transparent Material keeps the ripple visible.
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXS,
            vertical: 6,
          ),
          // Ink paints the chip fill on the Material so the ripple shows.
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingM,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryOf(context).withValues(alpha: 0.1)
                  : AppColors.inputBgOf(isDark),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              border: isSelected
                  ? Border.all(color: AppColors.primaryOf(context))
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(icon, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: AppDimensions.spacingXS),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: isSelected
                        ? AppColors.primaryOnTintOf(context)
                        : context.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreList(bool isDark) {
    final filteredPacks = _storePacks.where((pack) {
      if (_selectedCategory == null) return true;
      switch (_selectedCategory) {
        case 'popular':
        case 'new':
          return true;
        case 'animals':
          return pack.id.contains('animal');
        case 'emotions':
          return pack.id.contains('emotion');
        case 'food':
          return pack.id.contains('food');
        case 'celebration':
          return pack.id.contains('celebration');
        default:
          return false;
      }
    }).toList();

    if (filteredPacks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              size: 64,
              color: AppColors.textTertiaryOf(isDark),
            ),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              S.of(context)?.ui3StickerNoneFound ?? 'No stickers found',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.3, color: context.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      itemCount: filteredPacks.length,
      itemBuilder: (context, index) {
        final pack = filteredPacks[index];
        final isInstalled = _installedPacks.any((p) => p.id == pack.id);
        return _buildPackCard(pack, isInstalled, isDark);
      },
    );
  }

  Widget _buildPackCard(StickerPack pack, bool isInstalled, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXS),
      color: context.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头部信息
            Row(
              children: [
                // 贴纸包图标
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.placeholderOf(isDark),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Center(
                    child: pack.stickers.isNotEmpty
                        ? Text(
                            pack.stickers.first.emoji ?? '📦',
                            style: const TextStyle(fontSize: 28),
                          )
                        : const Icon(Icons.emoji_emotions),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingM),

                // 名称和描述
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              pack.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                                color: AppColors.textPrimaryOf(isDark),
                              ),
                            ),
                          ),
                          if (pack.isOfficial) ...[
                            const SizedBox(width: AppDimensions.spacingXS),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: AppColors.primaryOf(context),
                            ),
                          ],
                        ],
                      ),
                      if (pack.author != null)
                        Text(
                          S.of(context)?.ui3StickerByAuthor(pack.author!) ??
                              'by ${pack.author}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.3,
                            color: context.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),

                // 自定义包：管理（增删贴纸/改名/删包）
                if (pack.source == StickerPackSource.custom)
                  OutlinedButton(
                    onPressed: () => _openCustomPack(pack.id),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryOnTintOf(context),
                      side: BorderSide(color: AppColors.primaryOf(context)),
                    ),
                    child: Text(S.of(context)?.ui3StickerManage ?? 'Manage'),
                  )
                // 安装/已安装按钮
                else if (isInstalled)
                  OutlinedButton(
                    onPressed: () => _uninstallPack(pack),
                    style: OutlinedButton.styleFrom(
                      // Colors.grey label was 2.7:1 on the card.
                      foregroundColor: context.textSupporting,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: Text(S.of(context)?.commonRemove ?? 'Remove'),
                  )
                else
                  ElevatedButton(
                    onPressed: _installingIds.contains(pack.id)
                        ? null
                        : () => _installPack(pack),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryFillOf(context),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(S.of(context)?.commonAdd ?? 'Add'),
                  ),
              ],
            ),

            const SizedBox(height: AppDimensions.spacingM),

            // 贴纸预览
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pack.previewStickers.length,
                itemBuilder: (context, index) {
                  final sticker = pack.previewStickers[index];
                  return Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(
                      right: AppDimensions.spacingS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.placeholderOf(isDark),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    child: StickerThumb(sticker: sticker),
                  );
                },
              ),
            ),

            // 统计信息
            Row(
              children: [
                if (pack.downloadCount > 0) ...[
                  Icon(Icons.download, size: 14, color: context.textSecondary),
                  const SizedBox(width: AppDimensions.spacingXS),
                  Text(
                    '${pack.downloadCount}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: context.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing),
                ],
                Icon(
                  Icons.emoji_emotions_outlined,
                  size: 14,
                  color: context.textSecondary,
                ),
                const SizedBox(width: AppDimensions.spacingXS),
                Text(
                  S.of(context)?.ui3StickerCount(pack.stickerCount) ??
                      '${pack.stickerCount} stickers',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: context.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyStickersTab(bool isDark) {
    if (_installedPacks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              size: 64,
              color: AppColors.textTertiaryOf(isDark),
            ),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              S.of(context)?.ui3StickerNoneInstalled ??
                  'No stickers installed',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              S.of(context)?.ui3StickerGetFromStore ??
                  'Get stickers from the store',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingXL),
            ElevatedButton.icon(
              onPressed: () => _tabController.animateTo(0),
              icon: const Icon(Icons.store),
              label: Text(
                S.of(context)?.ui3StickerBrowseStore ?? 'Browse Store',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryFillOf(context),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      itemCount: _installedPacks.length,
      itemBuilder: (context, index) {
        final pack = _installedPacks[index];
        return _buildPackCard(pack, true, isDark);
      },
    );
  }
}
