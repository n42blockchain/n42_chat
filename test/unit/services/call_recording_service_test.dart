import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/call_recording_service.dart';

void main() {
  group('RecordingState', () {
    test('should have all expected states', () {
      expect(RecordingState.values, contains(RecordingState.idle));
      expect(RecordingState.values, contains(RecordingState.recording));
      expect(RecordingState.values, contains(RecordingState.paused));
      expect(RecordingState.values, contains(RecordingState.stopped));
      expect(RecordingState.values, contains(RecordingState.error));
      expect(RecordingState.values.length, 5);
    });
  });

  group('AudioEncoder', () {
    test('should have all expected encoders', () {
      expect(AudioEncoder.values, contains(AudioEncoder.aac));
      expect(AudioEncoder.values, contains(AudioEncoder.opus));
      expect(AudioEncoder.values, contains(AudioEncoder.wav));
      expect(AudioEncoder.values, contains(AudioEncoder.mp3));
      expect(AudioEncoder.values.length, 4);
    });
  });

  group('RecordingConfig', () {
    test('should create with default values', () {
      const config = RecordingConfig();

      expect(config.sampleRate, 44100);
      expect(config.bitRate, 128000);
      expect(config.channels, 2);
      expect(config.encoder, AudioEncoder.aac);
      expect(config.maxDuration, 0);
      expect(config.autoSaveInterval, 0);
    });

    test('should create with custom values', () {
      const config = RecordingConfig(
        sampleRate: 48000,
        bitRate: 256000,
        channels: 1,
        encoder: AudioEncoder.opus,
        maxDuration: 3600,
        autoSaveInterval: 300,
      );

      expect(config.sampleRate, 48000);
      expect(config.bitRate, 256000);
      expect(config.channels, 1);
      expect(config.encoder, AudioEncoder.opus);
      expect(config.maxDuration, 3600);
      expect(config.autoSaveInterval, 300);
    });

    test('static defaultConfig should have standard values', () {
      const config = RecordingConfig.defaultConfig;

      expect(config.sampleRate, 44100);
      expect(config.bitRate, 128000);
      expect(config.channels, 2);
    });

    test('static highQuality should have higher values', () {
      const config = RecordingConfig.highQuality;

      expect(config.sampleRate, 48000);
      expect(config.bitRate, 256000);
      expect(config.channels, 2);
    });

    test('static lowQuality should have lower values', () {
      const config = RecordingConfig.lowQuality;

      expect(config.sampleRate, 22050);
      expect(config.bitRate, 64000);
      expect(config.channels, 1);
    });
  });

  group('RecordingInfo', () {
    test('should create with required fields', () {
      final now = DateTime.now();
      final info = RecordingInfo(
        id: 'rec_123',
        filePath: '/path/to/recording.m4a',
        startTime: now,
      );

      expect(info.id, 'rec_123');
      expect(info.filePath, '/path/to/recording.m4a');
      expect(info.startTime, now);
      expect(info.endTime, null);
      expect(info.fileSize, null);
      expect(info.callId, null);
      expect(info.roomId, null);
      expect(info.isVideo, false);
    });

    test('should create with all fields', () {
      final startTime = DateTime(2024, 1, 15, 10, 0);
      final endTime = DateTime(2024, 1, 15, 10, 30);

      final info = RecordingInfo(
        id: 'rec_456',
        filePath: '/path/to/recording.m4a',
        startTime: startTime,
        endTime: endTime,
        fileSize: 1024000,
        callId: 'call_789',
        roomId: '!room:example.com',
        isVideo: true,
      );

      expect(info.id, 'rec_456');
      expect(info.endTime, endTime);
      expect(info.fileSize, 1024000);
      expect(info.callId, 'call_789');
      expect(info.roomId, '!room:example.com');
      expect(info.isVideo, true);
    });

    test('duration should calculate correctly', () {
      final startTime = DateTime(2024, 1, 15, 10, 0);
      final endTime = DateTime(2024, 1, 15, 10, 30);

      final info = RecordingInfo(
        id: 'rec_123',
        filePath: '/path/to/recording.m4a',
        startTime: startTime,
        endTime: endTime,
      );

      expect(info.duration, const Duration(minutes: 30));
    });

    test('copyWith should create new instance with updated values', () {
      final startTime = DateTime(2024, 1, 15, 10, 0);
      final original = RecordingInfo(
        id: 'rec_123',
        filePath: '/path/to/recording.m4a',
        startTime: startTime,
      );

      final endTime = DateTime(2024, 1, 15, 10, 30);
      final modified = original.copyWith(
        endTime: endTime,
        fileSize: 512000,
      );

      expect(modified.id, 'rec_123');
      expect(modified.endTime, endTime);
      expect(modified.fileSize, 512000);
      expect(original.endTime, null);
      expect(original.fileSize, null);
    });

    test('toJson should return correct map', () {
      final startTime = DateTime(2024, 1, 15, 10, 0);
      final endTime = DateTime(2024, 1, 15, 10, 30);

      final info = RecordingInfo(
        id: 'rec_123',
        filePath: '/path/to/recording.m4a',
        startTime: startTime,
        endTime: endTime,
        fileSize: 1024000,
        callId: 'call_789',
        roomId: '!room:example.com',
        isVideo: true,
      );

      final json = info.toJson();

      expect(json['id'], 'rec_123');
      expect(json['filePath'], '/path/to/recording.m4a');
      expect(json['startTime'], startTime.toIso8601String());
      expect(json['endTime'], endTime.toIso8601String());
      expect(json['fileSize'], 1024000);
      expect(json['callId'], 'call_789');
      expect(json['roomId'], '!room:example.com');
      expect(json['isVideo'], true);
      expect(json['durationSeconds'], 1800); // 30 minutes
    });
  });

  group('CallRecordingService', () {
    late CallRecordingService service;

    setUp(() {
      service = CallRecordingService();
    });

    tearDown(() {
      service.dispose();
    });

    test('should initialize with idle state', () {
      expect(service.state, RecordingState.idle);
      expect(service.isRecording, false);
      expect(service.isPaused, false);
      expect(service.currentRecording, null);
      expect(service.currentDuration, Duration.zero);
    });

    test('should have default config', () {
      expect(service.config.sampleRate, 44100);
      expect(service.config.bitRate, 128000);
    });

    test('should allow setting config when idle', () {
      service.setConfig(RecordingConfig.highQuality);

      expect(service.config.sampleRate, 48000);
      expect(service.config.bitRate, 256000);
    });

    test('reset should return to idle state', () {
      service.reset();

      expect(service.state, RecordingState.idle);
      expect(service.currentRecording, null);
      expect(service.currentDuration, Duration.zero);
    });

    test('should notify listeners on state change', () {
      var stateChangeCount = 0;
      RecordingState? lastState;

      service.onStateChanged = (state) {
        stateChangeCount++;
        lastState = state;
      };

      service.reset();

      // State was already idle, so no change notification
      expect(stateChangeCount, 0);
    });
  });
}
