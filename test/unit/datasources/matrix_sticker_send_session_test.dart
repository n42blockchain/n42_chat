import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_sticker_datasource.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_entity.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => registerFallbackValue(Uint8List(0)));
  for (final scenario in [
    'load switch',
    'upload switch',
    'failed upload switch',
    'stable upload',
    'stable fallback',
  ]) {
    test('legacy bundled sticker send: $scenario', () async {
      final manager = _Manager();
      final client = _Client();
      final room = _Room();
      var user = '@alice:example';
      final asset = Completer<ByteData?>();
      final started = Completer<void>();
      final upload = Completer<Uri>();
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMessageHandler('flutter/assets', (_) => asset.future);
      addTearDown(
        () => messenger.setMockMessageHandler('flutter/assets', null),
      );
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenAnswer((_) => user);
      when(() => client.getRoomById('!room:example')).thenReturn(room);
      when(() => room.sendTextEvent(any())).thenAnswer((_) async => 'fallback');
      when(() => room.sendEvent(any(), type: any(named: 'type')))
          .thenAnswer((_) async => 'sent');
      when(
        () => client.uploadContent(
          any(),
          filename: any(named: 'filename'),
          contentType: any(named: 'contentType'),
        ),
      ).thenAnswer((_) {
        started.complete();
        return upload.future;
      });
      final result = MatrixStickerDataSource(manager).sendStickerMessage(
        '!room:example',
        Sticker(
          id: scenario,
          url: 'asset:assets/stickers/openmoji/$scenario.svg',
          emoji: '🙂',
        ),
      );
      if (scenario == 'load switch') user = '@bob:example';
      asset.complete(
        ByteData.sublistView(Uint8List.fromList(utf8.encode('<svg/>'))),
      );
      if (scenario != 'load switch') {
        await started.future;
        if (scenario.contains('switch')) user = '@bob:example';
        if (scenario == 'failed upload switch' ||
            scenario == 'stable fallback') {
          upload.completeError(StateError('fixture upload failure'));
        } else {
          upload.complete(Uri.parse('mxc://example/sticker'));
        }
      } else {
        upload.complete(Uri.parse('mxc://example/sticker'));
      }
      expect(
        await result,
        scenario == 'stable upload'
            ? 'sent'
            : scenario == 'stable fallback'
            ? 'fallback'
            : isNull,
      );
      if (scenario.contains('switch')) {
        verifyNever(() => room.sendTextEvent(any()));
        verifyNever(() => room.sendEvent(any(), type: any(named: 'type')));
      }
    });
  }
}
