import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/core/services/mini_app_security_service.dart';
import 'package:n42_chat/src/domain/entities/mini_app_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final app = BuiltInMiniApps.all.first;
  late SimpleKeyPair key;
  late String publicKey;
  late DateTime now;
  late MiniAppSecurityService service;
  late MiniAppSecurityConfig config;
  Future<String> sign(Map<String, dynamic> claims) async {
    final bytes = utf8.encode(jsonEncode(claims));
    final sig = await Ed25519().sign(bytes, keyPair: key);
    return jsonEncode({
      'keyId': 'test',
      'payload': base64Url.encode(bytes),
      'signature': base64Url.encode(sig.bytes),
    });
  }

  Map<String, dynamic> policy({
    int revision = 1,
    String minimum = '1.1.0',
    List<String> denied = const [],
    List<String> apps = const [],
  }) {
    final seconds = now.millisecondsSinceEpoch ~/ 1000;
    return {
      'aud': config.audience,
      'revision': revision,
      'iat': seconds,
      'exp': seconds + 900,
      'minVersion': minimum,
      'deniedVersions': denied,
      'deniedAppIds': apps,
    };
  }

  Future<String> link({
    String nonce = 'abcdefghijklmnopqrstuv123456',
    String? target,
    String? audience,
    int? expires,
  }) async {
    final destination = target ?? '${app.url}/offer?item=1';
    final seconds = now.millisecondsSinceEpoch ~/ 1000;
    final claims = {
      'aud': audience ?? config.audience,
      'appId': app.id,
      'target': destination,
      'nonce': nonce,
      'iat': seconds,
      'exp': expires ?? seconds + 300,
    };
    final envelope = await sign(claims);
    final uri = Uri.parse(destination);
    return uri
        .replace(
          queryParameters: {
            ...uri.queryParameters,
            'n42_launch': base64Url.encode(utf8.encode(envelope)),
          },
        )
        .toString();
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    now = DateTime.utc(2026, 10, 23, 12);
    key = await Ed25519().newKeyPair();
    publicKey = base64Url.encode((await key.extractPublicKey()).bytes);
    config = MiniAppSecurityConfig(
      policyPublicKeys: {'test': publicKey},
      launchPublicKeys: {'test': publicKey},
    );
    service = MiniAppSecurityService(config: config, now: () => now);
  });
  tearDown(() => service.dispose());
  test(
    'unconfigured host allows bundled base but not unsigned business links',
    () async {
      expect(await service.authorizeLaunch(app, null), Uri.parse(app.url));
      expect(
        await service.authorizeLaunch(app, '${app.url}/'),
        Uri.parse(app.url),
      );
      await expectLater(
        service.authorizeLaunch(app, '${app.url}/offer?item=1'),
        throwsA(isA<MiniAppSecurityException>()),
      );
    },
  );
  test(
    'signed policy disables versions/apps and expired policy fails closed',
    () async {
      await service.acceptPolicy(await sign(policy()));
      expect(service.blockedReason(app), isNull);
      await service.acceptPolicy(
        await sign(policy(revision: 2, minimum: '1.2.0')),
      );
      expect(service.blockedReason(app), contains('Update'));
      await service.acceptPolicy(
        await sign(policy(revision: 3, denied: ['1.1.0'])),
      );
      expect(service.blockedReason(app), contains('Update'));
      await service.acceptPolicy(
        await sign(policy(revision: 4, apps: [app.id])),
      );
      expect(service.blockedReason(app), contains('disabled'));
      now = now.add(const Duration(minutes: 15));
      expect(service.blockedReason(app), isNotNull);
    },
  );
  test('version components compare numerically', () async {
    await service.acceptPolicy(await sign(policy(minimum: '1.10.0')));
    expect(service.blockedReason(app), contains('Update'));
  });
  test(
    'persistent revision rejects rollback and same-revision mutation',
    () async {
      final original = await sign(policy(revision: 4));
      await service.acceptPolicy(original);
      await service.acceptPolicy(original);
      await expectLater(
        service.acceptPolicy(await sign(policy(revision: 4, minimum: '9.0.0'))),
        throwsA(isA<MiniAppSecurityException>()),
      );
      service.dispose();
      service = MiniAppSecurityService(config: config, now: () => now);
      await expectLater(
        service.acceptPolicy(await sign(policy(revision: 3))),
        throwsA(isA<MiniAppSecurityException>()),
      );
    },
  );
  test(
    'wrong signature, audience, future timestamp and invalid version reject',
    () async {
      final envelope = jsonDecode(await sign(policy())) as Map<String, dynamic>;
      envelope['payload'] = base64Url.encode(
        utf8.encode(jsonEncode(policy(minimum: '0.0.0'))),
      );
      await expectLater(
        service.acceptPolicy(jsonEncode(envelope)),
        throwsA(isA<MiniAppSecurityException>()),
      );
      for (final change in [
        {'aud': 'other'},
        {'iat': now.millisecondsSinceEpoch ~/ 1000 + 1},
        {'minVersion': '1.1'},
        {'deniedAppIds': 'all'},
      ]) {
        await expectLater(
          service.acceptPolicy(await sign({...policy(), ...change})),
          throwsA(isA<MiniAppSecurityException>()),
        );
      }
    },
  );
  test(
    'launch strips signature and replay is rejected after service restart',
    () async {
      final url = await link();
      expect(
        (await service.authorizeLaunch(app, url)).toString(),
        '${app.url}/offer?item=1',
      );
      service.dispose();
      service = MiniAppSecurityService(config: config, now: () => now);
      await expectLater(
        service.authorizeLaunch(app, url),
        throwsA(isA<MiniAppSecurityException>()),
      );
    },
  );
  test('concurrent replay allows exactly one launch', () async {
    final url = await link();
    final results = await Future.wait(
      List.generate(3, (_) async {
        try {
          await service.authorizeLaunch(app, url);
          return true;
        } catch (_) {
          return false;
        }
      }),
    );
    expect(results.where((value) => value).length, 1);
  });
  test(
    'launch rejects target tampering, wrong audience and expired claims',
    () async {
      final url = await link();
      for (final bad in [
        url.replaceFirst('item=1', 'item=2'),
        await link(audience: 'evil'),
        await link(expires: now.millisecondsSinceEpoch ~/ 1000),
      ]) {
        await expectLater(
          service.authorizeLaunch(app, bad),
          throwsA(isA<MiniAppSecurityException>()),
        );
      }
    },
  );
  test(
    'unregistered manifests and added permissions cannot obtain a bridge',
    () {
      final forged = MiniAppEntity(
        id: app.id,
        name: app.name,
        description: '',
        url: app.url,
        iconUrl: '',
        category: app.category,
        permissions: [...app.permissions, MiniAppPermission.chatRead],
      );
      expect(service.blockedReason(forged), isNotNull);
    },
  );
  test(
    'remote refresh installs signed policy, refuses redirects and fails closed',
    () async {
      var mode = 0;
      final signed = await sign(policy(apps: [app.id]));
      final remote = MiniAppSecurityService(
        config: MiniAppSecurityConfig(
          policyUrl: 'https://config.n42.world/miniapps',
          policyPublicKeys: {'test': publicKey},
        ),
        now: () => now,
        client: MockClient((request) async {
          expect(request.followRedirects, isFalse);
          if (mode == 0)
            return http.Response(
              '',
              302,
              headers: {'location': 'https://evil.test'},
            );
          return http.Response(signed, 200);
        }),
      );
      addTearDown(remote.dispose);
      await remote.refresh();
      expect(remote.blockedReason(app), contains('unavailable'));
      mode = 1;
      await remote.refresh();
      expect(remote.blockedReason(app), contains('disabled'));
    },
  );
}
