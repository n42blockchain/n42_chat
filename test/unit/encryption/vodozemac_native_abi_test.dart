import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vodozemac/flutter_vodozemac.dart' as flutter_vod;
import 'package:vodozemac/vodozemac.dart' as vod;

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
