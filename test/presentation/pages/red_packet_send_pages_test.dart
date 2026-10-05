import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/pages/red_packet/send_red_packet_page.dart';
import 'package:n42_chat/src/presentation/pages/red_packet/send_transfer_page.dart';
import 'package:n42_chat/src/presentation/widgets/common/slide_to_pay_button.dart';

Widget _buildHarness(Widget page) {
  return MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute<void>(builder: (_) => page));
          },
          child: const Text('Open'),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('failed red packet send keeps form open', (tester) async {
    await tester.pumpWidget(
      _buildHarness(
        SendRedPacketPage(
          receiverName: 'Alice',
          onSend: (amount, token, greeting, count, isLucky) async => false,
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '12.34');
    await tester.pump();
    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton))
        .onPressed!
        .call();
    await tester.pump();

    expect(find.byType(SendRedPacketPage), findsOneWidget);

    final amountField = tester.widget<TextField>(find.byType(TextField).first);
    expect(amountField.controller?.text, '12.34');
  });

  testWidgets('successful red packet send closes page', (tester) async {
    await tester.pumpWidget(
      _buildHarness(
        SendRedPacketPage(
          receiverName: 'Alice',
          onSend: (amount, token, greeting, count, isLucky) async => true,
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '12.34');
    await tester.pump();
    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton))
        .onPressed!
        .call();
    await tester.pumpAndSettle();

    expect(find.byType(SendRedPacketPage), findsNothing);
  });

  testWidgets('currency changes trim precision and pickers update the form', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildHarness(
        SendRedPacketPage(
          receiverName: 'Alice',
          onSend: (amount, token, greeting, count, isLucky) async => true,
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(SendRedPacketPage)))!;

    await tester.tap(find.text('CNY').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('BTC').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '1.12345678');
    await tester.tap(find.text('BTC').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('CNY').last);
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      '1.12',
    );

    await tester.tap(find.text(l10n.commonRedPacketCover));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Golden'));
    await tester.pumpAndSettle();
    expect(find.text('Golden'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(1), 'Hi');
    await tester.tap(find.byIcon(Icons.emoji_emotions_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('🎉'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField).at(1)).controller!.text,
      'Hi🎉',
    );
  });

  testWidgets('lucky group packet rejects a zero packet count', (tester) async {
    var sendCalled = false;
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildHarness(
        SendRedPacketPage(
          receiverName: 'Group',
          isGroup: true,
          memberCount: 4,
          onSend: (amount, token, greeting, count, isLucky) async {
            sendCalled = true;
            return true;
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    final l10n = S.of(tester.element(find.byType(SendRedPacketPage)))!;

    await tester.tap(find.text(l10n.commonLuckyRedPacket));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '1.00');
    await tester.enterText(find.byType(TextField).at(2), '0');
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(sendCalled, isFalse);
    expect(find.text(l10n.commonRedPacketCountMin), findsOneWidget);
    expect(find.byType(SendRedPacketPage), findsOneWidget);
  });

  testWidgets('failed transfer send keeps form open and resets slider', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildHarness(
        SendTransferPage(
          receiverName: 'Alice',
          onSend: (amount, token, memo) async => false,
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '8.88');

    final slideButton = tester.widget<SlideToPayButton>(
      find.byType(SlideToPayButton),
    );
    slideButton.onConfirmed();
    await tester.pump();

    expect(find.byType(SendTransferPage), findsOneWidget);

    final amountField = tester.widget<TextField>(find.byType(TextField).first);
    expect(amountField.controller?.text, '8.88');
  });

  testWidgets('successful transfer send closes page', (tester) async {
    await tester.pumpWidget(
      _buildHarness(
        SendTransferPage(
          receiverName: 'Alice',
          onSend: (amount, token, memo) async => true,
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '8.88');

    final slideButton = tester.widget<SlideToPayButton>(
      find.byType(SlideToPayButton),
    );
    slideButton.onConfirmed();
    await tester.pumpAndSettle();

    expect(find.text('Open'), findsOneWidget);
    expect(find.byType(SendTransferPage), findsNothing);
  });
}
