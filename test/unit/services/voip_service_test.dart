import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/services/voip/voip_config.dart';

void main() {
  group('VoIPConfig', () {
    late VoIPConfig config;

    setUp(() {
      config = VoIPConfig();
      config.reset(); // 重置单例状态
    });

    test('should be a singleton', () {
      final config1 = VoIPConfig();
      final config2 = VoIPConfig();
      expect(identical(config1, config2), isTrue);
    });

    test('should have default values', () {
      expect(config.turnUris, isEmpty);
      expect(config.turnUsername, isNull);
      expect(config.turnPassword, isNull);
      expect(config.liveKitUrl, isNull);
      expect(config.defaultVideoEnabled, isTrue);
      expect(config.defaultAudioEnabled, isTrue);
      expect(config.callTimeout, equals(60));
    });

    test('should update from TURN response', () {
      config.updateFromTurnResponse({
        'uris': ['turn:turn.example.com:3478'],
        'username': 'user123',
        'password': 'pass456',
        'ttl': 3600000,
      });

      expect(config.turnUris, contains('turn:turn.example.com:3478'));
      expect(config.turnUsername, equals('user123'));
      expect(config.turnPassword, equals('pass456'));
      expect(config.turnTtl, equals(3600000));
    });

    test('should configure LiveKit', () {
      config.configureLiveKit(
        url: 'wss://livekit.example.com',
        apiKey: 'key123',
        apiSecret: 'secret456',
      );

      expect(config.liveKitUrl, equals('wss://livekit.example.com'));
      expect(config.liveKitApiKey, equals('key123'));
      expect(config.liveKitApiSecret, equals('secret456'));
    });

    test('hasTurnConfig should return correct value', () {
      expect(config.hasTurnConfig, isFalse);

      config.turnUris = ['turn:turn.example.com:3478'];
      expect(config.hasTurnConfig, isTrue);
    });

    test('hasLiveKitConfig should return correct value', () {
      expect(config.hasLiveKitConfig, isFalse);

      config.liveKitUrl = 'wss://livekit.example.com';
      expect(config.hasLiveKitConfig, isTrue);
    });

    test('getIceServers should include public STUN servers', () {
      final servers = config.getIceServers();
      
      // 应该至少包含公共 STUN 服务器
      expect(servers, isNotEmpty);
      expect(
        servers.any((s) => s['urls'].toString().contains('google.com')),
        isTrue,
      );
    });

    test('getIceServers should include TURN when configured', () {
      config.turnUris = ['turn:turn.example.com:3478'];
      config.turnUsername = 'user';
      config.turnPassword = 'pass';

      final servers = config.getIceServers();
      
      expect(
        servers.any((s) => s['urls'] == 'turn:turn.example.com:3478'),
        isTrue,
      );
    });

    test('reset should clear all configuration', () {
      config.turnUris = ['turn:turn.example.com:3478'];
      config.turnUsername = 'user';
      config.liveKitUrl = 'wss://livekit.example.com';

      config.reset();

      expect(config.turnUris, isEmpty);
      expect(config.turnUsername, isNull);
      expect(config.liveKitUrl, isNull);
    });
  });

  group('VideoResolution', () {
    test('sd360 should have correct dimensions', () {
      expect(VideoResolution.sd360.width, equals(640));
      expect(VideoResolution.sd360.height, equals(360));
    });

    test('hd720 should have correct dimensions', () {
      expect(VideoResolution.hd720.width, equals(1280));
      expect(VideoResolution.hd720.height, equals(720));
    });

    test('hd1080 should have correct dimensions', () {
      expect(VideoResolution.hd1080.width, equals(1920));
      expect(VideoResolution.hd1080.height, equals(1080));
    });

    test('toConstraints should return valid map', () {
      final constraints = VideoResolution.hd720.toConstraints();
      
      expect(constraints['width'], isA<Map>());
      expect(constraints['height'], isA<Map>());
      expect(constraints['width']['ideal'], equals(1280));
      expect(constraints['height']['ideal'], equals(720));
    });
  });
}
