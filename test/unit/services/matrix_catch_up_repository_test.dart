import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as m;
import 'package:matrix/encryption/encryption.dart';
import 'package:matrix/encryption/key_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/services/matrix_history_sharing.dart';
import 'package:n42_chat/src/data/services/matrix_unread_attention.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/chat_catch_up_repository.dart';

class Client extends Mock implements m.Client {}

class Room extends Mock implements m.Room {}

class Manager extends Mock implements MatrixClientManager {}

class Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

class Storage extends Mock implements SecureStorageDataSource {}

class Crypto extends Mock implements Encryption {}

class Keys extends Mock implements KeyManager {}

void main() {
  late Client client;
  late Room source, target;
  late Manager manager;
  late Lifecycle lifecycle;
  late Storage storage;
  late Crypto crypto;
  late Keys keys;
  late MatrixHistorySharing repository;
  late Map<String, String> journal;
  late Map<String, dynamic> policy;
  late List<Map<String, dynamic>> plaintexts;
  var active = true;
  var admin = 100;
  const user = '@me:hs',
      peer = '@new:hs',
      group = '!group:hs',
      direct = '!direct:hs';
  m.MatrixEvent event(
    String id, {
    String sender = peer,
    Map<String, dynamic>? content,
    Map<String, dynamic>? unsigned,
  }) => m.MatrixEvent(
    eventId: id,
    senderId: sender,
    originServerTs: DateTime.now().subtract(const Duration(hours: 1)),
    type: m.EventTypes.Message,
    content: content ?? {'msgtype': 'm.text', 'body': 'Selected text'},
    unsigned: unsigned,
  );
  setUp(() {
    client = Client();
    source = Room();
    target = Room();
    manager = Manager();
    lifecycle = Lifecycle();
    storage = Storage();
    crypto = Crypto();
    keys = Keys();
    journal = {};
    plaintexts = [];
    active = true;
    admin = 100;
    policy = {
      'enabled': true,
      'max_messages': 20,
      'max_age_hours': 168,
      'revision': 'v1',
    };
    final generation = AuthSessionInvalidation(
      userId: user,
      homeserver: Uri.parse('https://hs'),
      deviceId: 'device',
      isCurrent: () => active,
      matchesClient: (c) => identical(c, client),
    );
    when(() => manager.client).thenReturn(client);
    when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
    when(() => client.accessToken).thenReturn('test-token');
    when(() => client.isLogged()).thenReturn(true);
    when(() => client.userID).thenReturn(user);
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs'));
    when(() => client.deviceID).thenReturn('device');
    when(() => client.encryptionEnabled).thenReturn(true);
    when(() => client.encryption).thenReturn(crypto);
    when(() => crypto.keyManager).thenReturn(keys);
    when(() => client.getRoomById(group)).thenReturn(source);
    when(() => client.getRoomById(direct)).thenReturn(target);
    for (final entry in [(source, group), (target, direct)]) {
      when(() => entry.$1.id).thenReturn(entry.$2);
      when(() => entry.$1.client).thenReturn(client);
      when(() => entry.$1.encrypted).thenReturn(true);
      when(() => entry.$1.isDirectChat).thenReturn(entry.$2 == direct);
      when(
        () => client.getJoinedMembersByRoom(entry.$2),
      ).thenAnswer((_) async => {user: m.RoomMember(), peer: m.RoomMember()});
    }
    when(() => client.getRoomState(direct)).thenAnswer((_) async => []);
    when(
      () => client.getRoomStateWithKey(group, m.EventTypes.RoomPowerLevels, ''),
    ).thenAnswer(
      (_) async => {
        'users': {user: admin},
      },
    );
    when(
      () => client.getRoomStateWithKey(
        group,
        MatrixHistorySharing.policyType,
        '',
      ),
    ).thenAnswer((_) async => policy);
    when(
      () =>
          client.getRoomStateWithKey(group, m.EventTypes.HistoryVisibility, ''),
    ).thenAnswer((_) async => {'history_visibility': 'joined'});
    final selected = event('selected');
    when(() => client.getOneRoomEvent(group, 'selected'))
        .thenAnswer((_) async => selected);
    when(() => storage.readStrict(any()))
        .thenAnswer((call) async => journal[call.positionalArguments[0]]);
    when(() => storage.write(any(), any())).thenAnswer((call) async {
      journal[call.positionalArguments[0] as String] =
          call.positionalArguments[1] as String;
    });
    when(() => keys.clearOrUseOutboundGroupSession(direct, wipe: true))
        .thenAnswer((_) async => true);
    when(() => crypto.encryptGroupMessagePayload(any(), any()))
        .thenAnswer((call) async {
          plaintexts.add(
            Map<String, dynamic>.from(call.positionalArguments[1] as Map),
          );
          return {
            'algorithm': m.AlgorithmTypes.megolmV1AesSha2,
            'ciphertext': 'test-ciphertext',
          };
        });
    when(() => client.sendMessage(any(), any(), any(), any()))
        .thenAnswer((call) async => 'event-${call.positionalArguments[2]}');
    repository = MatrixHistorySharing(
      manager,
      lifecycle,
      storage,
      prepareEncryption: (_) async {},
    );
  });
  Future<HistoryShareDraft> preview() => repository.previewHistory(
    roomId: group,
    targetRoomId: direct,
    recipient: peer,
    eventIds: ['selected'],
  );

  test('preview does not send; confirmation sends ciphertext and two content-free audits', () async {
    final draft = await preview();
    verifyNever(() => client.sendMessage(any(), any(), any(), any()));
    expect(await repository.shareHistory(draft), HistoryShareStatus.completed);
    expect(plaintexts, hasLength(3));
    expect(plaintexts[0]['body'], isNot(contains('Selected text')));
    expect(plaintexts[1]['body'], contains('Selected text'));
    expect(plaintexts[2]['body'], isNot(contains('Selected text')));
    final calls = verify(
      () => client.sendMessage(
        any(),
        m.EventTypes.Encrypted,
        any(),
        captureAny(),
      ),
    ).captured;
    expect(calls, hasLength(3));
    expect(calls.every((c) => (c as Map)['body'] == null), isTrue);
    verify(() => keys.clearOrUseOutboundGroupSession(direct, wipe: true))
        .called(1);
    expect(await repository.shareHistory(draft), HistoryShareStatus.completed);
    verifyNever(() => client.sendMessage(any(), any(), any(), any()));
  });
  test(
    'policy change, revoked admin and expired account invalidate a preview',
    () async {
      final draft = await preview();
      policy['revision'] = 'v2';
      await expectLater(repository.shareHistory(draft), throwsStateError);
      policy['revision'] = 'v1';
      admin = 0;
      await expectLater(repository.shareHistory(draft), throwsStateError);
      admin = 100;
      active = false;
      await expectLater(repository.shareHistory(draft), throwsStateError);
      verifyNever(() => client.sendMessage(any(), any(), any(), any()));
    },
  );
  test(
    'invited outsiders and non-text events cannot receive shared history',
    () async {
      when(() => client.getRoomState(direct)).thenAnswer(
        (_) async => [
          m.MatrixEvent(
            eventId: 'invite',
            senderId: user,
            originServerTs: DateTime.now(),
            type: m.EventTypes.RoomMember,
            stateKey: '@outsider:hs',
            content: {'membership': 'invite'},
          ),
        ],
      );
      await expectLater(preview(), throwsStateError);
      when(() => client.getRoomState(direct)).thenAnswer((_) async => []);
      for (final content in [
        {
          'msgtype': 'm.text',
          'body': 'secret',
          'n42.self_destruct': {'after': 1},
        },
        {'msgtype': 'n42.transfer', 'body': 'money'},
        {
          'msgtype': 'm.text',
          'body': 'quote',
          'm.relates_to': <String, dynamic>{},
        },
      ]) {
        when(() => client.getOneRoomEvent(group, 'selected'))
            .thenAnswer((_) async => event('selected', content: content));
        await expectLater(preview(), throwsStateError);
      }
    },
  );
  test('unknown content send survives recreation and is reconciled without re-sending', () async {
    var sends = 0;
    when(() => client.sendMessage(any(), any(), any(), any()))
        .thenAnswer((call) async {
          sends++;
          if ((call.positionalArguments[2] as String).endsWith('.content')) {
            throw StateError('timeout after send');
          }
          return 'sent';
        });
    final draft = await preview();
    await expectLater(repository.shareHistory(draft), throwsStateError);
    expect(sends, 2);
    repository = MatrixHistorySharing(
      manager,
      lifecycle,
      storage,
      prepareEncryption: (_) async {},
    );
    final restored = await preview();
    expect(restored.id, draft.id);
    expect(
      await repository.shareHistory(restored),
      HistoryShareStatus.contentPending,
    );
    expect(sends, 2);
    when(
      () => client.getRoomEvents(direct, m.Direction.b, from: null, limit: 100),
    ).thenAnswer(
      (_) async => m.GetRoomEventsResponse(
        start: 'start',
        chunk: [
          event(
            'sent-content',
            sender: user,
            unsigned: {'transaction_id': '${draft.id}.content'},
          ),
        ],
      ),
    );
    expect(
      await repository.reconcileHistory(restored),
      HistoryShareStatus.contentSent,
    );
    expect(
      await repository.shareHistory(restored),
      HistoryShareStatus.completed,
    );
    expect(sends, 3);
  });
  test(
    'storage failure and plaintext encryption fallback stop network writes',
    () async {
      final draft = await preview();
      when(() => storage.readStrict(any()))
          .thenThrow(StateError('storage unavailable'));
      await expectLater(repository.shareHistory(draft), throwsStateError);
      verifyNever(() => client.sendMessage(any(), any(), any(), any()));
      when(() => storage.readStrict(any())).thenAnswer((_) async => null);
      when(() => crypto.encryptGroupMessagePayload(any(), any()))
          .thenAnswer((_) async => {'body': 'plaintext'});
      await expectLater(repository.shareHistory(draft), throwsStateError);
      verifyNever(() => client.sendMessage(any(), any(), any(), any()));
    },
  );
  test(
    'read index crosses empty pages and finds older original events by ID',
    () async {
      when(() => source.fullyRead).thenReturn('read');
      when(() => source.lastEvent).thenReturn(null);
      final own = m.Event.fromMatrixEvent(event('own', sender: user), source);
      when(() => source.getEventById('own')).thenAnswer((_) async => own);
      when(
        () =>
            client.getRoomEvents(group, m.Direction.b, from: null, limit: 100),
      ).thenAnswer(
        (_) async =>
            m.GetRoomEventsResponse(start: 'start', end: 'next', chunk: []),
      );
      when(
        () => client.getRoomEvents(
          group,
          m.Direction.b,
          from: 'next',
          limit: 100,
        ),
      ).thenAnswer(
        (_) async => m.GetRoomEventsResponse(
          start: 'next',
          chunk: [
            event(
              'reply',
              content: {
                'msgtype': 'm.text',
                'body': 'reply',
                'm.relates_to': {
                  'm.in_reply_to': {'event_id': 'own'},
                },
              },
            ),
            event(
              'mention',
              content: {
                'msgtype': 'm.text',
                'body': 'mention',
                'm.mentions': {'room': true},
              },
            ),
            event('read'),
            event('already-read'),
          ],
        ),
      );
      final result = await MatrixUnreadAttention.scan(source, () => active);
      expect(result.complete, isTrue);
      expect(result.replies.single.id, 'reply');
      expect(result.mentions.single.id, 'mention');
    },
  );
  test(
    'missing read marker and changed account are never reported as complete',
    () async {
      when(() => source.fullyRead).thenReturn('missing');
      when(() => source.lastEvent).thenReturn(null);
      when(
        () =>
            client.getRoomEvents(group, m.Direction.b, from: null, limit: 100),
      ).thenAnswer(
        (_) async => m.GetRoomEventsResponse(start: 'start', chunk: []),
      );
      expect(
        (await MatrixUnreadAttention.scan(source, () => active)).complete,
        isFalse,
      );
      when(
        () =>
            client.getRoomEvents(group, m.Direction.b, from: null, limit: 100),
      ).thenAnswer((_) async {
        active = false;
        return m.GetRoomEventsResponse(
          start: 'start',
          chunk: [event('missing')],
        );
      });
      expect(
        (await MatrixUnreadAttention.scan(source, () => active)).complete,
        isFalse,
      );
    },
  );
  test('recovery list remains available after restart without re-reading message bodies', () async {
    when(() => client.sendMessage(any(), any(), any(), any()))
        .thenThrow(StateError('unknown'));
    final draft = await preview();
    await expectLater(repository.shareHistory(draft), throwsStateError);
    repository = MatrixHistorySharing(
      manager,
      lifecycle,
      storage,
      prepareEncryption: (_) async {},
    );
    when(() => client.getOneRoomEvent(group, 'selected'))
        .thenThrow(StateError('redacted or unavailable'));
    final pending = await repository.pendingHistory(group);
    expect(pending.single.id, draft.id);
    when(
      () => client.getRoomEvents(group, m.Direction.b, from: null, limit: 100),
    ).thenAnswer(
      (_) async => m.GetRoomEventsResponse(
        start: 'start',
        chunk: [
          event(
            'audit',
            sender: user,
            unsigned: {'transaction_id': '${draft.id}.audit'},
          ),
        ],
      ),
    );
    expect(
      await repository.reconcileBatch(pending.single),
      HistoryShareStatus.auditSent,
    );
  });

  test(
    'read index covers 10000 events without using timestamps for ordering',
    () async {
      when(() => source.fullyRead).thenReturn('read');
      when(() => source.lastEvent).thenReturn(null);
      var pages = 0;
      when(
        () => client.getRoomEvents(
          group,
          m.Direction.b,
          from: any(named: 'from'),
          limit: 100,
        ),
      ).thenAnswer((call) async {
        final cursor = call.namedArguments[#from] as String?;
        final number = cursor == null ? 0 : int.parse(cursor);
        pages++;
        return m.GetRoomEventsResponse(
          start: '$number',
          end: number < 100 ? '${number + 1}' : null,
          chunk: number == 100
              ? [event('read')]
              : List.generate(
                  100,
                  (i) => event(
                    '$number-$i',
                    content: {
                      'msgtype': 'm.text',
                      'body': 'fixture',
                      'm.mentions': {
                        'user_ids': [user],
                      },
                    },
                  ),
                ),
        );
      });
      final result = await MatrixUnreadAttention.scan(source, () => true);
      expect(result.complete, isTrue);
      expect(result.mentions, hasLength(10000));
      expect(pages, 101);
    },
  );

  test('permission revoked while encrypting prevents publication', () async {
    final draft = await preview();
    when(() => crypto.encryptGroupMessagePayload(any(), any()))
        .thenAnswer((_) async {
          admin = 0;
          return {
            'algorithm': m.AlgorithmTypes.megolmV1AesSha2,
            'ciphertext': 'encrypted',
          };
        });
    await expectLater(repository.shareHistory(draft), throwsStateError);
    verifyNever(() => client.sendMessage(any(), any(), any(), any()));
  });
  test('preparation failure leaves the batch retryable without an unknown-send state', () async {
    var fail = true;
    repository = MatrixHistorySharing(
      manager,
      lifecycle,
      storage,
      prepareEncryption: (_) async {
        if (fail) throw StateError('Keys unavailable');
      },
    );
    final draft = await preview();
    await expectLater(repository.shareHistory(draft), throwsStateError);
    expect(await repository.pendingHistory(group), isEmpty);
    fail = false;
    expect(await repository.shareHistory(draft), HistoryShareStatus.completed);
  });
}
