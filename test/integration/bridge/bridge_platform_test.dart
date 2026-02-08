import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/n42_chat.dart';

void main() {
  group('BridgePlatform enum', () {
    test('should have 15 platforms', () {
      expect(BridgePlatform.values.length, 15);
    });

    test('should include all expected platforms', () {
      expect(BridgePlatform.values, containsAll([
        BridgePlatform.discord,
        BridgePlatform.meta,
        BridgePlatform.twitter,
        BridgePlatform.linkedin,
        BridgePlatform.whatsapp,
        BridgePlatform.signal,
        BridgePlatform.googleMessages,
        BridgePlatform.googleVoice,
        BridgePlatform.slack,
        BridgePlatform.bluesky,
        BridgePlatform.irc,
        BridgePlatform.zulip,
        BridgePlatform.telegram,
        BridgePlatform.imessage,
        BridgePlatform.googleChat,
      ]));
    });
  });

  group('BridgePlatformInfo', () {
    test('should have info for every platform', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info, isNotNull);
        expect(info.platform, platform);
      }
    });

    test('each platform should have non-empty display name', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info.displayName, isNotEmpty);
      }
    });

    test('each platform should have a bot username', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info.botUsername, isNotEmpty);
        expect(info.botUsername, isNot(contains('@')));
        expect(info.botUsername, isNot(contains(':')));
      }
    });

    test('each platform should have a repo name', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info.repoName, isNotEmpty);
      }
    });

    test('each platform should have at least one auth method', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info.authMethods, isNotEmpty);
      }
    });

    test('botUserId should format correctly', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.discord);
      expect(info.botUserId('matrix.org'), '@discordbot:matrix.org');
    });

    test('brand colors should be valid', () {
      for (final platform in BridgePlatform.values) {
        final info = BridgePlatformRegistry.getInfo(platform);
        expect(info.brandColor, isA<Color>());
      }
    });
  });

  group('BridgePlatformRegistry', () {
    test('allPlatforms should return 15 platforms', () {
      expect(BridgePlatformRegistry.allPlatforms.length, 15);
    });

    test('activePlatforms should exclude low-maintenance bridges', () {
      final active = BridgePlatformRegistry.activePlatforms;
      expect(active.length, 12); // 15 - 3 low maintenance
      expect(active.every((p) => p.isActive), isTrue);
    });

    test('groupedByStatus should separate active and inactive', () {
      final grouped = BridgePlatformRegistry.groupedByStatus;
      expect(grouped[true]?.length, 12); // Active
      expect(grouped[false]?.length, 3); // Telegram, iMessage, Google Chat
    });

    test('findByBotUsername should find existing bot', () {
      final info = BridgePlatformRegistry.findByBotUsername('discordbot');
      expect(info, isNotNull);
      expect(info!.platform, BridgePlatform.discord);
    });

    test('findByBotUsername should return null for unknown bot', () {
      final info = BridgePlatformRegistry.findByBotUsername('unknownbot');
      expect(info, isNull);
    });

    test('bot usernames should be unique', () {
      final usernames = <String>{};
      for (final info in BridgePlatformRegistry.allPlatforms) {
        expect(usernames.add(info.botUsername), isTrue,
            reason: '${info.botUsername} is duplicated');
      }
    });
  });

  group('BridgeAuthMethod', () {
    test('should have expected values', () {
      expect(BridgeAuthMethod.values, containsAll([
        BridgeAuthMethod.qrCode,
        BridgeAuthMethod.emailPassword,
        BridgeAuthMethod.phoneVerification,
        BridgeAuthMethod.oauth,
        BridgeAuthMethod.apiToken,
        BridgeAuthMethod.usernamePassword,
        BridgeAuthMethod.none,
      ]));
    });
  });

  group('Platform-specific checks', () {
    test('Discord should support relay mode', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.discord);
      expect(info.supportsRelay, isTrue);
    });

    test('Twitter should not support groups', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.twitter);
      expect(info.supportsGroups, isFalse);
    });

    test('WhatsApp should use QR code auth', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.whatsapp);
      expect(info.authMethods, contains(BridgeAuthMethod.qrCode));
    });

    test('Telegram should be marked as inactive', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.telegram);
      expect(info.isActive, isFalse);
      expect(info.language, 'Python');
    });

    test('IRC should support no-auth login', () {
      final info = BridgePlatformRegistry.getInfo(BridgePlatform.irc);
      expect(info.authMethods, contains(BridgeAuthMethod.none));
    });
  });
}
