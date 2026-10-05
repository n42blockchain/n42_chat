import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/presentation/pages/profile/profile_invoice_manage_page.dart';

class _ClientManager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements Client {}

void main() {
  late _ClientManager manager;
  late _Client client;

  setUp(() async {
    await getIt.reset();
    manager = _ClientManager();
    client = _Client();
    when(() => manager.client).thenReturn(client);
    when(client.isLogged).thenReturn(true);
    when(() => client.userID).thenReturn('@alice:hs.test');
    when(
      () => client.getAccountData('@alice:hs.test', 'n42.user.invoices'),
    ).thenAnswer((_) async => {'invoices': <Map<String, dynamic>>[]});
    when(
      () => client.setAccountData(any(), any(), any()),
    ).thenAnswer((_) async {});
    getIt.registerSingleton<MatrixClientManager>(manager);
  });

  tearDown(() => getIt.reset());

  Future<S> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: const InvoiceManagePage(),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(InvoiceManagePage)))!;
  }

  testWidgets('validates and saves a company invoice as the default', (
    tester,
  ) async {
    final l10n = await open(tester);
    expect(find.text(l10n.profileNoInvoice), findsOneWidget);
    await tester.tap(find.text(l10n.profileAddNew));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, l10n.profileCompany));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.commonSave));
    await tester.pumpAndSettle();
    expect(find.text(l10n.profileEnterCompanyName), findsAtLeastNWidgets(1));

    await tester.enterText(find.byType(TextField).at(0), 'N42 Inc.');
    await tester.tap(find.text(l10n.commonSave));
    await tester.pumpAndSettle();
    expect(find.text(l10n.profileEnterTaxIdNumber), findsAtLeastNWidgets(1));

    await tester.enterText(find.byType(TextField).at(1), 'TAX-123');
    await tester.enterText(find.byType(TextField).at(2), 'North Bank');
    await tester.enterText(find.byType(TextField).at(3), 'Account 456');
    await tester.enterText(find.byType(TextField).at(4), '1 Main Street');
    await tester.enterText(find.byType(TextField).at(5), '555-0123');
    await tester.ensureVisible(find.byType(CheckboxListTile));
    await tester.tap(find.byType(CheckboxListTile));
    await tester.tap(find.text(l10n.commonSave));
    await tester.pumpAndSettle();

    expect(find.text('N42 Inc.'), findsOneWidget);
    expect(find.textContaining('TAX-123'), findsOneWidget);
    expect(find.text(l10n.profileDefaultLabel), findsOneWidget);
    verify(
      () => client.setAccountData('@alice:hs.test', 'n42.user.invoices', {
        'invoices': [
          {
            'type': 'company',
            'title': 'N42 Inc.',
            'taxNumber': 'TAX-123',
            'bankName': 'North Bank',
            'bankAccount': 'Account 456',
            'companyAddress': '1 Main Street',
            'companyPhone': '555-0123',
            'isDefault': true,
          },
        ],
      }),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('loads existing invoice, edits it, and persists the change', (
    tester,
  ) async {
    when(
      () => client.getAccountData('@alice:hs.test', 'n42.user.invoices'),
    ).thenAnswer(
      (_) async => {
        'invoices': [
          {'type': 'personal', 'title': 'Alice', 'isDefault': true},
        ],
      },
    );
    final l10n = await open(tester);

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text(l10n.profileDefaultLabel), findsOneWidget);
    await tester.tap(find.text(l10n.commonEdit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Alice Updated');
    await tester.tap(find.text(l10n.commonSave));
    await tester.pumpAndSettle();

    expect(find.text('Alice Updated'), findsOneWidget);
    expect(find.text('Alice'), findsNothing);
    verify(
      () => client.setAccountData('@alice:hs.test', 'n42.user.invoices', {
        'invoices': [
          {
            'type': 'personal',
            'title': 'Alice Updated',
            'taxNumber': null,
            'bankName': null,
            'bankAccount': null,
            'companyAddress': null,
            'companyPhone': null,
            'isDefault': true,
          },
        ],
      }),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('delete confirmation keeps or removes the saved invoice', (
    tester,
  ) async {
    when(
      () => client.getAccountData('@alice:hs.test', 'n42.user.invoices'),
    ).thenAnswer(
      (_) async => {
        'invoices': [
          {'type': 'personal', 'title': 'Alice', 'isDefault': false},
        ],
      },
    );
    final l10n = await open(tester);

    await tester.tap(find.text(l10n.commonDelete));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();
    expect(find.text('Alice'), findsOneWidget);
    verifyNever(() => client.setAccountData(any(), any(), any()));

    await tester.tap(find.text(l10n.commonDelete));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.commonDelete).last);
    await tester.pumpAndSettle();
    expect(find.text(l10n.profileNoInvoice), findsOneWidget);
    verify(
      () => client.setAccountData('@alice:hs.test', 'n42.user.invoices', {
        'invoices': <Map<String, dynamic>>[],
      }),
    ).called(1);
    expect(tester.takeException(), isNull);
  });
}
