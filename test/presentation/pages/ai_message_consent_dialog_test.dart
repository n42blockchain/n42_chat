import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/widgets/chat/ai_message_consent_dialog.dart';

void main() {
  testWidgets(
    'requires explicit selection and returns selected messages only',
    (tester) async {
      Set<String>? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  result = await showDialog<Set<String>>(
                    context: context,
                    builder: (_) => const AiMessageConsentDialog(
                      messages: [
                        AiMessageConsentItem(
                          id: 'm1',
                          sender: 'Alice',
                          content: 'Selected message',
                        ),
                        AiMessageConsentItem(
                          id: 'm2',
                          sender: 'Bob',
                          content: 'Private message',
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Share selected'),
            )
            .onPressed,
        isNull,
      );
      await tester.tap(find.text('Selected message'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Share selected'));
      await tester.pumpAndSettle();

      expect(result, {'m1'});
    },
  );

  testWidgets('cancel returns no consent', (tester) async {
    Set<String>? result = {'sentinel'};
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await showDialog<Set<String>>(
                  context: context,
                  builder: (_) => const AiMessageConsentDialog(
                    messages: [
                      AiMessageConsentItem(
                        id: 'm1',
                        sender: 'Alice',
                        content: 'Private message',
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isNull);
  });
}
