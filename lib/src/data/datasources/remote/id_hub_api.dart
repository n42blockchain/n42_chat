import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/utils/debug_log.dart';

const Duration _defaultRequestTimeout = Duration(seconds: 20);

/// Client for the unified-identity N42 ID Hub wallet-login path.
///
/// The hub is a separate RFC 9457 service (not the `{code:200}` gateway), so
/// responses are read directly. The base URL comes from `N42ChatConfig.idHubUrl`;
/// when that is null/empty this client is never constructed and login falls back
/// to the legacy [WalletLoginCredentials] path - the graceful-degradation
/// contract.
class IdHubApi {
  final String baseUrl;
  final http.Client _client;
  final Duration _requestTimeout;

  IdHubApi({
    required String baseUrl,
    http.Client? client,
    Duration requestTimeout = _defaultRequestTimeout,
  }) : baseUrl = _canonicalOrigin(baseUrl),
       _client = client ?? http.Client(),
       _requestTimeout = requestTimeout;

  static String _canonicalOrigin(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        (uri.hasPort && uri.port != 443) ||
        (uri.path.isNotEmpty && uri.path != '/') ||
        uri.hasQuery ||
        uri.hasFragment) {
      throw ArgumentError.value(
        value,
        'baseUrl',
        'must be a canonical HTTPS origin',
      );
    }
    return Uri(
      scheme: 'https',
      host: uri.host,
      port: uri.hasPort ? 443 : null,
    ).toString().replaceAll(RegExp(r'/$'), '');
  }

  /// Create a wallet login challenge. Returns the exact message to personal_sign.
  Future<IdHubChallenge> createWalletChallenge({
    required String address,
    String chain = 'eip155:94',
  }) async {
    final uri = Uri.parse('$baseUrl/v1/auth/wallet/challenge');
    final response = await _post(uri, {
      'address': address.toLowerCase(),
      'chain': chain,
      'aud': 'chat',
    });
    final data = _decodeObject(response);
    if (response.statusCode != 200) {
      throw IdHubException(
        _detail(data, 'challenge failed'),
        response.statusCode,
        _problemCode(data),
      );
    }
    final challengeId = data['challenge_id'];
    final message = data['message'];
    if (challengeId is! String ||
        !_uuidPattern.hasMatch(challengeId) ||
        message is! String ||
        message.isEmpty) {
      throw const FormatException('invalid ID Hub challenge response');
    }
    return IdHubChallenge(challengeId: challengeId, message: message);
  }

  /// Verify a signed challenge. For aud=chat the hub provisions/looks up the
  /// Matrix account and returns its credentials alongside the DID; when it does
  /// not (e.g. the Matrix bridge is not yet live) [IdHubWalletResponse.hasMatrixCredentials]
  /// is false and the caller falls back to legacy login.
  Future<IdHubWalletResponse> verifyWalletLogin({
    required String challengeId,
    required String signature,
    String signerType = 'eoa',
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/v1/auth/wallet/verify');
      final response = await _post(uri, {
        'challenge_id': challengeId,
        'signature': signature,
        'signer_type': signerType,
      });
      final data = _decodeObject(response);
      if (response.statusCode != 200) {
        return IdHubWalletResponse.failure(
          _detail(data, 'verify failed'),
          statusCode: response.statusCode,
          code: _problemCode(data),
        );
      }
      final result = IdHubWalletResponse.success(
        did: data['sub'] as String?,
        matrixUserId: data['matrix_user_id'] as String?,
        matrixAccessToken: data['matrix_access_token'] as String?,
        matrixDeviceId: data['matrix_device_id'] as String?,
        matrixHomeserver: data['matrix_homeserver'] as String?,
      );
      result.validate();
      return result;
    } catch (e) {
      debugLog('IdHubApi: verify error - $e');
      return IdHubWalletResponse.failure(
        e is FormatException ? e.message : 'invalid ID Hub response',
      );
    }
  }

  /// Fetch a server-owned nonce; no provider token has been obtained yet.
  Future<IdHubNativeChallenge> startNativeLogin(
    String provider,
    String platform,
  ) async {
    if (!['apple', 'facebook'].contains(provider) ||
        !['ios', 'android'].contains(platform)) {
      throw ArgumentError('Unsupported native OIDC provider or platform');
    }
    final data = await _nativePost('/native/start', {
      'provider': provider,
      'platform': platform,
    });
    String secret(String name) {
      final value = data[name];
      if (value is! String || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(value)) {
        throw const FormatException('Invalid native login challenge');
      }
      return value;
    }

    if (data['expires_in'] is! int ||
        (data['expires_in'] as int) <= 0 ||
        (data['expires_in'] as int) > 300) {
      throw const FormatException('Invalid native login expiry');
    }
    return IdHubNativeChallenge(
      flowId: secret('flow_id'),
      completionSecret: secret('completion_secret'),
      nonce: secret('nonce'),
    );
  }

  /// Exchange the proof then obtain Matrix credentials for that exact Hub DID.
  Future<IdHubWalletResponse> completeNativeLogin(
    IdHubNativeChallenge challenge,
    String identityToken,
  ) async {
    if (identityToken.isEmpty || identityToken.length > 16384) {
      throw const FormatException('Missing provider identity token');
    }
    final result = await _nativePost('/native/complete', {
      'flow_id': challenge.flowId,
      'completion_secret': challenge.completionSecret,
      'identity_token': identityToken,
    });
    final session = result['session'];
    if (result['status'] != 'complete' ||
        session is! Map<String, dynamic> ||
        session['sub'] is! String ||
        !(session['sub'] as String).startsWith('did:') ||
        session['access_token'] is! String ||
        (session['access_token'] as String).isEmpty ||
        session['token_type'] != 'Bearer') {
      throw const FormatException('Invalid native login session');
    }
    final token = session['access_token'] as String;
    try {
      final data = await _nativePost('/matrix/session', {}, token: token);
      if (data['sub'] != session['sub'])
        throw const FormatException('Matrix identity mismatch');
      final response = IdHubWalletResponse.success(
        did: data['sub'] as String?,
        matrixUserId: data['matrix_user_id'] as String?,
        matrixAccessToken: data['matrix_access_token'] as String?,
        matrixDeviceId: data['matrix_device_id'] as String?,
        matrixHomeserver: data['matrix_homeserver'] as String?,
      );
      response.validate();
      if (!response.hasMatrixCredentials)
        throw const FormatException('Missing Matrix credentials');
      return response;
    } finally {
      // This adapter owns no wallet session. Revoke its temporary Hub grant.
      final refresh = session['refresh_token'];
      if (refresh is String && refresh.isNotEmpty) {
        try {
          final request =
              http.Request('POST', Uri.parse('$baseUrl/v1/oauth/revoke'))
                ..followRedirects = false
                ..headers['Content-Type'] = 'application/x-www-form-urlencoded'
                ..headers['Authorization'] = 'Bearer $token'
                ..bodyFields = {'refresh_token': refresh};
          await (await _client.send(request).timeout(_requestTimeout)).stream
              .drain<void>()
              .timeout(_requestTimeout);
        } catch (_) {
          /* Do not replace a completed login with a cleanup error. */
        }
      }
    }
  }

  Future<Map<String, dynamic>> _nativePost(
    String path,
    Map<String, Object?> body, {
    String? token,
  }) async {
    final request = http.Request('POST', Uri.parse('$baseUrl/v1/auth/n42$path'))
      ..followRedirects = false
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(body);
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    final response = await http.Response.fromStream(
      await _client.send(request).timeout(_requestTimeout),
    ).timeout(_requestTimeout);
    if (response.statusCode != 200)
      throw IdHubException('N42 login request failed', response.statusCode);
    return _decodeObject(response);
  }

  Future<http.Response> _post(Uri uri, Map<String, Object?> body) {
    return _client
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(
          _requestTimeout,
          onTimeout: () => throw IdHubException('ID Hub request timed out'),
        );
  }

  Map<String, dynamic> _decodeObject(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // The caller receives a stable error without reflecting an upstream body.
    }
    throw const FormatException('invalid ID Hub response');
  }

  String _detail(Map<String, dynamic> body, String fallback) {
    final detail = body['detail'] ?? body['title'];
    return detail is String ? detail : fallback;
  }

  String? _problemCode(Map<String, dynamic> body) {
    final code = body['code'];
    if (code is String && code.isNotEmpty) return code;
    final type = body['type'];
    if (type is! String || type.isEmpty) return null;
    final segments = Uri.tryParse(type)?.pathSegments;
    return segments == null || segments.isEmpty ? null : segments.last;
  }

  void close() => _client.close();

  static final _uuidPattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );
}

/// A wallet login challenge: the exact message the wallet must personal_sign.
class IdHubChallenge {
  final String challengeId;
  final String message;

  const IdHubChallenge({required this.challengeId, required this.message});
}

/// Result of an ID Hub wallet verify. Mirrors the Matrix-credential quad the
/// social-login response carries so it plugs into `loginWithToken`.
class IdHubWalletResponse {
  final bool success;
  final String? did;
  final String? matrixUserId;
  final String? matrixAccessToken;
  final String? matrixDeviceId;
  final String? matrixHomeserver;
  final String? error;
  final int? statusCode;
  final String? code;

  const IdHubWalletResponse._({
    required this.success,
    this.did,
    this.matrixUserId,
    this.matrixAccessToken,
    this.matrixDeviceId,
    this.matrixHomeserver,
    this.error,
    this.statusCode,
    this.code,
  });

  factory IdHubWalletResponse.success({
    String? did,
    String? matrixUserId,
    String? matrixAccessToken,
    String? matrixDeviceId,
    String? matrixHomeserver,
  }) => IdHubWalletResponse._(
    success: true,
    did: did,
    matrixUserId: matrixUserId,
    matrixAccessToken: matrixAccessToken,
    matrixDeviceId: matrixDeviceId,
    matrixHomeserver: matrixHomeserver,
  );

  factory IdHubWalletResponse.failure(
    String error, {
    int? statusCode,
    String? code,
  }) => IdHubWalletResponse._(
    success: false,
    error: error,
    statusCode: statusCode,
    code: code,
  );

  /// Whether the hub returned enough to establish a Matrix session.
  bool get hasMatrixCredentials =>
      _notEmpty(matrixUserId) &&
      _notEmpty(matrixAccessToken) &&
      _notEmpty(matrixHomeserver);

  void validate() {
    if (!success) return;
    if (did == null || !RegExp(r'^did:(plc|web):').hasMatch(did!)) {
      throw const FormatException('invalid ID Hub subject');
    }
    if (!hasMatrixCredentials) return;
    if (!matrixUserId!.startsWith('@')) {
      throw const FormatException('invalid Matrix user ID');
    }
    IdHubApi._canonicalOrigin(matrixHomeserver!);
  }

  static bool _notEmpty(String? value) => value != null && value.isNotEmpty;
}

/// Error thrown for a non-2xx hub response during the challenge step.
class IdHubException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  IdHubException(this.message, [this.statusCode, this.code]);

  @override
  String toString() => 'IdHubException($statusCode $code): $message';
}

/// Short-lived credentials kept only in the active login attempt.
class IdHubNativeChallenge {
  final String flowId;
  final String completionSecret;
  final String nonce;
  const IdHubNativeChallenge({
    required this.flowId,
    required this.completionSecret,
    required this.nonce,
  });
}
