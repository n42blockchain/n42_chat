/// A successful Future means the Matrix homeserver acknowledged the report.
/// It does not establish that a moderator saw or acted on the report.
abstract interface class IContentReportRepository {
  Future<void> reportUser({required String userId, required String reason});

  Future<void> reportRoom({required String roomId, required String reason});
}

enum ContentReportFailure {
  unavailable,
  accountChanged,
  unsupported,
  subjectNotFound,
  forbidden,
  unauthorized,
  rateLimited,
  transport,
  server,
}

class ContentReportException implements Exception {
  const ContentReportException(this.kind, {this.retryAfter});

  final ContentReportFailure kind;
  final Duration? retryAfter;

  @override
  String toString() => 'Content report failed: ${kind.name}';
}
