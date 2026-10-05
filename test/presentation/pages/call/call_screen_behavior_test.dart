import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/pages/call/call_screen.dart';
import 'package:n42_chat/src/services/voip/webrtc_service.dart';

class _CallService extends Fake implements WebRTCService {
  CallState currentState = CallState.connecting;
  bool muted = false;
  bool speakerOn = false;
  bool videoEnabled = true;
  int muteToggles = 0;
  int speakerToggles = 0;
  int videoToggles = 0;
  int cameraSwitches = 0;
  final RTCVideoRenderer localVideoRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteVideoRenderer = RTCVideoRenderer();
  final List<CallState> emittedStates = [];
  void Function(CallState)? _stateCallback;
  void Function(Duration)? _durationCallback;
  void Function(String)? _errorCallback;

  @override
  CallState get state => currentState;

  @override
  CallSession? get currentSession => null;

  @override
  bool get isMuted => muted;

  @override
  bool get isVideoEnabled => videoEnabled;

  @override
  RTCVideoRenderer get localRenderer => localVideoRenderer;

  @override
  RTCVideoRenderer get remoteRenderer => remoteVideoRenderer;

  @override
  bool get isSpeakerOn => speakerOn;

  @override
  void Function(CallState)? get onStateChanged => _stateCallback;

  @override
  set onStateChanged(void Function(CallState)? callback) =>
      _stateCallback = callback;

  @override
  void Function(Duration)? get onDurationUpdate => _durationCallback;

  @override
  set onDurationUpdate(void Function(Duration)? callback) =>
      _durationCallback = callback;

  @override
  void Function(String)? get onError => _errorCallback;

  @override
  set onError(void Function(String)? callback) => _errorCallback = callback;

  @override
  void toggleMute() {
    muteToggles++;
    muted = !muted;
  }

  @override
  Future<void> toggleSpeaker() async {
    speakerToggles++;
    speakerOn = !speakerOn;
  }

  @override
  void toggleVideo() {
    videoToggles++;
    videoEnabled = !videoEnabled;
  }

  @override
  Future<void> switchCamera() async {
    cameraSwitches++;
  }

  void emitState(CallState state) {
    currentState = state;
    emittedStates.add(state);
    _stateCallback?.call(state);
  }

  void emitDuration(Duration duration) => _durationCallback?.call(duration);

  void emitError(String error) => _errorCallback?.call(error);
}

CallSession _session({CallType type = CallType.voice}) => CallSession(
  callId: 'call-1',
  roomId: '!call:server.test',
  peerId: '@alice:server.test',
  peerName: 'Alice',
  type: type,
  direction: CallDirection.outgoing,
  startTime: DateTime(2026, 10, 2),
);

void main() {
  testWidgets('voice call follows state and duration callbacks', (
    tester,
  ) async {
    final service = _CallService();
    final previousStates = <CallState>[];
    final previousDurations = <Duration>[];
    final previousStateCallback = previousStates.add;
    final previousDurationCallback = previousDurations.add;
    service.onStateChanged = previousStateCallback;
    service.onDurationUpdate = previousDurationCallback;
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: CallScreen(webRTCService: service, session: _session()),
      ),
    );
    await tester.pump();
    final l10n = S.of(tester.element(find.byType(CallScreen)))!;

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text(l10n.chatConnectingCall), findsOneWidget);

    service.emitState(CallState.connected);
    service.emitDuration(const Duration(hours: 1, minutes: 2, seconds: 3));
    await tester.pump();

    expect(find.text('01:02:03'), findsOneWidget);
    expect(previousStates, [CallState.connected]);
    expect(previousDurations, [
      const Duration(hours: 1, minutes: 2, seconds: 3),
    ]);

    await tester.pumpWidget(const SizedBox.shrink());
    expect(service.onStateChanged, same(previousStateCallback));
    expect(service.onDurationUpdate, same(previousDurationCallback));
  });

  testWidgets('voice controls update mute and speaker state', (tester) async {
    final service = _CallService()..currentState = CallState.connected;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: CallScreen(webRTCService: service, session: _session()),
      ),
    );
    await tester.pump();
    final l10n = S.of(tester.element(find.byType(CallScreen)))!;

    await tester.tap(find.text(l10n.callMuteLabel));
    await tester.pump();
    expect(service.muteToggles, 1);
    expect(service.muted, isTrue);
    expect(find.text(l10n.callUnmuteLabel), findsOneWidget);

    await tester.tap(find.text(l10n.chatSpeakerOn));
    await tester.pump();
    expect(service.speakerToggles, 1);
    expect(service.speakerOn, isTrue);
    expect(find.text(l10n.chatSpeakerOff), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'service errors are shown and the previous callback is retained',
    (tester) async {
      final service = _CallService();
      final previousErrors = <String>[];
      final previousErrorCallback = previousErrors.add;
      service.onError = previousErrorCallback;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: Scaffold(
            body: CallScreen(webRTCService: service, session: _session()),
          ),
        ),
      );
      await tester.pump();

      service.emitError('Connection lost');
      await tester.pump();

      expect(previousErrors, ['Connection lost']);
      expect(find.text('Connection lost'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(service.onError, same(previousErrorCallback));
    },
  );

  testWidgets('incoming video call offers answer and decline actions', (
    tester,
  ) async {
    final service = _CallService()..currentState = CallState.incoming;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: CallScreen(
          webRTCService: service,
          session: _session(type: CallType.video),
          isIncoming: true,
        ),
      ),
    );
    await tester.pump();
    final l10n = S.of(tester.element(find.byType(CallScreen)))!;

    expect(find.byType(RTCVideoView), findsOneWidget);
    expect(find.text(l10n.callIncomingVideoCall), findsOneWidget);
    expect(find.text(l10n.callAnswer), findsOneWidget);
    expect(find.text(l10n.callDecline), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('connected video call restores controls and camera actions', (
    tester,
  ) async {
    final service = _CallService();
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: CallScreen(
          webRTCService: service,
          session: _session(type: CallType.video),
        ),
      ),
    );
    await tester.pump();
    service.emitState(CallState.connected);
    await tester.pump();
    final l10n = S.of(tester.element(find.byType(CallScreen)))!;

    expect(find.byType(RTCVideoView), findsNWidgets(2));
    expect(find.text(l10n.callMuteLabel), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
    expect(find.text(l10n.callMuteLabel), findsNothing);

    await tester.tapAt(const Offset(180, 400));
    await tester.pump();
    expect(find.text(l10n.callMuteLabel), findsOneWidget);

    await tester.tap(find.text(l10n.chatCameraOff));
    await tester.pump();
    expect(service.videoToggles, 1);
    expect(service.videoEnabled, isFalse);
    expect(find.text(l10n.chatCameraOn), findsOneWidget);

    await tester.tap(find.text(l10n.callSwitchCameraLabel));
    expect(service.cameraSwitches, 1);
    expect(tester.takeException(), isNull);
  });
}
