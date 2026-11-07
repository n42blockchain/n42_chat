# Matrix 16 compatibility candidate — 2026-11-07

Status: isolated candidate only; not integrated into N42 Wallet or Beta 73423.

The official Pub package 16.0.1 (2026-11-06) fixes the sdp_transform constraint for LiveKit compatibility. Version 16 also changes archived-event decryption/backup retry and group-call teardown. Its breaking maybeAutoRequest API now accepts a Room; the application has no direct call sites for that method. No business source has been changed to make this candidate compile.

Changed the package and example from ^15.0.0 to ^16.0.1, preserving other dependency constraints and native crypto version. The first upgrade resolved the package but failed on the example's old ^15 declaration. After updating the example, flutter pub get resolves both lockfiles with only Matrix advancing. Full flutter analyze --no-pub --no-fatal-infos exits 0, with informational lints and no errors/warnings.

Full test/coverage execution is active using Flutter 3.47.8, four test isolates, a 4,096-file limit and the already built locked flutter_vodozemac 0.9 native library. Its final result is pending. This native-library override does not establish a packaged iOS/Android ABI result.

The SDK 15 production/frontend baseline remains unchanged. Previous 20-client/10,000-event load, account switch and key-recovery evidence is not SDK 16 acceptance. Before host integration, require full tests/coverage, current encrypted backup/restore/export and VoIP checks, real isolated protocol checks, host pin resolution and native builds. Do not infer compatibility from resolver/analyzer success alone.


## First full run and corrected native environment

The first full run ends with 8,593 passed, four skipped and two failed. Both failures are loader errors for flutter_vodozemac.framework: the global FRB directory held only libvodozemac_bindings_dart.dylib, shadowing explicit packaged-library paths with the other stem. It does not contain the packaged libflutter_vodozemac.dylib. A new temporary directory links the compiled bindings library and the actual packaged macOS library under their own stems; neither source/cache binary is modified or substituted. The packaged ABI and encrypted-document files then pass all 105 tests, exit 0. A full coverage rerun is active with that environment and a separately generated 200-image corpus. Its terminal result remains pending.

## Actual Matrix 16 protocol smoke

The existing E2EE tool exits 0 against the independent loopback server using resolved Matrix 16.0.1. Three accounts/five clients cover 16 decrypted deliveries, five opaque server-event checks, revoked-token rejection, retained historical keys but blocked new-session decryption for the revoked device, and actual app backup/restore. A validly encoded wrong recovery key is rejected; the right key restores four sessions into a fresh database and decrypts the historical message. This proves one isolated recovery, not thirty. Source/lock/private-log hashes: matrix16-local-e2ee-2026-11-07.json. Physical UI, push and production acceptance remain open.
