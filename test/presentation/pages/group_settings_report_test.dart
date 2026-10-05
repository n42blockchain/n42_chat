import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/group_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/content_report_repository.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/group/group_state.dart';
import 'package:n42_chat/src/presentation/pages/group/group_settings_page.dart';

class _GroupBloc extends Mock implements GroupBloc {
  @override
  GroupState get state => const GroupState(
    status: GroupStatus.loaded,
    currentGroup: GroupEntity(roomId: '!actual:hs.test', name: 'Display name'),
  );

  @override
  Stream<GroupState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

class _ReportRepository extends Mock implements IContentReportRepository {}

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
    getIt.registerSingleton<IContentReportRepository>(reporter);
    addTearDown(getIt.popScope);
  }

  final manager = _Manager();
  final client = _Client();
  final auth = _Auth();
  final reporter = _ReportRepository();
  final bloc = _GroupBloc();
  bool current = true;

  late final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: 'device-A',
    isCurrent: () => current,
    matchesClient: (candidate) => identical(candidate, client),
  );

  Widget build() => BlocProvider<GroupBloc>.value(
    value: bloc,
    child: const MaterialApp(
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      locale: Locale('en'),
      home: GroupSettingsPage(roomId: '!actual:hs.test'),
    ),
  );
}

void main() {
  testWidgets(
    'group More reports its room ID only after Matrix acknowledgement',
    (tester) async {
      final fixture = _Fixture();
      final acknowledgement = Completer<void>();
      when(
        () => fixture.reporter.reportRoom(
          roomId: '!actual:hs.test',
          reason: 'Spam\nRoom details',
        ),
      ).thenAnswer((_) => acknowledgement.future);
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(fixture.build());
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();
      expect(find.text('Group QR Code'), findsOneWidget);
      expect(find.text('Search Chat History'), findsOneWidget);
      await tester.tap(find.text('Report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spam'));
      await tester.enterText(find.byType(TextField), 'Room details');
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      expect(find.text('Report submitted'), findsNothing);
      verify(
        () => fixture.reporter.reportRoom(
          roomId: '!actual:hs.test',
          reason: 'Spam\nRoom details',
        ),
      ).called(1);
      acknowledgement.complete();
      await tester.pumpAndSettle();
      expect(find.text('Report submitted'), findsOneWidget);
      verifyNever(
        () => fixture.reporter.reportUser(
          userId: any(named: 'userId'),
          reason: any(named: 'reason'),
        ),
      );
    },
  );

  testWidgets('stale account cannot submit a room report', (tester) async {
    final fixture = _Fixture();
    await tester.pumpWidget(fixture.build());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spam'));
    fixture.current = false;
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    expect(
      find.text('Account changed. Open this report again to send it.'),
      findsOneWidget,
    );
    verifyNever(
      () => fixture.reporter.reportRoom(
        roomId: any(named: 'roomId'),
        reason: any(named: 'reason'),
      ),
    );
  });

  testWidgets('failed room report keeps the draft and no success', (
    tester,
  ) async {
    final fixture = _Fixture();
    when(
      () => fixture.reporter.reportRoom(
        roomId: '!actual:hs.test',
        reason: 'Fraud\nRoom details',
      ),
    ).thenThrow(const ContentReportException(ContentReportFailure.transport));
    await tester.pumpWidget(fixture.build());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fraud'));
    await tester.enterText(find.byType(TextField), 'Room details');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(
      find.text('Could not send report. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('Room details'), findsOneWidget);
    expect(find.text('Report submitted'), findsNothing);
  });
}
