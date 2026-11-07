# Matrix 16 compatibility candidate — 2026-11-07

Status: isolated candidate only; not integrated into N42 Wallet or Beta 73423.

The official Pub package 16.0.1 (2026-11-06) fixes the sdp_transform constraint for LiveKit compatibility. Version 16 also changes archived-event decryption/backup retry and group-call teardown. Its breaking maybeAutoRequest API now accepts a Room; the application has no direct call sites for that method. No business source has been changed to make this candidate compile.

Changed the package and example from ^15.0.0 to ^16.0.1, preserving other dependency constraints and native crypto version. The first upgrade resolved the package but failed on the example's old ^15 declaration. After updating the example, flutter pub get resolves both lockfiles with only Matrix advancing. Full flutter analyze --no-pub --no-fatal-infos exits 0, with informational lints and no errors/warnings.

The corrected complete test/coverage run exits 0 using Flutter 3.47.8, four test isolates and a 4,096-file limit: 8,596 passed, three opt-in live cases skipped, zero failures. Instrumented line coverage is 104,392/145,226 (71.882445%), above the unchanged 70% gate. The generated 200-image corpus executes in this run. Source/lock/log/LCOV and separate packaged/compiled library hashes are retained in matrix16-full-suite-2026-11-07.json. This does not establish packaged iOS/Android app acceptance.

The SDK 15 production/frontend baseline remains unchanged. Previous 20-client/10,000-event load, account switch and key-recovery evidence is not SDK 16 acceptance. Before host integration, require full tests/coverage, current encrypted backup/restore/export and VoIP checks, real isolated protocol checks, host pin resolution and native builds. Do not infer compatibility from resolver/analyzer success alone.


## First full run and corrected native environment

The first full run ends with 8,593 passed, four skipped and two failed. Both failures are loader errors for flutter_vodozemac.framework: the global FRB directory held only libvodozemac_bindings_dart.dylib, shadowing explicit packaged-library paths with the other stem. It does not contain the packaged libflutter_vodozemac.dylib. A new temporary directory links the compiled bindings library and the actual packaged macOS library under their own stems; neither source/cache binary is modified or substituted. The packaged ABI and encrypted-document files then pass all 105 tests, exit 0. The full coverage rerun with that environment and a separately generated 200-image corpus now passes as recorded above.

## Actual Matrix 16 protocol smoke

The existing E2EE tool exits 0 against the independent loopback server using resolved Matrix 16.0.1. Three accounts/five clients cover 16 decrypted deliveries, five opaque server-event checks, revoked-token rejection, retained historical keys but blocked new-session decryption for the revoked device, and actual app backup/restore. A validly encoded wrong recovery key is rejected; the right key restores four sessions into a fresh database and decrypts the historical message. This proves one isolated recovery, not thirty. Source/lock/private-log hashes: matrix16-local-e2ee-2026-11-07.json. Physical UI, push and production acceptance remain open.


## Matrix 16 load follow-up in progress

The twenty-client/10,000-event harness is now running again with Matrix 16.0.1, a new generated room/accounts, and a separate log on the owned port-18949 service. Its source and assertions are unchanged from the accepted SDK 15 run: independent databases, explicit transaction IDs, one offline recipient, exact unique/decrypted history checks. Final completion and exit code remain pending. The separate SDK 15 thirty-recovery batch has now completed with exit 0 and 30/30 correct restores plus 30/30 wrong-key rejections. Its record is local-tuwunel-e2ee-30-2026-11-07.json and is not SDK 16 recovery coverage.


## Final Matrix 16 group-load result

The separate full load run exits 0: 20 clients each verify 10,000 unique readable message events, including the offline recipient, for 200,000 verified deliveries. It includes 100 encrypted file events; attachment payload download is outside this harness. The captured isolated server log has zero generated message-canary prefixes. Send phase: 392,119 ms; total: 1,166,169 ms. Concurrent full-suite/analysis work means these timings are not a controlled SDK 15/16 performance comparison. Source/lock/client-log/server-log hashes and all recipient counts: matrix16-group-load-2026-11-07.json. Native UI, production, push and existing-database upgrade acceptance remain separate gates.


## Existing SDK 15 database opened by SDK 16

`tool/local_sdk_upgrade_smoke.dart` uses identical source in two separate Dart processes, with explicit SDK 15 and SDK 16 package maps. It verifies the actual resolved package version before IO. SDK 15 creates two synthetic accounts, independent SQLite stores and four encrypted messages; it disposes clients without logout to retain their original sessions. SDK 16 opens those exact stores with its HTTP transport blocked. Both device IDs and signing fingerprints remain unchanged, and all eight historical message reads succeed offline. Network is then enabled; two new messages are sent using the retained sessions, and all twelve combined history/new-message reads pass without a new password login. Both processes exit 0. Final logout/disposal succeeds and the private fixture directory is removed.

Eight pre-network configuration guards pass; scoped analysis is clean. This proves SDK/SQLite/crypto compatibility, not migration of native app keychain/preferences or physical UI. Source and both private-log hashes: matrix15-to16-database-upgrade-2026-11-07.json. To reproduce, create an empty mode-0700 `n42-sdk-upgrade-*` directory outside Git, supply the owned loopback homeserver/registration token privately, and run the same file first with `N42_QA_UPGRADE_MODE=seed` under the SDK 15 package configuration, then with `verify` under SDK 16. The tool rejects other SDK versions and existing account credentials.
