import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/domain/entities/scheduled_recovery_copy.dart';
import 'package:n42_chat/src/domain/entities/scheduled_recovery_inspection.dart';

void main() {
  Map<String, dynamic> draft(String id, {String? room}) =>
      ScheduledMessageDraft(
        messageId: id,
        roomId: room,
        text: 'Preserved $id',
        type: MessageType.text,
        scheduledAt: DateTime.utc(2030),
        createdAt: DateTime.utc(2026),
      ).toJson();
  ScheduledRecoveryCopy copy(String raw) => ScheduledRecoveryCopy(
    id: sha256.convert(utf8.encode(raw)).toString(),
    raw: raw,
    isIntact: true,
  );
  ScheduledRecoveryInspection inspect(Object data) =>
      ScheduledRecoveryInspection.inspect(copy(jsonEncode(data)));
  test('valid siblings survive malformed entries with source positions', () {
    final result = inspect({
      '!room:test': [
        draft('one'),
        null,
        {'messageId': 'bad'},
        draft('two'),
      ],
    });
    expect(result.documentIssue, isNull);
    expect(result.entries.map((e) => e.index), [0, 1, 2, 3]);
    expect(result.entries.map((e) => e.draft?.messageId), [
      'one',
      null,
      null,
      'two',
    ]);
    expect(result.entries[1].issue, ScheduledRecoveryIssue.invalidEntry);
    expect(result.entries[2].issue, ScheduledRecoveryIssue.invalidEntry);
    expect(result.entries.first.draft!.roomId, '!room:test');
    expect(() => result.entries.clear(), throwsUnsupportedError);
  });
  test(
    'all duplicate identities are ambiguous, including malformed siblings',
    () {
      final result = inspect({
        'a': [
          draft('same'),
          {'messageId': 'same'},
        ],
        'b': [draft('same')],
      });
      expect(
        result.entries
            .take(2)
            .every(
              (e) =>
                  e.issue == ScheduledRecoveryIssue.duplicateIdentity &&
                  e.draft == null,
            ),
        true,
      );
      expect(result.entries.last.draft!.messageId, 'same');
    },
  );
  test('room mismatch and malformed room are reported without guessing', () {
    final result = inspect({
      'a': [draft('one', room: 'b')],
      'b': 'not list',
      '': <Object?>[],
    });
    expect(result.entries.map((e) => e.issue), [
      ScheduledRecoveryIssue.roomMismatch,
      ScheduledRecoveryIssue.invalidRoom,
      ScheduledRecoveryIssue.invalidRoom,
    ]);
  });
  test(
    'accepted and ambiguous delivery records retain receipt and retry state',
    () {
      final data = draft('one')
        ..addAll({
          'acceptedEventId': r'$accepted',
          'deliveryUnconfirmed': true,
          'failedAttempts': 3,
          'retryAt': '2031-01-01T00:00:00.000Z',
        });
      final parsed = inspect({
        'a': [data],
      }).entries.single.draft!;
      expect(parsed.acceptedEventId, r'$accepted');
      expect(parsed.deliveryUnconfirmed, true);
      expect(parsed.failedAttempts, 3);
      expect(parsed.retryAt, DateTime.utc(2031));
    },
  );
  test('all supported draft types stay identifiable without recreating attachments', () {
    for (final type in MessageType.values) {
      final data = draft('one')..['type'] = type.name;
      data['payload'] = {'localPath': '/original/file', 'filename': 'file'};
      final parsed = inspect({
        'a': [data],
      }).entries.single.draft!;
      expect(parsed.type, type);
      expect(parsed.payload, data['payload']);
    }
  });
  for (final raw in ['{broken', '[]', 'null']) {
    test('invalid document $raw stays unrepaired', () {
      final source = copy(raw);
      final result = ScheduledRecoveryInspection.inspect(source);
      expect(result.documentIssue, ScheduledRecoveryIssue.invalidDocument);
      expect(result.entries, isEmpty);
      expect(source.raw, raw);
    });
  }
  test('corrupted copy is never trusted solely from isIntact flag', () {
    final result = ScheduledRecoveryInspection.inspect(
      const ScheduledRecoveryCopy(id: 'bad', raw: '{}', isIntact: true),
    );
    expect(result.documentIssue, ScheduledRecoveryIssue.invalidDocument);
  });
  test('entry cap is explicit and does not claim a complete inspection', () {
    final result = inspect({
      'a': [
        for (var i = 0; i <= ScheduledRecoveryInspection.maxEntries; i++)
          draft('$i'),
      ],
    });
    expect(result.documentIssue, ScheduledRecoveryIssue.limitExceeded);
    expect(result.entries, hasLength(ScheduledRecoveryInspection.maxEntries));
  });
}
