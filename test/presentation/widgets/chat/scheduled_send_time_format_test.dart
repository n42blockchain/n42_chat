import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/scheduled_send_picker.dart';

void main() {
  for (final locale in S.supportedLocales) {
    for (final use24Hours in [false, true]) {
      testWidgets(
        '$locale scheduled quick times respect 24-hour preference $use24Hours',
        (tester) async {
          DateTime? selected;
          await tester.pumpWidget(
            MaterialApp(
              locale: locale,
              supportedLocales: S.supportedLocales,
              localizationsDelegates: S.localizationsDelegates,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: use24Hours),
                child: child!,
              ),
              home: Scaffold(
                body: Builder(
                  builder: (context) => TextButton(
                    onPressed: () async {
                      selected = await showScheduledSendPicker(context);
                    },
                    child: const Text('Open'),
                  ),
                ),
              ),
            ),
          );
          await tester.tap(find.text('Open'));
          await tester.pumpAndSettle();
          final tomorrow = find.ancestor(
            of: find.byIcon(Icons.wb_sunny),
            matching: find.byType(ListTile),
          );
          final context = tester.element(tomorrow);
          final formatted = MaterialLocalizations.of(context).formatTimeOfDay(
            const TimeOfDay(hour: 9, minute: 0),
            alwaysUse24HourFormat: use24Hours,
          );
          expect(
            find.descendant(
              of: tomorrow,
              matching: find.textContaining(formatted),
            ),
            findsOneWidget,
          );
          await tester.tap(tomorrow);
          await tester.pumpAndSettle();
          expect(selected, isNotNull);
          expect(selected!.hour, 9);
          expect(selected!.minute, 0);
          expect(selected!.isAfter(DateTime.now()), isTrue);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
