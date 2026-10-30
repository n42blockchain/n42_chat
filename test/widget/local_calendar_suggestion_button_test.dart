import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/local_calendar_suggestion_button.dart';

void main() {
  testWidgets(
    'native editor receives only previewed fields after explicit confirmation',
    (tester) async {
      final calls = <MethodCall>[];
      const channel = MethodChannel('n42.chat/calendar');
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
        call,
      ) async {
        calls.add(call);
        return true;
      });
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          channel,
          null,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            body: LocalCalendarSuggestionButton(
              startsAt: DateTime.utc(2026, 11, 1, 15, 30),
            ),
          ),
        ),
      );
      expect(calls, isEmpty);
      await tester.tap(find.text('Calendar suggestion'));
      await tester.pumpAndSettle();
      expect(calls, isEmpty);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(calls, isEmpty);
      await tester.tap(find.text('Calendar suggestion'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(calls, hasLength(1));
      expect(calls.single.method, 'addEvent');
      expect(calls.single.arguments, {
        'title': 'Chat event',
        'starts_at': DateTime.utc(2026, 11, 1, 15, 30).millisecondsSinceEpoch,
        'ends_at': DateTime.utc(2026, 11, 1, 16, 30).millisecondsSinceEpoch,
      });
    },
  );
}
