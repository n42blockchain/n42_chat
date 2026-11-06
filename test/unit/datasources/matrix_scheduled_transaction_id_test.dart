import 'dart:typed_data';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';
import 'package:n42_chat/src/data/repositories/message_repository_impl.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

class _Preferences extends Mock implements PreferencesDataSource {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(matrix.MatrixFile(bytes: Uint8List(0), name: 'file'));
  });
  for (final kind in [
    'text',
    'mention',
    'poll',
    'gif',
    'sticker',
    'image',
    'video',
    'file',
  ]) {
    test(
      '$kind preserves server receipt without querying the local echo',
      () async {
        final manager = _Manager(), client = _Client();
        final room = _Room();
        when(() => manager.client).thenReturn(client);
        when(() => client.isLogged()).thenReturn(true);
        when(() => client.userID).thenReturn('@sender:test');
        when(() => client.getRoomById('!room:test')).thenReturn(room);
        when(() => room.client).thenReturn(client);
        when(() => room.getEventById(any())).thenAnswer((_) async {
          throw StateError('local echo unavailable');
        });
        var encryptionReads = 0;
        // Exercise the existing video encrypted SDK branch after room preparation.
        when(() => room.encrypted)
            .thenAnswer((_) => kind == 'video' && ++encryptionReads > 1);
        when(() => client.fileEncryptionEnabled).thenReturn(true);
        when(
          () => client.uploadContent(
            any(),
            filename: any(named: 'filename'),
            contentType: any(named: 'contentType'),
          ),
        ).thenAnswer((_) async => Uri.parse('mxc://server/file'));
        final ids = <String?>[];
        final contents = <Map<String, dynamic>>[];
        when(
          () => room.sendEvent(
            any(),
            type: any(named: 'type'),
            txid: any(named: 'txid'),
          ),
        ).thenAnswer((invocation) async {
          ids.add(invocation.namedArguments[#txid] as String?);
          contents.add(
            Map<String, dynamic>.from(
              invocation.positionalArguments.first as Map,
            ),
          );
          return r'$accepted';
        });
        when(() => room.sendTextEvent(any(), txid: any(named: 'txid')))
            .thenAnswer((invocation) async {
              ids.add(invocation.namedArguments[#txid] as String?);
              return r'$accepted';
            });
        when(
          () => room.sendFileEvent(
            any(),
            txid: any(named: 'txid'),
            extraContent: any(named: 'extraContent'),
            thumbnail: any(named: 'thumbnail'),
          ),
        ).thenAnswer((invocation) async {
          ids.add(invocation.namedArguments[#txid] as String?);
          return r'$accepted';
        });
        final repository = MessageRepositoryImpl(
          MatrixMessageDataSource(manager),
          manager,
          _Preferences(),
        );
        const tx = 'n42_scheduled_public_fixture';
        final bytes = Uint8List.fromList([1, 2, 3]);
        for (var attempt = 0; attempt < 2; attempt++) {
          encryptionReads = 0;
          MessageEntity? receipt;
          switch (kind) {
            case 'text':
              receipt = await repository.sendTextMessage(
                '!room:test',
                'Hi',
                transactionId: tx,
              );
            case 'mention':
              receipt = await repository.sendTextMessage(
                '!room:test',
                'Hi',
                mentionedUserIds: ['@friend:test'],
                transactionId: tx,
              );
            case 'poll':
              receipt = await repository.sendPollMessage(
                '!room:test',
                question: 'Lunch?',
                options: ['A', 'B'],
                transactionId: tx,
              );
            case 'gif':
              receipt = await repository.sendGifMessage(
                '!room:test',
                gifUrl: 'mxc://server/gif',
                transactionId: tx,
              );
            case 'sticker':
              receipt = await repository.sendStickerMessage(
                '!room:test',
                stickerId: 's',
                packId: 'p',
                url: 'mxc://server/sticker',
                transactionId: tx,
              );
            case 'image':
              receipt = await repository.sendImageMessage(
                '!room:test',
                imageBytes: bytes,
                filename: 'image.png',
                transactionId: tx,
              );
            case 'video':
              receipt = await repository.sendVideoMessage(
                '!room:test',
                videoBytes: bytes,
                filename: 'video.mp4',
                transactionId: tx,
              );
            case 'file':
              receipt = await repository.sendFileMessage(
                '!room:test',
                fileBytes: bytes,
                filename: 'file.bin',
                transactionId: tx,
              );
          }
          expect(receipt?.id, r'$accepted');
          expect(receipt?.status, MessageStatus.sent);
          expect(receipt?.roomId, '!room:test');
          expect(receipt?.senderId, '@sender:test');
        }
        expect(ids, [tx, tx]);
        verifyNever(() => room.getEventById(any()));
        if (kind == 'poll') {
          expect(
            contents[0],
            contents[1],
            reason: 'Retry keeps poll answer IDs stable too',
          );
        }
      },
    );
  }
}
