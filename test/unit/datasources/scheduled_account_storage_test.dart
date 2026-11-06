import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

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
