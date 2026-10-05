import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/datasources/local/media_metadata_database.dart';

MediaFilesCompanion _file(
  String path, {
  required String roomId,
  required String category,
  required DateTime accessedAt,
  int size = 0,
  bool thumbnail = false,
  bool pinned = false,
}) => MediaFilesCompanion.insert(
  filePath: path,
  roomId: roomId,
  fileCategory: category,
  downloadedAt: DateTime(2026, 1, 1),
  lastAccessedAt: accessedAt,
  fileSize: Value(size),
  isThumbnail: Value(thumbnail),
  isPinned: Value(pinned),
);

void main() {
  late MediaMetadataDatabase database;

  setUp(() {
    database = MediaMetadataDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test(
    'tracks media, protects pinned files, and reports room totals',
    () async {
      final now = DateTime.now();
      await database.registerFile(
        _file(
          '/room/image.jpg',
          roomId: '!room:hs.test',
          category: 'image',
          accessedAt: now.subtract(const Duration(days: 40)),
          size: 400,
        ),
      );
      await database.registerFile(
        _file(
          '/room/video.mp4',
          roomId: '!room:hs.test',
          category: 'video',
          accessedAt: now.subtract(const Duration(days: 30)),
          size: 900,
          pinned: true,
        ),
      );
      await database.registerFile(
        _file(
          '/room/thumbnail.jpg',
          roomId: '!room:hs.test',
          category: 'image',
          accessedAt: now.subtract(const Duration(days: 20)),
          size: 100,
          thumbnail: true,
        ),
      );
      await database.registerFile(
        _file(
          '/other/audio.ogg',
          roomId: '!other:hs.test',
          category: 'audio',
          accessedAt: now,
          size: 300,
        ),
      );

      // Registration updates a record with the same local path.
      await database.registerFile(
        MediaFilesCompanion.insert(
          filePath: '/room/image.jpg',
          roomId: '!room:hs.test',
          fileCategory: 'image',
          downloadedAt: DateTime(2026, 1, 1),
          lastAccessedAt: now.subtract(const Duration(days: 50)),
          fileSize: const Value(450),
          mxcUrl: const Value('mxc://hs.test/image'),
        ),
      );

      final roomStats = await database.getRoomMediaStats('!room:hs.test');
      expect(roomStats.totalCount, 3);
      expect(roomStats.totalSize, 1450);
      expect(roomStats.imageSize, 550);
      expect(roomStats.videoSize, 900);
      expect(roomStats.audioSize, 0);
      expect(roomStats.documentSize, 0);

      final cleanable = await database.getCleanableFiles(
        olderThanDays: 10,
        roomId: '!room:hs.test',
        fileCategory: 'image',
        minFileSizeBytes: 400,
      );
      expect(cleanable.map((file) => file.filePath), ['/room/image.jpg']);
      expect(
        (await database.getCleanableFiles(preserveThumbnails: false)).length,
        3,
      );

      await database.touchFile('/room/image.jpg');
      await database.togglePinned('/room/image.jpg', true);
      expect(
        await database.getCleanableFiles(roomId: '!room:hs.test'),
        isEmpty,
      );

      await database.markCleaned(['/room/image.jpg', '/other/audio.ogg']);
      final cleaned = await database.getCleanedFile('/room/image.jpg');
      expect(cleaned?.mxcUrl, 'mxc://hs.test/image');
      expect(cleaned?.cleanedAt, isNotNull);
      expect(
        (await database.getRoomMediaFiles(
          roomId: '!room:hs.test',
        )).map((file) => file.filePath),
        unorderedEquals(['/room/thumbnail.jpg', '/room/video.mp4']),
      );
      expect(
        (await database.getRoomMediaFiles(
          roomId: '!room:hs.test',
          fileCategory: 'image',
          includeCleaned: true,
        )).map((file) => file.filePath),
        unorderedEquals(['/room/image.jpg', '/room/thumbnail.jpg']),
      );

      final roomTotals = await database.getAllRoomStats();
      expect(roomTotals.map((room) => room.roomId), ['!room:hs.test']);
      expect(roomTotals.single.totalCount, 2);
      expect(roomTotals.single.totalSize, 1000);
      final totalStats = await database.getTotalStats();
      expect(totalStats.totalCount, 2);
      expect(totalStats.totalSize, 1000);
      expect(totalStats.cleanableSize, 0);
      expect(
        (await database.getTotalStats(preserveThumbnails: false)).cleanableSize,
        100,
      );
    },
  );

  test('returns empty values for rooms without media', () async {
    final room = await database.getRoomMediaStats('!empty:hs.test');
    expect(room.totalCount, 0);
    expect(room.totalSize, 0);
    expect(room.categories, isEmpty);
    expect(await database.getCleanedFile('/missing'), isNull);
    expect(await database.getRoomMediaFiles(roomId: '!empty:hs.test'), isEmpty);
    expect(await database.getAllRoomStats(), isEmpty);
    expect((await database.getTotalStats()).totalCount, 0);
  });
}
