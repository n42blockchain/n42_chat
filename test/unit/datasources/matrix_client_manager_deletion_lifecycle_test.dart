import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

class _PausedDatabase extends Mock implements DatabaseApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('old SDK clear cannot erase a reopened same-name database', () async {
    SharedPreferences.setMockInitialValues({});
    final dir = await Directory.systemTemp.createTemp('chat-deletion-db-race-');
    addTearDown(() => dir.delete(recursive: true));
    if (!vod.isInitialized()) {
      final packageConfig = File('.dart_tool/package_config.json').absolute;
      final config = jsonDecode(await packageConfig.readAsString()) as Map;
      final pkg =
          (config['packages'] as List).firstWhere(
                (item) => item['name'] == 'flutter_vodozemac',
              )
              as Map;
      final root = packageConfig.uri
          .resolve(pkg['rootUri'] as String)
          .toFilePath();
      await Link('${dir.path}/libvodozemac_bindings_dart.dylib').create(
        '$root/macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/libflutter_vodozemac.dylib',
      );
      await vod.init(libraryPath: '${dir.path}/');
    }
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final manager = MatrixClientManager.instance;
    const name = 'N42DeletionRace';
    await manager.initialize(
      clientName: name,
      databasePath: dir.path,
      forceReinit: true,
    );
    final oldClient = manager.client!;
    final originalDatabase = oldClient.database;
    final clearEntered = Completer<void>();
    final releaseClear = Completer<void>();
    final paused = _PausedDatabase();
    when(() => paused.clear()).thenAnswer((_) async {
      clearEntered.complete();
      await releaseClear.future;
      await originalDatabase.clear();
    });
    when(() => paused.close()).thenAnswer((_) => originalDatabase.close());
    when(() => paused.delete()).thenAnswer((_) => originalDatabase.delete());
    oldClient.database = paused;

    final oldClear = manager.clearCapturedClientForDeletion(
      oldClient,
      () => true,
    );
    await clearEntered.future;
    var reopened = false;
    final reopening = manager
        .initialize(clientName: name, databasePath: dir.path, forceReinit: true)
        .then((_) => reopened = true);
    await Future<void>.delayed(Duration.zero);
    expect(reopened, isFalse);
    releaseClear.complete();
    expect(await oldClear, isTrue);
    await reopening;
    await manager.client!.database.storeAccountData('new-generation', {
      'value': 'keep',
    });

    await manager.initialize(
      clientName: name,
      databasePath: dir.path,
      forceReinit: true,
    );
    expect(
      (await manager.client!.database.getAccountData())['new-generation']
          ?.content,
      {'value': 'keep'},
    );
    final replaced = manager.client!;
    await manager.initialize(
      clientName: name,
      databasePath: dir.path,
      forceReinit: true,
    );
    expect(
      await manager.clearCapturedClientForDeletion(replaced, () => true),
      isFalse,
    );
    final latest = manager.client!;
    final latestDatabase = latest.database;
    final disposeClearEntered = Completer<void>();
    final releaseDisposeClear = Completer<void>();
    final pausedForDispose = _PausedDatabase();
    when(() => pausedForDispose.clear()).thenAnswer((_) async {
      disposeClearEntered.complete();
      await releaseDisposeClear.future;
      await latestDatabase.clear();
    });
    when(
      () => pausedForDispose.close(),
    ).thenAnswer((_) => latestDatabase.close());
    when(
      () => pausedForDispose.delete(),
    ).thenAnswer((_) => latestDatabase.delete());
    latest.database = pausedForDispose;
    final clearingBeforeDispose = manager.clearCapturedClientForDeletion(
      latest,
      () => true,
    );
    await disposeClearEntered.future;
    var disposed = false;
    final disposing = manager.dispose().then((_) => disposed = true);
    await Future<void>.delayed(Duration.zero);
    expect(disposed, isFalse);
    expect(manager.client, same(latest));
    releaseDisposeClear.complete();
    expect(await clearingBeforeDispose, isTrue);
    await disposing;
    expect(manager.client, isNull);
  });
}
