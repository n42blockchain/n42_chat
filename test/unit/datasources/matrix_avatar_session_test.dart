import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vodozemac/vodozemac.dart' as vod;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final replaced in [true, false]) {
    for (final sdkFails in [false, true]) {
      for (final changeDuringFallback in [false, true]) {
        if (changeDuringFallback && (replaced || !sdkFails)) continue;
        final reject = replaced || changeDuringFallback;
        test(
          'avatar upload session replaced=$replaced SDK failure=$sdkFails fallback switch=$changeDuringFallback',
          () async {
            SharedPreferences.setMockInitialValues({});
            final dir = await Directory.systemTemp.createTemp(
              'chat-avatar-session-',
            );
            addTearDown(() => dir.delete(recursive: true));
            if (!vod.isInitialized()) {
              final packageConfig = File('.dart_tool/package_config.json')
                  .absolute;
              final config =
                  jsonDecode(await packageConfig.readAsString()) as Map;
              final pkg = (config['packages'] as List).firstWhere(
                (item) => item['name'] == 'flutter_vodozemac',
              ) as Map;
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
            const name = 'N42AvatarSession';
            await manager.initialize(
              clientName: name,
              databasePath: dir.path,
              forceReinit: true,
            );

            addTearDown(manager.dispose);
            final client = manager.client!;
            final entered = Completer<void>();
            final release = Completer<void>();
            var profileWrites = 0;
            client.httpClient = MockClient((request) async {
              if (request.url.path.endsWith('/media/v3/upload')) {
                entered.complete();
                await release.future;
                if (sdkFails) {
                  return http.Response(
                    '{"errcode":"M_UNKNOWN","error":"synthetic"}',
                    500,
                  );
                }
                return http.Response(
                  jsonEncode({'content_uri': 'mxc://example/avatar'}),
                  200,
                );
              }
              if (request.url.path.contains('/profile/')) {
                if (request.method == 'PUT') profileWrites++;
                return http.Response(
                  jsonEncode({
                    'displayname': 'QA',
                    'avatar_url': 'mxc://example/avatar',
                  }),
                  200,
                );
              }
              if (request.url.path.endsWith('/sync')) {
                return http.Response(
                  jsonEncode({
                    'next_batch': 'qa',
                    'rooms': <String, dynamic>{},
                  }),
                  200,
                );
              }
              if (request.url.path.endsWith('/versions')) {
                return http.Response(
                  jsonEncode({
                    'versions': ['v1.11'],
                  }),
                  200,
                );
              }
              if (request.url.path.endsWith('/keys/upload')) {
                final body = jsonDecode(request.body) as Map;
                final count = (body['one_time_keys'] as Map?)?.length ?? 0;
                return http.Response(
                  jsonEncode({
                    'one_time_key_counts': {'signed_curve25519': count},
                  }),
                  200,
                );
              }
              if (request.url.path.endsWith('/filter')) {
                return http.Response('{"filter_id":"qa"}', 200);
              }
              return http.Response('{}', 200);
            });
            await client.init(
              newToken: 'synthetic-first',
              newUserID: '@qa:example',
              newDeviceID: 'QA',
              newHomeserver: Uri.parse('https://example.invalid'),
              waitForFirstSync: false,
            );
            client.backgroundSync = false;
            await client.abortSync();
            var fallbackCalls = 0;
            final update = http.runWithClient(
              () => manager.setAvatar(
                Uint8List.fromList([1, 2, 3]),
                'avatar.png',
              ),
              () => MockClient((request) async {
                fallbackCalls++;
                if (changeDuringFallback) {
                  client.accessToken = 'synthetic-second';
                }
                expect(
                  request.headers['Authorization'],
                  'Bearer synthetic-first',
                );
                return http.Response(
                  jsonEncode({'content_uri': 'mxc://example/fallback'}),
                  200,
                );
              }),
            );
            final checked = expectLater(
              update,
              reject ? throwsStateError : completes,
            );
            await entered.future;
            if (replaced) client.accessToken = 'synthetic-second';
            release.complete();
            await checked;
            expect(profileWrites, reject ? 0 : 1);
            expect(fallbackCalls, !replaced && sdkFails ? 1 : 0);
          },
        );
      }
    }
  }
}
