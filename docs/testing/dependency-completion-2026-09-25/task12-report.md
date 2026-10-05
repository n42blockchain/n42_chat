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


## Review repair — missed-call callback routing (2026-09-26)

Review base: `c25a9afc25fb80bedc2059b8b542cb5befe11560`. The earlier timeout-cleanup assertion was wrong: CallKit 3 emits an ID-only callback, so removing metadata at timeout prevented CallManager from finding the room. In addition, CallManager's pre-existing showMissedCall path generated a different ID and omitted the room. This repair supersedes the timeout cleanup description above.

The actual CallManager → showMissedCall → callback path now preserves its call ID and room. Minimal routing is stored using the project's FlutterSecureStorage Android defaults / iOS first_unlock_this_device accessibility. The cache contains only accountId, callId, roomId, callerId, isVideo and expiry; no display names, avatars, tokens or call history. It holds at most 64 total records, rejects entries at 24 hours, serializes read-modify-write operations and persists consumption before dispatch. Read/consume-write failures, malformed storage, unknown accounts and mismatched accounts do not dial. Native end/decline and programmatic dismissal invalidate routing; a suppressed late end event cannot recreate it. Account changes between incoming and timeout cannot rebind an old route to another account.

Service disposal removes memory state but preserves valid encrypted routing. A callback received before account binding retains only its ID for up to 90 seconds. CallManager attaches its subscriber and initializes WebRTC before binding the current account, so a valid early callback can replay through the actual outgoing-call path. Tests reconstruct service/manager state and verify the outgoing native call's caller/room; WebRTC room lookup is stubbed unavailable after routing, so no real microphone, remote call or native process restart is claimed.

The background push contract currently supplies no recipient account or push-registration identifier. Existing queued background payloads cannot safely be assigned to whichever session is active. Such background-only notifications without a previously bound callback record fail closed; this is explicitly tested and tracked as **DEP-002**. CallKit 3.1.6's Android receiver still sends a Bundle, but Dart `_receiveCallEvent` discards callback metadata; timed-out calls are removed from `activeCalls` and there is no public missed-call retrieval API. No speculative recipient field or gateway change was introduced. Thus the repaired cold-restart path is for already account-bound records, not every background/terminated notification.

Regression evidence: the original review-base production files fail both the timeout-routing and actual-manager-routing assertions (`task12-review-behavior-red.log.gz`). A separate regression exposed recaching on an ignored late end event and failed before that fix (`task12-review-late-end-red.log.gz`). Final focused verification covers callback consumption, cache recreation, cold/early account binding, mismatch, switch during I/O, switch before timeout, 24h expiry, 90s pending expiry, capacity eviction, storage failure, real manager routing and absent background provenance. Native Keychain/Keystore persistence and device notification delivery remain acceptance gaps.

Review repair final verification: **33 focused tests passed**; whole analyzer exit 0, **284 infos / 0 warnings / 0 errors**; standalone full suite exit 0, **6769 passed / 3 skipped / 0 failures**, 145 seconds. No native library substitution. An intermediate suite was interrupted before the late-end regression fix; only task12-review-full-suite.log.gz is the final repair suite. The earlier callback-green log is an interrupted intermediate fake-time test; the final targeted run supersedes it. `git diff --check` passed.
