import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/performance/message_cache.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

void main() {
  group('MessageCacheManager', () {
    late MessageCacheManager cacheManager;

    setUp(() {
      cacheManager = MessageCacheManager(
        maxMessagesPerRoom: 10,
        maxTotalMessages: 50,
        cacheExpiry: const Duration(hours: 1),
      );
    });

    MessageEntity createMessage(String id, String roomId) {
      return MessageEntity(
        id: id,
        roomId: roomId,
        senderId: '@user:server.com',
        senderName: 'Test User',
        content: 'Test message $id',
        timestamp: DateTime.now(),
        type: MessageType.text,
        status: MessageStatus.sent,
      );
    }

    test('should cache and retrieve messages', () {
      final messages = [
        createMessage('1', 'room1'),
        createMessage('2', 'room1'),
        createMessage('3', 'room1'),
      ];

      cacheManager.cacheMessages('room1', messages);

      final cached = cacheManager.getMessages('room1');
      expect(cached.length, 3);
      expect(cached[0].id, '1');
    });

    test('should respect max messages per room', () {
      final messages = List.generate(
        15,
        (i) => createMessage('$i', 'room1'),
      );

      cacheManager.cacheMessages('room1', messages);

      final cached = cacheManager.getMessages('room1');
      expect(cached.length, 10); // maxMessagesPerRoom
    });

    test('should add new messages', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
        createMessage('2', 'room1'),
      ]);

      cacheManager.addMessage('room1', createMessage('3', 'room1'));

      final cached = cacheManager.getMessages('room1');
      expect(cached.length, 3);
      expect(cached.last.id, '3');
    });

    test('should update existing messages', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
      ]);

      final updatedMessage = MessageEntity(
        id: '1',
        roomId: 'room1',
        senderId: '@user:server.com',
        senderName: 'Test User',
        content: 'Updated content',
        timestamp: DateTime.now(),
        type: MessageType.text,
        status: MessageStatus.sent,
      );

      cacheManager.updateMessage('room1', updatedMessage);

      final cached = cacheManager.getMessages('room1');
      expect(cached.first.content, 'Updated content');
    });

    test('should remove messages', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
        createMessage('2', 'room1'),
      ]);

      cacheManager.removeMessage('room1', '1');

      final cached = cacheManager.getMessages('room1');
      expect(cached.length, 1);
      expect(cached.first.id, '2');
    });

    test('should clear room cache', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
      ]);
      cacheManager.cacheMessages('room2', [
        createMessage('2', 'room2'),
      ]);

      cacheManager.clearRoom('room1');

      expect(cacheManager.getMessages('room1'), isEmpty);
      expect(cacheManager.getMessages('room2').length, 1);
    });

    test('should clear all caches', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
      ]);
      cacheManager.cacheMessages('room2', [
        createMessage('2', 'room2'),
      ]);

      cacheManager.clearAll();

      expect(cacheManager.getMessages('room1'), isEmpty);
      expect(cacheManager.getMessages('room2'), isEmpty);
    });

    test('should provide cache stats', () {
      cacheManager.cacheMessages('room1', [
        createMessage('1', 'room1'),
        createMessage('2', 'room1'),
      ]);
      cacheManager.cacheMessages('room2', [
        createMessage('3', 'room2'),
      ]);

      final stats = cacheManager.getStats();
      expect(stats.roomCount, 2);
      expect(stats.totalMessages, 3);
      expect(stats.maxMessages, 50);
    });
  });

  group('MessageRenderOptimizer', () {
    late MessageRenderOptimizer optimizer;

    setUp(() {
      optimizer = MessageRenderOptimizer();
    });

    test('should cache and retrieve heights', () {
      optimizer.cacheHeight('msg1', 60.0);
      optimizer.cacheHeight('msg2', 120.0);

      expect(optimizer.getCachedHeight('msg1'), 60.0);
      expect(optimizer.getCachedHeight('msg2'), 120.0);
      expect(optimizer.getCachedHeight('msg3'), isNull);
    });

    test('should clear height cache', () {
      optimizer.cacheHeight('msg1', 60.0);
      optimizer.clearHeightCache();

      expect(optimizer.getCachedHeight('msg1'), isNull);
    });

    test('should estimate heights for different message types', () {
      final textMessage = MessageEntity(
        id: '1',
        roomId: 'room1',
        senderId: '@user:server.com',
        senderName: 'Test',
        content: 'Short message',
        timestamp: DateTime.now(),
        type: MessageType.text,
        status: MessageStatus.sent,
      );

      final imageMessage = MessageEntity(
        id: '2',
        roomId: 'room1',
        senderId: '@user:server.com',
        senderName: 'Test',
        content: 'image.jpg',
        timestamp: DateTime.now(),
        type: MessageType.image,
        status: MessageStatus.sent,
      );

      final audioMessage = MessageEntity(
        id: '3',
        roomId: 'room1',
        senderId: '@user:server.com',
        senderName: 'Test',
        content: 'audio.m4a',
        timestamp: DateTime.now(),
        type: MessageType.audio,
        status: MessageStatus.sent,
      );

      expect(optimizer.estimateHeight(textMessage), greaterThan(0));
      expect(optimizer.estimateHeight(imageMessage), 200.0);
      expect(optimizer.estimateHeight(audioMessage), 60.0);
    });
  });
}

