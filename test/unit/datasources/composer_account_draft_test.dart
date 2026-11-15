import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

class _Reject extends InMemorySharedPreferencesStore {
  _Reject() : super.empty();
  bool reject = false;
  @override
  Future<bool> setValue(String type, String key, Object value) =>
      reject ? Future.value(false) : super.setValue(type, key, value);
  @override
  Future<bool> remove(String key) =>
      reject ? Future.value(false) : super.remove(key);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));
  test(
    'same room remains isolated across accounts; legacy stays unclaimed',
    () async {
      final store = PreferencesDataSource();
      await store.saveDraft('room', 'legacy');
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        isNull,
      );
      await store.saveAccountDraft(
        'room',
        'A',
        ownerUserId: '@a:test',
        isCurrent: () => true,
      );
      await store.saveAccountDraft(
        'room',
        'B',
        ownerUserId: '@b:test',
        isCurrent: () => true,
      );
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        'A',
      );
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@b:test',
          isCurrent: () => true,
        ),
        'B',
      );
      await store.saveAccountDraft(
        'room',
        '',
        ownerUserId: '@b:test',
        isCurrent: () => true,
      );
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        'A',
      );
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@b:test',
          isCurrent: () => true,
        ),
        isNull,
      );
      expect(await store.getDraft('room'), 'legacy');
    },
  );
  test('queued stale account write is rejected', () async {
    final store = PreferencesDataSource();
    var current = true;
    final pending = store.saveAccountDraft(
      'room',
      'stale',
      ownerUserId: '@a:test',
      isCurrent: () => current,
    );
    current = false;
    await expectLater(pending, throwsStateError);
    expect(
      await store.getAccountDraft(
        'room',
        ownerUserId: '@a:test',
        isCurrent: () => true,
      ),
      isNull,
    );
  });
  test('failed writes and deletion preserve previous durable value', () async {
    SharedPreferences.resetStatic();
    final platform = _Reject();
    SharedPreferencesStorePlatform.instance = platform;
    final store = PreferencesDataSource();
    await store.saveAccountDraft(
      'room',
      'original',
      ownerUserId: '@a:test',
      isCurrent: () => true,
    );
    platform.reject = true;
    for (final text in ['replacement', '']) {
      await expectLater(
        store.saveAccountDraft(
          'room',
          text,
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        throwsStateError,
      );
      expect(
        await store.getAccountDraft(
          'room',
          ownerUserId: '@a:test',
          isCurrent: () => true,
        ),
        'original',
      );
    }
  });
}
