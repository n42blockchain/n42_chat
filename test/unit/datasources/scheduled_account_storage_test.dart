import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('unconfirmed attempts persist without changing payload, identity or other accounts', () async {
    final storage = PreferencesDataSource();
    for (final user in ['@a:test', '@b:test']) {
      await storage.saveScheduledMessage(roomId: 'room', ownerUserId: user,
        messageId: 'draft', text: 'keep', scheduledAt: DateTime(2020), payload: {'filename': 'keep.txt'});
    }
    final before = (await storage.getScheduledMessages('room', ownerUserId: '@a:test')).single;
    expect(await storage.markScheduledDeliveryUnconfirmed(ownerUserId: '@a:test', roomId: 'room', messageId: 'draft'), true);
    final restored = (await PreferencesDataSource().getScheduledMessages('room', ownerUserId: '@a:test')).single;
    expect(restored.deliveryUnconfirmed, true);
    expect(restored.transactionId, before.transactionId);
    expect(restored.createdAt, before.createdAt);
    expect(restored.payload, before.payload);
    expect(restored.copyWith(roomId: 'room').deliveryUnconfirmed, true);
    expect((await storage.getScheduledMessages('room', ownerUserId: '@b:test')).single.deliveryUnconfirmed, false);
    await storage.removeScheduledMessage('room', 'draft', ownerUserId: '@a:test');
    expect(await storage.markScheduledDeliveryUnconfirmed(ownerUserId: '@a:test', roomId: 'room', messageId: 'draft'), false);
    expect(await storage.getScheduledMessages('room', ownerUserId: '@a:test'), isEmpty);
  });

  test('retry deadlines and bounded backoff survive storage recreation', () async {
    final storage = PreferencesDataSource();
    await storage.saveScheduledMessage(roomId: 'room', ownerUserId: '@a:test',
      messageId: 'backoff', text: 'keep', scheduledAt: DateTime(2020));
    final original = (await storage.getScheduledMessages('room', ownerUserId: '@a:test')).single;
    for (final delay in [1, 2, 4, 8, 16, 30, 30]) {
      final before = DateTime.now();
      await storage.markScheduledDeliveryUnconfirmed(ownerUserId: '@a:test', roomId: 'room', messageId: 'backoff');
      final after = DateTime.now();
      final recreated = PreferencesDataSource();
      final draft = (await recreated.getScheduledMessages('room', ownerUserId: '@a:test')).single;
      expect(draft.retryAt!.isBefore(before.add(Duration(minutes: delay))), false);
      expect(draft.retryAt!.isAfter(after.add(Duration(minutes: delay))), false);
      expect(draft.failedAttempts, inInclusiveRange(1, 6));
      expect(draft.transactionId, original.transactionId);
      expect(draft.isDue(draft.retryAt!.subtract(const Duration(microseconds: 1))), false);
      expect(draft.isDue(draft.retryAt!), true);
      expect(draft.copyWith(roomId: 'room').retryAt, draft.retryAt);
      expect(await recreated.getDueScheduledMessages(ownerUserId: '@a:test'), isEmpty);
    }
  });

  for (final malformed in ['{', '{"room":[42]}']) {
    test(
      'room read reports corruption and preserves stored bytes: $malformed',
      () async {
        SharedPreferences.setMockInitialValues({
          'n42_chat_scheduled_messages': malformed,
        });
        final storage = PreferencesDataSource();
        await expectLater(
          storage.getScheduledMessages('room'),
          throwsA(anything),
        );
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('n42_chat_scheduled_messages'), malformed);
        await prefs.remove('n42_chat_scheduled_messages');
        expect(await storage.getScheduledMessages('room'), isEmpty);
      },
    );
  }

  test(
    'same room and draft IDs stay separate across accounts and legacy storage',
    () async {
      final storage = PreferencesDataSource();
      for (final owner in <String?>[null, '@a:test', '@b:test']) {
        await storage.saveScheduledMessage(
          ownerUserId: owner,
          roomId: '!room:test',
          messageId: 'same',
          text: owner ?? 'legacy',
          scheduledAt: DateTime(2020),
        );
      }
      for (final owner in ['@a:test', '@b:test']) {
        expect(
          (await storage.getDueScheduledMessages(ownerUserId: owner))
              .single
              .text,
          owner,
        );
      }
      await storage.removeScheduledMessage(
        '!room:test',
        'same',
        ownerUserId: '@a:test',
      );
      expect(
        await storage.getDueScheduledMessages(ownerUserId: '@a:test'),
        isEmpty,
      );
      expect(
        (await storage.getScheduledMessages(
          '!room:test',
          ownerUserId: '@b:test',
        )).single.text,
        '@b:test',
      );
      await storage.clearScheduledMessages(
        '!room:test',
        ownerUserId: '@b:test',
      );
      expect(
        await storage.getDueScheduledMessages(ownerUserId: '@b:test'),
        isEmpty,
      );
      expect(
        (await storage.getScheduledMessages('!room:test')).single.text,
        'legacy',
      );
    },
  );

  test('concurrent account writes preserve every namespace', () async {
    final storage = PreferencesDataSource();
    await Future.wait(
      List.generate(
        40,
        (i) => storage.saveScheduledMessage(
          ownerUserId: '@user$i:test',
          roomId: '!room:test',
          messageId: 'same',
          text: '$i',
          scheduledAt: DateTime(2020),
        ),
      ),
    );
    for (var i = 0; i < 40; i++) {
      expect(
        (await storage.getDueScheduledMessages(ownerUserId: '@user$i:test'))
            .single
            .text,
        '$i',
      );
    }
    expect(await storage.getDueScheduledMessages(), isEmpty);
  });

  test('blank owner cannot silently access legacy drafts', () async {
    final storage = PreferencesDataSource();
    expect(await storage.getDueScheduledMessages(ownerUserId: ''), isEmpty);
    await expectLater(
      storage.getScheduledMessages(
        '!room:test',
        ownerUserId: ' @a:test ',
      ),
      throwsArgumentError,
    );
  });
}
