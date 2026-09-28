import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';

import '../../domain/repositories/content_report_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// Sends a report through the initiating Matrix account's SDK client.
class MatrixContentReportRepository implements IContentReportRepository {
  const MatrixContentReportRepository(this._manager);

  final MatrixClientManager _manager;
  static final RegExp _stableVersion = RegExp(r'^v([0-9]+)\.([0-9]+)$');

  @override
  Future<void> reportUser({required String userId, required String reason}) {
    if (!userId.startsWith('@') || !userId.contains(':')) {
      throw ArgumentError.value(userId, 'userId', 'Invalid Matrix user ID');
    }
    return _report(
      minMinorVersion: 14,
      send: (client) async {
        await client.reportUser(userId, reason);
      },
    );
  }

  @override
  Future<void> reportRoom({required String roomId, required String reason}) {
    if (!roomId.startsWith('!') || !roomId.contains(':')) {
      throw ArgumentError.value(roomId, 'roomId', 'Invalid Matrix room ID');
    }
    return _report(
      minMinorVersion: 13,
      send: (client) => client.reportRoom(roomId, reason),
    );
  }

  Future<void> _report({
    required int minMinorVersion,
    required Future<void> Function(Client client) send,
  }) async {
    final client = _manager.client;
    final userId = client?.userID;
    final homeserver = client?.homeserver;
    final token = client?.accessToken;
    final deviceId = client?.deviceID;
    if (client == null ||
        !client.isLogged() ||
        userId == null ||
        homeserver == null ||
        token == null) {
      throw const ContentReportException(ContentReportFailure.unavailable);
    }

    bool sameAccount() =>
        identical(_manager.client, client) &&
        client.isLogged() &&
        client.userID == userId &&
        client.homeserver == homeserver &&
        client.accessToken == token &&
        client.deviceID == deviceId;

    try {
      late final GetVersionsResponse versions;
      try {
        versions = await client.getVersions();
      } on MatrixException catch (error) {
        if (!sameAccount()) {
          throw const ContentReportException(
            ContentReportFailure.accountChanged,
          );
        }
        if (error.error == MatrixError.M_NOT_FOUND ||
            error.error == MatrixError.M_UNRECOGNIZED) {
          throw const ContentReportException(ContentReportFailure.unsupported);
        }
        rethrow;
      }
      if (!sameAccount()) {
        throw const ContentReportException(ContentReportFailure.accountChanged);
      }
      if (!_supportsStableVersion(versions.versions, minMinorVersion)) {
        throw const ContentReportException(ContentReportFailure.unsupported);
      }
      await send(client);
      if (!sameAccount()) {
        throw const ContentReportException(ContentReportFailure.accountChanged);
      }
    } on ContentReportException {
      rethrow;
    } on MatrixException catch (error) {
      if (!sameAccount()) {
        throw const ContentReportException(ContentReportFailure.accountChanged);
      }
      throw _mapMatrixError(error);
    } on TimeoutException {
      throw const ContentReportException(ContentReportFailure.transport);
    } on IOException {
      throw const ContentReportException(ContentReportFailure.transport);
    } on http.ClientException {
      throw const ContentReportException(ContentReportFailure.transport);
    }
  }

  bool _supportsStableVersion(List<String> versions, int minMinorVersion) {
    for (final version in versions) {
      final match = _stableVersion.firstMatch(version);
      if (match == null) continue;
      final major = int.tryParse(match.group(1)!);
      final minor = int.tryParse(match.group(2)!);
      if (major != null &&
          minor != null &&
          (major > 1 || (major == 1 && minor >= minMinorVersion))) {
        return true;
      }
    }
    return false;
  }

  ContentReportException _mapMatrixError(MatrixException error) {
    return switch (error.error) {
      MatrixError.M_UNRECOGNIZED => const ContentReportException(
        ContentReportFailure.unsupported,
      ),
      MatrixError.M_NOT_FOUND => const ContentReportException(
        ContentReportFailure.subjectNotFound,
      ),
      MatrixError.M_FORBIDDEN => const ContentReportException(
        ContentReportFailure.forbidden,
      ),
      MatrixError.M_UNAUTHORIZED || MatrixError.M_UNKNOWN_TOKEN =>
        const ContentReportException(ContentReportFailure.unauthorized),
      MatrixError.M_LIMIT_EXCEEDED => ContentReportException(
        ContentReportFailure.rateLimited,
        retryAfter: error.retryAfterMs == null || error.retryAfterMs! < 0
            ? null
            : Duration(milliseconds: error.retryAfterMs!),
      ),
      _ => const ContentReportException(ContentReportFailure.server),
    };
  }
}
