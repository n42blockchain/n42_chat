import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/services/scheduled_draft_operation.dart';

void main() {
  test('receipts survive release and stay scoped until confirmed cleanup', () {
    final first = ScheduledDraftOperation.tryAcquire(
      ownerUserId: 'receipt-owner',
      roomId: 'room',
      messageId: 'draft',
    )!;
    first.rememberAcceptance('event');
    first.release();
    expect(() => first.confirmCleanup(), throwsStateError);
    for (final key in [
      ('other-owner', 'room', 'draft'),
      ('receipt-owner', 'other-room', 'draft'),
      ('receipt-owner', 'room', 'other-draft'),
    ]) {
      expect(
        ScheduledDraftOperation.acceptedReceipt(
          ownerUserId: key.$1,
          roomId: key.$2,
          messageId: key.$3,
        ),
        isNull,
      );
    }
    final next = ScheduledDraftOperation.tryAcquire(
      ownerUserId: 'receipt-owner',
      roomId: 'room',
      messageId: 'draft',
    )!;
    expect(next.receipt, 'event');
    next.confirmCleanup();
    expect(next.receipt, isNull);
    next.release();
  });

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
