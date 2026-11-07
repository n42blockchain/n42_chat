import 'dart:typed_data';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/thread/thread_event.dart';

class _Repo extends Mock implements IMessageRepository {}

void main() {
  setUpAll(() => registerFallbackValue(Uint8List(0)));
  late _Repo repo;
  late ThreadBloc bloc;
  MessageEntity message(String id) => MessageEntity(
    id: id,
    roomId: '!room',
    senderId: '@a',
    senderName: 'A',
    content: 'text',
    timestamp: DateTime(2026),
    type: MessageType.text,
  );
  setUp(() async {
    repo = _Repo();
    when(() => repo.getThreadMessages(any(), any()))
        .thenAnswer((_) async => [message('root')]);
    when(() => repo.watchThreadMessages(any(), any()))
        .thenAnswer((_) => const Stream.empty());
    bloc = ThreadBloc(messageRepository: repo)
      ..add(const InitializeThread(roomId: '!room', threadRootEventId: 'root'));
    await pumpEventQueue();
  });
  tearDown(() => bloc.close());
  for (final id in <String?>[null, '', '   ']) {
    for (final kind in ['text', 'image', 'file']) {
      test('$kind rejects receipt $id', () async {
        final receipt = id == null ? null : message(id);
        when(() => repo.sendThreadTextMessage(any(), any(), any()))
            .thenAnswer((_) async => receipt);
        when(
          () => repo.sendThreadImageMessage(
            any(),
            any(),
            imageBytes: any(named: 'imageBytes'),
            filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'),
          ),
        ).thenAnswer((_) async => receipt);
        when(
          () => repo.sendThreadFileMessage(
            any(),
            any(),
            fileBytes: any(named: 'fileBytes'),
            filename: any(named: 'filename'),
            mimeType: any(named: 'mimeType'),
          ),
        ).thenAnswer((_) async => receipt);
        final completion = Completer<bool>();
        bloc.add(switch (kind) {
          'text' => SendThreadTextMessage('text', completion: completion),
          'image' => const SendThreadImageMessage(
            imageBytes: [1],
            filename: 'a.png',
          ),
          _ => const SendThreadFileMessage(fileBytes: [1], filename: 'a.txt'),
        });
        await pumpEventQueue();
        expect(bloc.state.error, contains('not acknowledged'));
        expect(bloc.state.isSending, isFalse);
        if (kind == 'text') expect(await completion.future, isFalse);
      });
    }
  }
  test('duplicate dispatch rejected while original is pending', () async {
    final pending = Completer<MessageEntity?>();
    when(() => repo.sendThreadTextMessage(any(), any(), any()))
        .thenAnswer((_) => pending.future);
    final first = Completer<bool>(), second = Completer<bool>();
    bloc.add(SendThreadTextMessage('text', completion: first));
    await pumpEventQueue();
    bloc.add(SendThreadTextMessage('text', completion: second));
    await pumpEventQueue();
    expect(await second.future, isFalse);
    expect(first.isCompleted, isFalse);
    pending.complete(message('accepted'));
    expect(await first.future, isTrue);
    verify(() => repo.sendThreadTextMessage(any(), any(), any())).called(1);
  });
}
