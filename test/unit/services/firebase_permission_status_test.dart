import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/notifications/firebase_push_service.dart';
import 'package:n42_chat/src/core/notifications/push_notification_service.dart';

class _MockMatrixClient extends Mock implements matrix.Client {}

class _Firebase extends FirebasePlatform {
  final _app = FirebaseAppPlatform(
    defaultFirebaseAppName,
    const FirebaseOptions(
      apiKey: 'test-key',
      appId: 'test-app',
      messagingSenderId: 'test-sender',
      projectId: 'test-project',
    ),
  );

  @override
  List<FirebaseAppPlatform> get apps => [_app];

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) => _app;
}

class _Messaging extends FirebaseMessagingPlatform {
  @override
  FirebaseMessagingPlatform delegateFor({required FirebaseApp app}) => this;

  @override
  FirebaseMessagingPlatform setInitialValues({bool? isAutoInitEnabled}) => this;

  @override
  Future<NotificationSettings> getNotificationSettings() async =>
      const NotificationSettings(
        alert: AppleNotificationSetting.disabled,
        announcement: AppleNotificationSetting.disabled,
        authorizationStatus: AuthorizationStatus.deniedPermanently,
        badge: AppleNotificationSetting.disabled,
        carPlay: AppleNotificationSetting.disabled,
        lockScreen: AppleNotificationSetting.disabled,
        notificationCenter: AppleNotificationSetting.disabled,
        showPreviews: AppleShowPreviewSetting.never,
        timeSensitive: AppleNotificationSetting.disabled,
        criticalAlert: AppleNotificationSetting.disabled,
        sound: AppleNotificationSetting.disabled,
        providesAppNotificationSettings: AppleNotificationSetting.disabled,
      );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FirebasePlatform.instance = _Firebase();
    FirebaseMessagingPlatform.instance = _Messaging();
  });

  test('maps permanently denied notification permission to denied', () async {
    final service = FirebasePushService(_MockMatrixClient());
    addTearDown(service.dispose);

    expect(
      await service.getPermissionStatus(),
      NotificationPermissionStatus.denied,
    );
  });
}
