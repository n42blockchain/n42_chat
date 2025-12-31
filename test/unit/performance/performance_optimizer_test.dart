import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/performance/performance_optimizer.dart';

void main() {
  group('Debouncer', () {
    test('should debounce multiple calls', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      int callCount = 0;

      // 快速调用多次
      debouncer.run(() => callCount++);
      debouncer.run(() => callCount++);
      debouncer.run(() => callCount++);

      // 等待防抖时间过后
      await Future<void>.delayed(const Duration(milliseconds: 150));

      // 应该只执行一次
      expect(callCount, 1);

      debouncer.dispose();
    });

    test('should cancel pending calls', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      int callCount = 0;

      debouncer.run(() => callCount++);
      debouncer.cancel();

      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(callCount, 0);

      debouncer.dispose();
    });
  });

  group('Throttler', () {
    test('should throttle rapid calls', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      int callCount = 0;

      // 快速调用多次
      for (int i = 0; i < 5; i++) {
        throttler.run(() => callCount++);
      }

      // 第一次调用应该立即执行
      expect(callCount, 1);

      // 等待节流时间过后
      await Future<void>.delayed(const Duration(milliseconds: 150));

      // 再次调用
      throttler.run(() => callCount++);
      expect(callCount, 2);
    });
  });

  group('LazyLoader', () {
    test('should lazy initialize', () {
      int initCount = 0;
      final lazy = LazyLoader<int>(() {
        initCount++;
        return 42;
      });

      expect(lazy.isInitialized, isFalse);
      expect(initCount, 0);

      // 第一次访问会初始化
      expect(lazy.value, 42);
      expect(lazy.isInitialized, isTrue);
      expect(initCount, 1);

      // 后续访问不会重新初始化
      expect(lazy.value, 42);
      expect(initCount, 1);
    });

    test('should reset and reinitialize', () {
      int initCount = 0;
      final lazy = LazyLoader<int>(() {
        initCount++;
        return initCount * 10;
      });

      expect(lazy.value, 10);
      expect(initCount, 1);

      lazy.reset();
      expect(lazy.isInitialized, isFalse);

      expect(lazy.value, 20);
      expect(initCount, 2);
    });
  });

  group('GenericCache', () {
    test('should cache and retrieve values', () {
      final cache = GenericCache<String, int>(maxSize: 100);

      cache.set('a', 1);
      cache.set('b', 2);

      expect(cache.get('a'), 1);
      expect(cache.get('b'), 2);
      expect(cache.get('c'), isNull);
    });

    test('should evict when max size reached (LRU)', () async {
      final cache = GenericCache<String, int>(
        maxSize: 3,
        strategy: CacheStrategy.lru,
      );

      cache.set('a', 1);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      cache.set('b', 2);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      cache.set('c', 3);

      // 访问'a'使其成为最近访问的
      cache.get('a');
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // 添加新项目，应该淘汰'b'
      cache.set('d', 4);

      expect(cache.get('a'), 1);
      expect(cache.get('b'), isNull);
      expect(cache.get('c'), 3);
      expect(cache.get('d'), 4);
    });

    test('should clear cache', () {
      final cache = GenericCache<String, int>(maxSize: 100);

      cache.set('a', 1);
      cache.set('b', 2);

      cache.clear();

      expect(cache.get('a'), isNull);
      expect(cache.get('b'), isNull);
      expect(cache.size, 0);
    });
  });

  group('BatchProcessor', () {
    test('should process items in batches', () async {
      final processedBatches = <List<int>>[];
      final processor = BatchProcessor<int>(
        batchSize: 3,
        batchDelay: const Duration(milliseconds: 50),
        processor: (items) async {
          processedBatches.add(items);
        },
      );

      // 添加5个项目
      processor.addAll([1, 2, 3, 4, 5]);

      // 等待处理
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // 应该处理了两批
      expect(processedBatches.length, 2);
      expect(processedBatches[0], [1, 2, 3]);
      expect(processedBatches[1], [4, 5]);
    });

    test('should flush immediately', () async {
      final processedBatches = <List<int>>[];
      final processor = BatchProcessor<int>(
        batchSize: 10,
        batchDelay: const Duration(seconds: 10),
        processor: (items) async {
          processedBatches.add(items);
        },
      );

      processor.addAll([1, 2, 3]);

      // 立即刷新
      await processor.flush();

      expect(processedBatches.length, 1);
      expect(processedBatches[0], [1, 2, 3]);
    });
  });
}

