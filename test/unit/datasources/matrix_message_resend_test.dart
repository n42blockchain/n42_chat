import 'dart:typed_data';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_media_uploader.dart';
import 'package:n42_chat/src/data/datasources/matrix/message/matrix_message_sender.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

class _Uploader extends Mock implements MatrixMediaUploader {}

class _Event extends Mock implements matrix.Event {}

class _Database extends Mock implements matrix.DatabaseApi {}

void main() {
  late _Manager manager;
  late _Client client;
  late _Room room;
  late MatrixMessageSender sender;
  late matrix.Event event;
  setUp(() {
    manager = _Manager();
    client = _Client();
    room = _Room();
    when(() => manager.client).thenReturn(client);
    when(() => client.isLogged()).thenReturn(true);
    when(() => client.userID).thenReturn('@me:test');
    when(() => client.accessToken).thenReturn('token');
    when(() => client.deviceID).thenReturn('device');
    when(() => client.getRoomById('!room:test')).thenReturn(room);
    when(() => room.id).thenReturn('!room:test');
    when(() => room.client).thenReturn(client);
    when(() => room.encrypted).thenReturn(false);
    event = matrix.Event(
      content: {'body': 'hello', 'msgtype': 'm.text'},
      type: 'm.room.message',
      eventId: 'local-id',
      senderId: '@me:test',
      originServerTs: DateTime(2026),
      room: room,
      status: matrix.EventStatus.error,
      unsigned: {'transaction_id': 'original-tx'},
    );
    when(() => room.getEventById('local-id')).thenAnswer((_) async => event);
    when(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    ).thenAnswer((_) async => r'$sent');
    sender = MatrixMessageSender(manager, _Uploader());
  });

  test('preserves original transaction and sticker type', () async {
    event = matrix.Event(
      content: {'body': 'sticker', 'url': 'mxc://test/art'},
      type: 'm.sticker',
      eventId: 'local-id',
      senderId: '@me:test',
      originServerTs: DateTime(2026),
      room: room,
      status: matrix.EventStatus.error,
      unsigned: {'transaction_id': 'original-tx'},
    );
    expect(await sender.resendMessage('!room:test', 'local-id'), isTrue);
    verify(
      () =>
          room.sendEvent(event.content, txid: 'original-tx', type: 'm.sticker'),
    ).called(1);
  });
  for (final mode in ['other-author', 'already-sent']) {
    test('rejects $mode events', () async {
      event = matrix.Event(
        content: {'body': 'hello'},
        type: 'm.room.message',
        eventId: 'local-id',
        senderId: mode == 'other-author' ? '@other:test' : '@me:test',
        originServerTs: DateTime(2026),
        room: room,
        status: mode == 'already-sent'
            ? matrix.EventStatus.synced
            : matrix.EventStatus.error,
      );
      expect(await sender.resendMessage('!room:test', 'local-id'), isFalse);
      verifyNever(
        () => room.sendEvent(
          any(),
          txid: any(named: 'txid'),
          type: any(named: 'type'),
        ),
      );
    });
  }
  test('rejects token change while loading the failed event', () async {
    final pending = Completer<matrix.Event?>();
    final entered = Completer<void>();
    when(() => room.getEventById('local-id')).thenAnswer((_) {
      entered.complete();
      return pending.future;
    });
    final result = sender.resendMessage('!room:test', 'local-id');
    await entered.future;
    when(() => client.accessToken).thenReturn('replacement');
    pending.complete(event);
    expect(await result, isFalse);
    verifyNever(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    );
  });
  test('coalesces concurrent automatic and manual resends', () async {
    final pending = Completer<String?>();
    when(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    ).thenAnswer((_) => pending.future);
    final first = sender.resendMessage('!room:test', 'local-id');
    final second = sender.resendMessage('!room:test', 'local-id');
    await Future<void>.delayed(Duration.zero);
    pending.complete(r'$sent');
    expect(await first, isTrue);
    expect(await second, isTrue);
    verify(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    ).called(1);
  });
  test('empty receipt is not success', () async {
    when(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    ).thenAnswer((_) async => null);
    expect(await sender.resendMessage('!room:test', 'local-id'), isFalse);
  });
  test(
    'media retry delegates cached upload to SDK with stable transaction',
    () async {
      final media = _Event();
      final database = _Database();
      when(() => client.database).thenReturn(database);
      when(() => database.getFile(Uri.parse('cache://file/original-tx')))
          .thenAnswer((_) async => Uint8List(1));
      event = media;
      when(() => media.room).thenReturn(room);
      when(() => media.senderId).thenReturn('@me:test');
      when(() => media.status).thenReturn(matrix.EventStatus.error);
      when(() => media.type).thenReturn('m.room.message');
      when(() => media.content).thenReturn({
        'body': 'photo',
        'filename': 'photo.png',
        'msgtype': 'm.image',
      });
      when(() => media.messageType).thenReturn('m.image');
      when(() => media.transactionId).thenReturn('original-tx');
      when(() => media.sendAgain(txid: 'original-tx'))
          .thenAnswer((_) async => r'$media');
      expect(await sender.resendMessage('!room:test', 'local-id'), isTrue);
      verify(() => media.sendAgain(txid: 'original-tx')).called(1);
      when(() => database.getFile(Uri.parse('cache://file/original-tx')))
          .thenAnswer((_) async => null);
      expect(await sender.resendMessage('!room:test', 'local-id'), isFalse);
      verifyNever(() => media.sendAgain(txid: 'original-tx'));
    },
  );
  test('account switch during cache lookup blocks media retry', () async {
    final media = _Event();
    final database = _Database();
    final entered = Completer<void>();
    final cached = Completer<Uint8List?>();
    event = media;
    when(() => client.database).thenReturn(database);
    when(() => media.room).thenReturn(room);
    when(() => media.senderId).thenReturn('@me:test');
    when(() => media.status).thenReturn(matrix.EventStatus.error);
    when(() => media.type).thenReturn('m.room.message');
    when(() => media.content)
        .thenReturn({'filename': 'photo.png', 'msgtype': 'm.image'});
    when(() => media.messageType).thenReturn('m.image');
    when(() => media.transactionId).thenReturn('original-tx');
    when(() => database.getFile(Uri.parse('cache://file/original-tx')))
        .thenAnswer((_) {
          entered.complete();
          return cached.future;
        });
    final result = sender.resendMessage('!room:test', 'local-id');
    await entered.future;
    when(() => client.accessToken).thenReturn('replacement');
    cached.complete(Uint8List(1));
    expect(await result, isFalse);
    verifyNever(() => media.sendAgain(txid: 'original-tx'));
  });

  for (final encrypted in [false, true]) {
    test(
      'already uploaded media reuses content without local cache: $encrypted',
      () async {
        final content = <String, dynamic>{
          'body': 'photo',
          'msgtype': 'm.image',
          if (encrypted)
            'file': {
              'url': 'mxc://test/photo',
              'key': {'k': 'fixture'},
            }
          else
            'url': 'https://example.invalid/photo.gif',
        };
        event = matrix.Event(
          content: content,
          type: 'm.room.message',
          eventId: 'local-id',
          senderId: '@me:test',
          originServerTs: DateTime(2026),
          room: room,
          status: matrix.EventStatus.error,
        );
        expect(await sender.resendMessage('!room:test', 'local-id'), isTrue);
        verify(
          () =>
              room.sendEvent(content, txid: 'local-id', type: 'm.room.message'),
        ).called(1);
      },
    );
  }
  test(
    'failed attempt releases single-flight guard for an explicit retry',
    () async {
      var attempts = 0;
      when(
        () => room.sendEvent(
          any(),
          txid: any(named: 'txid'),
          type: any(named: 'type'),
        ),
      ).thenAnswer((_) async {
        if (++attempts == 1) throw StateError('offline');
        return r'$sent';
      });
      expect(await sender.resendMessage('!room:test', 'local-id'), isFalse);
      expect(await sender.resendMessage('!room:test', 'local-id'), isTrue);
      verify(
        () => room.sendEvent(
          event.content,
          txid: 'original-tx',
          type: 'm.room.message',
        ),
      ).called(2);
    },
  );
  test('encrypted room with unavailable keys cannot resend', () async {
    when(() => room.encrypted).thenReturn(true);
    when(() => client.encryptionEnabled).thenReturn(false);
    expect(await sender.resendMessage('!room:test', 'local-id'), isFalse);
    verifyNever(
      () => room.sendEvent(
        any(),
        txid: any(named: 'txid'),
        type: any(named: 'type'),
      ),
    );
  });
}
