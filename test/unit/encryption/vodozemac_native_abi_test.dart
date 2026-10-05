import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vodozemac/flutter_vodozemac.dart' as flutter_vod;
import 'package:vodozemac/vodozemac.dart' as vod;
import 'package:matrix/encryption/utils/pickle_key.dart';

void main() {
  test(
    'packaged native Vodozemac completes FRB handshake and Megolm pickle round trip',
    () async {
      final config = File('.dart_tool/package_config.json');
      final packages =
          (jsonDecode(await config.readAsString())
                  as Map<String, dynamic>)['packages']
              as List<dynamic>;
      final package = packages.cast<Map<String, dynamic>>().singleWhere(
        (entry) => entry['name'] == 'flutter_vodozemac',
      );
      final root = Directory.fromUri(
        config.absolute.uri.resolve(package['rootUri'] as String),
      ).uri;
      final native = root.resolve(
        'macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/',
      );
      await flutter_vod.init(libraryPath: native.toFilePath());
      expect(vod.isInitialized(), isTrue);
      final legacy =
          jsonDecode(
                await File(
                  'test/fixtures/crypto/vodozemac-0.5-pickles.json',
                ).readAsString(),
              )
              as Map<String, dynamic>;
      final legacyKey = (legacy['user_id'] as String).toPickleKey();
      expect(base64Encode(legacyKey), legacy['public_pickle_key_base64']);
      final legacyAccount = vod.Account.fromPickleEncrypted(
        pickle: legacy['account_pickle'] as String,
        pickleKey: legacyKey,
      );
      expect(legacyAccount.ed25519Key.toBase64(), legacy['account_ed25519']);
      expect(
        legacyAccount.curve25519Key.toBase64(),
        legacy['account_curve25519'],
      );
      legacyAccount.ed25519Key.verify(
        message: legacy['plaintext'] as String,
        signature: vod.Ed25519Signature.fromBase64(
          legacy['signature'] as String,
        ),
      );
      expect(
        legacyAccount.sign(legacy['plaintext'] as String).toBase64(),
        legacy['signature'],
      );
      final legacyInbound = vod.InboundGroupSession.fromPickleEncrypted(
        pickle: legacy['inbound_pickle'] as String,
        pickleKey: legacyKey,
      );
      expect(legacyInbound.sessionId, legacy['session_id']);
      expect(
        legacyInbound.decrypt(legacy['ciphertext'] as String).plaintext,
        legacy['plaintext'],
      );
      final legacyOutbound = vod.GroupSession.fromPickleEncrypted(
        pickle: legacy['outbound_pickle'] as String,
        pickleKey: legacyKey,
      );
      expect(legacyOutbound.sessionId, legacy['session_id']);
      expect(
        legacyInbound
            .decrypt(legacyOutbound.encrypt('Continued after upgrade'))
            .plaintext,
        'Continued after upgrade',
      );
      expect(
        () => vod.Account.fromPickleEncrypted(
          pickle: legacy['account_pickle'] as String,
          pickleKey: Uint8List(32),
        ),
        throwsA(anything),
      );
      expect(
        () => vod.InboundGroupSession.fromPickleEncrypted(
          pickle: legacy['inbound_pickle'] as String,
          pickleKey: Uint8List(32),
        ),
        throwsA(anything),
      );
      final outbound = vod.GroupSession();
      final inbound = outbound.toInbound();
      final encrypted = outbound.encrypt('Native ABI encrypted message');
      expect(
        inbound.decrypt(encrypted).plaintext,
        'Native ABI encrypted message',
      );
      final key = Uint8List.fromList(List.filled(32, 7));
      final pickle = inbound.toPickleEncrypted(key);
      final restored = vod.InboundGroupSession.fromPickleEncrypted(
        pickle: pickle,
        pickleKey: key,
      );
      expect(
        restored.decrypt(encrypted).plaintext,
        'Native ABI encrypted message',
      );
      expect(
        () => vod.InboundGroupSession.fromPickleEncrypted(
          pickle: pickle,
          pickleKey: Uint8List(32),
        ),
        throwsA(anything),
      );
    },
    skip: !Platform.isMacOS
        ? 'Uses the official package macOS native artifact'
        : false,
  );
}
