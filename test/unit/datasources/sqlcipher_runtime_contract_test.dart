import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:matrix/matrix.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test(
    'Matrix SDK database persists unkeyed data with the SQLCipher native asset',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'chat-matrix-native-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final path = '${directory.path}/matrix.db';
      sqfliteFfiInit();
      Future<MatrixSdkDatabase> open() async => MatrixSdkDatabase.init(
        'native-contract',
        database: await databaseFactoryFfi.openDatabase(path),
      );
      var db = await open();
      await db.storeAccountData('n42.contract', {'retained': true});
      await db.close();
      db = await open();
      expect((await db.getAccountData())['n42.contract']?.content, {
        'retained': true,
      });
      await db.close();
      expect(
        String.fromCharCodes((await File(path).readAsBytes()).take(16)),
        startsWith('SQLite format 3'),
      );
    },
  );
  test('native asset is SQLCipher and supports unkeyed SQLite', () {
    final db = sqlite3.openInMemory();
    addTearDown(db.close);
    final version = db.select('PRAGMA cipher_version');
    expect(
      version,
      isNotEmpty,
      reason: 'Archive encryption must never silently use plain SQLite',
    );
    // ignore: avoid_print -- retain the real loaded native version in test evidence.
    print('SQLCipher native asset: ${version.single.values.single}');
    db.execute('CREATE TABLE matrix_contract (value TEXT)');
    db.execute("INSERT INTO matrix_contract VALUES ('unkeyed Matrix storage')");
    expect(
      db.select('SELECT value FROM matrix_contract').single['value'],
      'unkeyed Matrix storage',
    );
  });

  test(
    'keyed file rejects wrong and missing keys and hides plaintext',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'chat-cipher-contract-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final path = '${directory.path}/keyed.db';
      final key = List.filled(64, 'a').join();
      final db = sqlite3.open(path);
      db.execute('PRAGMA key = "x\'$key\'"');
      db.execute('CREATE TABLE fixture (body TEXT)');
      db.execute("INSERT INTO fixture VALUES ('private historical message')");
      db.close();
      final bytes = await File(path).readAsBytes();
      expect(
        String.fromCharCodes(bytes).contains('private historical message'),
        isFalse,
      );
      expect(
        String.fromCharCodes(bytes.take(16)).startsWith('SQLite format 3'),
        isFalse,
      );
      for (final incorrect in [null, List.filled(64, 'b').join()]) {
        final wrong = sqlite3.open(path);
        if (incorrect != null) wrong.execute('PRAGMA key = "x\'$incorrect\'"');
        expect(
          () => wrong.select('SELECT body FROM fixture'),
          throwsA(isA<SqliteException>()),
        );
        wrong.close();
      }
      final correct = sqlite3.open(path);
      correct.execute('PRAGMA key = "x\'$key\'"');
      expect(
        correct.select('SELECT body FROM fixture').single['body'],
        'private historical message',
      );
      correct.close();
    },
  );
}
