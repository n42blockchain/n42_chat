import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/bot_webhook_service.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/domain/entities/bot_config_entity.dart';

class _MockSecureStorageDataSource extends Mock
    implements SecureStorageDataSource {}

void main() {
  group('BotWebhookService', () {
    late _MockSecureStorageDataSource secureStorage;

    setUp(() {
      secureStorage = _MockSecureStorageDataSource();
      when(
        () => secureStorage.getRoomBotWebhookSecret(any()),
      ).thenAnswer((_) async => null);
    });

    test(
      'rejects non-public or non-https webhook urls before sending',
      () async {
        var requestCount = 0;
        final service = BotWebhookService(
          secureStorageDataSource: secureStorage,
          clientFactory: () => MockClient((request) async {
            requestCount++;
            return http.Response('ok', 200);
          }),
        );

        await service.dispatch(
          config: const BotConfig(
            enabled: true,
            webhookUrl: 'http://127.0.0.1:8080/hook',
            webhookEvents: {BotAutomationEventType.memberJoined},
          ),
          payload: BotWebhookEventPayload(
            eventType: BotAutomationEventType.memberJoined,
            roomId: '!room:test',
            roomName: 'Test',
            triggeredAt: DateTime.utc(2026, 3, 21),
          ),
        );

        expect(requestCount, 0);
      },
    );

    test('signs payload with locally stored secret only', () async {
      http.Request? capturedRequest;
      when(
        () => secureStorage.getRoomBotWebhookSecret('!room:test'),
      ).thenAnswer((_) async => 'device-secret');
      final service = BotWebhookService(
        secureStorageDataSource: secureStorage,
        clientFactory: () => MockClient((request) async {
          capturedRequest = request;
          return http.Response('ok', 200);
        }),
      );

      await service.dispatch(
        config: const BotConfig(
          enabled: true,
          webhookUrl: 'https://hooks.example.com/n42',
          webhookSecret: 'remote-secret',
          webhookEvents: {BotAutomationEventType.memberJoined},
        ),
        payload: BotWebhookEventPayload(
          eventType: BotAutomationEventType.memberJoined,
          roomId: '!room:test',
          roomName: 'Test',
          triggeredAt: DateTime.utc(2026, 3, 21, 12),
          userId: '@alice:test',
        ),
      );

      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.headers['X-N42-Signature'], isNotNull);
      expect(
        capturedRequest!.headers['X-N42-Signature'],
        isNot(contains('remote-secret')),
      );
      final body = jsonDecode(capturedRequest!.body) as Map<String, dynamic>;
      expect(body['room_id'], '!room:test');
      verify(
        () => secureStorage.getRoomBotWebhookSecret('!room:test'),
      ).called(1);
    });
  });
}
