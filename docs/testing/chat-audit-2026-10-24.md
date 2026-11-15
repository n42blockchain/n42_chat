# Chat audit — 2026-10-24

Reviewed the October 23 changes from the host-pinned `61d32227`: URL/OAuth parsing, policy signatures and expiry, WebView bridge permissions and session nonces, media limits/encryption/downloads, Markdown, NFC and telemetry. Final functional source: `699062eedfe5d3a67cf33f0e84b9c7e2cccb9ac4`.

## Repairs

- Capture media account identity before asynchronous room resolution. Recheck identity and encryption state before publishing or falling back to plaintext upload. Six regressions cover file/image/video account and encryption changes.
- Serialize cancelled download cleanup and restart. Late responses cannot publish files or alter the new attempt. Disposal completes waiting tasks as cancelled. Download transport has a 30-second idle/request timeout.
- Bound the initial ciphertext hash pass and rehash the bytes actually decrypted. Reject a file replaced between passes, remove failed temporary plaintext and clear key material on exception paths.
- Recheck signed launch expiry after nonce persistence. Security SDK is now `1.1.1` so deployment policies can distinguish this repair.
- Keep NFC discovery-in-progress state local to each session. A cancelled, unresolved tag read cannot block the next scan.
- Give Markdown image requests and text-document requests fresh transports on retry. A timed-out closed client is no longer reused.
- Report failed external link launches in the UI and contain the asynchronous exception.
- Distinguish successful void operations from null upload results in telemetry. Successful streamed decryption is no longer recorded as failure.

Regression files: `download_service_test.dart`, `streaming_attachment_decryptor_test.dart`, `nfc_uri_reader_test.dart`, `matrix_media_sender_test.dart`, `mini_app_security_service_test.dart`, `markdown_interaction_test.dart`, and `media_telemetry_test.dart`. Existing signed-policy, URL, bridge-race, encrypted-send and 100-document corpus tests remain in the full suite.

## Verified results

- Flutter 3.47.5 / Dart 3.13.4.
- Final full suite: **7,726 passed, 4 conditional skips, 0 failures**. Coverage was not recalculated.
- Analyzer: exit 0, no errors or warnings, 306 informational diagnostics.
- Targeted audit group: 57 passed. Preview/telemetry group: 121 passed. These groups overlap and must not be summed.
- Host integration: 136 passed; analyzer has no errors/warnings and 48 informational diagnostics.
- Functional repairs were pushed as `16a32e1f`, `c238a56c`, `699062ee`. Host release pin and TestFlight evidence are recorded in n42appv2.

Remaining production policy deployment, physical NFC tags, mobile large-file transfer/resource measurements and field pilot gaps remain in `OPEN_ISSUES.md`. Local fault-injection tests and a TestFlight upload do not close those gaps.
