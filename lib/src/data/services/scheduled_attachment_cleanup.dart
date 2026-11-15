import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Called while the scheduled preference store is locked, after durable removal.
/// Uncertain ownership or references must leave the attachment intact.
class ScheduledAttachmentCleanup {
  static Future<void> deleteUnreferenced(
    String candidate,
    Set<String> references,
  ) async {
    final support = await getApplicationSupportDirectory();
    final root = p.normalize(
      p.absolute(p.join(support.path, 'scheduled_attachments')),
    );
    final path = p.normalize(p.absolute(candidate));
    if (!p.isAbsolute(candidate) || p.dirname(path) != root) return;
    if (await FileSystemEntity.type(root, followLinks: false) !=
            FileSystemEntityType.directory ||
        await FileSystemEntity.type(path, followLinks: false) !=
            FileSystemEntityType.file) {
      return;
    }
    final realRoot = await Directory(root).resolveSymbolicLinks();
    final realPath = await File(path).resolveSymbolicLinks();
    if (p.dirname(realPath) != realRoot) return;
    for (final reference in references) {
      if (p.normalize(p.absolute(reference)) == path) return;
      // Even an unavailable reference can be an alias through an inaccessible
      // directory. Defer rather than treating lookup failure as no reference.
      try {
        if (await File(reference).resolveSymbolicLinks() == realPath) return;
      } on FileSystemException {
        return;
      }
    }
    if (await FileSystemEntity.type(root, followLinks: false) !=
            FileSystemEntityType.directory ||
        await Directory(root).resolveSymbolicLinks() != realRoot ||
        await File(path).resolveSymbolicLinks() != realPath) {
      return;
    }
    // Recheck the leaf: never follow a symlink during deletion.
    if (await FileSystemEntity.type(path, followLinks: false) ==
        FileSystemEntityType.file) {
      await File(path).delete();
    }
  }
}
