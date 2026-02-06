import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/web_adapter.dart';

void main() {
  group('StorageType', () {
    test('should have all expected types', () {
      expect(StorageType.values, contains(StorageType.sqlite));
      expect(StorageType.values, contains(StorageType.indexedDB));
      expect(StorageType.values, contains(StorageType.sharedPreferences));
      expect(StorageType.values, contains(StorageType.memory));
      expect(StorageType.values.length, 4);
    });
  });

  group('CacheStrategy', () {
    test('should have all expected strategies', () {
      expect(CacheStrategy.values, contains(CacheStrategy.fileSystem));
      expect(CacheStrategy.values, contains(CacheStrategy.serviceWorker));
      expect(CacheStrategy.values, contains(CacheStrategy.memory));
      expect(CacheStrategy.values, contains(CacheStrategy.none));
      expect(CacheStrategy.values.length, 4);
    });
  });

  group('VideoQuality', () {
    test('should have all expected qualities', () {
      expect(VideoQuality.values, contains(VideoQuality.sd360));
      expect(VideoQuality.values, contains(VideoQuality.sd480));
      expect(VideoQuality.values, contains(VideoQuality.hd720));
      expect(VideoQuality.values, contains(VideoQuality.hd1080));
      expect(VideoQuality.values, contains(VideoQuality.uhd4k));
      expect(VideoQuality.values.length, 5);
    });
  });

  group('NotificationPermission', () {
    test('should have all expected permissions', () {
      expect(NotificationPermission.values, contains(NotificationPermission.default_));
      expect(NotificationPermission.values, contains(NotificationPermission.granted));
      expect(NotificationPermission.values, contains(NotificationPermission.denied));
      expect(NotificationPermission.values.length, 3);
    });
  });

  group('WebAdapter capabilities', () {
    test('supportsLocalStorage should return true', () {
      expect(WebAdapter.supportsLocalStorage, true);
    });

    test('supportsWebRTC should return true', () {
      expect(WebAdapter.supportsWebRTC, true);
    });

    test('supportsMediaDevices should return true', () {
      expect(WebAdapter.supportsMediaDevices, true);
    });

    test('supportsClipboard should return true', () {
      expect(WebAdapter.supportsClipboard, true);
    });

    test('supportsDragDrop should return true', () {
      expect(WebAdapter.supportsDragDrop, true);
    });

    test('supportsFileUpload should return true', () {
      expect(WebAdapter.supportsFileUpload, true);
    });

    test('supportsFileDownload should return true', () {
      expect(WebAdapter.supportsFileDownload, true);
    });

    test('recommendedStorage should return valid type', () {
      expect(WebAdapter.recommendedStorage, isA<StorageType>());
    });

    test('recommendedCacheStrategy should return valid strategy', () {
      expect(WebAdapter.recommendedCacheStrategy, isA<CacheStrategy>());
    });

    test('maxUploadSize should be positive', () {
      expect(WebAdapter.maxUploadSize, greaterThan(0));
    });

    test('maxConcurrentUploads should be positive', () {
      expect(WebAdapter.maxConcurrentUploads, greaterThan(0));
    });

    test('recommendedImageQuality should be between 0 and 100', () {
      expect(WebAdapter.recommendedImageQuality, greaterThanOrEqualTo(0));
      expect(WebAdapter.recommendedImageQuality, lessThanOrEqualTo(100));
    });

    test('recommendedVideoQuality should return valid quality', () {
      expect(WebAdapter.recommendedVideoQuality, isA<VideoQuality>());
    });
  });

  group('StorageUsage', () {
    test('should create with required values', () {
      const usage = StorageUsage(
        used: 1024,
        quota: 10240,
        available: 9216,
      );

      expect(usage.used, 1024);
      expect(usage.quota, 10240);
      expect(usage.available, 9216);
    });

    test('usagePercent should calculate correctly', () {
      const usage = StorageUsage(
        used: 5000,
        quota: 10000,
        available: 5000,
      );

      expect(usage.usagePercent, 50.0);
    });

    test('usagePercent should return 0 when quota is 0', () {
      const usage = StorageUsage(
        used: 0,
        quota: 0,
        available: 0,
      );

      expect(usage.usagePercent, 0);
    });

    test('formattedUsed should format bytes correctly', () {
      expect(
        const StorageUsage(used: 500, quota: 1000, available: 500).formattedUsed,
        '500 B',
      );

      expect(
        const StorageUsage(used: 1536, quota: 10000, available: 8464).formattedUsed,
        '1.5 KB',
      );

      expect(
        const StorageUsage(used: 1572864, quota: 10000000, available: 8427136).formattedUsed,
        '1.5 MB',
      );

      expect(
        const StorageUsage(used: 1610612736, quota: 5368709120, available: 3758096384).formattedUsed,
        '1.5 GB',
      );
    });

    test('formattedQuota should format bytes correctly', () {
      expect(
        const StorageUsage(used: 0, quota: 1024, available: 1024).formattedQuota,
        '1.0 KB',
      );

      expect(
        const StorageUsage(used: 0, quota: 1048576, available: 1048576).formattedQuota,
        '1.0 MB',
      );
    });

    test('formattedAvailable should format bytes correctly', () {
      expect(
        const StorageUsage(used: 0, quota: 2048, available: 2048).formattedAvailable,
        '2.0 KB',
      );
    });
  });

  group('WebFile', () {
    test('should create with required values', () {
      const file = WebFile(
        name: 'document.pdf',
        size: 1024,
        mimeType: 'application/pdf',
      );

      expect(file.name, 'document.pdf');
      expect(file.size, 1024);
      expect(file.mimeType, 'application/pdf');
      expect(file.bytes, null);
      expect(file.path, null);
    });

    test('should create with optional values', () {
      const file = WebFile(
        name: 'image.png',
        size: 2048,
        mimeType: 'image/png',
        bytes: [0, 1, 2, 3],
        path: '/path/to/image.png',
      );

      expect(file.bytes, [0, 1, 2, 3]);
      expect(file.path, '/path/to/image.png');
    });

    test('extension should extract correctly', () {
      expect(
        const WebFile(name: 'document.pdf', size: 100, mimeType: 'application/pdf').extension,
        'pdf',
      );

      expect(
        const WebFile(name: 'photo.JPG', size: 100, mimeType: 'image/jpeg').extension,
        'jpg',
      );

      expect(
        const WebFile(name: 'archive.tar.gz', size: 100, mimeType: 'application/gzip').extension,
        'gz',
      );

      expect(
        const WebFile(name: 'noextension', size: 100, mimeType: 'application/octet-stream').extension,
        '',
      );
    });

    test('isImage should detect image files', () {
      expect(
        const WebFile(name: 'photo.jpg', size: 100, mimeType: 'image/jpeg').isImage,
        true,
      );

      expect(
        const WebFile(name: 'image.png', size: 100, mimeType: 'image/png').isImage,
        true,
      );

      expect(
        const WebFile(name: 'doc.pdf', size: 100, mimeType: 'application/pdf').isImage,
        false,
      );
    });

    test('isVideo should detect video files', () {
      expect(
        const WebFile(name: 'movie.mp4', size: 100, mimeType: 'video/mp4').isVideo,
        true,
      );

      expect(
        const WebFile(name: 'clip.webm', size: 100, mimeType: 'video/webm').isVideo,
        true,
      );

      expect(
        const WebFile(name: 'song.mp3', size: 100, mimeType: 'audio/mpeg').isVideo,
        false,
      );
    });

    test('isAudio should detect audio files', () {
      expect(
        const WebFile(name: 'song.mp3', size: 100, mimeType: 'audio/mpeg').isAudio,
        true,
      );

      expect(
        const WebFile(name: 'sound.wav', size: 100, mimeType: 'audio/wav').isAudio,
        true,
      );

      expect(
        const WebFile(name: 'movie.mp4', size: 100, mimeType: 'video/mp4').isAudio,
        false,
      );
    });
  });

  group('WebNotificationAdapter', () {
    test('requestPermission should return permission', () async {
      final permission = await WebNotificationAdapter.requestPermission();
      expect(permission, isA<NotificationPermission>());
    });

    test('showNotification should not throw', () async {
      expect(
        () => WebNotificationAdapter.showNotification(
          title: 'Test',
          body: 'Test body',
        ),
        returnsNormally,
      );
    });

    test('closeNotification should not throw', () async {
      expect(
        () => WebNotificationAdapter.closeNotification('tag'),
        returnsNormally,
      );
    });
  });

  group('WebStorageAdapter', () {
    test('setItem should not throw', () async {
      expect(
        () => WebStorageAdapter.setItem('key', 'value'),
        returnsNormally,
      );
    });

    test('getItem should return null on native', () async {
      final value = await WebStorageAdapter.getItem('key');
      // On native platforms, returns null
      expect(value, isNull);
    });

    test('removeItem should not throw', () async {
      expect(
        () => WebStorageAdapter.removeItem('key'),
        returnsNormally,
      );
    });

    test('clear should not throw', () async {
      expect(
        () => WebStorageAdapter.clear(),
        returnsNormally,
      );
    });

    test('getStorageUsage should return usage', () async {
      final usage = await WebStorageAdapter.getStorageUsage();
      expect(usage, isA<StorageUsage>());
    });
  });

  group('WebFullscreenAdapter', () {
    test('isFullscreen should return boolean', () {
      expect(WebFullscreenAdapter.isFullscreen, isA<bool>());
    });

    test('enterFullscreen should not throw', () async {
      expect(
        () => WebFullscreenAdapter.enterFullscreen(),
        returnsNormally,
      );
    });

    test('exitFullscreen should not throw', () async {
      expect(
        () => WebFullscreenAdapter.exitFullscreen(),
        returnsNormally,
      );
    });

    test('toggleFullscreen should not throw', () async {
      expect(
        () => WebFullscreenAdapter.toggleFullscreen(),
        returnsNormally,
      );
    });
  });

  group('WebClipboardAdapter', () {
    test('copyText should return boolean', () async {
      final result = await WebClipboardAdapter.copyText('test');
      expect(result, isA<bool>());
    });

    test('readText should return string or null', () async {
      final text = await WebClipboardAdapter.readText();
      expect(text, anyOf(isA<String>(), isNull));
    });

    test('copyImage should return boolean', () async {
      final result = await WebClipboardAdapter.copyImage([0, 1, 2]);
      expect(result, isA<bool>());
    });
  });

  group('WebFileAdapter', () {
    test('pickFiles should return list', () async {
      final files = await WebFileAdapter.pickFiles();
      expect(files, isA<List<WebFile>>());
    });

    test('downloadFile should not throw', () async {
      expect(
        () => WebFileAdapter.downloadFile(
          url: 'https://example.com/file.pdf',
          filename: 'file.pdf',
        ),
        returnsNormally,
      );
    });

    test('downloadBlob should not throw', () async {
      expect(
        () => WebFileAdapter.downloadBlob(
          bytes: [0, 1, 2, 3],
          filename: 'test.bin',
          mimeType: 'application/octet-stream',
        ),
        returnsNormally,
      );
    });
  });
}
