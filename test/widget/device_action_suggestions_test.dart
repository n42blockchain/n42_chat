import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/widgets/chat/device_action_suggestions.dart';

void main() {
  testWidgets(
    'system capability probe contains no text and cancelling never creates native actions',
    (tester) async {
      final probes = <MethodCall>[], platform = <MethodCall>[];
      const channel = MethodChannel('n42.chat/suggested_actions');
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
        call,
      ) async {
        probes.add(call);
        return true;
      });
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform_views,
        (call) async {
          platform.add(call);
          return null;
        },
      );
      addTearDown(() {
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          channel,
          null,
        );
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform_views,
          null,
        );
      });
      final message = MessageEntity(
        id: 'event',
        roomId: 'room',
        senderId: 'sender',
        senderName: 'Sender',
        content: 'Private meeting text',
        type: MessageType.text,
        timestamp: DateTime.utc(2026),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(body: DeviceActionSuggestions(message: message)),
        ),
      );
      await tester.pumpAndSettle();
      expect(probes.single.method, 'isAvailable');
      expect(probes.single.arguments, isNull);
      expect(platform, isEmpty);
      await tester.tap(find.text('On-device actions'));
      await tester.pumpAndSettle();
      expect(platform, isEmpty);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(platform, isEmpty);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.iOS),
  );
}
