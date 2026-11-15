import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/scheduled_send_picker.dart';

void main() {
  for (final language in ['en', 'de', 'ar', 'zh']) {
    testWidgets('$language picker fits a short screen with large text', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(language),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showScheduledSendPicker(context),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final custom = find.byIcon(Icons.calendar_today);
      await tester.ensureVisible(custom);
      await tester.pumpAndSettle();
      await tester.tap(custom);
      await tester.pumpAndSettle();
      expect(find.byType(DatePickerDialog), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('quick options return a future time and omit expired tonight', (
    tester,
  ) async {
    DateTime? result;
    final before = DateTime.now();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                result = await showScheduledSendPicker(context);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    if (before.hour >= 20) {
      expect(find.byIcon(Icons.nightlight_round), findsNothing);
    } else {
      expect(find.byIcon(Icons.nightlight_round), findsOneWidget);
    }
    await tester.tap(find.byIcon(Icons.schedule));
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.difference(before).inMinutes, greaterThanOrEqualTo(59));
    expect(result!.isAfter(DateTime.now()), isTrue);
  });
}
