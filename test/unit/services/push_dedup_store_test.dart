import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/notifications/push_dedup_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 测试 PushDedupStore 跨通道推送去重存储：
/// - 基本去重（首次 true / 重复 false）
/// - TTL 过期后允许重新标记
/// - 容量裁剪丢弃最旧条目
/// - 持久化：新实例（模拟另一 isolate）看到相同状态
/// - notificationIdForKey 稳定哈希
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  group('tryMarkNotified', () {
    test('first mark returns true, duplicate returns false', () async {
      final store = PushDedupStore(prefsKey: 'test.keys');

      expect(await store.tryMarkNotified(r'$event1'), isTrue);
      expect(await store.tryMarkNotified(r'$event1'), isFalse);
    });

    test('different keys do not interfere', () async {
      final store = PushDedupStore(prefsKey: 'test.keys');

      expect(await store.tryMarkNotified(r'$event1'), isTrue);
      expect(await store.tryMarkNotified(r'$event2'), isTrue);
      expect(await store.tryMarkNotified(r'$event1'), isFalse);
      expect(await store.tryMarkNotified(r'$event2'), isFalse);
    });

    test('a new store instance sees previously marked keys', () async {
      // 模拟跨 isolate：两个实例共享同一 SharedPreferences 底层存储。
      final storeA = PushDedupStore(prefsKey: 'test.keys');
      final storeB = PushDedupStore(prefsKey: 'test.keys');

      expect(await storeA.tryMarkNotified(r'$event1'), isTrue);
      expect(await storeB.tryMarkNotified(r'$event1'), isFalse);
    });

    test('expired entries can be marked again', () async {
      var now = DateTime(2026, 6, 12, 10, 0, 0);
      final store = PushDedupStore(
        prefsKey: 'test.keys',
        ttl: const Duration(hours: 1),
        now: () => now,
      );

      expect(await store.tryMarkNotified(r'$event1'), isTrue);
      now = now.add(const Duration(minutes: 59));
      expect(await store.tryMarkNotified(r'$event1'), isFalse);
      now = now.add(const Duration(minutes: 2));
      expect(await store.tryMarkNotified(r'$event1'), isTrue);
    });

    test('capacity pruning drops oldest entries', () async {
      final store = PushDedupStore(prefsKey: 'test.keys', capacity: 3);

      expect(await store.tryMarkNotified('k1'), isTrue);
      expect(await store.tryMarkNotified('k2'), isTrue);
      expect(await store.tryMarkNotified('k3'), isTrue);
      // k4 入列后 k1 被裁掉。
      expect(await store.tryMarkNotified('k4'), isTrue);

      expect(await store.tryMarkNotified('k1'), isTrue,
          reason: '最旧条目应已被容量裁剪丢弃');
      expect(await store.tryMarkNotified('k4'), isFalse);
    });

    test('concurrent marks of the same key only pass once', () async {
      final store = PushDedupStore(prefsKey: 'test.keys');

      final results = await Future.wait(<Future<bool>>[
        store.tryMarkNotified(r'$race'),
        store.tryMarkNotified(r'$race'),
        store.tryMarkNotified(r'$race'),
      ]);

      expect(results.where((r) => r).length, 1,
          reason: '同 isolate 内并发标记同一键只应有一次通过');
    });

    test('corrupted entries are ignored gracefully', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'test.keys': <String>['not-a-valid-entry', '|empty-ts', 'abc|x'],
      });
      final store = PushDedupStore(prefsKey: 'test.keys');

      expect(await store.tryMarkNotified(r'$event1'), isTrue);
    });
  });

  group('notificationIdForKey', () {
    test('is stable across calls and instances', () {
      final id1 = PushDedupStore.notificationIdForKey(r'$event:abc123');
      final id2 = PushDedupStore.notificationIdForKey(r'$event:abc123');
      expect(id1, id2);
    });

    test('is within positive 32-bit int range (Android notification id)', () {
      for (final key in <String>['a', r'$long:event:id:value', '中文键', '']) {
        final id = PushDedupStore.notificationIdForKey(key);
        expect(id, greaterThanOrEqualTo(0));
        expect(id, lessThanOrEqualTo(0x7FFFFFFF));
      }
    });

    test('different keys map to different ids (no trivial collisions)', () {
      final ids = <int>{};
      for (var i = 0; i < 1000; i++) {
        ids.add(PushDedupStore.notificationIdForKey('\$event:$i'));
      }
      expect(ids.length, 1000);
    });
  });
}
