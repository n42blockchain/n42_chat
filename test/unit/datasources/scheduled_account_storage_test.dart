import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('room mismatch preserves records while legacy room identity stays stable', () async {
    final storage = PreferencesDataSource();
    await storage.saveScheduledMessage(roomId: 'room', messageId: 'identity',
      text: 'keep', scheduledAt: DateTime(2020));
    final prefs = await SharedPreferences.getInstance();
    const key = 'n42_chat_scheduled_messages';
    final original = jsonDecode(prefs.getString(key)!) as Map<String, dynamic>;
    final record = Map<String, dynamic>.from((original['room'] as List).single as Map);
    for (final wrongRoom in ['other-room', '']) {
      final raw = jsonEncode({'room': [{...record, 'roomId': wrongRoom}]});
      await prefs.setString(key, raw);
      await expectLater(storage.getScheduledMessages('room'), throwsFormatException);
      await expectLater(storage.getDueScheduledMessages(), throwsFormatException);
      expect(prefs.getString(key), raw);
    }
    for (final legacy in [false, true]) {
      final repaired = {...record, 'roomId': 'room'};
      if (legacy) repaired.remove('roomId');
      await prefs.setString(key, jsonEncode({'room': [repaired]}));
      final listed = (await storage.getScheduledMessages('room')).single;
      final due = (await storage.getDueScheduledMessages()).single;
      expect(listed.roomId, 'room');
      expect(due.roomId, 'room');
      expect(listed.transactionId, due.transactionId);
      expect(listed.text, 'keep');
    }
  });

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

  test('server receipt survives reload, clears backoff and cannot be downgraded', () async {
    final storage = PreferencesDataSource();
    await storage.saveScheduledMessage(roomId: 'room', ownerUserId: '@a:test', messageId: 'accepted', text: 'Sent', scheduledAt: DateTime(2020));
    await storage.markScheduledDeliveryUnconfirmed(ownerUserId: '@a:test', roomId: 'room', messageId: 'accepted');
    expect(await storage.markScheduledDeliveryAccepted(ownerUserId: '@a:test', roomId: 'room', messageId: 'accepted', eventId: r'$event'), true);
    final restored = (await PreferencesDataSource().getDueScheduledMessages(ownerUserId: '@a:test')).single;
    expect(restored.acceptedEventId, r'$event');
    expect(restored.copyWith(roomId: 'room').acceptedEventId, r'$event');
    expect(restored.deliveryUnconfirmed, false);
    expect(restored.retryAt, null);
    expect(restored.failedAttempts, 0);
    expect(await storage.markScheduledDeliveryUnconfirmed(ownerUserId: '@a:test', roomId: 'room', messageId: 'accepted'), false);
    expect(await storage.markScheduledDeliveryAccepted(ownerUserId: '@b:test', roomId: 'room', messageId: 'accepted', eventId: r'$other'), false);
    await storage.removeScheduledMessage('room', 'accepted', ownerUserId: '@a:test');
    expect(await storage.markScheduledDeliveryAccepted(ownerUserId: '@a:test', roomId: 'room', messageId: 'accepted', eventId: r'$event'), false);
  });

  test(
    'due scan rejects partial corrupt queues and resumes after explicit repair',
    () async {
      final storage = PreferencesDataSource();
      await storage.saveScheduledMessage(
        roomId: 'room',
        messageId: 'valid',
        text: 'keep',
        scheduledAt: DateTime(2020),
      );
      final prefs = await SharedPreferences.getInstance();
      const key = 'n42_chat_scheduled_messages';
      final original = prefs.getString(key)!;
      final good = jsonDecode(original) as Map<String, dynamic>;
      for (final broken in <Object?>[
        42,
        null,
        'not a message',
        {},
        {...(good['room'] as List).single as Map, 'type': 'futureType'},
        {...(good['room'] as List).single as Map, 'scheduledAt': 'broken'},
      ]) {
        final raw = jsonEncode({
          'room': [...good['room'] as List, broken],
        });
        await prefs.setString(key, raw);
        await expectLater(storage.getDueScheduledMessages(), throwsA(anything));
        await expectLater(
          storage.getScheduledMessages('room'),
          throwsA(anything),
        );
        await expectLater(storage.getDueScheduledMessages(), throwsA(anything));
        expect(prefs.getString(key), raw);
      }
      await prefs.setString(key, original);
      expect(
        (await storage.getDueScheduledMessages()).single.messageId,
        'valid',
      );
    },
  );

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
        await expectLater(storage.getDueScheduledMessages(), throwsA(anything));
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
    await expectLater(storage.getDueScheduledMessages(ownerUserId: ''), throwsArgumentError);
    await expectLater(
      storage.getScheduledMessages(
        '!room:test',
        ownerUserId: ' @a:test ',
      ),
      throwsArgumentError,
    );
  });
}
