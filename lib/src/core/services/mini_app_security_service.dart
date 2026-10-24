import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/mini_app_entity.dart';
import '../utils/secure_uri.dart';

/// Only public Ed25519 keys belong here. Policy and launch signing are separate.
class MiniAppSecurityConfig {
  final String? policyUrl;
  final String? upgradeUrl;
  final String audience;
  final Map<String, String> policyPublicKeys;
  final Map<String, String> launchPublicKeys;

  const MiniAppSecurityConfig({
    this.policyUrl,
    this.upgradeUrl,
    this.audience = 'n42chat-miniapp',
    this.policyPublicKeys = const {},
    this.launchPublicKeys = const {},
  });
}

class MiniAppSecurityException implements Exception {
  final String message;
  const MiniAppSecurityException(this.message);
  @override
  String toString() => message;
}

/// A bounded, fail-closed gate shared by the launcher and every native call.
/// An unconfigured host supports only the bundled manifest's base entry points.
class MiniAppSecurityService {
  static const sdkVersion = '1.1.0';
  static const refreshInterval = Duration(minutes: 5);
  static const maxPolicyAge = Duration(minutes: 15);
  static const _storageKey = 'n42.miniapp.security.v1';
  final MiniAppSecurityConfig config;
  final http.Client _client;
  final DateTime Function() _now;
  final Future<SharedPreferences> Function() _preferences;
  late final Map<String, String> _policyKeys = Map.unmodifiable(
    config.policyPublicKeys,
  );
  late final Map<String, String> _launchKeys = Map.unmodifiable(
    config.launchPublicKeys,
  );
  Map<String, dynamic>? _policy;
  DateTime? _receivedAt;
  final Stopwatch _policyAge = Stopwatch();
  Timer? _timer;
  Future<void>? _refreshing;
  bool _disposed = false;
  Future<void> _launchQueue = Future.value();
  Future<void> _policyQueue = Future.value();

  MiniAppSecurityService({
    this.config = const MiniAppSecurityConfig(),
    http.Client? client,
    DateTime Function()? now,
    Future<SharedPreferences> Function()? preferences,
  }) : _client = client ?? http.Client(),
       _now = now ?? DateTime.now,
       _preferences = preferences ?? SharedPreferences.getInstance;

  String get _scope => base64Url.encode(
    utf8.encode('${config.audience}|${config.policyUrl ?? "local"}'),
  );

  Future<void> refresh() {
    if (_disposed || config.policyUrl == null) return Future.value();
    _timer ??= Timer.periodic(refreshInterval, (_) => unawaited(refresh()));
    return _refreshing ??= _fetchPolicy().whenComplete(
      () => _refreshing = null,
    );
  }

  Future<void> _fetchPolicy() async {
    try {
      final uri = parseSecureUri(config.policyUrl);
      if (uri == null || uri.hasFragment) throw const FormatException();
      final request = http.Request('GET', uri)..followRedirects = false;
      final response = await _client
          .send(request)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) throw const FormatException();
      final bytes = <int>[];
      final downloadTime = Stopwatch()..start();
      await for (final chunk in response.stream.timeout(
        const Duration(seconds: 10),
      )) {
        if (downloadTime.elapsed > const Duration(seconds: 10) ||
            bytes.length + chunk.length > 65536)
          throw const FormatException();
        bytes.addAll(chunk);
      }
      await acceptPolicy(utf8.decode(bytes));
    } catch (_) {
      // Keep a verified policy only until its absolute AND monotonic deadlines.
      // Never log policy URLs, signatures, parameters or server error bodies.
    }
  }

  /// Verifies an exact signed payload before installing it; useful for hosts
  /// that deliver the same signed envelope through their configuration service.
  Future<void> acceptPolicy(String envelope) {
    final result = _policyQueue.then((_) => _acceptPolicy(envelope));
    _policyQueue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  Future<void> _acceptPolicy(String envelope) async {
    final policy = await _verify(envelope, _policyKeys);
    _validateTime(policy, maxPolicyAge);
    if (policy['aud'] != config.audience ||
        policy['revision'] is! int ||
        (policy['revision'] as int) < 1 ||
        !_validVersion(policy['minVersion']) ||
        !_stringList(policy['deniedVersions']) ||
        !_stringList(policy['deniedAppIds']) ||
        (policy['deniedVersions'] as List).any((v) => !_validVersion(v))) {
      throw const MiniAppSecurityException('Invalid Mini App security policy');
    }
    final prefs = await _preferences();
    final key = '$_storageKey.revision.$_scope';
    final revision = policy['revision'] as int;
    final saved = prefs.getString(key);
    final previous = saved == null
        ? <String, dynamic>{}
        : jsonDecode(saved) as Map<String, dynamic>;
    final oldRevision = previous['revision'] as int? ?? 0;
    final payload =
        (jsonDecode(envelope) as Map<String, dynamic>)['payload'] as String;
    if (revision < oldRevision ||
        revision < (_policy?['revision'] as int? ?? 0) ||
        (revision == oldRevision && previous['payload'] != payload)) {
      throw const MiniAppSecurityException('Outdated Mini App security policy');
    }
    if (!await prefs.setString(
      key,
      jsonEncode({'revision': revision, 'payload': payload}),
    )) {
      throw const MiniAppSecurityException(
        'Unable to save Mini App security policy',
      );
    }
    if (_disposed) return;
    _policy = policy;
    _receivedAt = _now().toUtc();
    _policyAge
      ..reset()
      ..start();
  }

  String? blockedReason(MiniAppEntity app) {
    if (_disposed) return 'Mini App session ended. Please reopen it.';
    final registered = BuiltInMiniApps.all.where((item) => item.id == app.id);
    if (registered.isEmpty ||
        registered.first.url != app.url ||
        app.permissions.any(
          (permission) => !registered.first.permissions.contains(permission),
        )) {
      return 'This Mini App is not registered.';
    }
    if (normalizeTrustedMiniAppUri(app.url) == null)
      return 'Invalid mini app URL';
    if (config.policyUrl != null || _policy != null) {
      final policy = _policy;
      if (policy == null ||
          _receivedAt == null ||
          _policyAge.elapsed >= maxPolicyAge ||
          _now().toUtc().isBefore(_receivedAt!) ||
          _now().toUtc().difference(_receivedAt!) >= maxPolicyAge) {
        return 'Mini App security policy is unavailable. Please retry when online.';
      }
      try {
        _validateTime(policy, maxPolicyAge);
      } catch (_) {
        return 'Mini App security policy expired. Please retry when online.';
      }
      if (_compareVersions(sdkVersion, policy['minVersion'] as String) < 0 ||
          (policy['deniedVersions'] as List).contains(sdkVersion)) {
        return 'Update N42 to open this Mini App safely.';
      }
      if ((policy['deniedAppIds'] as List).contains(app.id)) {
        return 'This Mini App has been temporarily disabled for safety.';
      }
    }
    return null;
  }

  Future<Uri> authorizeLaunch(MiniAppEntity app, String? initialUrl) {
    final result = _launchQueue.then((_) => _authorizeLaunch(app, initialUrl));
    _launchQueue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  Future<Uri> _authorizeLaunch(MiniAppEntity app, String? initialUrl) async {
    await refresh();
    final blocked = blockedReason(app);
    if (blocked != null) throw MiniAppSecurityException(blocked);
    final base = normalizeTrustedMiniAppUri(app.url)!;
    final candidate = normalizeTrustedMiniAppUri(initialUrl ?? app.url);
    if (candidate == null || candidate.origin != base.origin) {
      throw const MiniAppSecurityException('Invalid mini app URL');
    }
    if (candidate == base ||
        (candidate.origin == base.origin &&
            candidate.path == '/' &&
            base.path.isEmpty &&
            !candidate.hasQuery &&
            !candidate.hasFragment))
      return base;
    final params = Map<String, String>.from(candidate.queryParameters);
    final envelope = params.remove('n42_launch');
    if (envelope == null) {
      throw const MiniAppSecurityException(
        'This link is not signed. Open the Mini App from Apps instead.',
      );
    }
    final target = Uri(
      scheme: candidate.scheme,
      host: candidate.host,
      port: candidate.hasPort ? candidate.port : null,
      path: candidate.path,
      queryParameters: params.isEmpty ? null : params,
      fragment: candidate.hasFragment ? candidate.fragment : null,
    );
    final claims = await _verify(
      utf8.decode(base64Url.decode(base64Url.normalize(envelope))),
      _launchKeys,
    );
    _validateTime(claims, const Duration(minutes: 5));
    final nonce = claims['nonce'];
    if (claims['aud'] != config.audience ||
        claims['appId'] != app.id ||
        claims['target'] != target.toString() ||
        nonce is! String ||
        !RegExp(r'^[A-Za-z0-9_-]{22,128}$').hasMatch(nonce)) {
      throw const MiniAppSecurityException('Invalid Mini App launch signature');
    }
    // Launches are serialized so persisted nonce updates cannot lose entries.
    final prefs = await _preferences();
    final storage = '$_storageKey.nonces.$_scope';
    final now = _now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final saved = prefs.getString(storage);
    final used = saved == null
        ? <String, dynamic>{}
        : jsonDecode(saved) as Map<String, dynamic>;
    used.removeWhere((_, expiry) => expiry is int && expiry <= now);
    if (used.containsKey(nonce))
      throw const MiniAppSecurityException('This link has already been used.');
    if (used.length >= 1024)
      throw const MiniAppSecurityException(
        'Too many links. Please try again later.',
      );
    used[nonce] = claims['exp'];
    if (!await prefs.setString(storage, jsonEncode(used)))
      throw const MiniAppSecurityException(
        'Unable to verify this link safely.',
      );
    // A policy may have changed while signature verification/storage was in flight.
    final after = blockedReason(app);
    if (after != null) throw MiniAppSecurityException(after);
    return target;
  }

  Future<Map<String, dynamic>> _verify(
    String envelope,
    Map<String, String> keys,
  ) async {
    try {
      if (envelope.length > 65536) throw const FormatException();
      final json = jsonDecode(envelope) as Map<String, dynamic>;
      final encodedKey = keys[json['keyId']];
      if (encodedKey == null) throw const FormatException();
      final keyBytes = base64Url.decode(base64Url.normalize(encodedKey));
      final payload = base64Url.decode(
        base64Url.normalize(json['payload'] as String),
      );
      final signature = base64Url.decode(
        base64Url.normalize(json['signature'] as String),
      );
      if (keyBytes.length != 32 ||
          signature.length != 64 ||
          !await Ed25519().verify(
            payload,
            signature: Signature(
              signature,
              publicKey: SimplePublicKey(keyBytes, type: KeyPairType.ed25519),
            ),
          )) {
        throw const FormatException();
      }
      return jsonDecode(utf8.decode(payload)) as Map<String, dynamic>;
    } catch (_) {
      throw const MiniAppSecurityException(
        'Mini App signature could not be verified.',
      );
    }
  }

  void _validateTime(Map<String, dynamic> claims, Duration maxAge) {
    final now = _now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final issued = claims['iat'];
    final expires = claims['exp'];
    if (issued is! int ||
        expires is! int ||
        issued > now ||
        expires <= now ||
        expires <= issued ||
        expires - issued > maxAge.inSeconds ||
        now - issued >= maxAge.inSeconds) {
      throw const MiniAppSecurityException(
        'Mini App authorization expired. Please request a new link.',
      );
    }
  }

  static bool _stringList(Object? value) =>
      value is List &&
      value.length <= 1024 &&
      value.every((v) => v is String && v.length <= 128);
  static bool _validVersion(Object? value) =>
      value is String &&
      RegExp(r'^(0|[1-9][0-9]{0,5})\.(0|[1-9][0-9]{0,5})\.(0|[1-9][0-9]{0,5})$')
          .hasMatch(value);
  static int _compareVersions(String a, String b) {
    final left = a.split('.').map(int.parse).toList();
    final right = b.split('.').map(int.parse).toList();
    for (var i = 0; i < 3; i++) {
      if (left[i] != right[i]) return left[i].compareTo(right[i]);
    }
    return 0;
  }

  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _client.close();
    _policyAge.stop();
  }
}
