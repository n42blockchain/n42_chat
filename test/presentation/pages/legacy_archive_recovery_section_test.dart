import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/services/archive_account_access.dart';
import 'package:n42_chat/src/core/services/legacy_archive_recovery_service.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/presentation/pages/settings/legacy_archive_recovery_section.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

void main() {
  for (final mode in ['none', 'cancel', 'confirm', 'stale', 'changed-source']) {
    testWidgets('legacy recovery selection and confirmation: $mode', (
      tester,
    ) async {
      final legacy = ArchiveDatabase.forTesting(NativeDatabase.memory());
      final target = ArchiveDatabase.forTesting(NativeDatabase.memory());
      addTearDown(() async {
        await legacy.close();
        await target.close();
      });
      ArchivedMessagesCompanion row(String id, String room) =>
          ArchivedMessagesCompanion.insert(
            eventId: id,
            roomId: room,
            senderId: '@alice:example.org',
            originServerTs: 100,
            type: 'm.room.message',
            quarter: 202601,
            archivedAt: DateTime(2026),
          );
      await legacy.insertMessages([
        row('selected', '!selected:example.org'),
        row('other', '!other:example.org'),
      ]);
      final manager = _Manager();
      final client = _Client();
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@alice:example.org');
      when(() => client.homeserver)
          .thenReturn(Uri.parse('https://example.org'));
      when(() => client.accessToken).thenReturn('fixture-token');
      when(() => client.deviceID).thenReturn('fixture-device');
      final access = ArchiveAccountAccess(
        clientManager: manager,
        open: (_, _) async => target,
      );
      final service = LegacyArchiveRecoveryService(
        access: access,
        openLegacy: () async => legacy,
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(body: LegacyArchiveRecoverySection(service: service)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recover older local history'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('@alice:example.org'), findsOneWidget);
      expect(find.textContaining('no verified owner'), findsOneWidget);
      final confirm = find.widgetWithText(FilledButton, 'Confirm');
      expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
      if (mode != 'none') {
        await tester.tap(
          find.widgetWithText(CheckboxListTile, '!selected:example.org'),
        );
        await tester.pumpAndSettle();
        expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
      }
      if (mode == 'none' || mode == 'cancel') {
        await tester.tap(find.text('Cancel'));
      } else {
        if (mode == 'stale') {
          when(() => client.userID).thenReturn('@bob:example.org');
        }
        if (mode == 'changed-source') {
          await legacy.insertMessages([row('late', '!selected:example.org')]);
        }
        await tester.tap(confirm);
      }
      await tester.pumpAndSettle();
      expect(
        await target.getMessageCount('!selected:example.org'),
        mode == 'confirm' ? 1 : 0,
      );
      expect(await target.isEventArchived('other'), isFalse);
      expect(await legacy.isEventArchived('selected'), isTrue);
      expect(find.byType(AlertDialog), findsNothing);
      expect(
        find.text('Done'),
        mode == 'confirm' ? findsOneWidget : findsNothing,
      );
      expect(tester.takeException(), isNull);
    });
  }
}
