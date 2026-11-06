import 'dart:io';
import 'dart:convert';

import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

class _Paths extends PathProviderPlatform {
  _Paths(this.root);
  final String root;
  @override
  Future<String?> getApplicationSupportPath() async => root;
}

class _Prefs extends Mock implements SharedPreferences {}

class _Source extends PreferencesDataSource {
  _Source(this.storage);
  final SharedPreferences storage;
  @override
  Future<SharedPreferences> get prefs async => storage;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory root;
  late Directory managed;
  late PathProviderPlatform previous;
  late PreferencesDataSource storage;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('n42_cleanup');
    managed = await Directory('${root.path}/scheduled_attachments').create();
    previous = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Paths(root.path);
    SharedPreferences.setMockInitialValues({});
    storage = PreferencesDataSource();
  });
  tearDown(() async {
    PathProviderPlatform.instance = previous;
    await root.delete(recursive: true);
  });
  Future<void> save(
    String path, {
    String id = 'one',
    String? owner = '@a:test',
    String room = 'room',
  }) => storage.saveScheduledMessage(
    ownerUserId: owner,
    roomId: room,
    messageId: id,
    text: 'file',
    type: MessageType.file,
    payload: {'localPath': path, 'filename': 'file'},
    scheduledAt: DateTime(2020),
  );
  Future<void> remove({
    String id = 'one',
    String? owner = '@a:test',
    String room = 'room',
  }) => storage.removeScheduledMessage(room, id, ownerUserId: owner);

  test('failed durable removal never deletes the attachment', () async {
    final file = await File('${managed.path}/file').writeAsString('keep');
    final prefs = _Prefs();
    when(() => prefs.reload()).thenAnswer((_) async {});
    when(() => prefs.getString(any())).thenReturn(
      jsonEncode({
        'room': [
          {
            'messageId': 'one',
            'payload': {'localPath': file.path},
          },
        ],
      }),
    );
    when(() => prefs.remove(any())).thenAnswer((_) async => false);
    await expectLater(
      _Source(prefs).removeScheduledMessage('room', 'one'),
      throwsStateError,
    );
    expect(await file.exists(), isTrue);
    verifyNever(() => prefs.getKeys());
  });
  test('unresolvable other reference defers cleanup', () async {
    final file = await File('${managed.path}/file').writeAsString('keep');
    await save(file.path);
    await save('${managed.path}/not-restored', id: 'two', owner: '@b:test');
    await remove();
    expect(await file.exists(), isTrue);
  });

  test('last managed reference is deleted after durable removal', () async {
    final file = await File('${managed.path}/file').writeAsString('keep');
    await save(file.path);
    await remove();
    expect(await file.exists(), isFalse);
    expect(
      await storage.getScheduledMessages('room', ownerUserId: '@a:test'),
      isEmpty,
    );
  });
  for (final owner in <String?>['@a:test', '@b:test', null]) {
    test(
      'shared reference in another room/account is preserved: $owner',
      () async {
        final file = await File('${managed.path}/file').writeAsString('keep');
        await save(file.path);
        await save(file.path, id: 'two', owner: owner, room: 'another');
        await remove();
        expect(await file.exists(), isTrue);
        await remove(id: 'two', owner: owner, room: 'another');
        expect(await file.exists(), isFalse);
      },
    );
  }
  test('external file and parent traversal are never deleted', () async {
    final file = await File('${root.path}/outside').writeAsString('keep');
    for (final path in [file.path, '${managed.path}/../outside']) {
      await save(path);
      await remove();
      expect(await file.readAsString(), 'keep');
    }
  });
  test('symlink is not followed or deleted', () async {
    final file = await File('${root.path}/outside').writeAsString('keep');
    final link = await Link('${managed.path}/link').create(file.path);
    await save(link.path);
    await remove();
    expect(await link.exists(), isTrue);
    expect(await file.readAsString(), 'keep');
  });
  test('symlink alias in another queue protects the target', () async {
    final file = await File('${managed.path}/file').writeAsString('keep');
    final alias = await Link('${root.path}/alias').create(file.path);
    await save(file.path);
    await save(alias.path, id: 'two', owner: '@b:test');
    await remove();
    expect(await file.exists(), isTrue);
  });
  test(
    'corrupt other queue defers cleanup without undoing cancellation',
    () async {
      final file = await File('${managed.path}/file').writeAsString('keep');
      await save(file.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('n42_chat_scheduled_messages', '{broken');
      await remove();
      expect(await file.exists(), isTrue);
      expect(
        await storage.getScheduledMessages('room', ownerUserId: '@a:test'),
        isEmpty,
      );
    },
  );
  test(
    'symlinked managed directory cannot authorize external deletion',
    () async {
      await managed.delete();
      final external = await Directory('${root.path}/external').create();
      await Link(managed.path).create(external.path);
      final file = await File('${external.path}/file').writeAsString('keep');
      await save('${managed.path}/file');
      await remove();
      expect(await file.exists(), isTrue);
    },
  );
}
