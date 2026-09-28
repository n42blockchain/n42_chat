import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_moment_datasource.dart';
import 'package:n42_chat/src/domain/entities/moment_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/content_report_repository.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

class _Lifecycle extends Mock implements IAccountBoundDeletionLifecycle {}

void main() {
  const roomA = '!a:hs.test';
  const roomB = '!b:hs.test';
  const postEventA = r'$post-a';
  const postEventB = r'$post-b';
  const commentEvent = r'$comment-a';
  const author = '@author:hs.test';
  const commenter = '@commenter:hs.test';
  late _Manager manager;
  late _Client client;
  late _Lifecycle lifecycle;
  late _Room a;
  late _Room b;
  late MatrixMomentDataSource source;
  late AuthSessionInvalidation generation;
  late bool active;

  MomentEntity post(String roomId, String eventId) => MomentEntity(
    id: 'same-content-id',
    userId: author,
    userName: 'Author',
    timestamp: DateTime.utc(2026),
    sourceRoomId: roomId,
    sourceEventId: eventId,
  );

  MomentComment comment() => MomentComment(
    id: 'comment-content-id',
    userId: commenter,
    userName: 'Commenter',
    content: 'Text',
    timestamp: DateTime.utc(2026),
    sourceRoomId: roomA,
    sourceEventId: commentEvent,
  );

  matrix.Event event(
    _Room room,
    String id,
    String type,
    String sender,
    Map<String, dynamic> content,
  ) => matrix.Event(
    room: room,
    eventId: id,
    type: type,
    senderId: sender,
    content: content,
    originServerTs: DateTime.utc(2026),
  );

  setUp(() {
    manager = _Manager();
    client = _Client();
    lifecycle = _Lifecycle();
    a = _Room();
    b = _Room();
    active = true;
    generation = AuthSessionInvalidation(
      userId: '@me:hs.test',
      homeserver: Uri.parse('https://hs.test'),
      deviceId: null,
      isCurrent: () => active,
      matchesClient: (candidate) => identical(candidate, client),
    );
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('token-A');
    when(() => client.deviceID).thenReturn(null);
    when(client.isLogged).thenReturn(true);
    when(() => lifecycle.currentAccountGeneration).thenReturn(generation);
    when(() => a.id).thenReturn(roomA);
    when(() => b.id).thenReturn(roomB);
    when(() => a.membership).thenReturn(matrix.Membership.join);
    when(() => b.membership).thenReturn(matrix.Membership.join);
    when(() => client.getRoomById(roomA)).thenReturn(a);
    when(() => client.getRoomById(roomB)).thenReturn(b);
    source = MatrixMomentDataSource(manager, accountLifecycle: lifecycle);
    when(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    ).thenAnswer((_) async {});
  });

  test('same content ID in two rooms reports the exact post events', () async {
    final first = post(roomA, postEventA);
    final second = post(roomB, postEventB);
    when(() => a.getEventById(postEventA)).thenAnswer(
      (_) async =>
          event(a, postEventA, 'n42.moment', author, {'moment_id': first.id}),
    );
    when(() => b.getEventById(postEventB)).thenAnswer(
      (_) async =>
          event(b, postEventB, 'n42.moment', author, {'moment_id': second.id}),
    );
    await source.reportMoment(first, 'Spam');
    await source.reportMoment(second, 'Spam');
    verify(
      () => client.reportEvent(roomA, postEventA, reason: 'Spam'),
    ).called(1);
    verify(
      () => client.reportEvent(roomB, postEventB, reason: 'Spam'),
    ).called(1);
  });

  test(
    'comment report targets its own event and validates parent ID',
    () async {
      final parent = post(roomA, postEventA);
      final reply = comment();
      when(() => a.getEventById(commentEvent)).thenAnswer(
        (_) async => event(a, commentEvent, 'n42.moment.comment', commenter, {
          'moment_id': parent.id,
          'moment_event_id': parent.sourceEventId,
          'comment_id': reply.id,
        }),
      );
      await source.reportComment(parent, reply, 'Abuse');
      verify(
        () => client.reportEvent(roomA, commentEvent, reason: 'Abuse'),
      ).called(1);
      verifyNever(() => client.reportEvent(roomA, postEventA, reason: 'Abuse'));
    },
  );

  test('comment with a different parent event does not report', () async {
    final parent = post(roomA, postEventA);
    final reply = comment();
    when(() => a.getEventById(commentEvent)).thenAnswer(
      (_) async => event(a, commentEvent, 'n42.moment.comment', commenter, {
        'moment_id': parent.id,
        'moment_event_id': r'$other-parent',
        'comment_id': reply.id,
      }),
    );
    await expectLater(
      source.reportComment(parent, reply, 'Abuse'),
      throwsA(isA<ContentReportException>()),
    );
    verifyNever(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    );
  });

  test('missing generation cannot authorize report', () async {
    source = MatrixMomentDataSource(manager);
    await expectLater(
      source.reportMoment(post(roomA, postEventA), 'Spam'),
      throwsA(isA<ContentReportException>()),
    );
    verifyNever(() => a.getEventById(any()));
  });

  test('left room cannot send an event report', () async {
    when(() => a.membership).thenReturn(matrix.Membership.leave);
    await expectLater(
      source.reportMoment(post(roomA, postEventA), 'Spam'),
      throwsA(isA<ContentReportException>()),
    );
    verifyNever(() => a.getEventById(any()));
    verifyNever(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    );
  });

  test('null canonical and old-history miss fail closed', () async {
    final legacy = MomentEntity(
      id: 'same-content-id',
      userId: author,
      userName: 'Author',
      timestamp: DateTime.utc(2026),
    );
    await expectLater(
      source.reportMoment(legacy, 'Spam'),
      throwsA(isA<ContentReportException>()),
    );
    when(() => a.getEventById(postEventA)).thenAnswer((_) async => null);
    await expectLater(
      source.reportMoment(post(roomA, postEventA), 'Spam'),
      throwsA(isA<ContentReportException>()),
    );
    verifyNever(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    );
  });

  for (final invalid in ['type', 'sender', 'content', 'room', 'event']) {
    test('rejects post with wrong $invalid', () async {
      final wrongRoom = _Room();
      when(() => wrongRoom.id).thenReturn(roomB);
      final resolved = event(
        invalid == 'room' ? wrongRoom : a,
        invalid == 'event' ? r'$wrong' : postEventA,
        invalid == 'type' ? 'n42.moment.comment' : 'n42.moment',
        invalid == 'sender' ? commenter : author,
        {'moment_id': invalid == 'content' ? 'other' : 'same-content-id'},
      );
      when(() => a.getEventById(postEventA)).thenAnswer((_) async => resolved);
      await expectLater(
        source.reportMoment(post(roomA, postEventA), 'Spam'),
        throwsA(isA<ContentReportException>()),
      );
      verifyNever(
        () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
      );
    });
  }

  test('A to B during lookup cannot submit through either client', () async {
    final pending = Completer<matrix.Event?>();
    when(() => a.getEventById(postEventA)).thenAnswer((_) => pending.future);
    final report = source.reportMoment(post(roomA, postEventA), 'Spam');
    final other = _Client();
    when(() => manager.client).thenReturn(other);
    active = false;
    final check = expectLater(report, throwsA(isA<ContentReportException>()));
    pending.complete(
      event(a, postEventA, 'n42.moment', author, {
        'moment_id': 'same-content-id',
      }),
    );
    await check;
    verifyNever(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    );
  });

  test('replacement A generation during lookup cannot submit', () async {
    final pending = Completer<matrix.Event?>();
    when(() => a.getEventById(postEventA)).thenAnswer((_) => pending.future);
    final report = source.reportMoment(post(roomA, postEventA), 'Spam');
    when(() => lifecycle.currentAccountGeneration).thenReturn(
      AuthSessionInvalidation(
        userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'),
        deviceId: null,
        isCurrent: () => true,
        matchesClient: (candidate) => identical(candidate, client),
      ),
    );
    final check = expectLater(report, throwsA(isA<ContentReportException>()));
    pending.complete(
      event(a, postEventA, 'n42.moment', author, {
        'moment_id': 'same-content-id',
      }),
    );
    await check;
    verifyNever(
      () => client.reportEvent(any(), any(), reason: any(named: 'reason')),
    );
  });

  test('late A report acknowledgement is never accepted as B', () async {
    when(() => a.getEventById(postEventA)).thenAnswer(
      (_) async => event(a, postEventA, 'n42.moment', author, {
        'moment_id': 'same-content-id',
      }),
    );
    final pending = Completer<void>();
    when(
      () => client.reportEvent(roomA, postEventA, reason: 'Spam'),
    ).thenAnswer((_) => pending.future);
    final report = source.reportMoment(post(roomA, postEventA), 'Spam');
    await Future<void>.delayed(Duration.zero);
    verify(
      () => client.reportEvent(roomA, postEventA, reason: 'Spam'),
    ).called(1);
    when(() => manager.client).thenReturn(_Client());
    active = false;
    final check = expectLater(
      report,
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.accountChanged,
        ),
      ),
    );
    pending.complete();
    await check;
  });

  test('late failure after replacement A generation remains stale', () async {
    when(() => a.getEventById(postEventA)).thenAnswer(
      (_) async => event(a, postEventA, 'n42.moment', author, {
        'moment_id': 'same-content-id',
      }),
    );
    final pending = Completer<void>();
    when(
      () => client.reportEvent(roomA, postEventA, reason: 'Spam'),
    ).thenAnswer((_) async {
      await pending.future;
      throw StateError('Network failed');
    });
    final report = source.reportMoment(post(roomA, postEventA), 'Spam');
    await Future<void>.delayed(Duration.zero);
    when(() => lifecycle.currentAccountGeneration).thenReturn(
      AuthSessionInvalidation(
        userId: '@me:hs.test',
        homeserver: Uri.parse('https://hs.test'),
        deviceId: null,
        isCurrent: () => true,
        matchesClient: (candidate) => identical(candidate, client),
      ),
    );
    final check = expectLater(
      report,
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.accountChanged,
        ),
      ),
    );
    pending.complete();
    await check;
  });

  for (final (errcode, expected) in [
    ('M_UNRECOGNIZED', ContentReportFailure.unsupported),
    ('M_NOT_FOUND', ContentReportFailure.subjectNotFound),
    ('M_FORBIDDEN', ContentReportFailure.forbidden),
  ]) {
    test('same-account Matrix $errcode stays classified', () async {
      when(() => a.getEventById(postEventA)).thenAnswer(
        (_) async => event(a, postEventA, 'n42.moment', author, {
          'moment_id': 'same-content-id',
        }),
      );
      when(
        () => client.reportEvent(roomA, postEventA, reason: 'Spam'),
      ).thenThrow(matrix.MatrixException.fromJson({'errcode': errcode}));
      await expectLater(
        source.reportMoment(post(roomA, postEventA), 'Spam'),
        throwsA(
          isA<ContentReportException>().having(
            (error) => error.kind,
            'kind',
            expected,
          ),
        ),
      );
    });
  }

  test('same-account lookup timeout is transport failure', () async {
    when(
      () => a.getEventById(postEventA),
    ).thenThrow(TimeoutException('offline'));
    await expectLater(
      source.reportMoment(post(roomA, postEventA), 'Spam'),
      throwsA(
        isA<ContentReportException>().having(
          (error) => error.kind,
          'kind',
          ContentReportFailure.transport,
        ),
      ),
    );
  });
}
