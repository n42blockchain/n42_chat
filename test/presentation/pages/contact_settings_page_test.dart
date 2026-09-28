import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/core/services/friend_details_store.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/repositories/content_report_repository.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/contact/contact_settings_page.dart';

class _ContactRepository extends Mock implements IContactRepository {}

class _ReportRepository extends Mock implements IContentReportRepository {}

class _ReportManager extends Mock implements MatrixClientManager {}

class _ReportClient extends Mock implements matrix.Client {}

class _ReportAuth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _ReportOwner {
  _ReportOwner() {
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenAnswer((_) => token);
    when(() => client.deviceID).thenReturn('device-A');
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    getIt.pushNewScope();
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    getIt.registerSingleton<IContentReportRepository>(reporter);
    addTearDown(getIt.popScope);
  }

  final manager = _ReportManager();
  final client = _ReportClient();
  final auth = _ReportAuth();
  final reporter = _ReportRepository();
  bool current = true;
  String token = 'session-A';

  late final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: 'device-A',
    isCurrent: () => current,
    matchesClient: (candidate) => identical(candidate, client),
  );
}

class MockContactBloc extends Mock implements ContactBloc {
  @override
  ContactState get state => const ContactState.initial();

  @override
  Stream<ContactState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

Widget buildTestWidget(Widget child, {ContactBloc? contactBloc}) {
  final widget = MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    locale: const Locale('en'),
    home: child,
  );

  if (contactBloc != null) {
    return BlocProvider<ContactBloc>.value(value: contactBloc, child: widget);
  }
  return widget;
}

void main() {
  late MockContactBloc mockContactBloc;

  setUp(() {
    mockContactBloc = MockContactBloc();
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('star persists when settings reopen and remains account scoped', (
    tester,
  ) async {
    final store = FriendDetailsStore('https://hs.test', '@me:hs', '@friend:hs');
    FlutterSecureStorage.setMockInitialValues({
      'n42_chat_session': jsonEncode({
        'homeserver': 'https://hs.test',
        'userId': '@me:hs',
        'accessToken': 'fixture',
        'deviceId': 'fixture',
      }),
    });
    await store.save({'starred': true});
    await tester.pumpWidget(
      buildTestWidget(
        const ContactSettingsPage(userId: '@friend:hs', displayName: 'Friend'),
        contactBloc: mockContactBloc,
      ),
    );
    await tester.pumpAndSettle();
    final toggle = find.byType(Switch).first;
    expect(tester.widget<Switch>(toggle).value, isTrue);
    await tester.ensureVisible(toggle);
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect((await store.load())['starred'], isFalse);
    final other = FriendDetailsStore(
      'https://hs.test',
      '@other:hs',
      '@friend:hs',
    );
    expect(await other.load(), isEmpty);
  });
  for (final fail in [false, true]) {
    testWidgets(
      'blocked user absent from contacts has truthful switch; save failure=$fail',
      (tester) async {
        _ReportOwner();
        final repository = _ContactRepository();
        final saved = Completer<void>();
        getIt.registerSingleton<IContactRepository>(repository);
        when(
          () => repository.isUserIgnored('@test:server.com'),
        ).thenReturn(true);
        when(
          () => repository.unignoreUser('@test:server.com'),
        ).thenAnswer((_) => saved.future);
        await tester.pumpWidget(
          buildTestWidget(
            const ContactSettingsPage(
              userId: '@test:server.com',
              displayName: 'Test User',
            ),
            contactBloc: mockContactBloc,
          ),
        );
        await tester.pumpAndSettle();
        final toggle = find.byType(Switch).last;
        expect(tester.widget<Switch>(toggle).value, isTrue);
        await tester.ensureVisible(toggle);
        await tester.tap(toggle);
        await tester.pump();
        expect(tester.widget<Switch>(toggle).value, isTrue);
        expect(tester.widget<Switch>(toggle).onChanged, isNull);
        if (fail) {
          saved.completeError(StateError('Offline'));
        } else {
          saved.complete();
        }
        await tester.pumpAndSettle();
        expect(tester.widget<Switch>(toggle).value, fail);
        expect(tester.widget<Switch>(toggle).onChanged, isNotNull);
        if (fail) expect(find.text('Save failed'), findsOneWidget);
        verify(() => repository.unignoreUser('@test:server.com')).called(1);
      },
    );
  }

  testWidgets('old block acknowledgement does not flip or refresh B page', (
    tester,
  ) async {
    final owner = _ReportOwner();
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    final acknowledgement = Completer<void>();
    when(() => repository.isUserIgnored('@test:server.com')).thenReturn(false);
    when(
      () => repository.ignoreUser('@test:server.com'),
    ).thenAnswer((_) => acknowledgement.future);
    await tester.pumpWidget(
      buildTestWidget(
        const ContactSettingsPage(
          userId: '@test:server.com',
          displayName: 'Test User',
        ),
        contactBloc: mockContactBloc,
      ),
    );
    await tester.pumpAndSettle();
    final toggle = find.byType(Switch).last;
    await tester.ensureVisible(toggle);
    await tester.tap(toggle);
    await tester.pump();
    owner.current = false;
    acknowledgement.complete();
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(toggle).value, isFalse);
    verifyNever(() => mockContactBloc.add(const RefreshContacts()));
    expect(find.text('Save failed'), findsNothing);
  });

  testWidgets('old block acknowledgement does not flip after ABA login', (
    tester,
  ) async {
    final owner = _ReportOwner();
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    final acknowledgement = Completer<void>();
    when(() => repository.isUserIgnored('@test:server.com')).thenReturn(false);
    when(
      () => repository.ignoreUser('@test:server.com'),
    ).thenAnswer((_) => acknowledgement.future);
    await tester.pumpWidget(
      buildTestWidget(
        const ContactSettingsPage(
          userId: '@test:server.com',
          displayName: 'Test User',
        ),
        contactBloc: mockContactBloc,
      ),
    );
    await tester.pumpAndSettle();
    final toggle = find.byType(Switch).last;
    await tester.ensureVisible(toggle);
    await tester.tap(toggle);
    await tester.pump();
    owner.current = false;
    final returnedA = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: 'device-A',
      isCurrent: () => true,
      matchesClient: (candidate) => identical(candidate, owner.client),
    );
    when(() => owner.auth.currentAccountGeneration).thenReturn(returnedA);
    acknowledgement.complete();
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(toggle).value, isFalse);
    verifyNever(() => mockContactBloc.add(const RefreshContacts()));
  });

  testWidgets('old block failure does not show A error on B page', (
    tester,
  ) async {
    final owner = _ReportOwner();
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    final acknowledgement = Completer<void>();
    when(() => repository.isUserIgnored('@test:server.com')).thenReturn(false);
    when(
      () => repository.ignoreUser('@test:server.com'),
    ).thenAnswer((_) => acknowledgement.future);
    await tester.pumpWidget(
      buildTestWidget(
        const ContactSettingsPage(
          userId: '@test:server.com',
          displayName: 'Test User',
        ),
        contactBloc: mockContactBloc,
      ),
    );
    await tester.pumpAndSettle();
    final toggle = find.byType(Switch).last;
    await tester.ensureVisible(toggle);
    await tester.tap(toggle);
    await tester.pump();
    owner.token = 'session-B';
    acknowledgement.completeError(StateError('A request failed'));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(toggle).value, isFalse);
    expect(find.text('Save failed'), findsNothing);
    verifyNever(() => mockContactBloc.add(const RefreshContacts()));
  });

  testWidgets('old settings page cannot start a block for new account', (
    tester,
  ) async {
    final owner = _ReportOwner();
    final repository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(repository);
    when(() => repository.isUserIgnored('@test:server.com')).thenReturn(false);
    await tester.pumpWidget(
      buildTestWidget(
        const ContactSettingsPage(
          userId: '@test:server.com',
          displayName: 'Test User',
        ),
        contactBloc: mockContactBloc,
      ),
    );
    await tester.pumpAndSettle();
    owner.current = false;
    final toggle = find.byType(Switch).last;
    await tester.ensureVisible(toggle);
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(toggle).value, isFalse);
    verifyNever(() => repository.ignoreUser('@test:server.com'));
    verifyNever(() => mockContactBloc.add(const RefreshContacts()));
  });

  for (final initiallyBlocked in [false, true]) {
    testWidgets('missing client keeps block=$initiallyBlocked unchanged', (
      tester,
    ) async {
      final owner = _ReportOwner();
      when(() => owner.manager.client).thenReturn(null);
      final repository = _ContactRepository();
      getIt.registerSingleton<IContactRepository>(repository);
      when(
        () => repository.isUserIgnored('@test:server.com'),
      ).thenReturn(initiallyBlocked);
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      final toggle = find.byType(Switch).last;
      await tester.ensureVisible(toggle);
      await tester.tap(toggle);
      await tester.pumpAndSettle();
      expect(tester.widget<Switch>(toggle).value, initiallyBlocked);
      expect(find.text('Save failed'), findsOneWidget);
      verifyNever(() => repository.ignoreUser('@test:server.com'));
      verifyNever(() => repository.unignoreUser('@test:server.com'));
      verifyNever(() => mockContactBloc.add(const RefreshContacts()));
    });
  }

  group('ContactSettingsPage', () {
    testWidgets('renders basic menu items', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();

      // 验证基本菜单项存在
      expect(find.textContaining('Report'), findsOneWidget);
      expect(find.textContaining('Delete'), findsOneWidget);
    });

    testWidgets('tapping Report opens report dialog', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();

      // 点击投诉按钮
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();

      // 验证投诉对话框弹出，包含举报原因选项
      expect(find.text('Spam'), findsOneWidget);
      expect(find.text('Harassment'), findsOneWidget);
      expect(find.text('Fraud'), findsOneWidget);
      expect(find.text('Other'), findsOneWidget);
    });

    testWidgets(
      'report dialog shows validation error when no reason selected',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const ContactSettingsPage(
              userId: '@test:server.com',
              displayName: 'Test User',
            ),
            contactBloc: mockContactBloc,
          ),
        );
        await tester.pumpAndSettle();

        // 打开投诉对话框
        await tester.tap(find.text('Report'));
        await tester.pumpAndSettle();

        // 不选择任何原因，直接点击提交
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        // 验证显示了验证错误提示
        expect(find.text('Please select a reason'), findsOneWidget);
      },
    );

    testWidgets('report dialog waits for acknowledgement before success', (
      tester,
    ) async {
      final owner = _ReportOwner();
      final acknowledgement = Completer<void>();
      when(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam\nDetails',
        ),
      ).thenAnswer((_) => acknowledgement.future);
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();

      // 打开投诉对话框
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();

      // 选择 Spam 原因
      await tester.tap(find.text('Spam'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Details');

      // 点击提交
      await tester.tap(find.text('Confirm'));
      await tester.pump();

      expect(find.text('Report submitted'), findsNothing);
      expect(find.text('Details'), findsOneWidget);
      verify(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam\nDetails',
        ),
      ).called(1);

      acknowledgement.complete();
      await tester.pumpAndSettle();
      expect(find.text('Report submitted'), findsOneWidget);
    });

    testWidgets('failed report retains reason and description for retry', (
      tester,
    ) async {
      final owner = _ReportOwner();
      var attempts = 0;
      when(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam\nDetails',
        ),
      ).thenAnswer((_) async {
        attempts++;
        if (attempts == 1) {
          throw const ContentReportException(ContentReportFailure.transport);
        }
      });
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      await tester.enterText(find.byType(TextField), 'Details');
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(
        find.text('Could not send report. Please try again.'),
        findsOneWidget,
      );
      expect(find.text('Details'), findsOneWidget);
      expect(find.text('Report submitted'), findsNothing);
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(attempts, 2);
      expect(find.text('Report submitted'), findsOneWidget);
    });

    testWidgets('unsupported homeserver leaves the report draft open', (
      tester,
    ) async {
      final owner = _ReportOwner();
      when(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Fraud',
        ),
      ).thenThrow(
        const ContentReportException(ContentReportFailure.unsupported),
      );
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fraud'));
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(
        find.text('This homeserver does not support user reports.'),
        findsOneWidget,
      );
      expect(find.text('Fraud'), findsOneWidget);
      expect(find.text('Report submitted'), findsNothing);
    });

    testWidgets('duplicate report taps send only one request', (tester) async {
      final owner = _ReportOwner();
      final acknowledgement = Completer<void>();
      when(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam',
        ),
      ).thenAnswer((_) => acknowledgement.future);
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      verify(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam',
        ),
      ).called(1);
      acknowledgement.complete();
      await tester.pumpAndSettle();
    });

    for (final dismissal in ['Cancel', 'barrier', 'back']) {
      testWidgets(
        'pending report resists $dismissal and retains a failed draft',
        (tester) async {
          final owner = _ReportOwner();
          final acknowledgement = Completer<void>();
          when(
            () => owner.reporter.reportUser(
              userId: '@test:server.com',
              reason: 'Spam\nDraft details',
            ),
          ).thenAnswer((_) => acknowledgement.future);
          await tester.pumpWidget(
            buildTestWidget(
              const ContactSettingsPage(
                userId: '@test:server.com',
                displayName: 'Test User',
              ),
              contactBloc: mockContactBloc,
            ),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text('Report'));
          await tester.pumpAndSettle();
          await tester.tap(find.text('Spam'));
          await tester.enterText(find.byType(TextField), 'Draft details');
          await tester.tap(find.text('Confirm'));
          await tester.pump();
          switch (dismissal) {
            case 'Cancel':
              await tester.tap(find.text('Cancel'));
            case 'barrier':
              await tester.tapAt(const Offset(5, 5));
            case 'back':
              await tester.binding.handlePopRoute();
          }
          await tester.pump();
          final draftWasVisibleWhilePending = find
              .text('Draft details')
              .evaluate()
              .isNotEmpty;
          acknowledgement.completeError(
            const ContentReportException(ContentReportFailure.transport),
          );
          await tester.pumpAndSettle();
          expect(draftWasVisibleWhilePending, isTrue);
          expect(find.text('Draft details'), findsOneWidget);
          expect(
            find.text('Could not send report. Please try again.'),
            findsOneWidget,
          );
          expect(find.text('Report submitted'), findsNothing);
          await tester.tap(find.text('Cancel'));
          await tester.pumpAndSettle();
          expect(find.text('Draft details'), findsNothing);
          verify(
            () => owner.reporter.reportUser(
              userId: '@test:server.com',
              reason: 'Spam\nDraft details',
            ),
          ).called(1);
        },
      );
    }

    testWidgets(
      'pending report stays open until one successful acknowledgement',
      (tester) async {
        final owner = _ReportOwner();
        final acknowledgement = Completer<void>();
        when(
          () => owner.reporter.reportUser(
            userId: '@test:server.com',
            reason: 'Spam',
          ),
        ).thenAnswer((_) => acknowledgement.future);
        await tester.pumpWidget(
          buildTestWidget(
            const ContactSettingsPage(
              userId: '@test:server.com',
              displayName: 'Test User',
            ),
            contactBloc: mockContactBloc,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Report'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Spam'));
        await tester.tap(find.text('Confirm'));
        await tester.pump();
        await tester.tapAt(const Offset(5, 5));
        await tester.pump();
        final stayedOpen = find.byType(AlertDialog).evaluate().isNotEmpty;
        acknowledgement.complete();
        await tester.pumpAndSettle();
        expect(stayedOpen, isTrue);
        expect(find.byType(AlertDialog), findsNothing);
        expect(find.text('Report submitted'), findsOneWidget);
        verify(
          () => owner.reporter.reportUser(
            userId: '@test:server.com',
            reason: 'Spam',
          ),
        ).called(1);
      },
    );

    testWidgets('a stale dialog cannot send under a replacement account', (
      tester,
    ) async {
      final owner = _ReportOwner();
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      owner.current = false;
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      expect(
        find.text('Account changed. Open this report again to send it.'),
        findsOneWidget,
      );
      verifyNever(
        () => owner.reporter.reportUser(
          userId: any(named: 'userId'),
          reason: any(named: 'reason'),
        ),
      );
    });

    testWidgets('a replaced token cannot send from the old dialog', (
      tester,
    ) async {
      final owner = _ReportOwner();
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      owner.token = 'session-B';
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      expect(
        find.text('Account changed. Open this report again to send it.'),
        findsOneWidget,
      );
      verifyNever(
        () => owner.reporter.reportUser(
          userId: any(named: 'userId'),
          reason: any(named: 'reason'),
        ),
      );
    });

    testWidgets('A acknowledgement after ABA does not become new A success', (
      tester,
    ) async {
      final owner = _ReportOwner();
      final acknowledgement = Completer<void>();
      when(
        () => owner.reporter.reportUser(
          userId: '@test:server.com',
          reason: 'Spam',
        ),
      ).thenAnswer((_) => acknowledgement.future);
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      owner.current = false;
      // The visible MXID/client fields return to A, but the old monitor epoch
      // remains invalid and a distinct generation now owns that session.
      final returnedA = AuthSessionInvalidation(
        userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'),
        deviceId: 'device-A',
        isCurrent: () => true,
        matchesClient: (candidate) => identical(candidate, owner.client),
      );
      when(() => owner.auth.currentAccountGeneration).thenReturn(returnedA);
      expect(returnedA.isCurrent, isTrue);
      expect(identical(returnedA, owner.generation), isFalse);
      acknowledgement.complete();
      await tester.pumpAndSettle();
      expect(find.text('Report submitted'), findsNothing);
      expect(
        find.text('Account changed. Open this report again to send it.'),
        findsOneWidget,
      );
    });

    testWidgets('report dialog has optional description field', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();

      // 打开投诉对话框
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();

      // 验证补充说明输入框存在
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('report dialog can be cancelled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();

      // 打开投诉对话框
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();

      // 点击取消
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // 验证对话框已关闭（不再显示举报原因选项）
      expect(find.text('Spam'), findsNothing);
    });

    testWidgets('report barrier dismisses the idle draft', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ContactSettingsPage(
            userId: '@test:server.com',
            displayName: 'Test User',
          ),
          contactBloc: mockContactBloc,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      expect(find.text('Spam'), findsOneWidget);
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(find.text('Spam'), findsNothing);
    });
  });
}
