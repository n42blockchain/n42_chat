import '../../domain/entities/message_entity.dart';

/// 消息缓存管理器
///
/// 优化消息列表的内存使用和性能
class MessageCacheManager {
  /// 每个房间的最大缓存消息数
  final int maxMessagesPerRoom;

  /// 全局最大缓存消息数
  final int maxTotalMessages;

  /// 缓存过期时间
  final Duration cacheExpiry;

  final Map<String, _RoomMessageCache> _roomCaches = {};

  MessageCacheManager({
    this.maxMessagesPerRoom = 500,
    this.maxTotalMessages = 5000,
    this.cacheExpiry = const Duration(hours: 24),
  });

  /// 获取房间的缓存消息
  List<MessageEntity> getMessages(String roomId) {
    final cache = _roomCaches[roomId];
    if (cache == null) return [];

    // 检查是否过期
    if (DateTime.now().difference(cache.lastAccess) > cacheExpiry) {
      _roomCaches.remove(roomId);
      return [];
    }

    cache.lastAccess = DateTime.now();
    return cache.messages;
  }

  /// 缓存房间消息
  void cacheMessages(String roomId, List<MessageEntity> messages) {
    // 限制每个房间的消息数
    final limitedMessages = messages.length > maxMessagesPerRoom
        ? messages.sublist(messages.length - maxMessagesPerRoom)
        : messages;

    _roomCaches[roomId] = _RoomMessageCache(limitedMessages);

    // 检查全局限制
    _enforceGlobalLimit();
  }

  /// 添加新消息到缓存
  void addMessage(String roomId, MessageEntity message) {
    var cache = _roomCaches[roomId];
    if (cache == null) {
      cache = _RoomMessageCache([]);
      _roomCaches[roomId] = cache;
    }

    cache.messages.add(message);
    cache.lastAccess = DateTime.now();

    // 检查房间限制
    if (cache.messages.length > maxMessagesPerRoom) {
      cache.messages.removeAt(0);
    }

    // 检查全局限制
    _enforceGlobalLimit();
  }

  /// 更新缓存中的消息
  void updateMessage(String roomId, MessageEntity message) {
    final cache = _roomCaches[roomId];
    if (cache == null) return;

    final index = cache.messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      cache.messages[index] = message;
      cache.lastAccess = DateTime.now();
    }
  }

  /// 从缓存中删除消息
  void removeMessage(String roomId, String messageId) {
    final cache = _roomCaches[roomId];
    if (cache == null) return;

    cache.messages.removeWhere((m) => m.id == messageId);
    cache.lastAccess = DateTime.now();
  }

  /// 清除房间缓存
  void clearRoom(String roomId) {
    _roomCaches.remove(roomId);
  }

  /// 清除所有缓存
  void clearAll() {
    _roomCaches.clear();
  }

  /// 获取缓存统计
  CacheStats getStats() {
    int totalMessages = 0;
    for (final cache in _roomCaches.values) {
      totalMessages += cache.messages.length;
    }

    return CacheStats(
      roomCount: _roomCaches.length,
      totalMessages: totalMessages,
      maxMessages: maxTotalMessages,
    );
  }

  void _enforceGlobalLimit() {
    int totalMessages = 0;
    for (final cache in _roomCaches.values) {
      totalMessages += cache.messages.length;
    }

    if (totalMessages <= maxTotalMessages) return;

    // 按最后访问时间排序，清除最旧的房间
    final sortedRooms = _roomCaches.entries.toList()
      ..sort((a, b) => a.value.lastAccess.compareTo(b.value.lastAccess));

    for (final entry in sortedRooms) {
      if (totalMessages <= maxTotalMessages) break;

      totalMessages -= entry.value.messages.length;
      _roomCaches.remove(entry.key);
    }
  }
}

class _RoomMessageCache {
  final List<MessageEntity> messages;
  DateTime lastAccess;

  _RoomMessageCache(this.messages) : lastAccess = DateTime.now();
}

/// 缓存统计
class CacheStats {
  final int roomCount;
  final int totalMessages;
  final int maxMessages;

  CacheStats({
    required this.roomCount,
    required this.totalMessages,
    required this.maxMessages,
  });

  double get usagePercentage => totalMessages / maxMessages * 100;

  @override
  String toString() {
    return 'CacheStats(rooms: $roomCount, messages: $totalMessages/$maxMessages, usage: ${usagePercentage.toStringAsFixed(1)}%)';
  }
}

/// 消息加载策略
class MessageLoadingStrategy {
  /// 初始加载数量
  final int initialLoadCount;

  /// 每次加载更多的数量
  final int loadMoreCount;

  /// 预加载阈值（距离底部多少条时开始加载）
  final int preloadThreshold;

  const MessageLoadingStrategy({
    this.initialLoadCount = 30,
    this.loadMoreCount = 20,
    this.preloadThreshold = 10,
  });

  /// 默认策略
  static const defaultStrategy = MessageLoadingStrategy();

  /// 高性能策略（适用于低端设备）
  static const lowEndStrategy = MessageLoadingStrategy(
    initialLoadCount: 20,
    loadMoreCount: 15,
    preloadThreshold: 5,
  );

  /// 高端设备策略
  static const highEndStrategy = MessageLoadingStrategy(
    initialLoadCount: 50,
    loadMoreCount: 30,
    preloadThreshold: 15,
  );
}

/// 消息渲染优化器
class MessageRenderOptimizer {
  /// 消息高度缓存
  final Map<String, double> _heightCache = {};

  /// 获取缓存的消息高度
  double? getCachedHeight(String messageId) {
    return _heightCache[messageId];
  }

  /// 缓存消息高度
  void cacheHeight(String messageId, double height) {
    _heightCache[messageId] = height;
  }

  /// 清除高度缓存
  void clearHeightCache() {
    _heightCache.clear();
  }

  /// 估算消息高度（用于初始渲染）
  double estimateHeight(MessageEntity message) {
    switch (message.type) {
      case MessageType.text:
        // 根据内容长度估算
        final lines = (message.content.length / 30).ceil();
        return 44.0 + (lines * 20.0);
      case MessageType.image:
        return 200.0;
      case MessageType.video:
        return 200.0;
      case MessageType.audio:
        return 60.0;
      case MessageType.file:
        return 72.0;
      case MessageType.system:
        return 32.0;
      default:
        return 60.0;
    }
  }
}
