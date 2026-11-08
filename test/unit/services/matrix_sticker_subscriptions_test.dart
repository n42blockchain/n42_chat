import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as m;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/services/matrix_sticker_subscriptions.dart';
import 'package:n42_chat/src/domain/entities/sticker_pack_subscription.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

class _Client extends Mock implements m.Client {}

class _Manager extends Mock implements MatrixClientManager {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

void main() {
  late _Client client;
  late _Manager manager;
  late _Lifecycle lifecycle;
  late MatrixStickerSubscriptions service;
  late bool active;
  late Map<String, dynamic> stored;
  const reference = StickerPackSubscription(
    roomId: '!room:test',
    stateKey: 'art',
  );
  const other = StickerPackSubscription(
    roomId: '!room:test',
    stateKey: 'other',
  );
  final content = <String, dynamic>{
    'images': {
      'smile': {'url': 'mxc://test/image'},
    },
  };
  Map<String, dynamic> clone(Map<String, dynamic> input) =>
      jsonDecode(jsonEncode(input)) as Map<String, dynamic>;
  setUp(() {
    client = _Client();
    manager = _Manager();
    lifecycle = _Lifecycle();
    active = true;
    stored = {};
    service = MatrixStickerSubscriptions(manager, lifecycle);
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@owner:test');
    when(() => client.deviceID).thenReturn('D');
    when(() => client.homeserver).thenReturn(Uri.parse('https://test'));
    when(() => client.accessToken).thenReturn('synthetic');
    final generation = AuthSessionInvalidation(
      userId: '@owner:test',
      homeserver: Uri.parse('https://test'),
      deviceId: 'D',
      isCurrent: () => active,
      matchesClient: (c) => identical(c, client),
    );
    when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) async => clone(stored));
    when(() => client.setAccountData(any(), any(), any()))
        .thenAnswer((call) async {
          stored = clone(call.positionalArguments[2] as Map<String, dynamic>);
        });
    when(() => client.getRoomStateWithKey(any(), any(), any()))
        .thenAnswer((_) async => content);
  });
  test('enable preserves other rooms, keys and unknown fields without joining or copying', () async {
    stored = {
      'extension': {'keep': true},
      'rooms': {
        '!old:test': {'': <String, dynamic>{}},
        '!room:test': {
          'other': {'future': true},
        },
      },
    };
    final original = clone(stored);
    await service.setEnabled(reference, enabled: true);
    expect(stored, {
      'extension': {'keep': true},
      'rooms': {
        '!old:test': {'': <String, dynamic>{}},
        '!room:test': {
          'other': {'future': true},
          'art': <String, dynamic>{},
        },
      },
    });
    expect(original['rooms'], {
      '!old:test': {'': <String, dynamic>{}},
      '!room:test': {
        'other': {'future': true},
      },
    });
    verify(
      () => client.setAccountData('@owner:test', 'm.image_pack.rooms', any()),
    ).called(1);
    verifyNever(() => client.joinRoom(any()));
    expect(
      await service.getEnabled(),
      containsAll([
        reference,
        other,
        const StickerPackSubscription(roomId: '!old:test'),
      ]),
    );
  });
  test('disable removes just its key without requiring room access', () async {
    stored = {
      'rooms': {
        '!room:test': {
          'art': <String, dynamic>{},
          'other': <String, dynamic>{},
        },
        '!old:test': {'': <String, dynamic>{}},
      },
    };
    await service.setEnabled(reference, enabled: false);
    expect(stored, {
      'rooms': {
        '!room:test': {'other': <String, dynamic>{}},
        '!old:test': {'': <String, dynamic>{}},
      },
    });
    verifyNever(() => client.getRoomStateWithKey(any(), any(), any()));
  });
  test(
    'removing last key removes its now-empty room and preserves extensions',
    () async {
      stored = {
        'extension': 7,
        'rooms': {
          '!room:test': {'art': <String, dynamic>{}},
        },
      };
      await service.setEnabled(reference, enabled: false);
      expect(stored, {'extension': 7, 'rooms': <String, dynamic>{}});
    },
  );
  test(
    'repeated enable and absent disable are idempotent read-only operations',
    () async {
      stored = {
        'rooms': {
          '!room:test': {'art': <String, dynamic>{}},
        },
      };
      await service.setEnabled(reference, enabled: true);
      await service.setEnabled(other, enabled: false);
      verifyNever(() => client.setAccountData(any(), any(), any()));
      verifyNever(() => client.getRoomStateWithKey(any(), any(), any()));
    },
  );
  test('empty state key and v12 room ID remain supported', () async {
    const empty = StickerPackSubscription(roomId: '!opaque');
    await service.setEnabled(empty, enabled: true);
    expect(stored, {
      'rooms': {
        '!opaque': {'': <String, dynamic>{}},
      },
    });
    expect(await service.getEnabled(), [empty]);
  });
  test('same-instance concurrent writes retain both references', () async {
    await Future.wait([
      service.setEnabled(reference, enabled: true),
      service.setEnabled(other, enabled: true),
    ]);
    expect(stored, {
      'rooms': {
        '!room:test': {
          'art': <String, dynamic>{},
          'other': <String, dynamic>{},
        },
      },
    });
  });
  test(
    'queued work retains its original account and rejects replacement',
    () async {
      final gate = Completer<Map<String, dynamic>>();
      when(() => client.getRoomStateWithKey(any(), any(), any()))
          .thenAnswer((_) => gate.future);
      final first = expectLater(
        service.setEnabled(reference, enabled: true),
        throwsStateError,
      );
      final second = expectLater(
        service.setEnabled(other, enabled: true),
        throwsStateError,
      );
      await Future<void>.delayed(Duration.zero);
      active = false;
      when(() => client.accessToken).thenReturn('replacement');
      gate.complete(content);
      await Future.wait([first, second]);
      verify(() => client.getAccountData(any(), any())).called(1);
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test(
    'failed operation releases queue for the next explicit request',
    () async {
      var calls = 0;
      when(() => client.getAccountData(any(), any())).thenAnswer((_) async {
        if (calls++ == 0) throw StateError('read failed');
        return clone(stored);
      });
      final first = expectLater(
        service.setEnabled(reference, enabled: true),
        throwsStateError,
      );
      final second = service.setEnabled(other, enabled: true);
      await first;
      await second;
      expect(await service.getEnabled(), [other]);
    },
  );
  test(
    'only not-found account data is treated as an empty subscription set',
    () async {
      when(() => client.getAccountData(any(), any()))
          .thenThrow(m.MatrixException.fromJson({'errcode': 'M_NOT_FOUND'}));
      expect(await service.getEnabled(), isEmpty);
      await service.setEnabled(reference, enabled: true);
      expect(stored, {
        'rooms': {
          '!room:test': {'art': <String, dynamic>{}},
        },
      });
    },
  );
  test(
    'authorization errors never reset the account subscription data',
    () async {
      when(() => client.getAccountData(any(), any()))
          .thenThrow(m.MatrixException.fromJson({'errcode': 'M_FORBIDDEN'}));
      await expectLater(
        service.setEnabled(reference, enabled: true),
        throwsA(isA<m.MatrixException>()),
      );
      verifyNever(() => client.setAccountData(any(), any(), any()));
    },
  );
  test(
    'unreadable source rejects enable without automatic membership',
    () async {
      when(() => client.getRoomStateWithKey(any(), any(), any()))
          .thenThrow(m.MatrixException.fromJson({'errcode': 'M_FORBIDDEN'}));
      await expectLater(
        service.setEnabled(reference, enabled: true),
        throwsA(isA<m.MatrixException>()),
      );
      verifyNever(() => client.setAccountData(any(), any(), any()));
      verifyNever(() => client.joinRoom(any()));
    },
  );
  for (final bad in [
    <String, dynamic>{'rooms': <Object>[]},
    <String, dynamic>{
      'rooms': {'!room:test': 'bad'},
    },
  ]) {
    test(
      'malformed owned containers reject mutation without overwriting data $bad',
      () async {
        stored = clone(bad);
        await expectLater(
          service.setEnabled(reference, enabled: true),
          throwsFormatException,
        );
        expect(stored, bad);
        verifyNever(() => client.setAccountData(any(), any(), any()));
      },
    );
  }
  test('malformed entries can be removed while sibling data remains', () async {
    stored = {
      'rooms': {
        '!room:test': {'art': null, 'other': <String, dynamic>{}},
        '!unknown:test': 'preserve',
      },
    };
    expect(await service.getEnabled(), [other]);
    await service.setEnabled(reference, enabled: false);
    expect(stored, {
      'rooms': {
        '!room:test': {'other': <String, dynamic>{}},
        '!unknown:test': 'preserve',
      },
    });
  });
  test('invalid reference rejects before any server request', () async {
    await expectLater(
      service.setEnabled(
        const StickerPackSubscription(roomId: 'https://evil'),
        enabled: true,
      ),
      throwsFormatException,
    );
    verifyNever(() => client.getAccountData(any(), any()));
  });
  test('late read cannot emit a previous account reference list', () async {
    final gate = Completer<Map<String, dynamic>>();
    when(() => client.getAccountData(any(), any()))
        .thenAnswer((_) => gate.future);
    final pending = service.getEnabled();
    active = false;
    gate.complete({
      'rooms': {
        '!room:test': {'art': <String, dynamic>{}},
      },
    });
    await expectLater(pending, throwsStateError);
  });
  test(
    'late successful write rejects stale completion and is not retried',
    () async {
      final gate = Completer<void>();
      when(() => client.setAccountData(any(), any(), any()))
          .thenAnswer((_) => gate.future);
      final pending = service.setEnabled(reference, enabled: true);
      await Future<void>.delayed(Duration.zero);
      active = false;
      gate.complete();
      await expectLater(pending, throwsStateError);
      verify(
        () => client.setAccountData('@owner:test', 'm.image_pack.rooms', any()),
      ).called(1);
    },
  );
  test('unknown write outcome propagates without retry', () async {
    when(() => client.setAccountData(any(), any(), any()))
        .thenThrow(StateError('lost acknowledgement'));
    await expectLater(
      service.setEnabled(reference, enabled: true),
      throwsStateError,
    );
    verify(() => client.setAccountData(any(), any(), any())).called(1);
  });
  test('oversized room packs are rejected before private write', () async {
    when(() => client.getRoomStateWithKey(any(), any(), any())).thenAnswer(
      (_) async => {
        'images': {
          for (var i = 0; i < 501; i++) '$i': {'url': 'mxc://test/image'},
        },
      },
    );
    await expectLater(
      service.setEnabled(reference, enabled: true),
      throwsFormatException,
    );
    verifyNever(() => client.setAccountData(any(), any(), any()));
  });
  test(
    'large reference sets reject reads/additions but can be reduced',
    () async {
      stored = {
        'rooms': {
          '!room:test': {
            for (var i = 0; i < 513; i++) '$i': <String, dynamic>{},
          },
        },
      };
      await expectLater(service.getEnabled(), throwsFormatException);
      await expectLater(
        service.setEnabled(reference, enabled: true),
        throwsFormatException,
      );
      await service.setEnabled(
        const StickerPackSubscription(roomId: '!room:test', stateKey: '0'),
        enabled: false,
      );
      expect(await service.getEnabled(), hasLength(512));
    },
  );
  test(
    'new account writes do not wait behind old account network requests',
    () async {
      final gate = Completer<Map<String, dynamic>>();
      when(
        () => client.getRoomStateWithKey(
          reference.roomId,
          'm.room.image_pack',
          reference.stateKey,
        ),
      ).thenAnswer((_) => gate.future);
      final old = expectLater(
        service.setEnabled(reference, enabled: true),
        throwsStateError,
      );
      await Future<void>.delayed(Duration.zero);
      active = false;
      when(() => client.userID).thenReturn('@replacement:test');
      when(() => client.accessToken).thenReturn('replacement');
      final replacement = AuthSessionInvalidation(
        userId: '@replacement:test',
        homeserver: Uri.parse('https://test'),
        deviceId: 'D',
        isCurrent: () => true,
        matchesClient: (c) => identical(c, client),
      );
      when(() => lifecycle.currentAccountGeneration).thenReturn(replacement);
      var completed = false;
      final next = service
          .setEnabled(other, enabled: true)
          .then((_) => completed = true);
      await Future<void>.delayed(Duration.zero);
      try {
        expect(
          completed,
          isTrue,
          reason: 'A new account has its own write queue',
        );
      } finally {
        gate.complete(content);
        await old;
        await next;
      }
      verify(
        () => client.setAccountData(
          '@replacement:test',
          'm.image_pack.rooms',
          any(),
        ),
      ).called(1);
      verifyNever(
        () => client.setAccountData('@owner:test', 'm.image_pack.rooms', any()),
      );
    },
  );
}
