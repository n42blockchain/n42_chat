import '../../../../l10n/app_localizations.dart';
import 'sticker_publish_page.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../core/utils/matrix_utils.dart' as mx_utils;
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../../domain/repositories/sticker_repository.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../widgets/common/n42_tap_area.dart';

/// 自定义贴纸包管理页
///
/// 用户自建贴纸包的上传/删除/改名/删包：
/// - 从相册多选图片上传为贴纸（[IStickerRepository.addStickerToPack]，内部上传 mxc）
/// - 长按贴纸删除（[IStickerRepository.removeStickerFromPack]）
/// - 改名 / 删除整个包
class CustomStickerPackPage extends StatefulWidget {
  const CustomStickerPackPage({super.key, required this.packId});

  final String packId;

  @override
  State<CustomStickerPackPage> createState() => _CustomStickerPackPageState();
}

class _CustomStickerPackPageState extends State<CustomStickerPackPage> {
  late final IStickerRepository _repo = getIt<IStickerRepository>();
  final ImagePicker _picker = ImagePicker();

  StickerPack? _pack;
  bool _loading = true;
  bool _busy = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pack = await _repo.getPackById(widget.packId);
    if (!mounted) return;
    setState(() {
      _pack = pack;
      _loading = false;
    });
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _addStickers() async {
    if (_busy) return;
    final List<XFile> files = await _picker.pickMultiImage();
    if (files.isEmpty) return;
    setState(() => _busy = true);
    var added = 0;
    try {
      for (final file in files) {
        final bytes = await file.readAsBytes();
        final ok = await _repo.addStickerToPack(
          packId: widget.packId,
          imageBytes: bytes,
          filename: file.name,
          name: file.name,
        );
        if (ok) added++;
      }
      _changed = _changed || added > 0;
      await _load();
      if (!mounted) return;
      _snack(
        S.of(context)?.ui3StickerAddedCount(added) ??
            'Added $added sticker(s)',
      );
    } catch (e) {
      if (!mounted) return;
      _snack(S.of(context)?.ui3StickerAddFailed('$e') ?? 'Failed to add: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _removeSticker(Sticker sticker) async {
    final s = S.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.ui3StickerRemoveTitle ?? 'Remove sticker'),
        content: Text(
          s?.ui3StickerRemoveConfirm ?? 'Remove this sticker from the pack?',
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
    final ok = await _repo.removeStickerFromPack(
      packId: widget.packId,
      stickerId: sticker.id,
    );
    if (ok) {
      _changed = true;
      await _load();
    } else {
      if (!mounted) return;
      _snack(S.of(context)?.ui3StickerRemoveFailed ?? 'Failed to remove');
    }
  }

  Future<void> _rename() async {
    final controller = TextEditingController(text: _pack?.name ?? '');
    final s = S.of(context);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.ui3StickerRenamePack ?? 'Rename pack'),
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
            child: Text(s?.commonSave ?? 'Save'),
          ),
        ],
      ),
    );
    if (newName == null || newName.isEmpty || newName == _pack?.name) return;
    final ok = await _repo.renamePack(widget.packId, newName);
    if (ok) {
      _changed = true;
      await _load();
    } else {
      if (!mounted) return;
      _snack(S.of(context)?.ui3StickerRenameFailed ?? 'Failed to rename');
    }
  }

  Future<void> _deletePack() async {
    final s = S.of(context);
    final packName = _pack?.name ?? s?.ui3StickerThisPack ?? 'this pack';
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.ui3StickerDeletePack ?? 'Delete pack'),
        content: Text(
          s?.ui3StickerDeletePackConfirm(packName) ??
              'Delete "$packName" and all its '
                  'stickers? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              s?.commonDelete ?? 'Delete',
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
    final ok = await _repo.deleteCustomPack(widget.packId);
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true); // 返回并通知 store 刷新
    } else {
      _snack(S.of(context)?.ui3StickerDeleteFailed ?? 'Failed to delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    final s = S.of(context);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(pack?.name ?? s?.ui3StickerPack ?? 'Sticker Pack'),
          actions: [
            IconButton(
              key: const ValueKey('sticker_pack_publish'),
              tooltip: s?.commonShare ?? 'Share',
              icon: const Icon(Icons.share_outlined),
              onPressed: pack == null || _busy
                  ? null
                  : () => Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (_) =>
                            StickerPublishPage(packId: widget.packId),
                      ),
                    ),
            ),
            IconButton(
              tooltip: s?.ui3StickerRenamePack ?? 'Rename pack',
              icon: const Icon(Icons.edit_outlined),
              onPressed: pack == null ? null : _rename,
            ),
            IconButton(
              tooltip: s?.ui3StickerDeletePack ?? 'Delete pack',
              icon: const Icon(Icons.delete_outline),
              onPressed: pack == null ? null : _deletePack,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _busy ? null : _addStickers,
          icon: _busy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_photo_alternate_outlined),
          label: Text(
            _busy
                ? (s?.ui3StickerAdding ?? 'Adding…')
                : (s?.ui3StickerAddStickers ?? 'Add stickers'),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final pack = _pack;
    if (pack == null) {
      return Center(
        child: Text(S.of(context)?.ui3StickerPackNotFound ?? 'Pack not found'),
      );
    }
    if (pack.stickers.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_photo_alternate_outlined, size: 56),
            const SizedBox(height: AppDimensions.spacingM),
            Text(
              S.of(context)?.ui3StickerEmptyHint ??
                  'Tap "Add stickers" to upload images',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingM)
          .copyWith(bottom: 88),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: pack.stickers.length,
      itemBuilder: (context, i) {
        final sticker = pack.stickers[i];
        return GestureDetector(
          onLongPress: () => _removeSticker(sticker),
          child: Stack(
            children: [
              Positioned.fill(child: _StickerThumb(sticker: sticker)),
              // 44pt hit area in the tile corner; the 18pt badge keeps its
              // 2pt inset.
              Positioned(
                top: 0,
                right: 0,
                child: N42TapArea(
                  onTap: () => _removeSticker(sticker),
                  tooltip: S.of(context)?.commonRemove ?? 'Remove',
                  child: SizedBox(
                    width: N42TapArea.minTarget,
                    height: N42TapArea.minTarget,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 贴纸缩略图（自定义包贴纸为上传的图片，走 http + Matrix 鉴权头）。
class _StickerThumb extends StatelessWidget {
  const _StickerThumb({required this.sticker});

  final Sticker sticker;

  @override
  Widget build(BuildContext context) {
    final httpUrl = sticker.httpUrl ?? sticker.url;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget container(Widget child) => Container(
      decoration: BoxDecoration(
        color: AppColors.placeholderOf(isDark),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Center(child: child),
    );

    if (httpUrl.startsWith('http')) {
      final client = getIt.isRegistered<MatrixClientManager>()
          ? getIt<MatrixClientManager>().client
          : null;
      return container(
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            httpUrl,
            fit: BoxFit.contain,
            headers: mx_utils.MatrixUtils.buildAuthenticatedMediaHeaders(
              httpUrl,
              client: client,
            ),
            errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported),
          ),
        ),
      );
    }
    return container(
      Text(sticker.emoji ?? '🙂', style: const TextStyle(fontSize: 28)),
    );
  }
}
