import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/utils/matrix_deletion_uia_coordinator.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_operation.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_session.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_store.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Operation extends Mock implements MatrixAccountDeletionOperation {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final server = Uri.parse('https://hs.test');
  late _Operation operation;
  late MatrixPendingDeletionStore journal;
  late bool sameGeneration;

  setUpAll(() {
    registerFallbackValue(
      DeletionUiaReceipt(
        userId: '@a:hs',
        homeserver: server,
        requiresDeferredCleanup: false,
      ),
    );
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    operation = _Operation();
    journal = MatrixPendingDeletionStore();
    sameGeneration = true;
    when(() => operation.userId).thenReturn('@a:hs');
    when(() => operation.homeserver).thenReturn(server);
    when(() => operation.deviceId).thenReturn('device-A');
    when(() => operation.erase).thenReturn(true);
    when(() => operation.isCurrentAccount).thenAnswer((_) => sameGeneration);
    when(() => operation.request(any())).thenAnswer((_) async {});
  });

  MatrixAccountDeletionSession session() => MatrixAccountDeletionSession(
    operation: operation,
    journal: journal,
    generation: AuthSessionInvalidation(
      userId: '@a:hs',
      homeserver: server,
      deviceId: 'device-A',
      isCurrent: () => sameGeneration,
      isSameGeneration: () => sameGeneration,
    ),
  );

  test(
    'successful server receipt is journaled before scoped cleanup',
    () async {
      when(() => operation.cleanup(any())).thenAnswer((_) async {
        expect((await journal.list()).single.userId, '@a:hs');
        return DeletionCleanupStatus.complete;
      });
      final flow = session();

      expect(await flow.start(), DeletionUiaStatus.deactivated);
      expect(flow.confirmedDeletion?.userId, '@a:hs');
      expect(await flow.cleanupConfirmed(), DeletionCleanupStatus.complete);
      expect(await journal.list(), isEmpty);
      verify(() => operation.request(null)).called(1);
      verify(() => operation.cleanup(any())).called(1);
    },
  );

  test('deferred A cleanup remains discoverable after B switch', () async {
    when(
      () => operation.cleanup(any()),
    ).thenAnswer((_) async => DeletionCleanupStatus.deferredClientClear);
    final flow = session();
    expect(await flow.start(), DeletionUiaStatus.deactivated);
    sameGeneration = false;

    expect(
      await flow.cleanupConfirmed(),
      DeletionCleanupStatus.deferredClientClear,
    );
    expect((await MatrixPendingDeletionStore().list()).single.userId, '@a:hs');
  });

  test('cleanup failure retains confirmed A journal entry', () async {
    when(
      () => operation.cleanup(any()),
    ).thenThrow(StateError('local fixture failure'));
    final flow = session();
    expect(await flow.start(), DeletionUiaStatus.deactivated);

    await expectLater(flow.cleanupConfirmed(), throwsStateError);
    expect((await journal.list()).single.userId, '@a:hs');
    expect(flow.confirmedDeletion?.userId, '@a:hs');
  });
}
