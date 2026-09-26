# Task 12 — public dependency and API migration

Base: `3cc19c12a7c9bbf2031270acca8e3922730b55a5`.
SDK: official Flutter 3.47.5 / Dart 3.13.4, explicit `/Users/jieliu/.codex/toolchains/flutter-3.47.5/flutter/bin` PATH.
Worktree: `/Users/jieliu/.codex/worktrees/n42-chat-dependency-completion`.

## Changes

- Upgraded file_picker 13.1.0, share_plus 13.3.0, permission_handler 13.0.2, go_router 18.0.1, equatable 3.0.0, cached_network_image 4.0.2, pro_image_editor 14.4.1, ML Kit face 0.15.1 / text 0.17.1 / translation 0.15.1 / selfie 0.12.1, Firebase Messaging 16.7.0 (platform interface 4.10.0), CallKit 3.1.6. Live pub.dev metadata is retained in task12-registry.json.gz.
- FilePicker uses the new multi-select list and single-file APIs. File length is awaited and unknown size fails closed; byte streams remain lazy. Existing encrypted-room size checks and downstream attachment limits remain in force. The editor theme now uses its required material_ui 1.1.1 types; app-wide themes are unchanged.
- Firebase permanent denial maps explicitly to denied. All five authorization states have assertions.
- CallKit uses typed sealed events and Android-localized accept/decline labels. A bounded 64-call metadata cache preserves metadata for id-only timeout/callback events, with timeout/decline/end/programmatic dismissal/dispose cleanup. Cold accept caching, duplicate hangup suppression, call IDs, ringtone handling and reinitialization remain covered. Hold/mute events were previously ignored; they remain ignored and are tested not to produce accept/end actions. No unused public control callbacks were added.
- Equatable 3.0.0's CHANGELOG claim about runtimeType conflicts with its actual implementation. Downloaded `lib/src/equatable.dart:50–58` retains runtimeType equality and hashing. Archive SHA256: `ea36e500cbf0ec18361deabca755434f73e42fe53c5130021c7e2d6b5ebe1702`. Auth event, state and user entity subtype tests pass without any compatibility abstraction. Same-value nonidentical instances also compare equal with matching hashes.
- Timed-status fixture stubs typed `Map<String, BasicEvent>` accountData, privacy policy loading, an owned status room and current presence. It asserts empty private status/account metadata and cleared public presence text while retaining unavailable presence; production privacy behavior was not changed.
- Fixed five new SDK warnings by awaiting futures within existing try/catch/finally scopes, including consuming a streamed HTTP response before closing its client. Flutter automatically added build/platform analyzer exclusions during pub get.

## Scope ruling and generation

The initial latest-generator solve failed: build_runner 2.16.1 requires analyzer >=13.3, whereas drift_dev compatible with sqlite3 2.x requires analyzer <11. Exact solver evidence: task12-target-solve.log.gz. Controller explicitly deferred the coupled generator upgrades to Task 13; this is a temporary task boundary, not a final cap. No new overrides were introduced.

Retained coupled family: Matrix 6.1.1, drift/drift_dev 2.31.0, sqlite3 2.9.4, flutter_vodozemac 0.6.0, vodozemac 0.5.0, FRB 2.11.1, secure storage 10.0.0. Current generators: build_runner 2.11.1, json_serializable 6.11.2, injectable_generator 2.9.1, mockito 5.6.3.

`dart run build_runner build --delete-conflicting-outputs` exited 0 in 64 seconds; `flutter gen-l10n` exited 0. No generated output was hand-edited; generation produced no tracked code diff. Generator warning about analyzer's Dart 3.11 support versus SDK Dart 3.13 is recorded under DEP-001 pending Task 13.

## Verification

Baseline solve succeeded; baseline analyzer: 284 informational/warning diagnostics including five warnings, no errors. Baseline timed-status test reproduced the accountData mock failure; fixing only accountData exposed the incomplete rooms/privacy fixture, which was then completed.

The API red run failed to compile on removed CallKit APIs and the added Firebase enum, with the log retained. Final focused run passed 57 tests across notification, equality, timed status, media byte resolution and encrypted attachment limits. A final dedicated CallKit boundary run also covers 64-entry retention.

Whole analyzer and full-suite final results are recorded below. Logs are gzip-compressed losslessly. One premature suite overlapped build_runner's temporary deletion of generated files; it was interrupted (exit 130) and rerun after generation completed. That interrupted log is retained and is not counted as final verification.

No native library was substituted or cache source modified. The standalone test command uses `ulimit -n 4096` and `flutter test --no-pub test/ --concurrency=4 --reporter expanded`. Opt-in live/native acceptance remains unverified; see DEP-001 and existing call/privacy acceptance issues. Nothing was pushed.

Final results: whole analyzer exit 0, 281 informational diagnostics, zero warnings/errors (two new intentional non-const equality fixture hints). Full suite exit 0: **6753 passed, 3 skipped**, 155 seconds. Focused suite exit 0: **57 passed**. The additional capacity regression was added after the full-suite CallKit file had loaded; the subsequent dedicated CallKit run passed **13/13**, including that new boundary. No production code changed after the full-suite run began. `git diff --check` passed.

Implementation HEAD: `8695597b3850275e28ed2c03fa18472724bb33ed`. The following documentation commit only records evidence.
