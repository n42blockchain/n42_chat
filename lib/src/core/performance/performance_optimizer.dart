import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// 性能优化器
///
/// 提供各种性能优化工具和监控
class PerformanceOptimizer {
  static final PerformanceOptimizer _instance = PerformanceOptimizer._();

  factory PerformanceOptimizer() => _instance;

  PerformanceOptimizer._();

  /// 帧率监控
  final FrameRateMonitor frameRateMonitor = FrameRateMonitor();

  /// 内存监控
  final MemoryMonitor memoryMonitor = MemoryMonitor();

  /// 启动所有监控
  void startAllMonitoring() {
    frameRateMonitor.start();
    memoryMonitor.start();
  }

  /// 停止所有监控
  void stopAllMonitoring() {
    frameRateMonitor.stop();
    memoryMonitor.stop();
  }
}

/// 帧率监控器
class FrameRateMonitor {
  Timer? _timer;
  int _frameCount = 0;
  double _currentFps = 0.0;

  /// 当前FPS
  double get currentFps => _currentFps;

  /// 是否正在监控
  bool get isMonitoring => _timer != null;

  /// FPS变化回调
  void Function(double fps)? onFpsUpdate;

  /// 启动监控
  void start() {
    if (_timer != null) return;

    SchedulerBinding.instance.addPostFrameCallback(_onFrame);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _currentFps = _frameCount.toDouble();
      _frameCount = 0;
      onFpsUpdate?.call(_currentFps);
    });
  }

  void _onFrame(Duration timestamp) {
    _frameCount++;
    if (_timer != null) {
      SchedulerBinding.instance.addPostFrameCallback(_onFrame);
    }
  }

  /// 停止监控
  void stop() {
    _timer?.cancel();
    _timer = null;
    _frameCount = 0;
  }
}

/// 内存监控器
class MemoryMonitor {
  Timer? _timer;

  /// 内存使用变化回调
  void Function(MemoryInfo info)? onMemoryUpdate;

  /// 启动监控
  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkMemory();
    });
  }

  void _checkMemory() {
    // 注：实际内存监控需要平台特定实现
    // 这里提供一个示例结构
    final info = MemoryInfo(
      usedMemory: 0,
      totalMemory: 0,
      timestamp: DateTime.now(),
    );
    onMemoryUpdate?.call(info);
  }

  /// 停止监控
  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}

/// 内存信息
class MemoryInfo {
  final int usedMemory;
  final int totalMemory;
  final DateTime timestamp;

  MemoryInfo({
    required this.usedMemory,
    required this.totalMemory,
    required this.timestamp,
  });

  double get usagePercentage {
    if (totalMemory == 0) return 0;
    return usedMemory / totalMemory * 100;
  }
}

/// 图片缓存管理器
class ImageCacheManager {
  /// 最大缓存大小（MB）
  static const int maxCacheSize = 100;

  /// 清除图片缓存
  static void clearCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// 设置最大缓存数量
  static void setMaxCacheCount(int count) {
    PaintingBinding.instance.imageCache.maximumSize = count;
  }

  /// 获取当前缓存数量
  static int get currentCacheCount => PaintingBinding.instance.imageCache.currentSize;

  /// 清除指定URL的缓存
  static void evict(String url) {
    PaintingBinding.instance.imageCache.evict(url);
  }
}

/// 列表性能优化工具
class ListOptimizer {
  /// 创建带缓存的列表项构建器
  static Widget Function(BuildContext, int) createCachedBuilder<T>({
    required List<T> items,
    required Widget Function(T item) builder,
    Map<int, Widget>? cache,
  }) {
    final itemCache = cache ?? <int, Widget>{};

    return (context, index) {
      if (itemCache.containsKey(index)) {
        return itemCache[index]!;
      }

      final widget = builder(items[index]);
      itemCache[index] = widget;
      return widget;
    };
  }

  /// 清除列表缓存
  static void clearCache(Map<int, Widget>? cache) {
    cache?.clear();
  }
}

/// 防抖器
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({this.duration = const Duration(milliseconds: 300)});

  /// 执行防抖
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// 取消
  void cancel() {
    _timer?.cancel();
  }

  /// 释放资源
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

/// 节流器
class Throttler {
  final Duration duration;
  DateTime? _lastExecution;

  Throttler({this.duration = const Duration(milliseconds: 300)});

  /// 执行节流
  void run(VoidCallback action) {
    final now = DateTime.now();

    if (_lastExecution == null ||
        now.difference(_lastExecution!) >= duration) {
      _lastExecution = now;
      action();
    }
  }
}

/// 延迟加载辅助器
class LazyLoader<T> {
  T? _value;
  final T Function() _factory;

  LazyLoader(this._factory);

  /// 获取值（延迟初始化）
  T get value {
    _value ??= _factory();
    return _value!;
  }

  /// 是否已初始化
  bool get isInitialized => _value != null;

  /// 重置
  void reset() {
    _value = null;
  }
}

/// 批量操作处理器
class BatchProcessor<T> {
  final int batchSize;
  final Duration batchDelay;
  final Future<void> Function(List<T> items) processor;

  final List<T> _queue = [];
  Timer? _timer;
  bool _isProcessing = false;

  BatchProcessor({
    this.batchSize = 10,
    this.batchDelay = const Duration(milliseconds: 100),
    required this.processor,
  });

  /// 添加项目到队列
  void add(T item) {
    _queue.add(item);
    _scheduleProcess();
  }

  /// 添加多个项目到队列
  void addAll(Iterable<T> items) {
    _queue.addAll(items);
    _scheduleProcess();
  }

  void _scheduleProcess() {
    if (_timer != null || _isProcessing) return;

    if (_queue.length >= batchSize) {
      _process();
    } else {
      _timer = Timer(batchDelay, () {
        _timer = null;
        _process();
      });
    }
  }

  Future<void> _process() async {
    if (_queue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    while (_queue.isNotEmpty) {
      final batch = _queue.take(batchSize).toList();
      _queue.removeRange(0, batch.length);

      try {
        await processor(batch);
      } catch (e) {
        debugPrint('Batch processing error: $e');
      }
    }

    _isProcessing = false;
  }

  /// 立即处理所有队列项目
  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    await _process();
  }

  /// 清除队列
  void clear() {
    _queue.clear();
    _timer?.cancel();
    _timer = null;
  }
}

/// 缓存策略
enum CacheStrategy {
  /// 永不过期
  never,
  /// LRU（最近最少使用）
  lru,
  /// TTL（基于时间）
  ttl,
}

/// 通用缓存
class GenericCache<K, V> {
  final int maxSize;
  final Duration? ttl;
  final CacheStrategy strategy;

  final Map<K, _CacheEntry<V>> _cache = {};

  GenericCache({
    this.maxSize = 100,
    this.ttl,
    this.strategy = CacheStrategy.lru,
  });

  /// 获取值
  V? get(K key) {
    final entry = _cache[key];
    if (entry == null) return null;

    // 检查TTL
    if (strategy == CacheStrategy.ttl && ttl != null) {
      if (DateTime.now().difference(entry.createdAt) > ttl!) {
        _cache.remove(key);
        return null;
      }
    }

    // LRU: 更新访问时间
    if (strategy == CacheStrategy.lru) {
      entry.lastAccess = DateTime.now();
    }

    return entry.value;
  }

  /// 设置值
  void set(K key, V value) {
    // 检查是否需要淘汰
    if (_cache.length >= maxSize && !_cache.containsKey(key)) {
      _evict();
    }

    _cache[key] = _CacheEntry(value);
  }

  /// 移除值
  void remove(K key) {
    _cache.remove(key);
  }

  /// 清空缓存
  void clear() {
    _cache.clear();
  }

  /// 缓存大小
  int get size => _cache.length;

  void _evict() {
    if (_cache.isEmpty) return;

    switch (strategy) {
      case CacheStrategy.lru:
        // 移除最久未访问的
        K? oldestKey;
        DateTime? oldestTime;
        for (final entry in _cache.entries) {
          if (oldestTime == null || entry.value.lastAccess.isBefore(oldestTime)) {
            oldestKey = entry.key;
            oldestTime = entry.value.lastAccess;
          }
        }
        if (oldestKey != null) {
          _cache.remove(oldestKey);
        }
        break;
      case CacheStrategy.ttl:
        // 移除过期的
        final now = DateTime.now();
        _cache.removeWhere((_, entry) =>
            ttl != null && now.difference(entry.createdAt) > ttl!);
        break;
      case CacheStrategy.never:
        // 移除第一个
        if (_cache.isNotEmpty) {
          _cache.remove(_cache.keys.first);
        }
        break;
    }
  }
}

class _CacheEntry<V> {
  final V value;
  final DateTime createdAt;
  DateTime lastAccess;

  _CacheEntry(this.value)
      : createdAt = DateTime.now(),
        lastAccess = DateTime.now();
}

