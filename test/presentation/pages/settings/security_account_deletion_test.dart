import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/encryption/e2ee_manager.dart';
import 'package:n42_chat/src/core/encryption/key_backup_service.dart';
import 'package:n42_chat/src/core/utils/matrix_deletion_uia_coordinator.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_operation.dart';
import 'package:n42_chat/src/data/services/matrix_account_deletion_session.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_store.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/pages/settings/security_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _E2ee extends Mock implements E2EEManager {}

class _Backup extends Mock implements KeyBackupService {}

class _Client extends Mock implements Client {}

class _Session implements IMatrixAccountDeletionSession {
  final _server = Uri.parse('https://hs.test');
  late final AuthSessionInvalidation _generation = AuthSessionInvalidation(
    userId: '@a:hs',
    homeserver: _server,
    deviceId: 'device-A',
    isCurrent: () => isOriginalGeneration,
  );
  bool original = true;
  bool eraseValue = false;
  DeletionUiaStatus currentStatus = DeletionUiaStatus.idle;
  List<String> stages = const [];
  String? currentSession;
  String? sentPassword;
  int starts = 0;
  int cleanups = 0;
  int retries = 0;
  Future<DeletionUiaStatus> Function()? startAction;
  Future<DeletionUiaStatus> Function()? retryAction;
  DeletionCleanupStatus cleanupResult = DeletionCleanupStatus.complete;

  @override
  AuthSessionInvalidation get generation => _generation;
  @override
  bool get isOriginalGeneration => original;
  @override
  String get userId => '@a:hs';
  @override
  Uri get homeserver => _server;
  @override
  bool get erase => eraseValue;
  @override
  DeletionUiaStatus get status => currentStatus;
  @override
  DeletionUiaReceipt? get confirmedDeletion =>
      currentStatus == DeletionUiaStatus.deactivated ||
          currentStatus == DeletionUiaStatus.deactivatedNeedsScopedCleanup
      ? DeletionUiaReceipt(
          userId: userId,
          homeserver: homeserver,
          requiresDeferredCleanup: !original,
        )
      : null;
  @override
  List<String> get nextStages => stages;
  @override
  String? get session => currentSession;
  @override
  Future<DeletionUiaStatus> start() async {
    starts++;
    currentStatus =
        await (startAction?.call() ??
            Future.value(DeletionUiaStatus.deactivated));
    return currentStatus;
  }

  @override
  Future<DeletionUiaStatus> submitPassword(String password) async {
    sentPassword = password;
    currentStatus = DeletionUiaStatus.deactivated;
    return currentStatus;
  }

  @override
  Uri fallbackUri(String stage) => _server.replace(
    path: '/fallback',
    queryParameters: {'session': currentSession},
  );
  @override
  Future<DeletionUiaStatus> retryAfterExternalFallback({
    required String stage,
    required String session,
  }) async {
    retries++;
    currentStatus =
        await (retryAction?.call() ??
            Future.value(DeletionUiaStatus.awaitingAuthentication));
    return currentStatus;
  }

  @override
  Future<DeletionCleanupStatus> cleanupConfirmed() async {
    cleanups++;
    return cleanupResult;
  }

  @override
  void cancel() => currentStatus = DeletionUiaStatus.cancelled;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _E2ee e2ee;
  late _Backup backup;
  late _Session session;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
    e2ee = _E2ee();
    backup = _Backup();
    session = _Session();
    when(() => e2ee.client).thenReturn(_Client());
    when(() => e2ee.status).thenReturn(E2EEStatus.ready);
    when(() => e2ee.isCrossSigningEnabled).thenReturn(false);
    when(() => backup.getBackupInfo()).thenAnswer((_) async => null);
  });

  Future<void> open(
    WidgetTester tester, {
    Future<bool> Function(Uri)? openFallback,
    Future<Uri?> Function(IMatrixAccountDeletionSession)? management,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: SecuritySettingsPage(
          e2eeManager: e2ee,
          keyBackupService: backup,
          restoreKeysOnOpen: false,
          deletionSessionFactory: (erase) => session..eraseValue = erase,
          openDeletionFallback: openFallback,
          resolveDeletionManagement: management,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapDelete(WidgetTester tester) async {
    final target = find.byKey(const ValueKey('delete_account'));
    await tester.scrollUntilVisible(target, 300);
    await tester.ensureVisible(target);
    await tester.drag(find.byType(ListView).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets('exact password and erase choice reach one confirmed cleanup', (
    tester,
  ) async {
    session.startAction = () async {
      session.stages = ['m.login.password'];
      session.currentSession = 'server-session';
      return DeletionUiaStatus.awaitingAuthentication;
    };
    await open(tester);
    await tapDelete(tester);
    await tester.enterText(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextField),
      ),
      ' secret ',
    );
    await tester.tap(find.byKey(const ValueKey('delete_server_erase')));
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pumpAndSettle();

    expect(session.erase, isTrue);
    expect(session.sentPassword, ' secret ');
    expect(session.starts, 1);
    expect(session.cleanups, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('browser return with server UIA rejection never cleans up', (
    tester,
  ) async {
    session.startAction = () async {
      session.stages = ['m.login.sso'];
      session.currentSession = 'server-session';
      return DeletionUiaStatus.awaitingAuthentication;
    };
    session.retryAction = () async {
      session.stages = ['m.login.sso'];
      return DeletionUiaStatus.awaitingAuthentication;
    };
    Uri? opened;
    await open(
      tester,
      openFallback: (uri) async {
        opened = uri;
        return true;
      },
    );
    await tapDelete(tester);
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('deletion_fallback_m.login.sso')),
    );
    await tester.pumpAndSettle();
    expect(opened?.host, 'hs.test');
    await tester.tap(find.byKey(const ValueKey('deletion_retry_server')));
    await tester.pumpAndSettle();
    expect(session.retries, 1);
    expect(session.cleanups, 0);
    expect(find.byKey(const ValueKey('deletion_stage_dialog')), findsOneWidget);
  });

  testWidgets('A to B switch keeps B page and reports no A success', (
    tester,
  ) async {
    final server = Completer<DeletionUiaStatus>();
    session.startAction = () => server.future;
    session.cleanupResult = DeletionCleanupStatus.deferredClientClear;
    await open(tester);
    await tapDelete(tester);
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pump();
    session.original = false;
    server.complete(DeletionUiaStatus.deactivatedNeedsScopedCleanup);
    await tester.pumpAndSettle();
    expect(session.cleanups, 1);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(find.byKey(const ValueKey('deletion_success')), findsNothing);
  });

  testWidgets('cancel and repeated tap do not send deletion twice', (
    tester,
  ) async {
    await open(tester);
    final target = find.byKey(const ValueKey('delete_account'));
    await tester.scrollUntilVisible(target, 300);
    await tester.ensureVisible(target);
    await tester.drag(find.byType(ListView).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.tap(target, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();
    expect(session.starts, 0);
    expect(session.cleanups, 0);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
  });

  testWidgets('journaled A retry stays pending after restart on B page', (
    tester,
  ) async {
    await MatrixPendingDeletionStore().markPending(
      userId: '@a:hs',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: 'device-A',
    );
    await open(tester);
    final target = find.byKey(const ValueKey('pending_delete_account'));
    await tester.scrollUntilVisible(target, 300);
    await tester.ensureVisible(target);
    await tester.drag(find.byType(ListView).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('retry_deletion_@a:hs')));
    await tester.pumpAndSettle();
    expect(session.starts, 0);
    expect(session.cleanups, 0);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
    expect(await MatrixPendingDeletionStore().list(), hasLength(1));
  });

  testWidgets('account management link never marks server deletion', (
    tester,
  ) async {
    Uri? opened;
    await open(
      tester,
      management: (_) async => Uri.parse(
        'https://auth.test/manage?action=org.matrix.account_deactivate',
      ),
      openFallback: (uri) async {
        opened = uri;
        return true;
      },
    );
    await tapDelete(tester);
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pumpAndSettle();
    expect(opened?.host, 'auth.test');
    expect(session.starts, 0);
    expect(session.cleanups, 0);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
  });

  testWidgets('account switch before management resolution opens nothing', (
    tester,
  ) async {
    final metadata = Completer<Uri?>();
    var opened = false;
    await open(
      tester,
      management: (_) => metadata.future,
      openFallback: (_) async {
        opened = true;
        return true;
      },
    );
    await tapDelete(tester);
    await tester.tap(find.byKey(const ValueKey('confirm_delete_account')));
    await tester.pump();
    session.original = false;
    metadata.complete(Uri.parse('https://auth.test/manage'));
    await tester.pumpAndSettle();
    expect(opened, isFalse);
    expect(session.starts, 0);
    expect(session.cleanups, 0);
    expect(find.byType(SecuritySettingsPage), findsOneWidget);
  });
}
