# Isolated Tuwunel 1.9.4 protocol QA — 2026-11-07

## Environment

- Independent Docker container `n42-matrix-qa-20261107`, dedicated database volume and network. Host listener is restricted to `127.0.0.1:18948`; federation is disabled. This is a separate local service, not a production deployment or database copy.
- Image matches the pinned production upgrade digest: `jevolk/tuwunel@sha256:0e86c6164d6c9f5b60291938eb61ad8395021c37fe58d47a963ea7edddbedaec`. Client versions returns HTTP 200 and Tuwunel 1.9.4.
- Configuration and random registration token are controlled outside Git under `~/.config/n42/qa/matrix-20261107/`. Never print or commit runtime.env or credentials. All accounts/content are generated solely for this local run.
- The first internal-only Docker network did not publish a usable host port. The owned container was stopped and moved to a dedicated regular bridge; only loopback is published. Do not describe this as an egress-isolated network. The original unused internal network is recorded for later cleanup.
- Configuration reference: [official Docker deployment](https://matrix-construct.github.io/tuwunel/deploying/docker.html).

## Media result

- The standalone `dart run tool/live_media_smoke.dart` failed before contacting the homeserver: Flutter-backed media services import dart:ui, unavailable in a standalone Dart VM.
- Added an explicit Flutter-VM entrypoint: `flutter test tool/live_media_smoke_test.dart --no-pub --reporter expanded`. It preserves credential validation and all existing assertions; it is outside the default test/ suite and does not silently skip missing credentials.
- Actual isolated-server run exited 0: registration, room creation, image upload through the app sender, streaming 4 KiB file upload, protected file download through the app download service, and live-location state retrieval passed. The script contains seven checked steps including connection. This is one tool-level test, not seven independently counted tests.
- Existing credential/HTTP guard regressions: 14 passed. Scoped analysis: no issues. Result and log hash: local-tuwunel-media-2026-11-07.json. Private raw logs remain in the controlled QA directory.
- Runtime lib/ sources are unchanged from the wallet's ad7ce8c4 pin; this is a tool-only correction and does not require a host dependency update.

## Open acceptance

The independent live message smoke completed with exit 0 against this local environment. Ten checked steps include registration, room creation, normalized UTF-8/rich-text content, reply relations, edit aggregation, reaction/redaction, thread relations, and anonymous poll/vote/end round trips through the SDK and app mapper. Result and log hash: local-tuwunel-messages-2026-11-07.json. This is not encrypted, cross-device or production acceptance.

These rooms are not encrypted. Production identities, real E2EE and device verification, key recovery/revocation, mobile push/calls, large-transfer limits, mobile memory/disk behavior and physical-device acceptance remain open. Temporary QA accounts are logged out, not deactivated; only this owned disposable database contains them. Retain evidence before shutting down and cleaning up owned QA resources. Do not reuse any production credential or change production registration policy.

## Legacy CLI regression

The hardened `tool/server_test.dart` completed against the same owned loopback server using a new random disposable account: 13 checks passed, zero failed, exit 0. This includes registration-token UIA, profile read/write, sync, room creation, text send, user/public-room queries and logout. The registration token is absent from the private log. The structured record is `local-tuwunel-legacy-2026-11-07.json`. This test remains single-account and unencrypted; E2EE, recovery, push and production acceptance remain open.

## Three-client encrypted group

`tool/local_e2ee_smoke.dart` now provides an explicit loopback-only check with three generated accounts and three separate SQLite databases. Six configuration guards reject public endpoints, credentials embedded in URLs, existing accounts and missing registration configuration before native initialization or network access.

The real 1.9.4 run passed: three sent events were opaque encrypted events on the server, and all three clients correctly decrypted every payload (nine deliveries). Exit 0; no registration token appeared in the log. See `local-tuwunel-e2ee-2026-11-07.json` for source and log hashes. An initial invalid harness reused the SQLite in-memory database and failed; it was corrected to separate database files before the successful run.

Run explicitly with the controlled local homeserver and registration token in the environment, and a compatible native vodozemac library configured through `FRB_DART_LOAD_EXTERNAL_LIBRARY_NATIVE_LIB_DIR`: `dart run tool/local_e2ee_smoke.dart`. This tool only creates synthetic accounts; it logs out sessions but does not delete accounts. This proves isolated encrypted group transport/decryption, not same-account multidevice, recovery, revocation, physical-device UI, production push or the original load target.

### Same-account second device

The follow-up adds a fourth client with another independent SQLite database and password-login to the first synthetic account. It asserts matching user ID, a different device ID and enabled encryption, waits for device discovery, then sends a fresh encrypted message. All four clients decrypt it correctly. The complete rerun passed four ciphertext checks and 13 decrypted deliveries (the original nine plus four after second-device login), exit 0. All 20 QA configuration/credential guard tests pass. The structured E2EE record now contains this expanded result and current source/log hashes; the successful log is retained privately as `~/.config/n42/qa/matrix-20261107/e2ee-multidevice-smoke.log` with mode 0600. No device trust flags or keys were copied. This verifies new-message reception on a same-account second client, not historical key recovery, cross-signing verification, revocation or physical-device behavior.

### Revoked second device

The expanded run stops the synthetic second device's sync while retaining its local crypto state, deletes that device using the owning account's password UIA, and independently checks that its old access token receives HTTP 401/M_UNKNOWN_TOKEN. After normal sender device-list refresh, a new message uses a different Megolm session. All three remaining clients decrypt it correctly. The revoked offline client still decrypts the earlier message (positive control), but cannot decrypt the new session even when given the new ciphertext directly. No manual sender session rotation or key deletion is used.

Final successful run: five server ciphertext checks, 16 correct deliveries, old-session-key positive control, rejected old token and blocked new-session decryption; exit 0. Twenty guard tests pass and scoped analysis reports no issues. Current structured evidence and source hash are in the E2EE JSON; private log `~/.config/n42/qa/matrix-20261107/e2ee-revocation-smoke.log` is mode 0600. This proves isolated protocol behavior after observed device-list refresh; it does not establish revocation propagation latency, offline sender behavior, UI, production operation or historical backup recovery. Revocation does not erase already received content/keys.

### Application key-backup recovery

The tool now calls the actual app `E2EEManager.createRecoveryKey`, clears its in-memory cached recovery key, and stops all original peers' sync. It logs the same synthetic account into a fifth client with a new SQLite database. The target historical inbound session is absent before recovery. `E2EEManager.unlockWithRecoveryKey` restores four sessions, after which the historical event decrypts to the exact expected body. Recovery keys are neither logged nor persisted by the tool.

The final-source run exits 0 and preserves the previous ciphertext, multidevice and revocation assertions. Seventeen app backup-behavior/configuration-guard tests pass; scoped analysis is clean. Updated structured evidence hashes the exact source and private `e2ee-backup-recovery-smoke.log` (0600). This is one isolated backup recovery in the final run, not the original 30/30 recovery target, physical-device UI acceptance or production recovery. Wrong-key, interrupted-network and corrupted-backup live cases remain open.

### Repeated-recovery batch status

The 30-attempt batch hit the server's per-account login limit at recovery device four. Diagnostics established a retry delay of 333,000 ms, above the harness's original five-minute wait budget. These terminated runs are not recorded as successful batches. The tool now honors server delays up to 15 minutes, with five retries per login; only explicit rate-limit errors retry. The actual 333-second delay is covered by a focused test, and all 38 backup/configuration/retry tests pass. A fresh batch is running with the server limits unchanged. The structured acceptance JSON is intentionally left at the previous successful single-recovery result until the full batch produces its terminal result and exit code.

## Host golden CI result

Chat golden regression run 42372807637 passes on both Ubuntu and xcode-27 macOS for source 6f6f811e. Exact comparison is retained. Material fixture inheritance, fixture heading contrast and separately reviewed host baselines were corrected. The earlier macOS 26 renderer's four/six edge pixels are resolved by aligning the runner to the macOS 27 family used for the reviewed baseline. This is a golden-test result only, not physical-device or production acceptance.


## Twenty-client encrypted group load

Final tool `local_group_load.dart` exits 0 against a second owned Tuwunel 1.9.4 instance, loopback port 18949, with federation disabled, independent database volume, 2 CPU / 2 GiB server limits and linux/amd64 Docker emulation. It does not alter the ongoing recovery server at port 18948.

Twenty Matrix SDK clients use independent SQLite stores. The run sends 10,000 acknowledged events with explicit transaction IDs: text/notice/emote plus 100 encrypted file events. One recipient stops sync after key establishment and resumes after the send phase. Every recipient's history has exactly 10,000 unique expected event IDs and correct decrypted bodies: 200,000 verified deliveries, zero missing/duplicate/unreadable results. Send phase: 339,033 ms; total: 1,174,155 ms. These virtual-client measurements are not mobile or production throughput benchmarks.

An initial three-client preflight failed because the harness opened history before resumed sync. It now awaits sync first; final three-client/100-event preflight and the full run both exit 0. Fourteen pre-IO guard cases pass; scoped analysis has no issues. No product runtime source was changed to pass this test.

Structured source/log hashes and per-recipient counts: `local-tuwunel-group-load-2026-11-07.json`. Full client/server logs are mode 0600 in the controlled matrix-load QA directory. The captured server log contains zero occurrences of the generated message-body canary prefix. This does not cover production or push logs. File-event bodies are checked, but this load test does not download/decrypt their attachments. Accounts are logged out, not deactivated; the owned database is retained. Physical UI, push, attachment payloads and other MSG-001 gaps remain open.
