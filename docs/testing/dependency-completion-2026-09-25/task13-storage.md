# Task 13A — coupled Matrix, SQLite and crypto migration

Base: `fb53754379ffa3984a2fe1ad79dca3477bde2b77`. Atomic implementation commit: `49ff48b2093e04b215e6b8bf65714fd6da3c867a`. Work is confined to the official Chat isolated worktree. No host source, cache package, mirror, or remote was modified.

## Resolved graph and generation

Flutter **3.47.5**, Dart **3.13.4**, explicit SDK `/Users/jieliu/.codex/toolchains/flutter-3.47.5/flutter/bin`.

| Family | Resolved stable version |
| --- | --- |
| matrix | 13.0.0 |
| drift / drift_dev | 2.35.0 |
| sqlite3 | 3.6.0 |
| sqflite_common_ffi | 2.4.3 |
| flutter_vodozemac / vodozemac | 0.8.1 / 0.8.0 |
| flutter_rust_bridge | **2.13.0 exact** |
| build_runner | 2.16.1 |
| json_serializable | 6.14.1 |
| mockito | 5.8.1 |
| injectable / injectable_generator | 3.0.0 / 3.1.3 |

Versions were checked against live official pub.dev metadata (`task13-registry.json`). The atomic graph resolves without a new override. `sqlcipher_flutter_libs` is removed. Existing secure-storage 10 constraints/override remain for the separately authorized Task 13B; they are not a final cap. There is no existing direct freezed dependency to upgrade.

`flutter pub get` also resolves the example. Its old direct Matrix 6 constraint initially rejected Matrix 13; it now matches 13. Normal `dart run build_runner build --delete-conflicting-outputs` succeeded and regenerated both Drift outputs. build_runner 2.16 reports the legacy flag removed/ignored; no generated source was hand edited.

## Runtime adaptations

- Matrix `PowerLevel.level` preserves integer permission values, including negative and large exact values. Regression tests cover the integer boundary values and existing token-gate/group behavior.
- Member transitions read `unsigned.prev_content` and avoid treating a repeated join as a new member. The test constructs the SDK sync event from real JSON.
- TURN `Uri` values become strings at the existing WebRTC boundary, including refresh. Event reports preserve reason; the removed SDK `score` argument is no longer passed.
- Matrix 6→13 changelogs and used APIs were inspected. Chat has no `loadArchive`/SDK archived-room-cache consumer or direct `initCryptoIdentity` call to adapt. Its historical search uses the independent archive database; its configurable `includeLeaveRooms` sync flag is retained. `MatrixClientManager` still awaits native Vodozemac initialization before `Client.init()` and keeps existing crypto setup.
- sqlite3 native hooks replace Android process-local overrides in archive and background media connections. The archive still probes real `cipher_version`, requires its retained key, verifies encrypted copies, preserves unreadable sources, and never falls back to plaintext.
- Failure tests found `LazyDatabase.close()` can rethrow a failed opening future. Singleton cleanup now runs in `finally`, allowing a later correct-key retry without deleting history or changing keys. Wrong/missing-key tests prove both preserved ciphertext and successful later recovery.
- Failed SQLCipher export exceptions include the key-bearing ATTACH statement. The local debug log now records only the exception type; the original failure still propagates.

## Real native evidence

The sqlite3 hook emitted `package:sqlite3/src/ffi/libsqlite3.g.dart` backed by `.dart_tool/hooks_runner/shared/sqlite3/build/download-ddfec276/libsqlcipher.dylib`. The loaded runtime reports **SQLCipher 4.19.0 community**; asset SHA-256 `ddfec276b19d034f3e6432eeb09dabb2e3ddcd34f9b798da548c30489614c858`.

A genuine **4.10.0 community** writer was compiled in ignored scratch storage from the existing host CocoaPods 4.10 amalgamation, accessed read-only. The generated synthetic ciphertext and reproducible writer are committed under `test/fixtures/archive/`; its README records source, binary and fixture hashes and the public test key. The writer asserts its actual cipher version before writing. This is not a fixture written by 4.19 and labeled as old.

Production `ArchiveDatabase.getInstance()` tests exercise old ciphertext read/FTS search, wrong/missing keys, correct-key recovery, plaintext conversion with preserved schema version/search history, encrypted output/reopen, and export failure preserving original bytes. Only path-provider and secure-storage access are mocked; SQLCipher and Drift I/O are real. Matrix's actual `MatrixSdkDatabase` also writes and reopens unkeyed account data through sqflite_common_ffi with this library.

The official flutter_vodozemac 0.8.1 package's macOS universal library is `macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/libflutter_vodozemac.dylib`, SHA-256 `fbbb5e1227d718e872ecca9661b426c4149f93b29ccdde97f07baca259ccc55d`. Its real FRB handshake, Megolm encryption/decryption, encrypted pickle reopen, and wrong-key rejection pass. Existing native test helpers now reference this package's new dylib layout. No unrelated binary or ABI substitution is used.

## Host boundary and remaining work

Chat and its example declare sqlite3 hook `source: sqlcipher`. A consuming host must configure its own entrypoint hooks. The known Android host already ships `libsqlcipher.so` in its native AAR; do not bundle a second same-named native asset or hide the conflict with arbitrary `pickFirst`. Task 14 must validate the host mapping:

```yaml
hooks:
  user_defines:
    sqlite3:
      source:
        android: system
        ios: executable
        default: sqlcipher
      name:
        android: sqlcipher
```

Host iOS must retain SQLCipher force-load/executable symbol availability. Android/iOS build and device validation are outside the macOS native evidence here; they remain explicit Task 14 acceptance work.

Secure storage 11 is split into **Task 13B** by controller ruling: historical host v9 EncryptedSharedPreferences credentials require a verified legacy import path and actual Android upgrade tests, while facebook_auth_desktop also constrains 10.x. No reader removal or namespace migration is attempted here. DEP-002's recipient-less background callback remains open for Task 15.

## Verification and failed attempts

- Focused database, encryption, Matrix/group and archive-search tests: **174 passed**, no skips (`task13-focused-final.log.gz`).
- Final analyzer: **exit 0, 288 infos, zero warnings/errors** (four new informational notices are sqlite3’s still-supported `dispose()` deprecation) (`task13-analyze-final.log.gz`).
- Direct-friendship real SDK fixtures: **30 passed** (`task13-direct-friendship-final.log.gz`). Matrix 13 requires a non-null database and reads the real default `getDisplayNameAndAvatarFromPrevContent = true`; fixture stubs now match an empty database and that default. Production behavior was not changed for the tests.
- First full suite: 6777 passed, 3 skipped, 3 failed in those incomplete mock fixtures. Final full suite rerun: **6780 passed, 3 existing skips, zero failures, exit 0, 141 seconds** (`task13-full-final.log.gz`).
- Initial API compile errors, stale-singleton test failures, and test-loader setup failures are retained in compressed logs. The loader attempts failed first because Flutter test does not support `Isolate.resolvePackageUri`, then because a package-root URI lacked directory semantics. Final tests resolve `package_config.json` correctly. Existing crypto tests initially used the old framework layout and were updated to the published dylib path. No failing/skipped test is counted as passed.
- The first standalone legacy-writer compile omitted SQLCipher's required EXTRA_INIT/EXTRA_SHUTDOWN defines; the successful command includes them in the fixture README.

Commands used (from the Chat worktree, explicit SDK on PATH):

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test test/unit/datasources/archive_sqlcipher_migration_test.dart \
  test/unit/datasources/archive_database_migration_guard_test.dart \
  test/unit/datasources/sqlcipher_runtime_contract_test.dart test/unit/encryption \
  test/unit/datasources/matrix_group_datasource_test.dart \
  test/unit/repositories/search_archive_filter_behavior_test.dart \
  test/unit/repositories/group_token_gate_behavior_test.dart \
  test/unit/repositories/group_repository_impl_test.dart --reporter expanded
flutter test test/unit/datasources/direct_friendship_test.dart --reporter expanded
flutter analyze --no-fatal-infos
ulimit -n 4096
flutter test test/ --concurrency=4 --reporter expanded
```

No extra native-library environment override is required on macOS: tests resolve the official package artifact and sqlite3's generated hook asset. The native ABI test explicitly skips non-macOS hosts, where a platform-specific native artifact test remains necessary.

## Independent review fix — preservation and historical crypto fixtures

Review base: `a54624c3b47a928a4b7410f5ac4a8acb5284ecaf`.

The reviewer identified a pre-existing preservation violation: a valid-format wrong archive key caused verification to fail, but a plaintext backup older than seven days was still shredded. The new regression uses real old encrypted ciphertext and a real plaintext database backup aged 30 days. It reproduced the deletion before the fix (`task13-review-backup-red.log.gz`). Missing-key handling follows an earlier rejection path and was covered separately.

Removed age-based backup deletion entirely. Failed keyed verification now preserves both ciphertext and plaintext backup byte-for-byte regardless of age. Tests prove correct-key recovery subsequently opens history and only then permits backup cleanup. No reset, plaintext fallback, or key replacement was added. All four sqlite3 `dispose()` calls were updated to `close()`.

The crypto fixture gap is now covered with genuine old native data. An isolated writer resolved exact vodozemac 0.5.0 / FRB 2.11.1 and loaded the previously shipped flutter_vodozemac 0.6.0 framework. It generated synthetic encrypted **Account**, **inbound Megolm**, and **outbound Megolm** pickles using Matrix 6's actual persisted key derivation. The writer source, exact lockfile, public fixture and package/native hashes are under `test/fixtures/crypto/`. The new native test derives the key through current Matrix's production `toPickleKey`, imports all three old pickles, preserves both identity public keys, verifies/reproduces the old signature, decrypts historical ciphertext and continues the outbound session. Wrong keys are rejected. This is native pickle compatibility evidence, not Android secure-storage migration evidence.

Generation cleanup: use `dart run build_runner build` without the removed flag. `build.yaml` explicitly limits sources to package/lib/test/example-lib/pubspec so `example/.dart_tool` artifacts are not builder inputs. Generation succeeded with no tracked generated-source changes; `task13-review-generation.log.gz` contains neither obsolete-option nor cache-input warnings.

Review-fix verification:

- Focused native/database/crypto/Matrix/group/archive regression: **176 passed**, zero skipped/failed (`task13-review-focused-final.log.gz`).
- Analyzer: **exit 0, 284 infos, zero warnings/errors** (`task13-review-analyze-final.log.gz`); all four new SQLite deprecation notices are removed.
- Original failed backup regression, legacy harness resolution/generation and successful generation are retained as separate compressed logs.
- No full-suite rerun in this scoped fix round: production changes only remove unsafe backup expiry and use equivalent SQLite close APIs; affected archive/native/crypto paths have focused regression coverage. The **6780 pass / 3 skip** full-suite result above belongs to the pre-review implementation, not this revised HEAD.
- Secure storage 11 remains Task 13B; host Android/iOS native selection/device acceptance remains Task 14. No push or host-source edit.
