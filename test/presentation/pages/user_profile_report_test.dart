import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/repositories/content_report_repository.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/pages/profile/user_profile_page.dart';

class _ContactRepository extends Mock implements IContactRepository {}

class _ReportRepository extends Mock implements IContentReportRepository {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _ContactBloc extends Mock implements ContactBloc {
  @override
  ContactState get state => const ContactState.initial();

  @override
  Stream<ContactState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

void main() {
  testWidgets('profile report waits for the captured account acknowledgement', (
    tester,
  ) async {
    final contacts = _ContactRepository();
    final reports = _ReportRepository();
    final manager = _Manager();
    final client = _Client();
    final auth = _Auth();
    final bloc = _ContactBloc();
    final acknowledgement = Completer<void>();
    final generation = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: 'device-A',
      isCurrent: () => true,
      matchesClient: (candidate) => identical(candidate, client),
    );
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('session-A');
    when(() => client.deviceID).thenReturn('device-A');
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => contacts.isUserIgnored('@friend:hs.test')).thenReturn(false);
    when(() => contacts.getContactById('@friend:hs.test')).thenAnswer(
      (_) async =>
          const ContactEntity(userId: '@friend:hs.test', displayName: 'Friend'),
    );
    when(
      () => reports.reportUser(userId: '@friend:hs.test', reason: 'Fraud'),
    ).thenAnswer((_) => acknowledgement.future);
    getIt.pushNewScope();
    getIt.registerSingleton<IContactRepository>(contacts);
    getIt.registerSingleton<IContentReportRepository>(reports);
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    addTearDown(getIt.popScope);
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      BlocProvider<ContactBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: Locale('en'),
          home: UserProfilePage(userId: '@friend:hs.test'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Report'));
    await tester.tap(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fraud'));
    await tester.tap(find.text('Confirm'));
    await tester.pump();

    expect(find.text('Report submitted'), findsNothing);
    verify(
      () => reports.reportUser(userId: '@friend:hs.test', reason: 'Fraud'),
    ).called(1);
    acknowledgement.complete();
    await tester.pumpAndSettle();
    expect(find.text('Report submitted'), findsOneWidget);
  });
}
