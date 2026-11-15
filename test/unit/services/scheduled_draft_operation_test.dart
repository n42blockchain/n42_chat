import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/services/scheduled_draft_operation.dart';

void main() {
  test('account recovery excludes only its owner and old releases cannot unlock newer leases', () {
    final recovery = ScheduledDraftOperation.tryAcquireRecovery('recover')!;
    expect(ScheduledDraftOperation.tryAcquireRecovery('recover'), isNull);
    expect(ScheduledDraftOperation.tryAcquire(ownerUserId: 'recover', roomId: 'room', messageId: 'draft'), isNull);
    final other = ScheduledDraftOperation.tryAcquire(ownerUserId: 'other', roomId: 'room', messageId: 'draft')!;
    other.release(); recovery.release();
    final newer = ScheduledDraftOperation.tryAcquireRecovery('recover')!;
    recovery.release();
    expect(ScheduledDraftOperation.tryAcquireRecovery('recover'), isNull);
    newer.release();
    final send = ScheduledDraftOperation.tryAcquire(ownerUserId: 'recover', roomId: 'room', messageId: 'draft')!;
    expect(ScheduledDraftOperation.tryAcquireRecovery('recover'), isNull);
    send.rememberAcceptance('accepted'); send.release();
    final afterReceipt = ScheduledDraftOperation.tryAcquireRecovery('recover')!;
    expect(ScheduledDraftOperation.acceptedReceipt(ownerUserId: 'recover', roomId: 'room', messageId: 'draft'), 'accepted');
    afterReceipt.release();
    final cleanup = ScheduledDraftOperation.tryAcquire(ownerUserId: 'recover', roomId: 'room', messageId: 'draft')!;
    cleanup.confirmCleanup(); cleanup.release();
  });

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
