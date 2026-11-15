import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Private, device-local annotations, isolated by server, account and friend.
class FriendDetailsStore {
  final String key;
  FriendDetailsStore(String homeserver, String accountId, String friendId)
    : key =
          'friend_details_${sha256.convert(utf8.encode(jsonEncode([homeserver, accountId, friendId])))}';

  Future<Map<String, dynamic>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    return raw == null
        ? <String, dynamic>{}
        : jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> save(Map<String, dynamic> details) async {
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setString(key, jsonEncode(details))) {
      throw StateError('Contact details were not saved');
    }
  }

  Future<Directory> _directory() async =>
      Directory(p.join((await getApplicationSupportDirectory()).path, key));

  Future<File> photo(String name) async {
    if (!RegExp(r'^\d+\.jpg$').hasMatch(name)) {
      throw ArgumentError('Invalid contact photo name');
    }
    return File(p.join((await _directory()).path, name));
  }

  Future<String> importPhoto(XFile image) async {
    final directory = await _directory();
    await directory.create(recursive: true);
    final (name, destination) = await _reservePhotoFile(directory);
    try {
      await image.saveTo(destination.path);
      return name;
    } catch (_) {
      if (await destination.exists()) await destination.delete();
      rethrow;
    }
  }

  /// Claims an unused timestamp name. Several photos imported together can
  /// read the same clock value (Windows ticks are coarse), and reusing a name
  /// would overwrite the earlier photo and list it twice.
  Future<(String, File)> _reservePhotoFile(Directory directory) async {
    var stamp = DateTime.now().microsecondsSinceEpoch;
    while (true) {
      final name = '$stamp.jpg';
      final file = File(p.join(directory.path, name));
      try {
        await file.create(exclusive: true);
        return (name, file);
      } on PathExistsException {
        // Taken. Checking exists() instead would race with a concurrent
        // import whose copy is replacing the reserved file.
        stamp++;
      } on FileSystemException {
        if (!await file.exists()) rethrow;
        stamp++;
      }
    }
  }

  Future<void> deletePhoto(String name) async {
    final file = await photo(name);
    if (await file.exists()) await file.delete();
  }
}
