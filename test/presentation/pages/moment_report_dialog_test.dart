import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/moment_entity.dart';
import 'package:n42_chat/src/domain/repositories/moment_repository.dart';
import 'package:n42_chat/src/presentation/widgets/common/user_report_dialog.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class _ReportRepository extends Mock
    implements IMomentRepository, IMomentReportRepository {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Fixture {
  _Fixture() {
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('session-A');
    when(() => client.deviceID).thenReturn('device-A');
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    getIt.pushNewScope();
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    getIt.registerSingleton<IMomentRepository>(reporter);
    addTearDown(getIt.popScope);
  }

  final manager = _Manager();
  final client = _Client();
  final auth = _Auth();
  final reporter = _ReportRepository();
  bool current = true;

  late final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: 'device-A',
    isCurrent: () => current,
    matchesClient: (candidate) => identical(candidate, client),
  );

  final moment = MomentEntity(
    id: 'post-1',
    userId: '@author:hs.test',
    userName: 'Author',
    content: 'Post',
    timestamp: DateTime(2026),
    sourceRoomId: '!moments:hs.test',
    sourceEventId: r'$post',
  );

  MomentComment? selectedComment;

  Widget build() => MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => showMomentReportDialog(
            context,
            moment: moment,
            comment: selectedComment,
          ),
          child: const Text('Open report'),
        ),
      ),
    ),
  );
}

Future<void> _openReport(WidgetTester tester, _Fixture fixture) async {
  await tester.pumpWidget(fixture.build());
  await tester.pumpAndSettle();
  await tester.tap(find.text('Open report'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Spam'));
  await tester.enterText(find.byType(TextField), 'Details');
}

void main() {
  testWidgets('comment report targets the comment instead of its parent', (
    tester,
  ) async {
    final f = _Fixture();
    final comment = MomentComment(
      id: 'comment-1',
      userId: '@other:hs.test',
      userName: 'Other',
      content: 'Comment',
      timestamp: DateTime(2026),
      sourceRoomId: '!moments:hs.test',
      sourceEventId: r'$comment',
    );
    f.selectedComment = comment;
    when(() => f.reporter.reportComment(f.moment, comment, 'Spam\nDetails'))
        .thenAnswer((_) async {});
    await _openReport(tester, f);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    verify(() => f.reporter.reportComment(f.moment, comment, 'Spam\nDetails'))
        .called(1);
    verifyNever(() => f.reporter.reportMoment(f.moment, 'Spam\nDetails'));
    expect(find.text('Report submitted'), findsOneWidget);
  });

  testWidgets('post report waits for exact repository acknowledgement', (
    tester,
  ) async {
    final f = _Fixture();
    final pending = Completer<void>();
    when(() => f.reporter.reportMoment(f.moment, 'Spam\nDetails'))
        .thenAnswer((_) => pending.future);
    await _openReport(tester, f);
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    verify(() => f.reporter.reportMoment(f.moment, 'Spam\nDetails')).called(1);
    expect(find.text('Report submitted'), findsNothing);
    expect(find.byType(AlertDialog), findsOneWidget);
    pending.complete();
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Report submitted'), findsOneWidget);
  });

  testWidgets('account switch before submit never sends the old post', (
    tester,
  ) async {
    final f = _Fixture();
    await _openReport(tester, f);
    f.current = false;
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    verifyNever(() => f.reporter.reportMoment(f.moment, 'Spam\nDetails'));
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Report submitted'), findsNothing);
  });

  for (final fail in [false, true]) {
    testWidgets(
      'late post report after account change cannot show success: $fail',
      (tester) async {
        final f = _Fixture();
        final pending = Completer<void>();
        when(() => f.reporter.reportMoment(f.moment, 'Spam\nDetails'))
            .thenAnswer((_) => pending.future);
        await _openReport(tester, f);
        await tester.tap(find.text('Confirm'));
        await tester.pump();
        f.current = false;
        if (fail) {
          pending.completeError(StateError('network'));
        } else {
          pending.complete();
        }
        await tester.pumpAndSettle();
        expect(find.text('Report submitted'), findsNothing);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Details'), findsOneWidget);
      },
    );
  }
}
