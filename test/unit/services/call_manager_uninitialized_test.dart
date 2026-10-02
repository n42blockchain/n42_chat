import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/services/voip/call_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CallManager manager;
  late List<String> errors;

  setUp(() {
    manager = CallManager();
    errors = [];
    manager.config.reset();
    manager.onError = errors.add;
    manager.setNavigatorKey(null);
  });

  tearDown(() {
    manager.config.reset();
    manager.onError = null;
    manager.setNavigatorKey(null);
  });

  group('one-to-one calls before initialization', () {
    test(
      'voice and video requests fail closed with a specific error',
      () async {
        expect(
          await manager.startVoiceCall(
            roomId: '!synthetic-voice:example.invalid',
            peerId: '@voice-peer:example.invalid',
            peerName: 'Voice peer',
          ),
          isFalse,
        );
        expect(
          await manager.startVideoCall(
            roomId: '!synthetic-video:example.invalid',
            peerId: '@video-peer:example.invalid',
            peerName: 'Video peer',
          ),
          isFalse,
        );

        expect(errors, ['call_not_initialized', 'call_not_initialized']);
        expect(manager.isInitialized, isFalse);
      },
    );

    test('answer request returns false when WebRTC is unavailable', () async {
      expect(await manager.answerCall(), isFalse);
      expect(errors, isEmpty);
    });
  });

  group('meetings before initialization', () {
    test('create and join report that LiveKit is not initialized', () async {
      expect(
        await manager.createMeeting(
          roomName: 'synthetic-room',
          participantName: 'Synthetic participant',
          token: 'synthetic-token',
        ),
        isFalse,
      );
      expect(
        await manager.joinMeeting(
          roomName: 'synthetic-room',
          participantName: 'Synthetic participant',
          token: 'synthetic-token',
        ),
        isFalse,
      );

      expect(errors, ['meeting_not_initialized', 'meeting_not_initialized']);
    });
  });

  group('group calls before initialization', () {
    test('voice and video requests fail without a Matrix client', () async {
      expect(
        await manager.startGroupVoiceCall(
          conversationId: '!synthetic-group:example.invalid',
          roomDisplayName: 'Synthetic group',
        ),
        isFalse,
      );
      expect(
        await manager.startGroupVideoCall(
          conversationId: '!synthetic-group:example.invalid',
          roomDisplayName: 'Synthetic group',
        ),
        isFalse,
      );

      expect(errors, ['call_not_initialized', 'call_not_initialized']);
    });
  });

  test('forwards TURN values and trims LiveKit URL configuration', () {
    manager.configureTurn(
      uris: const ['turn:turn.example.invalid:3478'],
      username: 'synthetic-user',
      password: 'synthetic-password',
      ttl: 300000,
    );
    manager.configureLiveKit(
      url: '  wss://livekit.example.invalid  ',
      apiKey: 'synthetic-key',
    );

    expect(manager.config.turnUris, ['turn:turn.example.invalid:3478']);
    expect(manager.config.turnUsername, 'synthetic-user');
    expect(manager.config.turnPassword, 'synthetic-password');
    expect(manager.config.turnTtl, 300000);
    expect(manager.config.liveKitUrl, 'wss://livekit.example.invalid');
    expect(manager.config.hasLiveKitConfig, isTrue);
    expect(errors, isEmpty);
  });
}
