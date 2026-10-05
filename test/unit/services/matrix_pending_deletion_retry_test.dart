import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/utils/matrix_deletion_uia_coordinator.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_operation.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_session.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_retry.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_store.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Session extends Mock implements IMatrixAccountDeletionSession {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final server = Uri.parse('https://hs.test');
  late MatrixPendingDeletionStore journal;
  late MatrixPendingDeletionEntry entry;
  late _Session session;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    journal = MatrixPendingDeletionStore();
    await journal.markPending(
      userId: '@a:hs',
      homeserver: server,
      deviceId: 'device-A',
    );
    entry = (await journal.list()).single;
    session = _Session();
    when(() => session.generation).thenReturn(
      AuthSessionInvalidation(
        userId: '@a:hs',
        homeserver: server,
        deviceId: 'device-A',
        isCurrent: () => true,
      ),
    );
    when(() => session.confirmedDeletion).thenReturn(
      DeletionUiaReceipt(
        userId: '@a:hs',
        homeserver: server,
        requiresDeferredCleanup: false,
      ),
    );
  });

  test('same original generation can retry confirmed scoped cleanup', () async {
    when(() => session.isOriginalGeneration).thenReturn(true);
    when(() => session.cleanupConfirmed()).thenAnswer((_) async {
      await journal.complete(
        userId: entry.userId,
        homeserver: entry.homeserver,
        deviceId: entry.deviceId,
      );
      return DeletionCleanupStatus.complete;
    });

    expect(
      await MatrixPendingDeletionRetry(
        journal,
      ).retry(entry, originalSession: session),
      DeletionCleanupStatus.complete,
    );
    expect(await journal.list(), isEmpty);
    verify(() => session.cleanupConfirmed()).called(1);
  });

  test('new A generation cannot use old A confirmed cleanup', () async {
    when(() => session.isOriginalGeneration).thenReturn(false);

    expect(
      await MatrixPendingDeletionRetry(
        journal,
      ).retry(entry, originalSession: session),
      DeletionCleanupStatus.deferredClientClear,
    );
    expect((await journal.list()).single.userId, '@a:hs');
    verifyNever(() => session.cleanupConfirmed());
  });

  test(
    'after restart without original operation cleanup stays pending',
    () async {
      expect(
        await MatrixPendingDeletionRetry(journal).retry(entry),
        DeletionCleanupStatus.deferredClientClear,
      );
      expect((await journal.list()).single.userId, '@a:hs');
    },
  );

  test('different identity receipt cannot clean A', () async {
    when(() => session.isOriginalGeneration).thenReturn(true);
    when(() => session.confirmedDeletion).thenReturn(
      DeletionUiaReceipt(
        userId: '@b:hs',
        homeserver: server,
        requiresDeferredCleanup: false,
      ),
    );
    expect(
      await MatrixPendingDeletionRetry(
        journal,
      ).retry(entry, originalSession: session),
      DeletionCleanupStatus.deferredClientClear,
    );
    verifyNever(() => session.cleanupConfirmed());
  });
}
