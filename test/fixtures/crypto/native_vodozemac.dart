import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vodozemac/vodozemac.dart' as vod;

const _overrideVariable = 'N42_VODOZEMAC_TEST_LIB';

/// flutter_vodozemac ships a prebuilt native library only for macOS. Other
/// hosts run native crypto tests when [_overrideVariable] points at a library
/// built for that host; otherwise the tests are skipped with this reason.
final Object nativeVodozemacSkip =
    Platform.isMacOS || Platform.environment[_overrideVariable] != null
    ? false
    : 'Set $_overrideVariable to the native vodozemac library on this host.';

/// Loads native vodozemac once per test process.
///
/// The library is exposed under the bindings name inside [directory]. Windows
/// needs a privilege to create symlinks and cannot delete a loaded DLL, so
/// there the library is copied into its own temporary directory instead.
Future<void> initNativeVodozemac(Directory directory) async {
  if (vod.isInitialized()) return;
  final configFile = File('.dart_tool/package_config.json').absolute;
  final config =
      jsonDecode(await configFile.readAsString()) as Map<String, dynamic>;
  final package = (config['packages'] as List)
      .cast<Map<String, dynamic>>()
      .firstWhere((entry) => entry['name'] == 'flutter_vodozemac');
  final root = configFile.uri
      .resolve(package['rootUri'] as String)
      .toFilePath();
  final native =
      Platform.environment[_overrideVariable] ??
      p.join(
        root,
        'macos',
        'flutter_vodozemac',
        'flutter_vodozemac.xcframework',
        'macos-arm64_x86_64',
        'libflutter_vodozemac.dylib',
      );
  if (Platform.isWindows) {
    final libraryDirectory = await Directory.systemTemp.createTemp(
      'n42-vodozemac-',
    );
    await File(
      native,
    ).copy(p.join(libraryDirectory.path, 'vodozemac_bindings_dart.dll'));
    await vod.init(libraryPath: '${libraryDirectory.path}${p.separator}');
    return;
  }
  final suffix = Platform.isMacOS ? 'dylib' : 'so';
  await Link(
    p.join(directory.path, 'libvodozemac_bindings_dart.$suffix'),
  ).create(native);
  await vod.init(libraryPath: '${directory.path}${p.separator}');
}
