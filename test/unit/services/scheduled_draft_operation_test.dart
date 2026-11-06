import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/services/scheduled_draft_operation.dart';

void main() {
  test('account, room and message scope do not block each other', () {
    final leases = <ScheduledDraftOperation>[];
    addTearDown(() {
      for (final lease in leases) {
        lease.release();
      }
    });
    for (final key in [
      ('a', 'room', 'draft'),
      ('b', 'room', 'draft'),
      ('a', 'other', 'draft'),
      ('a', 'room', 'other'),
    ]) {
      final lease = ScheduledDraftOperation.tryAcquire(
        ownerUserId: key.$1,
        roomId: key.$2,
        messageId: key.$3,
      );
      expect(lease, isNotNull);
      leases.add(lease!);
      expect(
        ScheduledDraftOperation.tryAcquire(
          ownerUserId: key.$1,
          roomId: key.$2,
          messageId: key.$3,
        ),
        isNull,
      );
    }
  });

  test('releasing an old lease twice cannot release its replacement', () {
    ScheduledDraftOperation? acquire() => ScheduledDraftOperation.tryAcquire(
      ownerUserId: 'owner',
      roomId: 'room',
      messageId: 'draft',
    );
    final first = acquire()!;
    first.release();
    final next = acquire()!;
    addTearDown(next.release);
    first.release();
    expect(acquire(), isNull);
    next.release();
    final last = acquire();
    expect(last, isNotNull);
    last!.release();
  });
}
