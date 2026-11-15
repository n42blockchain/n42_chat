import 'dart:convert';

import 'package:matrix/matrix.dart' as matrix;

import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../../domain/entities/token_gate_entity.dart';

/// A rejected local admission check, carrying the result used by the gate UI.
class RoomAdmissionException implements Exception {
  final String roomId;
  final TokenGateVerificationResult result;

  const RoomAdmissionException(this.roomId, this.result);

  @override
  String toString() => result.errorMessage ?? 'Token gate verification failed';
}

typedef TokenGateVerifier = Future<TokenGateVerificationResult> Function(
  String roomId,
);

typedef _JoinSession = ({
  matrix.Client client,
  String? userId,
  String? deviceId,
  String? accessToken,
});

/// Joins an immutable room ID after checking any locally known token gate.
///
/// Unknown rooms retain Matrix's normal join policy. Invite/preview state may
/// be partial, so this client check is not a server-side admission mechanism.
class RoomJoinService {
  final MatrixClientManager _manager;
  final TokenGateVerifier? verifyGate;
  final _pending = <({_JoinSession session, String roomId}), Future<String>>{};

  RoomJoinService(this._manager, {this.verifyGate});

  Future<String> join(String roomIdOrAlias) async {
    final target = roomIdOrAlias.trim();
    if (!RegExp(r'^[!#][^\s:]+:[^\s]+$').hasMatch(target)) {
      throw const FormatException('Invalid room ID or alias');
    }
    final client = _manager.client;
    if (client == null) throw StateError('Matrix client not initialized');
    final session = (
      client: client,
      userId: client.userID,
      deviceId: client.deviceID,
      accessToken: client.accessToken,
    );
    var roomId = target;
    List<String>? via;
    if (target.startsWith('#')) {
      final resolved = await client.getRoomIdByAlias(target);
      roomId = resolved.roomId ?? '';
      via = resolved.servers;
      if (!RegExp(r'^![^\s:]+:[^\s]+$').hasMatch(roomId)) {
        throw const FormatException('Invalid resolved room ID');
      }
    }
    _ensureSession(session);
    final key = (session: session, roomId: roomId);
    final pending = _pending[key];
    if (pending != null) return pending;
    final operation = _join(session, roomId, via);
    _pending[key] = operation;
    try {
      return await operation;
    } finally {
      _pending.removeWhere((k, v) => k == key && identical(v, operation));
    }
  }

  Future<String> _join(
    _JoinSession session,
    String roomId,
    List<String>? via,
  ) async {
    final client = session.client;
    final room = client.getRoomById(roomId);
    if (room?.membership == matrix.Membership.join) return roomId;
    final gate = room?.getState('n42.token_gate')?.content;
    if (gate != null && gate['enabled'] != false) {
      final snapshot = jsonEncode(gate);
      final verifier = verifyGate;
      if (verifier == null) {
        throw RoomAdmissionException(
          roomId,
          TokenGateVerificationResult.error('Token gate verifier unavailable'),
        );
      }
      final result = await verifier(roomId);
      _ensureSession(session);
      if (!result.passed) throw RoomAdmissionException(roomId, result);
      final latestGate = client
          .getRoomById(roomId)
          ?.getState('n42.token_gate')
          ?.content;
      if (jsonEncode(latestGate) != snapshot) {
        throw RoomAdmissionException(
          roomId,
          TokenGateVerificationResult.error(
            'Token gate changed; retry verification',
          ),
        );
      }
    }
    _ensureSession(session);
    if (room != null) {
      await room.join();
      _ensureSession(session);
      return roomId;
    }
    final joinedId = await client.joinRoom(roomId, via: via);
    _ensureSession(session);
    if (joinedId != roomId) throw StateError('Joined room ID does not match');
    return joinedId;
  }

  void _ensureSession(_JoinSession session) {
    final client = session.client;
    if (!identical(_manager.client, client) ||
        client.userID != session.userId ||
        client.deviceID != session.deviceId ||
        client.accessToken != session.accessToken) {
      throw StateError('Matrix session changed during room admission');
    }
  }
}
