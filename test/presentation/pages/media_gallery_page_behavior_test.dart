import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/pages/media/media_gallery_page.dart';

MessageEntity _message(
  String id,
  MessageType type, {
  DateTime? timestamp,
  MessageMetadata? metadata,
}) => MessageEntity(
  id: id,
  roomId: '!gallery:test',
  senderId: '@alice:test',
  senderName: 'Alice',
  content: id,
  type: type,
  timestamp: timestamp ?? DateTime.now(),
  metadata: metadata,
);

Future<void> _pumpGallery(
  WidgetTester tester, {
  List<MessageEntity> messages = const [],
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MediaGalleryPage(
        roomName: 'Gallery',
        roomId: '!gallery:test',
        mediaMessages: messages,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('empty filters show matching empty-state icons and counts', (
    tester,
  ) async {
    await _pumpGallery(tester);

    for (final (label, icon) in <(String, IconData)>[
      ('All', Icons.perm_media_outlined),
      ('Images', Icons.image_outlined),
      ('Videos', Icons.videocam_outlined),
      ('Files', Icons.insert_drive_file_outlined),
      ('Audio', Icons.audiotrack_outlined),
    ]) {
      if (label != 'All') {
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
      }
      expect(find.text('No media found'), findsOneWidget);
      expect(find.text('0 items'), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
    }
  });

  testWidgets('tabs filter by media type and audio includes voice messages', (
    tester,
  ) async {
    await _pumpGallery(
      tester,
      messages: [
        _message('photo', MessageType.image),
        _message('movie', MessageType.video),
        _message(
          'document',
          MessageType.file,
          metadata: const MessageMetadata(fileName: 'notes.pdf'),
        ),
        _message(
          'sound',
          MessageType.audio,
          metadata: const MessageMetadata(fileName: 'sound.mp3'),
        ),
        _message(
          'voice-note',
          MessageType.voice,
          metadata: const MessageMetadata(fileName: 'voice.ogg'),
        ),
      ],
    );

    expect(find.text('5 items'), findsOneWidget);
    await tester.tap(find.text('Images'));
    await tester.pumpAndSettle();
    expect(find.text('1 items'), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);

    await tester.tap(find.text('Videos'));
    await tester.pumpAndSettle();
    expect(find.text('1 items'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    await tester.tap(find.text('Files'));
    await tester.pumpAndSettle();
    expect(find.text('1 items'), findsOneWidget);
    expect(find.text('notes.pdf'), findsOneWidget);

    await tester.tap(find.text('Audio'));
    await tester.pumpAndSettle();
    expect(find.text('2 items'), findsOneWidget);
    expect(find.text('sound.mp3'), findsOneWidget);
    expect(find.text('voice.ogg'), findsOneWidget);
  });

  testWidgets('image and video grids group media by newest date first', (
    tester,
  ) async {
    final now = DateTime.now();
    await _pumpGallery(
      tester,
      messages: [
        _message(
          'yesterday-image',
          MessageType.image,
          timestamp: now.subtract(const Duration(days: 1)),
        ),
        _message('today-video', MessageType.video, timestamp: now),
      ],
    );

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Today')).dy,
      lessThan(tester.getTopLeft(find.text('Yesterday')).dy),
    );
  });

  testWidgets('file rows without a resolvable URL stay on the gallery', (
    tester,
  ) async {
    await _pumpGallery(
      tester,
      messages: [
        _message(
          'missing-url',
          MessageType.file,
          metadata: const MessageMetadata(fileName: 'offline.pdf'),
        ),
      ],
    );
    await tester.tap(find.text('Files'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('offline.pdf'));
    await tester.pumpAndSettle();

    expect(find.text('offline.pdf'), findsOneWidget);
    expect(find.text('Downloading...'), findsNothing);
  });
}
