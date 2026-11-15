import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

class _Prefs extends Mock implements SharedPreferences {}

class _Source extends PreferencesDataSource {
  final SharedPreferences backend;
  _Source(this.backend);
  @override
  Future<SharedPreferences> get prefs async => backend;
}

void main() {
  late _Prefs prefs;
  late Map<String, String> durable;
  late Map<String, String> cache;
  Completer<void>? writeGate;
  late bool rejectWrite;
  setUp(() {
    prefs = _Prefs();
    durable = {};
    cache = {};
    writeGate = null;
    rejectWrite = false;
    when(() => prefs.reload()).thenAnswer((_) async {
      cache = Map.of(durable);
    });
    when(() => prefs.getString(any()))
        .thenAnswer((i) => cache[i.positionalArguments.first]);
    when(() => prefs.setString(any(), any())).thenAnswer((i) async {
      final key = i.positionalArguments[0] as String;
      final value = i.positionalArguments[1] as String;
      cache[key] = value;
      await writeGate?.future;
      if (rejectWrite) return false;
      durable[key] = value;
      return true;
    });
    when(() => prefs.remove(any())).thenAnswer((i) async {
      final key = i.positionalArguments.first as String;
      cache.remove(key);
      await writeGate?.future;
      if (rejectWrite) return false;
      durable.remove(key);
      return true;
    });
  });
  Future<void> save(
    _Source source,
    String id, {
    String room = 'room',
    String text = 'draft',
  }) => source.saveScheduledMessage(
    roomId: room,
    messageId: id,
    text: text,
    scheduledAt: DateTime(2020),
  );

  test('all instances preserve 100 concurrent saves and 50 removals', () async {
    final a = _Source(prefs), b = _Source(prefs);
    await Future.wait(List.generate(100, (i) => save(i.isEven ? a : b, '$i')));
    await Future.wait([
      for (var i = 0; i < 50; i++) a.removeScheduledMessage('room', '$i'),
      for (var i = 100; i < 150; i++) save(b, '$i'),
    ]);
    final restored = await _Source(prefs).getScheduledMessages('room');
    expect(restored.map((draft) => draft.messageId).toSet(), {
      for (var i = 50; i < 150; i++) '$i',
    });
    expect(restored, hasLength(100));
  });

  test(
    'reads and cancellation wait for a pending save acknowledgement',
    () async {
      final a = _Source(prefs), b = _Source(prefs);
      await save(a, 'old');
      writeGate = Completer<void>();
      final saving = save(a, 'new');
      await Future<void>.delayed(Duration.zero);
      final cancel = b.removeScheduledMessage('room', 'old');
      var readFinished = false;
      final reading = b.getDueScheduledMessages().then((value) {
        readFinished = true;
        return value;
      });
      await Future<void>.delayed(Duration.zero);
      expect(readFinished, isFalse);
      writeGate!.complete();
      await Future.wait([saving, cancel]);
      expect((await reading).map((draft) => draft.messageId), ['new']);
    },
  );

  test(
    'room clear cannot overwrite a concurrently saved draft in another room',
    () async {
      final a = _Source(prefs), b = _Source(prefs);
      await save(a, 'removed', room: 'old');
      writeGate = Completer<void>();
      final saving = save(b, 'kept', room: 'new');
      final clearing = a.clearScheduledMessages('old');
      writeGate!.complete();
      await Future.wait([saving, clearing]);
      expect(await a.getScheduledMessages('old'), isEmpty);
      expect((await b.getScheduledMessages('new')).single.messageId, 'kept');
    },
  );

  test(
    'same draft ID is replaced once without changing another room',
    () async {
      final a = _Source(prefs);
      await save(a, 'same', text: 'first');
      await save(a, 'same', room: 'other');
      await save(_Source(prefs), 'same', text: 'updated');
      expect((await a.getScheduledMessages('room')).single.text, 'updated');
      expect((await a.getScheduledMessages('other')).single.text, 'draft');
    },
  );

  test(
    'failed save never appears as durable and does not poison the queue',
    () async {
      final a = _Source(prefs);
      rejectWrite = true;
      await expectLater(save(a, 'failed'), throwsStateError);
      expect(await a.getScheduledMessages('room'), isEmpty);
      rejectWrite = false;
      await save(a, 'retry');
      expect((await a.getDueScheduledMessages()).single.messageId, 'retry');
    },
  );

  for (final otherRoom in [false, true]) {
    test(
      'failed clear preserves durable drafts and can retry: other=$otherRoom',
      () async {
        final a = _Source(prefs);
        await save(a, 'keep');
        if (otherRoom) await save(a, 'other', room: 'other');
        rejectWrite = true;
        await expectLater(a.clearScheduledMessages('room'), throwsStateError);
        expect(
          (await _Source(prefs).getScheduledMessages('room')).single.messageId,
          'keep',
        );
        rejectWrite = false;
        await a.clearScheduledMessages('room');
        expect(await a.getScheduledMessages('room'), isEmpty);
        if (otherRoom) {
          expect(
            (await a.getScheduledMessages('other')).single.messageId,
            'other',
          );
        }
      },
    );
  }
}
