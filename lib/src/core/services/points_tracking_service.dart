import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../../domain/entities/points/reward_rule.dart';
import '../../domain/repositories/points_repository.dart';

/// Service that automatically tracks user actions and awards points.
///
/// Listens to Matrix sync events and triggers point awards based
/// on configured rules (message sending, reactions, etc.).
class PointsTrackingService {
  final IPointsRepository _repository;
  final MatrixClientManager _clientManager;

  StreamSubscription<dynamic>? _syncSubscription;
  final Map<String, DateTime> _lastActionTimes = {};
  bool _isTracking = false;

  PointsTrackingService({
    required IPointsRepository repository,
    required MatrixClientManager clientManager,
  })  : _repository = repository,
        _clientManager = clientManager;

  /// Whether the service is currently tracking events.
  bool get isTracking => _isTracking;

  /// Start tracking Matrix sync events for automatic point awards.
  void startTracking() {
    if (_isTracking) return;

    final client = _clientManager.client;
    if (client == null) {
      debugPrint('PointsTrackingService: Cannot start - client not available');
      return;
    }

    _syncSubscription = client.onSync.stream.listen((sync) {
      _processSyncUpdate(sync);
    });
    _isTracking = true; // Only set after subscription is successfully created

    debugPrint('PointsTrackingService: Started tracking');
  }

  /// Stop tracking events.
  void stopTracking() {
    _syncSubscription?.cancel();
    _syncSubscription = null;
    _isTracking = false;
    debugPrint('PointsTrackingService: Stopped tracking');
  }

  /// Award daily login points for a user in a room.
  ///
  /// Checks whether the daily login has already been awarded today
  /// before sending the award request.
  Future<void> awardDailyLogin(String userId, String roomId) async {
    try {
      final count = await _repository.getDailyEarnCount(
        userId,
        roomId,
        PointsAction.dailyLogin.name,
      );
      if (count == 0) {
        await _repository.awardPoints(
          userId: userId,
          roomId: roomId,
          amount: 5,
          actionType: PointsAction.dailyLogin.name,
          description: 'Daily login bonus',
        );
      }
    } catch (e) {
      debugPrint('PointsTrackingService: Failed to award daily login: $e');
    }
  }

  /// Release resources.
  void dispose() {
    stopTracking();
    _lastActionTimes.clear();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  void _processSyncUpdate(dynamic sync) {
    try {
      final client = _clientManager.client;
      if (client == null) return;

      final rooms = sync.rooms?.join as Map<String, dynamic>?;
      if (rooms == null) return;

      for (final entry in rooms.entries) {
        final roomId = entry.key;
        final roomData = entry.value;
        final events =
            (roomData?.timeline?.events as List<dynamic>?) ?? <dynamic>[];

        for (final event in events) {
          if (event.senderId == client.userID) {
            _processUserEvent(roomId, event);
          } else {
            _processOtherEvent(roomId, event);
          }
        }
      }
    } catch (e) {
      debugPrint('PointsTrackingService: Error processing sync: $e');
    }
  }

  void _processUserEvent(String roomId, dynamic event) {
    final userId = _clientManager.client?.userID;
    if (userId == null) return;

    final eventType = event.type as String?;
    PointsAction? action;
    int points = 0;

    switch (eventType) {
      case 'm.room.message':
        final msgtype = event.content?['msgtype'] as String?;
        if (msgtype == 'm.text') {
          action = PointsAction.sendMessage;
          points = 1;
        } else if (msgtype == 'm.image' ||
            msgtype == 'm.video' ||
            msgtype == 'm.audio') {
          action = PointsAction.sendMedia;
          points = 2;
        }
        break;
    }

    if (action != null && points > 0) {
      _tryAwardPoints(
        userId: userId,
        roomId: roomId,
        action: action,
        points: points,
      );
    }
  }

  void _processOtherEvent(String roomId, dynamic event) {
    // Reaction point awards require looking up the target message's author.
    // This cannot be done reliably in the sync listener without additional
    // API calls. Reaction awards should be handled server-side instead.
    // TODO: Move reaction tracking to backend /api/points/award
    //
    // Previously this method awarded points to the CURRENT user for any
    // reaction event, which was incorrect -- it should only award when
    // someone else reacts to the current user's message.
  }

  Future<void> _tryAwardPoints({
    required String userId,
    required String roomId,
    required PointsAction action,
    required int points,
  }) async {
    // Cooldown check: prevent rapid-fire awards (5-second minimum gap)
    final key = '$userId:$roomId:${action.name}';
    final lastTime = _lastActionTimes[key];
    if (lastTime != null &&
        DateTime.now().difference(lastTime).inSeconds < 5) {
      return;
    }
    _lastActionTimes[key] = DateTime.now();

    try {
      // Daily limit check: prevent excessive point farming
      final dailyCount = await _repository.getDailyEarnCount(
        userId, roomId, action.name,
      );
      if (dailyCount >= 50) return; // Default daily cap of 50 per action

      await _repository.awardPoints(
        userId: userId,
        roomId: roomId,
        amount: points,
        actionType: action.name,
        description: '${action.name} reward',
      );
    } catch (e) {
      debugPrint('PointsTrackingService: Failed to award points: $e');
    }
  }
}
