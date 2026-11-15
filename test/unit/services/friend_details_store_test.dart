import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n42_chat/src/core/services/friend_details_store.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _Paths extends PathProviderPlatform {
  _Paths(this.path);
  final String path;
  @override
  Future<String?> getApplicationSupportPath() async => path;
}

void main() {
  late Directory directory;
  late PathProviderPlatform originalPaths;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('friend-store-test');
    originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Paths(directory.path);
  });

  tearDown(() {
    PathProviderPlatform.instance = originalPaths;
    directory.deleteSync(recursive: true);
  });

  test('photos imported together get distinct files with their own bytes', () async {
    final store = FriendDetailsStore('https://hs.test', '@me:hs.test', '@friend:hs.test');
    final sources = [
      for (var i = 0; i < 4; i++)
        File(p.join(directory.path, 'source-$i.jpg'))..writeAsBytesSync([i, i, i]),
    ];

    // Concurrent imports read the clock at the same time; on hosts with a
    // coarse clock they used to share one name and overwrite each other.
    final names = await Future.wait([
      for (final source in sources) store.importPhoto(XFile(source.path)),
    ]);

    expect(names.toSet(), hasLength(sources.length));
    for (var i = 0; i < names.length; i++) {
      expect(names[i], matches(RegExp(r'^\d+\.jpg$')));
      expect(await (await store.photo(names[i])).readAsBytes(), [i, i, i]);
    }
  });
}
