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
