import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';

void main() {
  test('transaction identity survives persistence and scopes the room', () {
    final original = ScheduledMessageDraft(
      messageId: 'same/id',
      roomId: '!one:test',
      text: 'message',
      type: MessageType.text,
      scheduledAt: DateTime(2030),
      createdAt: DateTime(2026),
    );
    final restored = ScheduledMessageDraft.fromJson(original.toJson());
    expect(restored.transactionId, original.transactionId);
    expect(
      original.transactionId,
      matches(RegExp(r'^n42_scheduled_[0-9a-f]{64}$')),
    );
    expect(
      original.copyWith(roomId: '!two:test').transactionId,
      isNot(original.transactionId),
    );
  });

  test('rejects damaged identity, dates, payload and unknown types', () {
    final original = ScheduledMessageDraft(
      messageId: 'draft',
      text: 'keep',
      type: MessageType.text,
      scheduledAt: DateTime.utc(2030),
      createdAt: DateTime.utc(2026),
    ).toJson();
    for (final change in <Map<String, dynamic>>[
      {'messageId': null},
      {'messageId': ' '},
      {'scheduledAt': null},
      {'scheduledAt': 'broken'},
      {'createdAt': 'broken'},
      {'type': 'futureType'},
      {'payload': 'broken'},
    ]) {
      expect(
        () => ScheduledMessageDraft.fromJson({...original, ...change}),
        throwsA(anything),
        reason: change.keys.single,
      );
    }
    // Older text-only drafts had no type or payload field.
    final legacy = {...original}
      ..remove('type')
      ..remove('payload');
    final restored = ScheduledMessageDraft.fromJson(legacy);
    expect(restored.type, MessageType.text);
    expect(restored.payload, isEmpty);
    expect(restored.scheduledAt, DateTime.utc(2030));
  });

  group('ScheduledMessageDraft', () {
    test('parses poll payload and builds preview text', () {
      final draft = ScheduledMessageDraft.fromJson({
        'messageId': 'scheduled_poll',
        'text': 'Lunch?',
        'type': 'poll',
        'scheduledAt': DateTime.utc(2026, 3, 22, 12).toIso8601String(),
        'createdAt': DateTime.utc(2026, 3, 22, 11).toIso8601String(),
        'payload': {
          'options': ['Sushi', 'Pizza'],
          'maxSelections': 1,
        },
      });

      expect(draft.type, MessageType.poll);
      expect(draft.pollOptions, ['Sushi', 'Pizza']);
      expect(draft.timelinePreviewText, '[Poll] Lunch?');
    });

    test('creates pending preview messages as plain text summaries', () {
      final draft = ScheduledMessageDraft(
        messageId: 'scheduled_poll',
        text: 'Lunch?',
        type: MessageType.poll,
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
        createdAt: DateTime.now(),
        payload: {
          'options': ['Sushi', 'Pizza'],
        },
      );

      final preview = draft.toPreviewMessage(
        roomId: '!room:test',
        senderId: '@me:test',
      );

      expect(preview.type, MessageType.text);
      expect(preview.content, '[Poll] Lunch?');
      expect(preview.isScheduled, isTrue);
    });

    test('treats image payload with gifUrl as a scheduled GIF', () {
      final draft = ScheduledMessageDraft.fromJson({
        'messageId': 'scheduled_gif',
        'text': 'Celebration',
        'type': 'image',
        'scheduledAt': DateTime.utc(2026, 3, 22, 12).toIso8601String(),
        'createdAt': DateTime.utc(2026, 3, 22, 11).toIso8601String(),
        'payload': {
          'gifUrl': 'https://media.giphy.com/media/abc/giphy.gif',
          'previewUrl': 'https://media.giphy.com/media/abc/preview.gif',
          'width': 320,
          'height': 240,
        },
      });

      expect(draft.isGif, isTrue);
      expect(draft.typeLabel, 'GIF');
      expect(draft.timelinePreviewText, '[GIF] Celebration');
    });

    test('parses local attachment payload and builds media preview text', () {
      final draft = ScheduledMessageDraft.fromJson({
        'messageId': 'scheduled_photo',
        'text': 'IMG_0001.jpg',
        'type': 'image',
        'scheduledAt': DateTime.utc(2026, 3, 22, 12).toIso8601String(),
        'createdAt': DateTime.utc(2026, 3, 22, 11).toIso8601String(),
        'payload': {
          'localPath': '/tmp/scheduled/IMG_0001.jpg',
          'filename': 'IMG_0001.jpg',
          'mimeType': 'image/jpeg',
          'fileSize': 2048,
        },
      });

      expect(draft.hasLocalAttachment, isTrue);
      expect(draft.localAttachmentPath, '/tmp/scheduled/IMG_0001.jpg');
      expect(draft.attachmentMimeType, 'image/jpeg');
      expect(draft.attachmentFileSize, 2048);
      expect(draft.typeLabel, 'Photo');
      expect(draft.timelinePreviewText, '[Photo] IMG_0001.jpg');
    });
  });
}
