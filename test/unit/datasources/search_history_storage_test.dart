import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_search_datasource.dart';

class Manager extends Mock implements MatrixClientManager {}

class Client extends Mock implements matrix.Client {}

class RejectingStore extends InMemorySharedPreferencesStore {
  RejectingStore() : super.empty();
  String? failure;
  Future<bool> reject(Future<bool> Function() write) async {
    if (failure == 'false') return false;
    if (failure == 'throw') throw StateError('Rejected write');
    return write();
  }

  @override
  Future<bool> setValue(String type, String key, Object value) =>
      reject(() => super.setValue(type, key, value));
  @override
  Future<bool> remove(String key) => reject(() => super.remove(key));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Manager manager;
  late Client client;
  late MatrixSearchDataSource source;
  late String user;
  late String server;
  late String? token;
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'n42_chat_search_history': '["legacy secret"]',
    });
    manager = Manager();
    client = Client();
    user = '@alice:example.org';
    server = 'https://example.org';
    token = 'test-only';
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenAnswer((_) => user);
    when(() => client.homeserver).thenAnswer((_) => Uri.parse(server));
    when(() => client.accessToken).thenAnswer((_) => token);
    when(() => client.deviceID).thenReturn('device');
    source = MatrixSearchDataSource(manager);
  });
  tearDown(() => SharedPreferences.setMockInitialValues({}));
  for (final failure in ['false', 'throw']) {
    for (final mutation in ['save', 'delete', 'clear']) {
      test('$mutation rejects $failure and recovers queue and cache', () async {
        final platform = RejectingStore();
        SharedPreferencesStorePlatform.instance = platform;
        await source.saveSearchQuery('original');
        platform.failure = failure;
        final operation = switch (mutation) {
          'save' => source.saveSearchQuery('phantom'),
          'delete' => source.deleteSearchQuery('original'),
          _ => source.clearSearchHistory(),
        };
        await expectLater(operation, throwsStateError);
        expect(await source.getRecentSearches(), ['original']);
        platform.failure = null;
        await source.saveSearchQuery('retry');
        expect(await source.getRecentSearches(), ['retry', 'original']);
      });
    }
  }
  test(
    'isolates accounts and servers without adopting legacy history',
    () async {
      expect(await source.getRecentSearches(), isEmpty);
      await source.saveSearchQuery('alice secret');
      user = '@bob:example.org';
      expect(await source.getRecentSearches(), isEmpty);
      await source.saveSearchQuery('bob secret');
      user = '@alice:example.org';
      server = 'https://other.example.org';
      expect(await source.getRecentSearches(), isEmpty);
      server = 'https://example.org';
      expect(await source.getRecentSearches(), ['alice secret']);
      await source.clearSearchHistory();
      user = '@bob:example.org';
      expect(await source.getRecentSearches(), ['bob secret']);
    },
  );
  test(
    'serializes saves and deletes across instances and orders clear',
    () async {
      final other = MatrixSearchDataSource(manager);
      await Future.wait(
        List.generate(
          20,
          (i) => (i.isEven ? source : other).saveSearchQuery('$i'),
        ),
      );
      expect(
        await source.getRecentSearches(limit: 30),
        List.generate(20, (i) => '${19 - i}'),
      );
      await Future.wait([
        source.deleteSearchQuery('19'),
        other.saveSearchQuery('new'),
        source.clearSearchHistory(),
        other.saveSearchQuery('after'),
      ]);
      expect(await source.getRecentSearches(), ['after']);
    },
  );
  test('rejects queued work after account or credential changes', () async {
    final pending = source.saveSearchQuery('must not persist');
    user = '@bob:example.org';
    await pending;
    expect(await source.getRecentSearches(), isEmpty);
    user = '@alice:example.org';
    expect(await source.getRecentSearches(), isEmpty);
    final revoked = source.saveSearchQuery('revoked');
    token = null;
    await revoked;
    await source.saveSearchQuery('anonymous');
    expect(await source.getRecentSearches(), isEmpty);
    token = 'new-session';
    expect(await source.getRecentSearches(), isEmpty);
  });
  test('deduplicates, bounds history and accepts an empty limit', () async {
    for (var i = 0; i < 25; i++) {
      await source.saveSearchQuery('$i');
    }
    await source.saveSearchQuery('24');
    expect((await source.getRecentSearches(limit: 30)).length, 20);
    expect(await source.getRecentSearches(limit: 1), ['24']);
    expect(await source.getRecentSearches(limit: -1), isEmpty);
  });
}
