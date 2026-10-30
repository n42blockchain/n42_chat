import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/chat_catch_up_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';
import '../datasources/matrix/message/encrypted_send_guard.dart';
import 'matrix_unread_attention.dart';

/// Recipient-specific sharing. Journal transitions precede every network write.
/// Unknown sends are reconciled by transaction ID, never automatically retried.
class MatrixHistorySharing implements IChatCatchUpRepository {
  static const policyType = 'n42.history_sharing';
  final MatrixClientManager manager;
  final IAccountBoundDeletionLifecycle lifecycle;
  final SecureStorageDataSource storage;
  final Future<void> Function(matrix.Room) prepareEncryption;
  StreamSubscription<AuthSessionInvalidation>? _invalidations;
  bool _disposed = false;
  final _busy = <String>{};
  Future<void> _metadataTail = Future<void>.value();
  final _previews = <String, (HistoryShareDraft, AuthSessionInvalidation)>{};
  MatrixHistorySharing(
    this.manager,
    this.lifecycle,
    this.storage, {
    Future<void> Function(matrix.Room)? prepareEncryption,
  }) : prepareEncryption = prepareEncryption ?? EncryptedSendGuard.prepare {
    if (lifecycle is IAccountBoundAuthInvalidation) {
      _invalidations = (lifecycle as IAccountBoundAuthInvalidation)
          .accountInvalidationStream
          .listen((_) => _previews.clear());
    }
  }
  Future<void> dispose() async {
    _disposed = true;
    _previews.clear();
    await _invalidations?.cancel();
  }

  (matrix.Client, AuthSessionInvalidation, bool Function()) _session() {
    final client = manager.client;
    final generation = lifecycle.currentAccountGeneration;
    if (client == null || generation == null) {
      throw StateError('No active account');
    }
    final token = client.accessToken;
    bool current() =>
        !_disposed &&
        token != null &&
        token.isNotEmpty &&
        generation.userId == client.userID &&
        generation.homeserver == client.homeserver &&
        generation.deviceId == client.deviceID &&
        identical(manager.client, client) &&
        identical(lifecycle.currentAccountGeneration, generation) &&
        generation.isCurrent &&
        generation.matchesClient(client) &&
        client.accessToken == token &&
        client.isLogged();
    if (!current()) throw StateError('Account changed');
    return (client, generation, current);
  }

  void _check(bool Function() current) {
    if (!current()) throw StateError('Account changed');
  }

  @override
  Future<UnreadAttention> unreadAttention(
    String roomId, {
    bool Function()? isCancelled,
  }) async {
    final (client, _, current) = _session();
    final room = client.getRoomById(roomId);
    if (room == null) return const UnreadAttention();
    return MatrixUnreadAttention.scan(
      room,
      () => current() && !(isCancelled?.call() ?? false),
    );
  }

  Future<Map<String, dynamic>> _authorize(
    matrix.Client client,
    String roomId,
    bool Function() current,
  ) async {
    final members = await client.getJoinedMembersByRoom(roomId);
    final power = await client.getRoomStateWithKey(
      roomId,
      matrix.EventTypes.RoomPowerLevels,
      '',
    );
    _check(current);
    final users = power['users'];
    final own = users is Map ? users[client.userID] : null;
    final level = own is int
        ? own
        : (power['users_default'] is int ? power['users_default'] as int : 0);
    if (members == null || !members.containsKey(client.userID) || level < 100) {
      throw StateError('Administrator required');
    }
    return Map<String, dynamic>.from(
      members.map((key, value) => MapEntry(key, true)),
    );
  }

  @override
  Future<void> setHistorySharing(
    String roomId, {
    required bool enabled,
    int maxMessages = 20,
    int maxAgeHours = 168,
  }) async {
    if (maxMessages < 1 ||
        maxMessages > 50 ||
        maxAgeHours < 1 ||
        maxAgeHours > 720) {
      throw ArgumentError('Invalid sharing limits');
    }
    final (client, _, current) = _session();
    await _authorize(client, roomId, current);
    final room = client.getRoomById(roomId);
    if (room == null || !room.encrypted) {
      throw StateError('Encrypted group required');
    }
    _check(current);
    if (enabled) {
      await client.setRoomStateWithKey(
        roomId,
        matrix.EventTypes.HistoryVisibility,
        '',
        {'history_visibility': 'joined'},
      );
      _check(current);
    }
    await client.setRoomStateWithKey(roomId, policyType, '', {
      'enabled': enabled,
      'max_messages': maxMessages,
      'max_age_hours': maxAgeHours,
      'revision': client.generateUniqueTransactionId(),
    });
  }

  Future<(String, List<MessageEntity>)> _validate(
    matrix.Client client,
    bool Function() current,
    String roomId,
    String targetRoomId,
    String recipient,
    List<String> ids,
  ) async {
    if (roomId == targetRoomId ||
        recipient == client.userID ||
        ids.isEmpty ||
        ids.length > 50 ||
        ids.toSet().length != ids.length) {
      throw StateError('Invalid sharing selection');
    }
    final source = client.getRoomById(roomId),
        target = client.getRoomById(targetRoomId);
    if (source == null ||
        target == null ||
        !source.encrypted ||
        source.isDirectChat ||
        !target.encrypted ||
        !target.isDirectChat ||
        !client.encryptionEnabled ||
        client.encryption == null) {
      throw StateError('Encrypted group and direct chat required');
    }
    final members = await _authorize(client, roomId, current);
    final recipients = await client.getJoinedMembersByRoom(targetRoomId);
    final targetState = await client.getRoomState(targetRoomId);
    if (targetState.any(
      (e) =>
          e.type == matrix.EventTypes.RoomMember &&
          (e.content['membership'] == 'invite' ||
              (e.content['membership'] == 'join' &&
                  e.stateKey != client.userID &&
                  e.stateKey != recipient)),
    )) {
      throw StateError('Target has additional invited or joined recipients');
    }
    final visibility = await client.getRoomStateWithKey(
      roomId,
      matrix.EventTypes.HistoryVisibility,
      '',
    );
    if (visibility['history_visibility'] != 'joined') {
      throw StateError('Join-scoped history required');
    }
    final policy = await client.getRoomStateWithKey(roomId, policyType, '');
    _check(current);
    if (!members.containsKey(recipient) ||
        recipients == null ||
        recipients.length != 2 ||
        !recipients.containsKey(recipient) ||
        !recipients.containsKey(client.userID)) {
      throw StateError('Recipient membership changed');
    }
    final max = policy['max_messages'], hours = policy['max_age_hours'];
    if (policy['enabled'] != true ||
        max is! int ||
        max < 1 ||
        max > 50 ||
        ids.length > max ||
        hours is! int ||
        hours < 1 ||
        hours > 720 ||
        policy['revision'] is! String) {
      throw StateError(
        'History sharing is disabled or selection exceeds policy',
      );
    }
    final messages = <MessageEntity>[];
    for (final id in ids) {
      final raw = await client.getOneRoomEvent(roomId, id);
      var event = matrix.Event.fromMatrixEvent(raw, source);
      if (event.type == matrix.EventTypes.Encrypted) {
        event = await client.encryption!.decryptRoomEvent(event);
      }
      _check(current);
      final content = event.content;
      if (event.eventId != id ||
          event.redacted ||
          event.type != matrix.EventTypes.Message ||
          content['msgtype'] != 'm.text' ||
          content['body'] is! String ||
          (content['body'] as String).length > 8000 ||
          content.containsKey('n42.self_destruct') ||
          content.containsKey('m.relates_to') ||
          DateTime.now().difference(event.originServerTs) >
              Duration(hours: hours) ||
          event.originServerTs.isAfter(DateTime.now())) {
        throw StateError('Selected message is not shareable');
      }
      messages.add(attentionMessage(event));
    }
    if (utf8.encode(messages.map((m) => m.content).join()).length > 24000) {
      throw StateError('Selection is too large');
    }
    messages.sort((a, b) => a.id.compareTo(b.id));
    final fingerprint = sha256
        .convert(
          utf8.encode(
            jsonEncode([
              policy['revision'],
              max,
              hours,
              messages
                  .map(
                    (m) => [
                      m.id,
                      m.senderId,
                      m.timestamp.millisecondsSinceEpoch,
                      m.content,
                    ],
                  )
                  .toList(),
            ]),
          ),
        )
        .toString();
    return (fingerprint, messages);
  }

  @override
  Future<HistoryShareDraft> previewHistory({
    required String roomId,
    required String targetRoomId,
    required String recipient,
    required List<String> eventIds,
  }) async {
    final (client, generation, current) = _session();
    final (fingerprint, messages) = await _validate(
      client,
      current,
      roomId,
      targetRoomId,
      recipient,
      eventIds,
    );
    _check(current);
    final id = sha256
        .convert(
          utf8.encode(
            '${generation.homeserver}|${generation.userId}|$roomId|$targetRoomId|$recipient|$fingerprint',
          ),
        )
        .toString();
    final draft = HistoryShareDraft(
      id: id,
      roomId: roomId,
      targetRoomId: targetRoomId,
      recipient: recipient,
      fingerprint: fingerprint,
      messages: List.unmodifiable(messages),
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    );
    _previews.removeWhere(
      (_, value) => value.$1.expiresAt.isBefore(DateTime.now()),
    );
    _previews[id] = (draft, generation);
    return draft;
  }

  String _accountKey(AuthSessionInvalidation generation) =>
      'n42_history_index_v1_${sha256.convert(utf8.encode('${generation.homeserver}|${generation.userId}'))}';

  Future<List<Map<String, dynamic>>> _records(
    AuthSessionInvalidation generation,
  ) async {
    final data = await storage.readStrict(_accountKey(generation));
    if (data == null) return [];
    return (jsonDecode(data) as List)
        .map((r) => Map<String, dynamic>.from(r as Map))
        .toList();
  }

  Future<void> _remember(
    HistoryShareDraft draft,
    AuthSessionInvalidation generation,
  ) async {
    final previous = _metadataTail;
    final done = Completer<void>();
    _metadataTail = done.future;
    await previous;
    try {
      final records = await _records(generation);
      if (records.any((r) => r['id'] == draft.id)) return;
      // Keep unknown operations across restarts; only prune completed records.
      if (records.length >= 200) {
        for (final record in List<Map<String, dynamic>>.from(records)) {
          if (await _status(record['id'] as String) ==
              HistoryShareStatus.completed) {
            records.remove(record);
          }
        }
      }
      if (records.length >= 200) {
        throw StateError('Resolve pending shares before starting more');
      }
      records.add({
        'id': draft.id,
        'room': draft.roomId,
        'target': draft.targetRoomId,
        'recipient': draft.recipient,
      });
      await storage.write(_accountKey(generation), jsonEncode(records));
    } finally {
      done.complete();
    }
  }

  @override
  Future<List<HistoryShareRecovery>> pendingHistory(String roomId) async {
    final (_, generation, current) = _session();
    final records = await _records(generation);
    final result = <HistoryShareRecovery>[];
    for (final record in records.where((r) => r['room'] == roomId)) {
      final status = await _status(record['id'] as String);
      if (status != HistoryShareStatus.completed &&
          status != HistoryShareStatus.prepared) {
        result.add(
          HistoryShareRecovery(
            id: record['id'] as String,
            roomId: roomId,
            targetRoomId: record['target'] as String,
            recipient: record['recipient'] as String,
            status: status,
          ),
        );
      }
    }
    _check(current);
    return result;
  }

  String _key(String id) => 'n42_history_share_v1_$id';
  Future<HistoryShareStatus> _status(String id) async {
    final value = await storage.readStrict(_key(id));
    if (value == null) return HistoryShareStatus.prepared;
    return HistoryShareStatus.values.byName(value);
  }

  Future<void> _save(String id, HistoryShareStatus status) =>
      storage.write(_key(id), status.name);

  Future<String> _send(
    matrix.Client client,
    bool Function() current,
    matrix.Room room,
    String txid,
    Map<String, dynamic> content,
    Future<void> Function() validate,
  ) async {
    // Key preparation and validation have not published a message. Keep the
    // previous journal state when they fail, so a corrected preview can proceed.
    await prepareEncryption(room);
    final encrypted = await client.encryption!.encryptGroupMessagePayload(
      room.id,
      content,
    );
    if (encrypted['ciphertext'] is! String ||
        encrypted['algorithm'] != matrix.AlgorithmTypes.megolmV1AesSha2) {
      throw StateError('Encrypted payload required');
    }
    await validate();
    _check(current);
    if (!room.encrypted) throw StateError('Encryption changed');
    final separator = txid.lastIndexOf('.');
    final batch = txid.substring(0, separator);
    final (previous, pending) = switch (txid.substring(separator + 1)) {
      'audit' => (HistoryShareStatus.prepared, HistoryShareStatus.auditPending),
      'content' => (
        HistoryShareStatus.auditSent,
        HistoryShareStatus.contentPending,
      ),
      'complete' => (
        HistoryShareStatus.contentSent,
        HistoryShareStatus.completionPending,
      ),
      _ => throw StateError('Invalid share step'),
    };
    await _save(batch, pending);
    try {
      await validate();
      _check(current);
      if (!room.encrypted) throw StateError('Encryption changed');
    } catch (_) {
      await _save(batch, previous);
      rethrow;
    }
    final id = await client.sendMessage(
      room.id,
      matrix.EventTypes.Encrypted,
      txid,
      encrypted,
    );
    if (id.isEmpty) throw StateError('Unknown send result');
    return id;
  }

  @override
  Future<HistoryShareStatus> shareHistory(HistoryShareDraft draft) async {
    if (!_busy.add(draft.id)) throw StateError('Sharing already in progress');
    try {
      final (client, generation, current) = _session();
      final issued = _previews[draft.id];
      if (issued == null ||
          !identical(issued.$1, draft) ||
          !identical(issued.$2, generation) ||
          !draft.expiresAt.isAfter(DateTime.now())) {
        throw StateError('Preview expired; review again');
      }
      Future<void> validate() async {
        if (!draft.expiresAt.isAfter(DateTime.now())) {
          throw StateError('Preview expired');
        }
        final (fingerprint, _) = await _validate(
          client,
          current,
          draft.roomId,
          draft.targetRoomId,
          draft.recipient,
          draft.messages.map((m) => m.id).toList(),
        );
        if (fingerprint != draft.fingerprint) {
          throw StateError('Selection or policy changed; review again');
        }
        _check(current);
      }

      await validate();
      await _remember(draft, generation);
      var status = await _status(draft.id);
      final source = client.getRoomById(draft.roomId)!,
          target = client.getRoomById(draft.targetRoomId)!;
      final times = draft.messages.map((m) => m.timestamp).toList()..sort();
      Map<String, dynamic> audit(String phase) => {
        'msgtype': 'm.notice',
        'body':
            'History share $phase: ${draft.recipient}; ${draft.messages.length} messages; '
            '${times.first.toUtc().toIso8601String()} – ${times.last.toUtc().toIso8601String()}; batch ${draft.id}',
        'n42.history_share': {
          'batch': draft.id,
          'phase': phase,
          'recipient': draft.recipient,
          'count': draft.messages.length,
          'from': times.first.millisecondsSinceEpoch,
          'to': times.last.millisecondsSinceEpoch,
        },
      };
      if (status == HistoryShareStatus.prepared) {
        await _send(
          client,
          current,
          source,
          '${draft.id}.audit',
          audit('requested'),
          validate,
        );
        await _save(draft.id, HistoryShareStatus.auditSent);
        status = HistoryShareStatus.auditSent;
      }
      if (status == HistoryShareStatus.auditSent) {
        // Never reuse the source history key or an old target outbound session.
        await client.encryption!.keyManager.clearOrUseOutboundGroupSession(
          target.id,
          wipe: true,
        );
        await _send(client, current, target, '${draft.id}.content', {
          'msgtype': 'm.text',
          'body':
              'Shared history (${draft.messages.length} messages):\n\n${draft.messages.map((m) => '${m.senderId} · ${m.timestamp.toUtc().toIso8601String()}\n${m.content}').join('\n\n')}',
          'n42.history_share': {'batch': draft.id, 'source': draft.roomId},
        }, validate);
        await _save(draft.id, HistoryShareStatus.contentSent);
        status = HistoryShareStatus.contentSent;
      }
      if (status == HistoryShareStatus.contentSent) {
        await _send(
          client,
          current,
          source,
          '${draft.id}.complete',
          audit('completed'),
          validate,
        );
        await _save(draft.id, HistoryShareStatus.completed);
        status = HistoryShareStatus.completed;
      }
      _check(current);
      return status;
    } finally {
      _busy.remove(draft.id);
    }
  }

  @override
  Future<HistoryShareStatus> reconcileHistory(HistoryShareDraft draft) =>
      reconcileBatch(
        HistoryShareRecovery(
          id: draft.id,
          roomId: draft.roomId,
          targetRoomId: draft.targetRoomId,
          recipient: draft.recipient,
          status: HistoryShareStatus.prepared,
        ),
      );

  @override
  Future<HistoryShareStatus> reconcileBatch(HistoryShareRecovery record) async {
    if (!_busy.add(record.id)) throw StateError('Sharing already in progress');
    try {
      final (client, generation, current) = _session();
      final records = await _records(generation);
      if (!records.any(
        (r) =>
            r['id'] == record.id &&
            r['room'] == record.roomId &&
            r['target'] == record.targetRoomId &&
            r['recipient'] == record.recipient,
      )) {
        throw StateError('No pending share for this account');
      }
      final status = await _status(record.id);
      final (roomId, suffix, next) = switch (status) {
        HistoryShareStatus.auditPending => (
          record.roomId,
          'audit',
          HistoryShareStatus.auditSent,
        ),
        HistoryShareStatus.contentPending => (
          record.targetRoomId,
          'content',
          HistoryShareStatus.contentSent,
        ),
        HistoryShareStatus.completionPending => (
          record.roomId,
          'complete',
          HistoryShareStatus.completed,
        ),
        _ => ('', '', status),
      };
      if (roomId.isEmpty) return status;
      String? from;
      final tokens = <String>{};
      for (var pageNumber = 0; pageNumber < 100; pageNumber++) {
        final page = await client.getRoomEvents(
          roomId,
          matrix.Direction.b,
          from: from,
          limit: 100,
        );
        _check(current);
        if (page.chunk.any(
          (e) =>
              e.senderId == client.userID &&
              e.unsigned?['transaction_id'] == '${record.id}.$suffix',
        )) {
          await _save(record.id, next);
          return next;
        }
        if (page.end == null || !tokens.add(page.end!)) break;
        from = page.end;
      }
      return status;
    } finally {
      _busy.remove(record.id);
    }
  }
}
