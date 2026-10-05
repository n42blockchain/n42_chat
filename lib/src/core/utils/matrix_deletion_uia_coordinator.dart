import 'package:matrix/matrix.dart';

enum DeletionUiaStatus {
  idle,
  awaitingAuthentication,
  deactivated,
  deactivatedNeedsScopedCleanup,
  failed,
  cancelled,
}

enum DeletionUiaFailure {
  invalidChallenge,
  invalidStage,
  staleSession,
  untrustedOrigin,
  accountChanged,
  busy,
  invalidState,
  attemptLimit,
}

class DeletionUiaException implements Exception {
  final DeletionUiaFailure reason;

  const DeletionUiaException(this.reason);

  @override
  String toString() => 'Deletion UIA failed: $reason';
}

/// A successful server response for the original Matrix account. If the UI
/// was cancelled or the active account changed while the request was pending,
/// cleanup must be reconciled against this identity rather than the active UI.
class DeletionUiaReceipt {
  final String userId;
  final Uri homeserver;

  /// True when the active UI cannot safely run immediate account-local cleanup.
  /// The normal confirmed path also needs account-local cleanup.
  final bool requiresDeferredCleanup;

  const DeletionUiaReceipt({
    required this.userId,
    required this.homeserver,
    required this.requiresDeferredCleanup,
  });
}

/// Coordinates only the server's Matrix UIA request. It does not clean local
/// data or treat an external authentication signal as account deactivation.
class MatrixDeletionUiaCoordinator {
  MatrixDeletionUiaCoordinator({
    required this.userId,
    required this.homeserver,
    required this.isCurrentAccount,
    required this.request,
    this.maxAttempts = 8,
  }) {
    if (userId.isEmpty ||
        homeserver.host.isEmpty ||
        homeserver.userInfo.isNotEmpty ||
        homeserver.hasQuery ||
        homeserver.hasFragment ||
        (homeserver.scheme != 'https' &&
            !(homeserver.scheme == 'http' &&
                (homeserver.host == 'localhost' ||
                    homeserver.host == '127.0.0.1'))) ||
        maxAttempts < 1) {
      throw ArgumentError('Invalid Matrix account or homeserver');
    }
  }

  final String userId;
  final Uri homeserver;
  final bool Function() isCurrentAccount;
  final Future<void> Function(AuthenticationData? auth) request;
  final int maxAttempts;

  DeletionUiaStatus status = DeletionUiaStatus.idle;
  DeletionUiaReceipt? _confirmedDeletion;
  DeletionUiaReceipt? get confirmedDeletion => _confirmedDeletion;
  String? session;
  List<String> _nextStages = const [];
  List<String> get nextStages => List.unmodifiable(_nextStages);
  final Set<String> _openedFallbackStages = {};
  int _attempts = 0;
  bool _busy = false;

  Future<DeletionUiaStatus> start() {
    if (status != DeletionUiaStatus.idle) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidState);
    }
    return _attempt(null);
  }

  Future<DeletionUiaStatus> submitPassword(String password) async {
    _requireStage('m.login.password');
    if (password.isEmpty) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidStage);
    }
    return await _attempt(
      AuthenticationPassword(
        session: session,
        password: password,
        identifier: AuthenticationUserIdentifier(user: userId),
      ),
    );
  }

  /// Use this URL only for a stage offered as the next stage by the server.
  Uri fallbackUri(String stage) {
    _requireStage(stage);
    _openedFallbackStages.add(stage);
    return homeserver.replace(
      pathSegments: [
        ...homeserver.pathSegments.where((segment) => segment.isNotEmpty),
        '_matrix',
        'client',
        'v3',
        'auth',
        stage,
        'fallback',
        'web',
      ],
      queryParameters: {'session': session!},
    );
  }

  /// The browser integration must also verify the callback window/source.
  /// This method verifies the origin and operation session, then asks the
  /// server again; it never interprets the callback as deletion success.
  Future<DeletionUiaStatus> retryAfterFallback({
    required String stage,
    required String session,
    required Uri origin,
  }) async {
    _requireStage(stage);
    if (!_openedFallbackStages.contains(stage) || session != this.session) {
      throw const DeletionUiaException(DeletionUiaFailure.staleSession);
    }
    if (origin.scheme != homeserver.scheme ||
        origin.host != homeserver.host ||
        origin.port != homeserver.port) {
      throw const DeletionUiaException(DeletionUiaFailure.untrustedOrigin);
    }
    return _retryOpenedFallback(stage: stage, session: session);
  }

  /// An external browser supplies no trusted completion callback. A manual
  /// return only permits retrying the original server operation/session.
  Future<DeletionUiaStatus> retryAfterExternalFallback({
    required String stage,
    required String session,
  }) async {
    _requireStage(stage);
    if (!_openedFallbackStages.contains(stage) || session != this.session) {
      throw const DeletionUiaException(DeletionUiaFailure.staleSession);
    }
    return _retryOpenedFallback(stage: stage, session: session);
  }

  Future<DeletionUiaStatus> _retryOpenedFallback({
    required String stage,
    required String session,
  }) async {
    _openedFallbackStages.remove(stage);
    return await _attempt(AuthenticationData(session: session));
  }

  void cancel() {
    if (_confirmedDeletion == null) {
      status = DeletionUiaStatus.cancelled;
      _nextStages = const [];
      _openedFallbackStages.clear();
    }
  }

  void _requireStage(String stage) {
    if (_busy) throw const DeletionUiaException(DeletionUiaFailure.busy);
    if (status != DeletionUiaStatus.awaitingAuthentication ||
        !_nextStages.contains(stage)) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidStage);
    }
    _checkAccount();
  }

  void _checkAccount() {
    if (!isCurrentAccount()) {
      throw const DeletionUiaException(DeletionUiaFailure.accountChanged);
    }
  }

  Future<DeletionUiaStatus> _attempt(AuthenticationData? auth) async {
    if (status == DeletionUiaStatus.cancelled || _confirmedDeletion != null) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidState);
    }
    if (_busy) throw const DeletionUiaException(DeletionUiaFailure.busy);
    _checkAccount();
    if (_attempts >= maxAttempts) {
      throw const DeletionUiaException(DeletionUiaFailure.attemptLimit);
    }
    _attempts++;
    _busy = true;
    try {
      await request(auth);
      var currentAccount = false;
      try {
        currentAccount = isCurrentAccount();
      } catch (_) {
        // The server result is authoritative even if local account inspection
        // fails after the request has completed.
      }
      final requiresDeferredCleanup =
          status == DeletionUiaStatus.cancelled || !currentAccount;
      _confirmedDeletion = DeletionUiaReceipt(
        userId: userId,
        homeserver: homeserver,
        requiresDeferredCleanup: requiresDeferredCleanup,
      );
      status = requiresDeferredCleanup
          ? DeletionUiaStatus.deactivatedNeedsScopedCleanup
          : DeletionUiaStatus.deactivated;
      session = null;
      _nextStages = const [];
      _openedFallbackStages.clear();
      return status;
    } on MatrixException catch (error) {
      _checkAfterRequest();
      if (!error.requireAdditionalAuthentication) {
        status = DeletionUiaStatus.failed;
        rethrow;
      }
      _acceptChallenge(error);
      return status;
    } catch (_) {
      if (status != DeletionUiaStatus.cancelled) {
        status = DeletionUiaStatus.failed;
      }
      rethrow;
    } finally {
      _busy = false;
    }
  }

  void _checkAfterRequest() {
    if (status == DeletionUiaStatus.cancelled) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidState);
    }
    _checkAccount();
  }

  void _acceptChallenge(MatrixException error) {
    // An unusable replacement challenge must not leave an earlier fallback
    // window or session authorized to resubmit the deactivation request.
    status = DeletionUiaStatus.failed;
    session = null;
    _nextStages = const [];
    _openedFallbackStages.clear();
    final newSession = error.session;
    final rawFlows = error.raw['flows'];
    final rawCompleted = error.raw['completed'];
    if (newSession == null ||
        newSession.isEmpty ||
        rawFlows is! List ||
        rawFlows.isEmpty ||
        (rawCompleted != null && rawCompleted is! List)) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidChallenge);
    }
    final completed = rawCompleted == null
        ? <String>[]
        : (rawCompleted as List).cast<Object?>();
    if (completed.any((stage) => stage is! String || stage.isEmpty)) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidChallenge);
    }
    final next = <String>[];
    for (final rawFlow in rawFlows) {
      if (rawFlow is! Map || rawFlow['stages'] is! List) {
        throw const DeletionUiaException(DeletionUiaFailure.invalidChallenge);
      }
      final stages = (rawFlow['stages'] as List).cast<Object?>();
      if (stages.isEmpty ||
          stages.any((stage) => stage is! String || stage.isEmpty)) {
        throw const DeletionUiaException(DeletionUiaFailure.invalidChallenge);
      }
      if (completed.length >= stages.length) continue;
      var matches = true;
      for (var i = 0; i < completed.length; i++) {
        if (stages[i] != completed[i]) matches = false;
      }
      if (matches && !next.contains(stages[completed.length])) {
        next.add(stages[completed.length] as String);
      }
    }
    if (next.isEmpty) {
      throw const DeletionUiaException(DeletionUiaFailure.invalidChallenge);
    }
    session = newSession;
    _nextStages = next;
    status = DeletionUiaStatus.awaitingAuthentication;
  }
}
