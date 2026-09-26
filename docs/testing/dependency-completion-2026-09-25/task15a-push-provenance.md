# Task 15A — background call recipient provenance (DEP-002)

Date: 2026-09-26. Official Chat branch: `codex/dependency-completion-20260925`, base `e71e59ea3ab33fa0c0681baebe4ab38ece019014`. Source commits: `66236336` (secure push recipient bindings), `a089fc1e` (isolated missed-call records), `e296abe0` (recipient-bound background calls), `2b92a2d4` (preserve verified binding on restart), `cb8aaab7` (validate early accepts). Review 2 added only test commit `658c810e` (prove manager dispatch). No deployment was performed.

## Client behavior

Matrix 13 pusher registration sends flat `n42_receiver_account_id` and `n42_push_binding_id` strings in `data.default_payload`. The client snapshots account/device across token retrieval and registration, and activates the local binding only after `getPushers()` echoes both fields on the matching pusher. Routine startup with the same account, token and verified pusher reuses its unexpired binding, preserving saved missed-call routes. Account switch, token or echoed-field mismatch, explicit re-registration, logout and expiry revoke or rotate as appropriate. A transient echo failure does not claim verification or destroy the still-valid local binding.

A background call route is retained only when recipient account, binding, room and caller match; secure records have separate account/native-UUID keys and expire after 24 hours. Different calls no longer share a read/modify/write index that can lose concurrent writes. An A callback cannot use B's record even when remote call/event IDs coincide. A tagged native accept arriving before account initialization is validated against the stored route, held for the matching account, and checked again at consumption, including after a late binding revocation. Duplicate consumption is bounded. Untagged background accepts fail closed; only an authenticated foreground call can accept without native provenance tags. Android `event_id_only` semantics and notification privacy are unchanged, and no background decryption or event-type inference was added.

Delete-before-dispatch prevents routine duplicate foreground handling, but a crash after deletion can lose the action; secure storage offers no atomic cross-isolate take. The separate-key design addresses concurrent writes for different calls, not distributed exactly-once delivery.

## Verification chronology

All times below are 2026-09-26 EDT. Toolchain: Flutter 3.47.5 / Dart 3.13.4. The [evidence archive](task15a-evidence.tar.gz) contains the actual RED/GREEN logs, failed focused fixture, intermediate runs, and final analysis/full-suite logs. All log members use relative `logs/...` paths; `MANIFEST.sha256` is at the archive root. [Member hashes](task15a-evidence.MANIFEST.sha256) and [archive hash](task15a-evidence.tar.gz.sha256) are retained alongside it.

| Checkpoint | Result | Archive log |
| --- | --- | --- |
| 14:21:54, initial source | 91 focused tests passed | `logs/task-15a-focused.log` |
| 14:23:38, initial source | Analyzer exit 0; 285 infos, no warnings/errors | `logs/task-15a-analyze.log` |
| 14:26:26, initial source | Full suite 6,797 passed, 3 skipped | `logs/task-15a-full-suite.log` |
| 14:52:15, lifecycle repairs | 103 focused tests passed | `logs/task-15a-review1-focused-final.log` |
| 14:52:41, lifecycle repairs | Analyzer exit 0; 285 infos, no warnings/errors | `logs/task-15a-review1-analyze-final.log` |
| 14:55:39, lifecycle repairs | Full suite 6,807 passed, 3 skipped | `logs/task-15a-review1-full-suite-final.log` |
| 15:02:02, manager assertion RED control | Deliberately disabling pending-answer dispatch caused the new test to fail on absent `WebRTCService.answerCall()` method entry | `logs/task-15a-review2-manager-red.log` |
| 15:02:19, restored production source | Single manager test passed | `logs/task-15a-review2-manager-green.log` |
| 15:03:07, final test source | 103 focused tests passed; source was then committed as `658c810e` | `logs/task-15a-review2-focused-final.log` |

Run from the Chat repository with the isolated toolchain. The final focused command was:

```sh
/Users/jieliu/.codex/toolchains/flutter-3.47.5/flutter/bin/flutter test --no-pub test/unit/services/push_registration_provenance_test.dart test/unit/services/push_recipient_binding_store_test.dart test/unit/services/missed_call_callback_store_test.dart test/unit/services/call_notification_service_test.dart test/unit/services/firebase_push_service_test.dart test/unit/services/background_call_kit_test.dart
```

The review 1 full-suite and analyzer commands were:

```sh
/Users/jieliu/.codex/toolchains/flutter-3.47.5/flutter/bin/flutter test --no-pub
/Users/jieliu/.codex/toolchains/flutter-3.47.5/flutter/bin/flutter analyze --no-fatal-infos
```

Initial RED logs cover the missing binding, shared-record write race, registration provenance, and background routing. Review 1 RED logs reproduce same-account binding rotation, early valid accept loss, untagged legacy accept borrowing a later login, and acceptance after revocation; matching GREEN logs are in the archive. `task-15a-review1-focused-initial.log` preserves a failed foreground test fixture that was corrected to create a real local incoming call. The first manager fixture failure from a missing mocked WebRTC `textureId` was not separately preserved; its corrected green run is `task-15a-review1-manager.log`. The intermediate 6,806-pass full suite predates the final late-revocation change; the 6,807-pass rerun covers that change. The final 6,807-pass suite and analyzer **predate** the review 2 test-only commit; the final 103-pass focused command compiled and ran that test.

The manager regression now sends a verified accept before account binding, waits through the actual CallManager startup path, invokes its installed WebRTC incoming callback, and observes entry into `WebRTCService.answerCall()` without a duplicate native incoming notification. It proves an answer attempt, not remote connection or media acceptance. The RED control temporarily set pending answer to false, failed on the absent method entry, and was restored; production has no review 2 diff.

Archive: 33 log files plus `MANIFEST.sha256` = 34 regular members. SHA-256 of the compressed archive: `431c5d176e2815cdbdd0efc007cbf89c963508d13c7d29f79f2468c842e7a891`. The manifest lists SHA-256 for each original log and was checked against every extracted member. Archive member names were checked for absolute paths, traversal and duplicates. A credential-pattern scan found no authorization headers, token/password assignments, JWTs, private-key blocks or URL userinfo in the archived logs.

## Acceptance limit

The Matrix 13 SDK serialization and `getPushers()` echo prove registered pusher fields. The [Matrix push-gateway contract](https://spec.matrix.org/latest/push-gateway-api/) forwards pusher `data`, and the reviewed [Sygnal source at `d96899fc`](https://github.com/element-hq/sygnal/blob/d96899fc4932d6b95f5281cb15eff22c56a80617/sygnal/gcmpushkin.py#L680-L683) merges `default_payload` into FCM data, but the deployed gateway implementation/version and actual forwarding are unknown. There has been no online gateway or background/terminated Android/iOS device acceptance test. Event-ID-only notifications may lack `type` and `sender`, so the client cannot create a call route from those payloads. DEP-002 remains open in `OPEN_ISSUES.md` for deployed gateway provenance and device acceptance; the legacy untagged background path remains unsupported.
