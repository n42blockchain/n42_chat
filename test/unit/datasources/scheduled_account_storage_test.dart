import 'dart:convert';
import 'dart:async';
import 'package:n42_chat/src/data/services/scheduled_draft_operation.dart';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

class _RejectRecoveryStore extends InMemorySharedPreferencesStore {
  bool reject = false;
  bool rejectRemove = false;
  Future<void> Function()? beforeRecoveryWrite;
  _RejectRecoveryStore() : super.empty();
  @override
  Future<bool> setValue(String type, String key, Object value) async {
    if (key.contains('_recovery_')) await beforeRecoveryWrite?.call();
    if (reject && key.contains('_recovery_')) return false;
    return super.setValue(type, key, value);
  }
  @override
  Future<bool> remove(String key) async => rejectRemove ? false : super.remove(key);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('confirmed corrupt reset preserves bytes and other account while allowing new drafts', () async {
    final store = PreferencesDataSource();
    const owner = '@reset:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    const raw = '{damaged original';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, raw);
    await store.saveScheduledMessage(ownerUserId: '@other:test', roomId: 'room', messageId: 'other', text: 'other account', scheduledAt: DateTime(2030));
    await store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: raw, isCurrent: () => true);
    expect(prefs.getString(key), isNull);
    expect((await store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true)).single.raw, raw);
    expect((await store.getScheduledMessages('room', ownerUserId: '@other:test')).single.text, 'other account');
    await store.saveScheduledMessage(ownerUserId: owner, roomId: 'room', messageId: 'new', text: 'new draft', scheduledAt: DateTime(2030));
    expect((await store.getScheduledMessages('room', ownerUserId: owner)).single.text, 'new draft');
  });
  test('reset rejects healthy, changed and stale queues without deleting data', () async {
    final store = PreferencesDataSource();
    const owner = '@reset:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    for (final raw in ['{}', '{"room":[]}', '{newer damage']) {
      await prefs.setString(key, raw);
      await expectLater(store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: raw.startsWith('{newer') ? '{old damage' : raw, isCurrent: () => true), throwsStateError);
      expect(prefs.getString(key), raw);
    }
    var checks = 0;
    await expectLater(store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: '{newer damage', isCurrent: () => ++checks < 3), throwsStateError);
    expect(prefs.getString(key), '{newer damage');
  });
  for (final failBackup in [true, false]) {
    test('reset preserves queue on failed ${failBackup ? 'backup' : 'removal'} acknowledgement', () async {
      final platform = _RejectRecoveryStore();
      SharedPreferencesStorePlatform.instance = platform;
      final store = PreferencesDataSource();
      const owner = '@reset:test';
      final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, '{damaged');
      platform.reject = failBackup; platform.rejectRemove = !failBackup;
      await expectLater(store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: '{damaged', isCurrent: () => true), throwsStateError);
      expect(prefs.getString(key), '{damaged');
      platform.reject = false; platform.rejectRemove = false;
      await store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: '{damaged', isCurrent: () => true);
      expect(prefs.getString(key), isNull);
      expect((await store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true)).single.raw, '{damaged');
    });
  }
  test('reset excludes in-flight sends and preserves a save queued during recovery', () async {
    final platform = _RejectRecoveryStore();
    SharedPreferencesStorePlatform.instance = platform;
    final store = PreferencesDataSource();
    const owner = '@reset:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '{damaged');
    final sending = ScheduledDraftOperation.tryAcquire(ownerUserId: owner, roomId: 'room', messageId: 'sending')!;
    await expectLater(store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: '{damaged', isCurrent: () => true), throwsStateError);
    sending.release();
    final entered = Completer<void>(); final release = Completer<void>();
    platform.beforeRecoveryWrite = () async { entered.complete(); await release.future; };
    final reset = store.resetCorruptScheduledMessages(ownerUserId: owner, expectedRaw: '{damaged', isCurrent: () => true);
    await entered.future;
    expect(ScheduledDraftOperation.tryAcquire(ownerUserId: owner, roomId: 'another', messageId: 'new'), isNull);
    final save = store.saveScheduledMessage(ownerUserId: owner, roomId: 'room', messageId: 'new', text: 'queued during recovery', scheduledAt: DateTime(2030));
    release.complete(); await reset; await save;
    expect((await store.getScheduledMessages('room', ownerUserId: owner)).single.text, 'queued during recovery');
  });

  test(
    'rejected recovery write does not claim success or change queue',
    () async {
      final platform = _RejectRecoveryStore();
      SharedPreferencesStorePlatform.instance = platform;
      final store = PreferencesDataSource();
      await store.saveScheduledMessage(
        roomId: 'room',
        ownerUserId: '@a:test',
        messageId: 'draft',
        text: 'keep',
        scheduledAt: DateTime(2030),
      );
      final prefs = await SharedPreferences.getInstance();
      final original = Map.fromEntries(
        prefs.getKeys().map((key) => MapEntry(key, prefs.getString(key))),
      );
      platform.reject = true;
      await expectLater(
        store.saveScheduledRecoveryCopy(
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        throwsStateError,
      );
      expect(
        Map.fromEntries(
          prefs.getKeys().map((key) => MapEntry(key, prefs.getString(key))),
        ),
        original,
      );
      platform.reject = false;
      expect(
        await store.saveScheduledRecoveryCopy(
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        isNotNull,
      );
      expect(
        (await store.getScheduledMessages(
          'room',
          ownerUserId: '@a:test',
        )).single.text,
        'keep',
      );
    },
  );

  test('recovery copy preserves exact corrupt bytes and never claims legacy data', () async {
    const owner = '@a:test';
    final key =
        'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    const raw = '{damaged json with private text';
    SharedPreferences.setMockInitialValues({
      key: raw,
      'n42_chat_scheduled_messages': 'unowned',
    });
    final store = PreferencesDataSource();
    expect(
      await store.saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => true,
      ),
      raw,
    );
    expect(
      await PreferencesDataSource().saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => true,
      ),
      raw,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final copies = prefs
        .getKeys()
        .where((key) => key.contains('_recovery_'))
        .toList();
    expect(copies, hasLength(1));
    expect(prefs.getString(copies.single), raw);
    expect(prefs.getString(key), raw);
    expect(prefs.getString('n42_chat_scheduled_messages'), 'unowned');
    expect(
      await store.saveScheduledRecoveryCopy(
        ownerUserId: '@b:test',
        isCurrent: () => true,
      ),
      isNull,
    );
    await expectLater(
      store.getDueScheduledMessages(ownerUserId: owner),
      throwsFormatException,
    );
    await prefs.remove(key);
    expect(await store.getDueScheduledMessages(ownerUserId: owner), isEmpty);
    expect(prefs.getString(copies.single), raw);
  });

  test('stale recovery and conflicting copy preserve source without overwriting', () async {
    const owner = '@a:test';
    final key =
        'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    const raw = '{original';
    final backup = '${key}_recovery_${sha256.convert(utf8.encode(raw))}';
    SharedPreferences.setMockInitialValues({key: raw});
    final store = PreferencesDataSource();
    var checks = 0;
    await expectLater(
      store.saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => ++checks == 1,
      ),
      throwsStateError,
    );
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey(backup), false);
    await prefs.setString(backup, 'preserve conflicting copy');
    await expectLater(
      store.saveScheduledRecoveryCopy(
        ownerUserId: owner,
        isCurrent: () => true,
      ),
      throwsStateError,
    );
    expect(prefs.getString(backup), 'preserve conflicting copy');
    expect(prefs.getString(key), raw);
  });

  test('reviewed copy deletion preserves queue and rejects stale or foreign requests', () async {
    final store = PreferencesDataSource();
    const owner = '@delete:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    for (final raw in ['first', 'second']) {
      await prefs.setString(key, raw);
      await store.saveScheduledRecoveryCopy(ownerUserId: owner, isCurrent: () => true);
    }
    var checks = 0;
    await expectLater(store.deleteScheduledRecoveryCopy(ownerUserId: owner, expectedRaw: 'first', isCurrent: () => ++checks == 1), throwsStateError);
    await expectLater(store.deleteScheduledRecoveryCopy(ownerUserId: '@other:test', expectedRaw: 'first', isCurrent: () => true), throwsStateError);
    await store.deleteScheduledRecoveryCopy(ownerUserId: owner, expectedRaw: 'first', isCurrent: () => true);
    expect(prefs.getString(key), 'second');
    expect((await store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true)).single.raw, 'second');
    final backup = '${key}_recovery_${sha256.convert(utf8.encode('second'))}';
    await prefs.setString(backup, 'changed bytes');
    await expectLater(store.deleteScheduledRecoveryCopy(ownerUserId: owner, expectedRaw: 'second', isCurrent: () => true), throwsStateError);
    expect(prefs.getString(backup), 'changed bytes');
  });
  test('rejected copy deletion reloads and preserves the copy', () async {
    final platform = _RejectRecoveryStore();
    SharedPreferences.resetStatic();
    SharedPreferencesStorePlatform.instance = platform;
    final store = PreferencesDataSource();
    const owner = '@delete:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, 'reviewed');
    await store.saveScheduledRecoveryCopy(ownerUserId: owner, isCurrent: () => true);
    platform.rejectRemove = true;
    await expectLater(store.deleteScheduledRecoveryCopy(ownerUserId: owner, expectedRaw: 'reviewed', isCurrent: () => true), throwsStateError);
    expect((await store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true)).single.raw, 'reviewed');
  });

  test('saved copies reopen without active queue and stay account-scoped', () async {
    final store = PreferencesDataSource();
    const owner = '@a:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    for (final raw in ['{first damaged', '{second damaged']) {
      await prefs.setString(key, raw);
      await store.saveScheduledRecoveryCopy(ownerUserId: owner, isCurrent: () => true);
    }
    await prefs.remove(key);
    final copies = await PreferencesDataSource().getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true);
    expect(copies.map((copy) => copy.raw).toSet(), {'{first damaged', '{second damaged'});
    expect(copies.every((copy) => copy.isIntact), true);
    expect(() => copies.clear(), throwsUnsupportedError);
    expect(await store.getScheduledRecoveryCopies(ownerUserId: '@b:test', isCurrent: () => true), isEmpty);
    expect(await store.getDueScheduledMessages(ownerUserId: owner), isEmpty);
  });

  test('damaged copies are reported alongside intact copies without mutation', () async {
    final store = PreferencesDataSource();
    const owner = '@a:test';
    final key = 'n42_chat_scheduled_messages_account_${sha256.convert(utf8.encode(owner))}';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '{valid snapshot');
    await store.saveScheduledRecoveryCopy(ownerUserId: owner, isCurrent: () => true);
    await prefs.setString('${key}_recovery_bad-digest', 'changed bytes');
    await prefs.setInt('${key}_recovery_wrong-type', 42);
    final copies = await store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => true);
    expect(copies.where((copy) => copy.isIntact), hasLength(1));
    expect(copies.where((copy) => !copy.isIntact), hasLength(2));
    expect(prefs.getString('${key}_recovery_bad-digest'), 'changed bytes');
    expect(prefs.getInt('${key}_recovery_wrong-type'), 42);
    var checks = 0;
    await expectLater(store.getScheduledRecoveryCopies(ownerUserId: owner, isCurrent: () => ++checks == 1), throwsStateError);
    await expectLater(store.getScheduledRecoveryCopies(ownerUserId: '', isCurrent: () => true), throwsArgumentError);
  });

  test('corrupt delivery states preserve bytes and prevent due recovery', () async {
    final store = PreferencesDataSource();
    await store.saveScheduledMessage(roomId: 'room', messageId: 'draft',
      text: 'keep', scheduledAt: DateTime(2020));
    final prefs = await SharedPreferences.getInstance();
    const key = 'n42_chat_scheduled_messages';
    final original = jsonDecode(prefs.getString(key)!) as Map<String, dynamic>;
    final draft = Map<String, dynamic>.from((original['room'] as List).single as Map);
    for (final change in [
      {'deliveryUnconfirmed': 'true'}, {'deliveryUnconfirmed': 1},
      {'acceptedEventId': ''}, {'acceptedEventId': ' '}, {'acceptedEventId': 'event\n'},
    ]) {
      final damaged = jsonEncode({'room': [{...draft, ...change}]});
      await prefs.setString(key, damaged);
      await expectLater(store.getScheduledMessages('room'), throwsFormatException);
      await expectLater(store.getDueScheduledMessages(), throwsFormatException);
      expect(prefs.getString(key), damaged);
    }
    await prefs.setString(key, jsonEncode(original));
    expect((await store.getDueScheduledMessages()).single.text, 'keep');
  });

  test('invalid server receipt cannot alter an account draft', () async {
    final store = PreferencesDataSource();
    await store.saveScheduledMessage(roomId: 'room', ownerUserId: '@a:test', messageId: 'draft',
      text: 'keep', scheduledAt: DateTime(2020));
    for (final event in ['', ' ', 'event\n', 'ev\u0000ent']) {
      await expectLater(store.markScheduledDeliveryAccepted(ownerUserId: '@a:test', roomId: 'room', messageId: 'draft', eventId: event), throwsArgumentError);
      final draft = (await store.getScheduledMessages('room', ownerUserId: '@a:test')).single;
      expect(draft.acceptedEventId, isNull); expect(draft.text, 'keep');
    }
    expect(await store.markScheduledDeliveryAccepted(ownerUserId: '@a:test', roomId: 'room', messageId: 'draft', eventId: r'$valid:test'), true);
    expect((await store.getScheduledMessages('room', ownerUserId: '@a:test')).single.acceptedEventId, r'$valid:test');
  });

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
