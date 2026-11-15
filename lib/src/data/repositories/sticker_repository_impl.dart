import 'dart:typed_data';
import 'dart:async';
import 'dart:collection';

import '../../domain/entities/sticker_pack_entity.dart';
import '../../domain/entities/sticker_pack_subscription.dart';
import '../../domain/entities/sticker_publication_receipt_failure.dart';
import '../../domain/repositories/sticker_repository.dart';
import '../datasources/matrix/matrix_sticker_datasource.dart';
import '../datasources/bundled_sticker_packs.dart';
import '../services/matrix_sticker_publication.dart';
import '../services/matrix_sticker_subscriptions.dart';
import '../../core/utils/debug_log.dart';
import '../../core/utils/sticker_suggestion_utils.dart';
import '../../core/utils/matrix_sticker_pack_link.dart';
import '../../core/utils/sticker_pack_fingerprint.dart';

/// 贴纸仓库实现
class StickerRepositoryImpl implements IStickerRepository {
  final MatrixStickerDataSource _dataSource;

  /// 已安装贴纸包缓存
  List<StickerPack>? _installedPacksCache;
  Object? _installedPacksScope;
  Object? _importScope;
  final _importPreviews = <String, StickerPack>{};

  /// 已安装贴纸包变化流控制器
  final _installedPacksController =
      StreamController<(Object?, int, List<StickerPack>)>.broadcast();

  final MatrixStickerPublication? publication;
  final MatrixStickerSubscriptions? subscriptions;
  StreamSubscription<void>? _subscriptionChanges;
  Object? _observedInstalledScope;
  Object? _loadScope;
  Future<List<StickerPack>>? _installedLoad;
  int _installedRevision = 0;
  bool _disposed = false;
  static const _liveReadConcurrency = 4;
  final _readBudgets = <Object?, _StickerReadBudget>{};

  StickerRepositoryImpl(
    this._dataSource, {
    this.publication,
    this.subscriptions,
  }) {
    _subscriptionChanges = subscriptions?.watchChanges().listen((_) {
      if (_disposed) return;
      _invalidateCache();
      _notifyInstalledPacksChanged();
    });
  }

  Object? get _installedScope => subscriptions == null
      ? _dataSource.accountScope
      : (_dataSource.accountScope, subscriptions!.accountScope);

  @override
  Future<List<StickerPack>> getInstalledPacks() {
    final scope = _installedScope;
    if (_observedInstalledScope != scope) {
      _observedInstalledScope = scope;
      _invalidateCache();
    }
    if (_disposed ||
        (subscriptions != null && subscriptions!.accountScope == null)) {
      return Future.value(List<StickerPack>.of(BundledStickerPacks.all));
    }
    if (_installedPacksScope == scope && _installedPacksCache != null) {
      return Future.value(_installedPacksCache!);
    }
    if (_loadScope == scope && _installedLoad != null) return _installedLoad!;
    _loadScope = scope;
    final revision = _installedRevision;
    return _installedLoad = Future<List<StickerPack>>.microtask(
      () => _loadInstalledPacks(scope, revision),
    );
  }

  Future<List<StickerPack>> _loadInstalledPacks(
    Object? scope,
    int revision,
  ) async {
    try {
      if (_disposed || _installedScope != scope) {
        return List.of(BundledStickerPacks.all);
      }
      if (revision != _installedRevision) return await getInstalledPacks();
      final private = await _dataSource.getInstalledPacks();
      if (_disposed || _installedScope != scope) {
        return List.of(BundledStickerPacks.all);
      }
      if (revision != _installedRevision) return await getInstalledPacks();
      final live = <StickerPack>[];
      var incomplete = false;
      if (subscriptions != null) {
        try {
          final references = await subscriptions!.getEnabled();
          if (_disposed || _installedScope != scope) {
            return List.of(BundledStickerPacks.all);
          }
          if (revision != _installedRevision) return await getInstalledPacks();
          final joined = references.isEmpty
              ? const <String>{}
              : await subscriptions!.getJoinedRoomIds();
          if (_disposed || _installedScope != scope) {
            return List.of(BundledStickerPacks.all);
          }
          if (revision != _installedRevision) return await getInstalledPacks();
          final readable = references
              .where((ref) => joined.contains(ref.roomId))
              .toList();
          for (
            var start = 0;
            start < readable.length;
            start += _liveReadConcurrency
          ) {
            final batch = await Future.wait(
              readable
                  .skip(start)
                  .take(_liveReadConcurrency)
                  .map((ref) => _resolveLivePack(ref, scope, revision)),
            );
            if (_disposed || _installedScope != scope) {
              return List.of(BundledStickerPacks.all);
            }
            if (revision != _installedRevision) {
              return await getInstalledPacks();
            }
            for (final pack in batch) {
              if (pack != null) {
                live.add(pack);
              } else {
                incomplete = true;
              }
            }
          }
        } catch (_) {
          incomplete = true;
        }
      }
      if (_disposed || _installedScope != scope) {
        return List.of(BundledStickerPacks.all);
      }
      if (revision != _installedRevision) return await getInstalledPacks();
      final packs = _dedupePacksById([
        ...BundledStickerPacks.all,
        ...live,
        ...private,
      ]);
      if (!incomplete) {
        _installedPacksScope = scope;
        _installedPacksCache = packs;
      }
      return packs;
    } finally {
      if (_loadScope == scope && revision == _installedRevision) {
        _installedLoad = null;
        _loadScope = null;
      }
    }
  }

  Future<StickerPack?> _resolveLivePack(
    StickerPackSubscription reference,
    Object? scope,
    int revision,
  ) async {
    final budget = _readBudgets.putIfAbsent(scope, _StickerReadBudget.new);
    if (budget.active < _liveReadConcurrency) {
      budget.active++;
    } else {
      final permit = Completer<void>();
      budget.waiting.add(permit);
      await permit.future;
    }
    try {
      if (_disposed ||
          _installedScope != scope ||
          revision != _installedRevision) {
        return null;
      }
      return await _dataSource.getSubscribedPack(reference);
    } catch (_) {
      return null;
    } finally {
      if (budget.waiting.isNotEmpty) {
        budget.waiting.removeFirst().complete();
      } else {
        budget.active--;
      }
      if (budget.active == 0 &&
          budget.waiting.isEmpty &&
          identical(_readBudgets[scope], budget)) {
        _readBudgets.remove(scope);
      }
    }
  }

  @override
  Future<List<StickerPack>> getStorePacks({
    int limit = 20,
    int offset = 0,
    String? category,
  }) async {
    // Built-in sample stickers — replace with Matrix sticker pack API (m.sticker_pack)
    // TODO: 从贴纸商店 API 获取
    // 目前返回一些示例贴纸包
    final packs = _filterStorePacks(_getSampleStorePacks(), category: category);
    return packs.skip(offset).take(limit).toList();
  }

  List<StickerPack> _getSampleStorePacks() {
    return [
      const StickerPack(
        id: 'store_cute_animals',
        name: 'Cute Animals',
        description: 'Adorable animal stickers for every occasion',
        author: 'N42 Studio',
        source: StickerPackSource.store,
        isOfficial: true,
        stickers: [
          Sticker(id: 'cat1', url: 'emoji:🐱', emoji: '🐱'),
          Sticker(id: 'dog1', url: 'emoji:🐶', emoji: '🐶'),
          Sticker(id: 'bunny1', url: 'emoji:🐰', emoji: '🐰'),
          Sticker(id: 'bear1', url: 'emoji:🐻', emoji: '🐻'),
        ],
      ),
      const StickerPack(
        id: 'store_emotions',
        name: 'Emotions',
        description: 'Express your feelings with these stickers',
        author: 'N42 Studio',
        source: StickerPackSource.store,
        isOfficial: true,
        stickers: [
          Sticker(id: 'happy1', url: 'emoji:😊', emoji: '😊'),
          Sticker(id: 'sad1', url: 'emoji:😢', emoji: '😢'),
          Sticker(id: 'angry1', url: 'emoji:😠', emoji: '😠'),
          Sticker(id: 'love1', url: 'emoji:😍', emoji: '😍'),
        ],
      ),
      const StickerPack(
        id: 'store_food',
        name: 'Yummy Food',
        description: 'Delicious food stickers',
        author: 'Community',
        source: StickerPackSource.store,
        stickers: [
          Sticker(id: 'pizza1', url: 'emoji:🍕', emoji: '🍕'),
          Sticker(id: 'burger1', url: 'emoji:🍔', emoji: '🍔'),
          Sticker(id: 'sushi1', url: 'emoji:🍣', emoji: '🍣'),
          Sticker(id: 'cake1', url: 'emoji:🎂', emoji: '🎂'),
        ],
      ),
      const StickerPack(
        id: 'store_celebration',
        name: 'Celebration',
        description: 'Party and celebration stickers',
        author: 'Community',
        source: StickerPackSource.store,
        stickers: [
          Sticker(id: 'party1', url: 'emoji:🎉', emoji: '🎉'),
          Sticker(id: 'gift1', url: 'emoji:🎁', emoji: '🎁'),
          Sticker(id: 'balloon1', url: 'emoji:🎈', emoji: '🎈'),
          Sticker(id: 'confetti1', url: 'emoji:🎊', emoji: '🎊'),
        ],
      ),
    ];
  }

  @override
  Future<StickerPack?> getPackById(String packId) async {
    // 先从已安装列表查找
    final installed = await getInstalledPacks();
    final installedPack = installed.where((p) => p.id == packId).firstOrNull;
    if (installedPack != null) return installedPack;

    if (_importScope != _dataSource.accountScope) _importPreviews.clear();
    final preview = _importPreviews[packId];
    if (preview != null) return preview;

    // 从商店查找
    final storePacks = _getSampleStorePacks();
    return storePacks.where((p) => p.id == packId).firstOrNull;
  }

  @override
  Future<bool> installPack(String packId) async {
    final origin = _dataSource.accountScope;
    final pack = await getPackById(packId);
    if (pack == null || _dataSource.accountScope != origin) return false;

    if (pack.subscription != null) return true;
    final success = await _dataSource.installPack(packId, pack);
    if (_dataSource.accountScope != origin) return false;
    if (success) {
      _invalidateCache();
      _notifyInstalledPacksChanged();
    }
    return success;
  }

  @override
  Future<bool> uninstallPack(String packId) async {
    if (packId.startsWith('subscribed_') && subscriptions != null) {
      final scope = _installedScope;
      final reference = (await getPackSubscriptions())
          .where((ref) => ref.packId == packId)
          .firstOrNull;
      if (_installedScope != scope || reference == null) return false;
      return setPackSubscribed(reference, enabled: false);
    }
    final origin = _dataSource.accountScope;
    final success = await _dataSource.uninstallPack(packId);
    if (_dataSource.accountScope != origin) return false;
    if (success) {
      _invalidateCache();
      _notifyInstalledPacksChanged();
    }
    return success;
  }

  @override
  Future<List<RecentSticker>> getRecentStickers({int limit = 20}) async {
    if (subscriptions == null) {
      return _dataSource.getRecentStickers(limit: limit);
    }
    final scope = _installedScope;
    if (_disposed || subscriptions!.accountScope == null) return [];
    final packs = await getInstalledPacks();
    if (_disposed || _installedScope != scope) return [];
    final recent = await _dataSource.getRecentStickers(
      limit: limit,
      resolvedPacks: packs,
    );
    return !_disposed && _installedScope == scope ? recent : [];
  }

  @override
  Future<void> recordStickerUsage(String packId, String stickerId) async {
    await _dataSource.recordStickerUsage(packId, stickerId);
  }

  @override
  Future<void> clearRecentStickers() async {
    await _dataSource.clearRecentStickers();
  }

  @override
  Future<List<StickerPack>> searchPacks(String query) async {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();

    // 搜索已安装的贴纸包
    final installed = await getInstalledPacks();
    final installedMatches = installed.where(
      (pack) =>
          pack.name.toLowerCase().contains(queryLower) ||
          (pack.description?.toLowerCase().contains(queryLower) ?? false) ||
          pack.stickers.any(
            (s) =>
                (s.name?.toLowerCase().contains(queryLower) ?? false) ||
                (s.emoji?.contains(queryLower) ?? false),
          ),
    );

    // 搜索商店贴纸包
    final storePacks = _getSampleStorePacks();
    final storeMatches = storePacks.where(
      (pack) =>
          pack.name.toLowerCase().contains(queryLower) ||
          (pack.description?.toLowerCase().contains(queryLower) ?? false),
    );

    return _dedupePacksById([...installedMatches, ...storeMatches]);
  }

  @override
  Future<List<StickerHit>> searchStickers(
    String query, {
    int limit = 24,
  }) async {
    if (query.trim().isEmpty) return const [];
    final installed = await getInstalledPacks();
    return StickerSuggestionUtils.rank(installed, query, limit: limit);
  }

  @override
  Future<List<StickerCategory>> getCategories() async {
    return const [
      StickerCategory(
        id: 'popular',
        name: 'Popular',
        icon: '🔥',
        packCount: 10,
      ),
      StickerCategory(id: 'new', name: 'New', icon: '✨', packCount: 5),
      StickerCategory(id: 'animals', name: 'Animals', icon: '🐾', packCount: 8),
      StickerCategory(
        id: 'emotions',
        name: 'Emotions',
        icon: '😊',
        packCount: 12,
      ),
      StickerCategory(id: 'food', name: 'Food', icon: '🍔', packCount: 6),
      StickerCategory(
        id: 'celebration',
        name: 'Celebration',
        icon: '🎉',
        packCount: 4,
      ),
    ];
  }

  @override
  Future<StickerPack?> createCustomPack({
    required String name,
    String? description,
    Uint8List? avatarBytes,
  }) async {
    final origin = _dataSource.accountScope;
    try {
      String? avatarUrl;
      if (avatarBytes != null) {
        avatarUrl = await _dataSource.uploadStickerImage(
          avatarBytes,
          'avatar.png',
          'image/png',
        );
      }

      if (_dataSource.accountScope != origin) return null;

      final packId = 'custom_${DateTime.now().millisecondsSinceEpoch}';
      final pack = StickerPack(
        id: packId,
        name: name,
        description: description,
        avatarUrl: avatarUrl,
        source: StickerPackSource.custom,
        isInstalled: true,
        createdAt: DateTime.now(),
      );

      final success = await _dataSource.installPack(packId, pack);
      if (_dataSource.accountScope != origin) return null;
      if (success) {
        _invalidateCache();
        _notifyInstalledPacksChanged();
        return pack;
      }
      return null;
    } catch (e) {
      debugLog('StickerRepositoryImpl: Failed to create custom pack: $e');
      return null;
    }
  }

  @override
  Future<bool> addStickerToPack({
    required String packId,
    required Uint8List imageBytes,
    required String filename,
    String? name,
    String? emoji,
  }) async {
    final origin = _dataSource.accountScope;
    try {
      final pack = await getPackById(packId);
      if (pack == null || _dataSource.accountScope != origin) return false;

      // 上传贴纸图片
      final url = await _dataSource.uploadStickerImage(
        imageBytes,
        filename,
        _getMimeType(filename),
      );
      if (url == null || _dataSource.accountScope != origin) return false;

      // 创建新贴纸
      final stickerId = 'sticker_${DateTime.now().millisecondsSinceEpoch}';
      final sticker = Sticker(
        id: stickerId,
        url: url,
        name: name,
        emoji: emoji,
        mimeType: _getMimeType(filename),
        size: imageBytes.length,
      );

      // 更新贴纸包
      final updatedPack = pack.copyWith(
        stickers: [...pack.stickers, sticker],
        updatedAt: DateTime.now(),
      );

      final success = await _dataSource.installPack(packId, updatedPack);
      if (_dataSource.accountScope != origin) return false;
      if (success) {
        _invalidateCache();
        _notifyInstalledPacksChanged();
      }
      return success;
    } catch (e) {
      debugLog('StickerRepositoryImpl: Failed to add sticker: $e');
      return false;
    }
  }

  @override
  Future<bool> removeStickerFromPack({
    required String packId,
    required String stickerId,
  }) async {
    final origin = _dataSource.accountScope;
    try {
      final pack = await getPackById(packId);
      if (pack == null || _dataSource.accountScope != origin) return false;

      final updatedStickers = pack.stickers
          .where((s) => s.id != stickerId)
          .toList();
      final updatedPack = pack.copyWith(
        stickers: updatedStickers,
        updatedAt: DateTime.now(),
      );

      final success = await _dataSource.installPack(packId, updatedPack);
      if (_dataSource.accountScope != origin) return false;
      if (success) {
        _invalidateCache();
        _notifyInstalledPacksChanged();
      }
      return success;
    } catch (e) {
      debugLog('StickerRepositoryImpl: Failed to remove sticker: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteCustomPack(String packId) async {
    return await uninstallPack(packId);
  }

  @override
  Future<bool> renamePack(String packId, String newName) async {
    final origin = _dataSource.accountScope;
    try {
      final pack = await getPackById(packId);
      if (pack == null || _dataSource.accountScope != origin) return false;

      final updatedPack = pack.copyWith(
        name: newName,
        updatedAt: DateTime.now(),
      );

      final success = await _dataSource.installPack(packId, updatedPack);
      if (_dataSource.accountScope != origin) return false;
      if (success) {
        _invalidateCache();
        _notifyInstalledPacksChanged();
      }
      return success;
    } catch (e) {
      debugLog('StickerRepositoryImpl: Failed to rename pack: $e');
      return false;
    }
  }

  @override
  Future<StickerPack?> importPack(String shareUrl) async {
    final reference = parseMatrixStickerPackLink(shareUrl);
    final scope = _dataSource.accountScope;
    if (reference == null || scope == null) return null;
    if (_importScope != scope) {
      _importPreviews.clear();
      _importScope = scope;
    }
    final pack = await _dataSource.previewSharedPack(reference);
    if (pack == null || _dataSource.accountScope != scope) return null;
    if (_importPreviews.length >= 32) {
      _importPreviews.remove(_importPreviews.keys.first);
    }
    _importPreviews[pack.id] = pack;
    return pack;
  }

  @override
  Future<String?> getPackShareUrl(
    String packId, {
    StickerPack? reviewedPack,
  }) async {
    final scope = _dataSource.accountScope;
    final pack = await getPackById(packId);
    if (_dataSource.accountScope != scope ||
        pack == null ||
        (reviewedPack != null && pack != reviewedPack)) {
      return null;
    }
    final snapshot = pack.copyWith(stickers: List.unmodifiable(pack.stickers));
    final fingerprint = stickerPackFingerprint(snapshot);
    final link = snapshot.source == StickerPackSource.custom
        ? await _dataSource.getPublicationReceipt(snapshot)
        : snapshot.origin?.shareUrl;
    return _dataSource.accountScope == scope &&
            stickerPackFingerprint(pack) == fingerprint
        ? link
        : null;
  }

  @override
  Future<String?> publishPack(
    String packId,
    String roomId, {
    required StickerPack reviewedPack,
  }) async {
    final publisher = publication;
    final generation = publisher?.lifecycle.currentAccountGeneration;
    final scope = _dataSource.accountScope;
    if (publisher == null ||
        generation == null ||
        !generation.isCurrent ||
        scope == null) {
      return null;
    }
    final pack = await getPackById(packId);
    if (pack == null ||
        pack != reviewedPack ||
        pack.source != StickerPackSource.custom ||
        _dataSource.accountScope != scope ||
        !generation.isCurrent ||
        !identical(publisher.lifecycle.currentAccountGeneration, generation)) {
      return null;
    }
    final snapshot = pack.copyWith(stickers: List.unmodifiable(pack.stickers));
    final origin = await publisher.publish(snapshot, roomId);
    if (_dataSource.accountScope != scope ||
        !generation.isCurrent ||
        !identical(publisher.lifecycle.currentAccountGeneration, generation)) {
      return null;
    }
    bool current() =>
        _dataSource.accountScope == scope &&
        generation.isCurrent &&
        identical(publisher.lifecycle.currentAccountGeneration, generation);
    final saved = await _dataSource.savePublicationReceipt(
      snapshot,
      origin,
      isCurrent: current,
    );
    if (!current()) return null;
    if (!saved) throw StickerPublicationReceiptFailure(origin.shareUrl);
    return origin.shareUrl;
  }

  @override
  Future<List<StickerPackSubscription>> getPackSubscriptions() async {
    final service = subscriptions;
    final scope = _installedScope;
    if (_disposed || service == null || service.accountScope == null) return [];
    final references = await service.getEnabled();
    return !_disposed && _installedScope == scope ? references : [];
  }

  @override
  Future<bool> setPackSubscribed(
    StickerPackSubscription reference, {
    required bool enabled,
  }) async {
    final service = subscriptions;
    final scope = _installedScope;
    if (_disposed || service == null || service.accountScope == null) {
      return false;
    }
    try {
      await service.setEnabled(reference, enabled: enabled);
      if (_disposed || _installedScope != scope) return false;
      _invalidateCache();
      _notifyInstalledPacksChanged();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<List<StickerPack>> watchInstalledPacks() {
    // 立即发送当前数据
    _notifyInstalledPacksChanged();
    return _installedPacksController.stream
        .where(
          (event) =>
              !_disposed &&
              event.$1 == _installedScope &&
              event.$2 == _installedRevision,
        )
        .map((event) => event.$3);
  }

  void _invalidateCache() {
    _installedPacksCache = null;
    _installedRevision++;
    _installedLoad = null;
    _loadScope = null;
  }

  List<StickerPack> _filterStorePacks(
    Iterable<StickerPack> packs, {
    String? category,
  }) {
    final filtered = category == null
        ? packs.toList()
        : packs.where((pack) => _matchesStoreCategory(pack, category)).toList();

    if (category == 'popular' &&
        filtered.any((pack) => pack.downloadCount > 0)) {
      filtered.sort((a, b) {
        final count = b.downloadCount.compareTo(a.downloadCount);
        return count != 0 ? count : a.id.compareTo(b.id);
      });
    } else if (category == 'new') {
      filtered.sort((a, b) => b.id.compareTo(a.id));
    }

    return filtered;
  }

  bool _matchesStoreCategory(StickerPack pack, String category) {
    switch (category) {
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
  }

  List<StickerPack> _dedupePacksById(Iterable<StickerPack> packs) {
    final deduped = <String, StickerPack>{};
    for (final pack in packs) {
      deduped.putIfAbsent(pack.id, () => pack);
    }
    return deduped.values.toList();
  }

  void _notifyInstalledPacksChanged() {
    if (_disposed) return;
    final origin = _installedScope;
    final load = getInstalledPacks();
    final revision = _installedRevision;
    unawaited(
      load.then(
        (packs) {
          if (!_disposed &&
              _installedScope == origin &&
              revision == _installedRevision &&
              !_installedPacksController.isClosed) {
            _installedPacksController.add((origin, revision, packs));
          }
        },
        onError: (Object error, StackTrace stack) {
          debugLog('StickerRepositoryImpl: Installed-pack refresh failed');
        },
      ),
    );
  }

  String? _getMimeType(String filename) {
    final ext = filename.toLowerCase().split('.').last;
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return null;
    }
  }

  void dispose() {
    _disposed = true;
    unawaited(_subscriptionChanges?.cancel());
    unawaited(_installedPacksController.close());
  }
}

class _StickerReadBudget {
  int active = 0;
  final waiting = Queue<Completer<void>>();
}
