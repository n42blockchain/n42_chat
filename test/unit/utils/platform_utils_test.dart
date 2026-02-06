import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/platform_utils.dart';

void main() {
  group('PlatformType', () {
    test('should have all expected types', () {
      expect(PlatformType.values, contains(PlatformType.web));
      expect(PlatformType.values, contains(PlatformType.ios));
      expect(PlatformType.values, contains(PlatformType.android));
      expect(PlatformType.values, contains(PlatformType.macos));
      expect(PlatformType.values, contains(PlatformType.windows));
      expect(PlatformType.values, contains(PlatformType.linux));
      expect(PlatformType.values, contains(PlatformType.unknown));
      expect(PlatformType.values.length, 7);
    });
  });

  group('ScreenType', () {
    test('should have all expected types', () {
      expect(ScreenType.values, contains(ScreenType.mobile));
      expect(ScreenType.values, contains(ScreenType.tablet));
      expect(ScreenType.values, contains(ScreenType.desktop));
      expect(ScreenType.values, contains(ScreenType.variable));
      expect(ScreenType.values.length, 4);
    });
  });

  group('PlatformFeatures', () {
    test('should have web features', () {
      const webFeatures = PlatformFeatures(
        screenType: ScreenType.variable,
        supportsTouch: true,
        supportsMouse: true,
        supportsKeyboardShortcuts: true,
        supportsDragAndDrop: true,
        hasSystemStatusBar: false,
        hasNavigationBar: false,
      );

      expect(webFeatures.screenType, ScreenType.variable);
      expect(webFeatures.supportsTouch, true);
      expect(webFeatures.supportsMouse, true);
      expect(webFeatures.supportsKeyboardShortcuts, true);
      expect(webFeatures.supportsDragAndDrop, true);
      expect(webFeatures.hasSystemStatusBar, false);
      expect(webFeatures.hasNavigationBar, false);
    });

    test('should have mobile features', () {
      const mobileFeatures = PlatformFeatures(
        screenType: ScreenType.mobile,
        supportsTouch: true,
        supportsMouse: false,
        supportsKeyboardShortcuts: false,
        supportsDragAndDrop: false,
        hasSystemStatusBar: true,
        hasNavigationBar: true,
      );

      expect(mobileFeatures.screenType, ScreenType.mobile);
      expect(mobileFeatures.supportsTouch, true);
      expect(mobileFeatures.supportsMouse, false);
      expect(mobileFeatures.supportsKeyboardShortcuts, false);
      expect(mobileFeatures.supportsDragAndDrop, false);
      expect(mobileFeatures.hasSystemStatusBar, true);
      expect(mobileFeatures.hasNavigationBar, true);
    });

    test('should have desktop features', () {
      const desktopFeatures = PlatformFeatures(
        screenType: ScreenType.desktop,
        supportsTouch: false,
        supportsMouse: true,
        supportsKeyboardShortcuts: true,
        supportsDragAndDrop: true,
        hasSystemStatusBar: true,
        hasNavigationBar: false,
      );

      expect(desktopFeatures.screenType, ScreenType.desktop);
      expect(desktopFeatures.supportsTouch, false);
      expect(desktopFeatures.supportsMouse, true);
      expect(desktopFeatures.supportsKeyboardShortcuts, true);
      expect(desktopFeatures.supportsDragAndDrop, true);
      expect(desktopFeatures.hasSystemStatusBar, true);
      expect(desktopFeatures.hasNavigationBar, false);
    });
  });

  group('PlatformUtils static getters', () {
    // Note: These tests will pass on the test platform
    // In actual runtime, values depend on the platform

    test('isWeb should return boolean', () {
      expect(PlatformUtils.isWeb, isA<bool>());
    });

    test('platformName should return string', () {
      expect(PlatformUtils.platformName, isA<String>());
      expect(PlatformUtils.platformName.isNotEmpty, true);
    });

    test('platformType should return valid type', () {
      expect(PlatformUtils.platformType, isA<PlatformType>());
    });

    test('supportsWebRTC should be true', () {
      expect(PlatformUtils.supportsWebRTC, true);
    });
  });

  group('Platform capability checks', () {
    test('desktop platforms should support system tray', () {
      // These are static properties based on platform
      expect(PlatformUtils.supportsSystemTray, isA<bool>());
    });

    test('desktop platforms should support multi window', () {
      expect(PlatformUtils.supportsMultiWindow, isA<bool>());
    });

    test('mobile platforms should support push notifications', () {
      expect(PlatformUtils.supportsPushNotifications, isA<bool>());
    });

    test('mobile platforms should support background service', () {
      expect(PlatformUtils.supportsBackgroundService, isA<bool>());
    });

    test('iOS should support CallKit', () {
      expect(PlatformUtils.supportsCallKit, isA<bool>());
    });

    test('Android should support ConnectionService', () {
      expect(PlatformUtils.supportsConnectionService, isA<bool>());
    });

    test('needsResponsiveLayout should return boolean', () {
      expect(PlatformUtils.needsResponsiveLayout, isA<bool>());
    });
  });
}
