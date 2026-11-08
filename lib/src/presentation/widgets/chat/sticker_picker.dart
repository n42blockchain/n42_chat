import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import 'video_sticker_view.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/a11y_l10n.dart';
import '../../../core/utils/matrix_utils.dart' as mx_utils;
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../data/datasources/bundled_sticker_packs.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../../domain/repositories/sticker_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../core/theme/app_dimensions.dart';

/// 贴纸选择回调
typedef StickerSelectedCallback = void Function(Sticker sticker, String packId);
typedef StickerLongPressedCallback = Future<void> Function(
  Sticker sticker,
  String packId,
);

/// 贴纸选择器面板
///
/// 微信风格的贴纸选择器：
/// - 顶部显示贴纸包标签
/// - 主区域显示当前选中贴纸包的贴纸
/// - 支持常用贴纸
class StickerPicker extends StatefulWidget {
  /// 选择贴纸回调
  final StickerSelectedCallback onStickerSelected;

  /// 长按贴纸回调
  final StickerLongPressedCallback? onStickerLongPressed;

  /// 打开贴纸商店回调
  final VoidCallback? onOpenStore;

  /// 面板高度
  final double height;

  const StickerPicker({
    super.key,
    required this.onStickerSelected,
    this.onStickerLongPressed,
    this.onOpenStore,
    this.height = 260,
  });

  @override
  State<StickerPicker> createState() => _StickerPickerState();
}

class _StickerPickerState extends State<StickerPicker> {
  late final IStickerRepository _repository;
  StreamSubscription<List<StickerPack>>? _packSubscription;
  StreamSubscription<void>? _sessionChanges;
  StreamSubscription<AuthSessionInvalidation>? _invalidations;
  int _loadEpoch = 0;
  Object? _viewScope;
  final TextEditingController _searchController = TextEditingController();

  List<StickerPack> _packs = [];
  List<RecentSticker> _recentStickers = [];
  int _selectedPackIndex = 0;
  bool _isLoading = true;

  String _searchQuery = '';
  List<StickerHit> _searchResults = const [];
  int _searchToken = 0;

  @override
  void initState() {
    super.initState();
    _repository = getIt<IStickerRepository>();
    _packSubscription = _repository.watchInstalledPacks().listen(
      _onPacksChanged,
      onError: (Object error, StackTrace stack) {
        if (mounted) setState(() => _isLoading = false);
      },
    );
    if (getIt.isRegistered<IAuthRepository>()) {
      final auth = getIt<IAuthRepository>();
      if (auth is IAccountBoundSessionChanges) {
        _sessionChanges = (auth as IAccountBoundSessionChanges)
            .accountSessionChanges
            .listen((_) => _onAccountChanged());
      }
      if (auth is IAccountBoundAuthInvalidation) {
        _invalidations = (auth as IAccountBoundAuthInvalidation)
            .accountInvalidationStream
            .listen((_) => _onAccountChanged());
      }
    }
    unawaited(_loadStickers());
  }

  @override
  void dispose() {
    _loadEpoch++;
    unawaited(_packSubscription?.cancel());
    unawaited(_sessionChanges?.cancel());
    unawaited(_invalidations?.cancel());
    _searchController.dispose();
    super.dispose();
  }

  Object? _accountScope() {
    if (!getIt.isRegistered<IStickerRepository>() ||
        !identical(getIt<IStickerRepository>(), _repository)) {
      return null;
    }
    if (getIt.isRegistered<IAuthRepository>()) {
      final auth = getIt<IAuthRepository>();
      if (auth is IAccountBoundDeletionLifecycle) {
        final generation =
            (auth as IAccountBoundDeletionLifecycle).currentAccountGeneration;
        if (generation == null || !generation.isCurrent) return null;
        return (auth, generation);
      }
    }
    return _repository;
  }

  void _onAccountChanged() {
    if (!mounted || _accountScope() == _viewScope) return;
    _loadEpoch++;
    _searchToken++;
    _searchController.clear();
    setState(() {
      _viewScope = null;
      _packs = [];
      _recentStickers = [];
      _searchResults = [];
      _searchQuery = '';
      _selectedPackIndex = 0;
      _isLoading = false;
    });
    if (_accountScope() != null) unawaited(_loadStickers());
  }

  void _onPacksChanged(List<StickerPack> packs) {
    if (!mounted) return;
    final scope = _accountScope();
    final sameAccount = scope != null && scope == _viewScope;
    final selectedId =
        sameAccount &&
            _selectedPackIndex >= 0 &&
            _selectedPackIndex < _packs.length
        ? _packs[_selectedPackIndex].id
        : null;
    final epoch = ++_loadEpoch;
    _searchToken++;
    if (!sameAccount) _searchController.clear();
    setState(() {
      _viewScope = scope;
      _packs = scope == null ? [] : List.unmodifiable(packs);
      _recentStickers = [];
      _searchResults = [];
      if (!sameAccount) _searchQuery = '';
      final selected = selectedId == null
          ? -1
          : _packs.indexWhere((p) => p.id == selectedId);
      _selectedPackIndex = selected >= 0 ? selected : 0;
      _isLoading = false;
    });
    if (scope != null) {
      unawaited(_loadRecent(epoch, scope));
      if (_searchQuery.isNotEmpty) unawaited(_onSearchChanged(_searchQuery));
    }
  }

  Future<void> _loadRecent(int epoch, Object scope) async {
    try {
      final recent = await _repository.getRecentStickers(limit: 20);
      if (!mounted || epoch != _loadEpoch || _accountScope() != scope) return;
      setState(() => _recentStickers = recent);
    } catch (_) {
      /* Keep the current pack list available. */
    }
  }

  Future<void> _onSearchChanged(String query) async {
    final trimmed = query.trim();
    setState(() => _searchQuery = trimmed);
    if (trimmed.isEmpty) {
      setState(() => _searchResults = const []);
      return;
    }
    final token = ++_searchToken;
    final scope = _viewScope;
    if (scope == null || _accountScope() != scope) return;
    try {
      final results = await _repository.searchStickers(trimmed, limit: 40);
      if (!mounted || token != _searchToken || _accountScope() != scope) return;
      setState(() => _searchResults = results);
    } catch (_) {
      if (!mounted || token != _searchToken || _accountScope() != scope) return;
      setState(() => _searchResults = const []);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _searchToken++;
    setState(() {
      _searchQuery = '';
      _searchResults = const [];
    });
  }

  Future<void> _loadStickers() async {
    final scope = _accountScope();
    final epoch = ++_loadEpoch;
    _viewScope = scope;
    setState(() => _isLoading = scope != null);
    if (scope == null) return;
    try {
      final packs = await _repository.getInstalledPacks();
      final recent = await _repository.getRecentStickers(limit: 20);
      if (!mounted || epoch != _loadEpoch || _accountScope() != scope) return;
      setState(() {
        _packs = List.unmodifiable(packs);
        _recentStickers = recent;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted || epoch != _loadEpoch || _accountScope() != scope) return;
      setState(() => _isLoading = false);
    }
  }

  bool _canUseSticker(Sticker sticker, String packId) =>
      _viewScope != null &&
      _accountScope() == _viewScope &&
      (_packs.any(
            (pack) => pack.id == packId && pack.stickers.contains(sticker),
          ) ||
          _recentStickers.any(
            (recent) => recent.packId == packId && recent.sticker == sticker,
          ) ||
          _searchResults.any(
            (hit) => hit.packId == packId && hit.sticker == sticker,
          ));

  void _onStickerTap(Sticker sticker, String packId) {
    if (!_canUseSticker(sticker, packId)) return;
    final scope = _viewScope;
    widget.onStickerSelected(sticker, packId);
    if (_accountScope() == scope) {
      unawaited(_repository.recordStickerUsage(packId, sticker.id));
    }
  }

  void _onPackSelected(int index) {
    if (index < -1 || index >= _packs.length) return;
    setState(() => _selectedPackIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: widget.height + bottomPadding,
      decoration: BoxDecoration(
        color: context.inputBarColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // 搜索框
            _buildSearchField(isDark),

            // 贴纸包标签栏（搜索时隐藏）
            if (_searchQuery.isEmpty) _buildPackTabs(isDark),

            // 贴纸网格
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchQuery.isNotEmpty
                  ? _buildSearchResults(isDark)
                  : _buildStickerGrid(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: context.dividerColor, width: 0.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(Icons.search, size: 18, color: context.textTertiary),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: TextStyle(fontSize: 14, color: context.textPrimary),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: S.of(context)?.commonSearch ?? 'Search stickers',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: context.textTertiary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingS,
                  ),
                ),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              Semantics(
                button: true,
                label: A11yL10n.of(context).clearSearch,
                excludeSemantics: true,
                child: GestureDetector(
                  onTap: _clearSearch,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingS,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: context.textTertiary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(bool isDark) {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: context.textTertiary),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              S.of(context)?.searchNoResults ?? 'No stickers found',
              style: TextStyle(color: context.textTertiary),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final hit = _searchResults[index];
        return _buildStickerItem(hit.sticker, hit.packId, isDark);
      },
    );
  }

  Widget _buildPackTabs(bool isDark) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          bottom: BorderSide(color: context.dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // 常用贴纸标签
          if (_recentStickers.isNotEmpty)
            _buildPackTab(
              icon: Icons.access_time,
              isSelected: _selectedPackIndex == -1,
              onTap: () => _onPackSelected(-1),
              isDark: isDark,
            ),

          // 贴纸包标签
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _packs.length,
              itemBuilder: (context, index) {
                final pack = _packs[index];

                return _buildPackTab(
                  emoji: pack.stickers.isNotEmpty
                      ? pack.stickers.first.emoji
                      : null,
                  label: pack.name,
                  isSelected: _selectedPackIndex == index,
                  onTap: () => _onPackSelected(index),
                  isDark: isDark,
                );
              },
            ),
          ),

          // 贴纸商店按钮
          if (widget.onOpenStore != null)
            _buildPackTab(
              icon: Icons.add,
              onTap: widget.onOpenStore,
              isDark: isDark,
            ),
        ],
      ),
    );
  }

  Widget _buildPackTab({
    IconData? icon,
    String? emoji,
    String? label,
    bool isSelected = false,
    VoidCallback? onTap,
    required bool isDark,
  }) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: icon != null
          ? A11yL10n.of(context).stickerStore
          : (label ?? A11yL10n.of(context).stickerPack),
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    size: 22,
                    color: isSelected
                        ? AppColors.primary
                        : context.textSecondary,
                  )
                : Text(
                    emoji ?? label?.substring(0, 1) ?? '?',
                    style: TextStyle(
                      fontSize: emoji != null ? 22 : 14,
                      color: isSelected
                          ? AppColors.primary
                          : context.textSecondary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildStickerGrid(bool isDark) {
    // 常用贴纸
    if (_selectedPackIndex == -1 && _recentStickers.isNotEmpty) {
      return _buildRecentStickers(isDark);
    }

    // 贴纸包
    if (_packs.isEmpty) {
      return _buildEmptyState(isDark);
    }

    final packIndex = _selectedPackIndex < 0 ? 0 : _selectedPackIndex;
    if (packIndex >= _packs.length) {
      return _buildEmptyState(isDark);
    }

    final pack = _packs[packIndex];
    return _buildPackStickers(pack, isDark);
  }

  Widget _buildRecentStickers(bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _recentStickers.length,
      itemBuilder: (context, index) {
        final recent = _recentStickers[index];
        return _buildStickerItem(recent.sticker, recent.packId, isDark);
      },
    );
  }

  Widget _buildPackStickers(StickerPack pack, bool isDark) {
    if (pack.stickers.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: pack.stickers.length,
      itemBuilder: (context, index) {
        final sticker = pack.stickers[index];
        return _buildStickerItem(sticker, pack.id, isDark);
      },
    );
  }

  Widget _buildStickerItem(Sticker sticker, String packId, bool isDark) {
    return GestureDetector(
      onTap: () => _onStickerTap(sticker, packId),
      onLongPress: widget.onStickerLongPressed == null
          ? null
          : () {
              if (_canUseSticker(sticker, packId)) {
                widget.onStickerLongPressed!(sticker, packId);
              }
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.placeholderOf(isDark),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Center(child: _buildStickerContent(sticker)),
      ),
    );
  }

  Widget _buildStickerContent(Sticker sticker) {
    // Emoji 贴纸
    if (sticker.url.startsWith('emoji:')) {
      final emoji = sticker.url.substring(6);
      return Text(emoji, style: const TextStyle(fontSize: 32));
    }

    // 内置 asset 贴纸（Lottie 动画 / SVG 静态）
    if (BundledStickerPacks.isAssetSticker(sticker.url)) {
      final path = BundledStickerPacks.assetPath(sticker.url);
      return Padding(
        padding: const EdgeInsets.all(6),
        child: BundledStickerPacks.isLottie(sticker.url)
            ? Lottie.asset(path, fit: BoxFit.contain, repeat: true)
            : SvgPicture.asset(
                path,
                fit: BoxFit.contain,
                placeholderBuilder: (_) => Text(
                  sticker.emoji ?? '🙂',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
      );
    }

    // 图片 / 视频贴纸
    final httpUrl = sticker.httpUrl ?? sticker.url;
    if (httpUrl.startsWith('http')) {
      final client = getIt.isRegistered<MatrixClientManager>()
          ? getIt<MatrixClientManager>().client
          : null;
      final headers = mx_utils.MatrixUtils.buildAuthenticatedMediaHeaders(
        httpUrl,
        client: client,
      );
      // 视频贴纸（WebM/MP4，对齐 Telegram）：用 video_player 循环播放。
      if (VideoStickerView.isVideoSticker(
        mimeType: sticker.mimeType,
        url: httpUrl,
      )) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          child: VideoStickerView(url: httpUrl, headers: headers),
        );
      }
      // 静态 / 动画 WebP / GIF（Flutter Image 原生支持动画 WebP & GIF）。
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        child: Image.network(
          httpUrl,
          fit: BoxFit.contain,
          headers: headers,
          errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported),
        ),
      );
    }

    // 显示 emoji 或占位符
    return Text(sticker.emoji ?? '?', style: const TextStyle(fontSize: 32));
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_emotions_outlined,
            size: 48,
            color: context.textTertiary,
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            'No stickers yet',
            style: TextStyle(color: context.textTertiary),
          ),
          if (widget.onOpenStore != null) ...[
            const SizedBox(height: AppDimensions.spacing),
            TextButton.icon(
              onPressed: widget.onOpenStore,
              icon: const Icon(Icons.add),
              label: const Text('Get Stickers'),
            ),
          ],
        ],
      ),
    );
  }
}
