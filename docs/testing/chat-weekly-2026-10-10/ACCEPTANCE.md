# Local acceptance — 2026-10-10

Implementation commit: `7e63759f`. Toolchain: Flutter 3.47.5 / Dart 3.13.4.

- Final complete Chat suite: **7,321 passed, 3 skipped, 0 failed, exit 0**. The three skipped cases are not accepted external flows.
- Final focused suite: **85 passed, 0 failed, exit 0** (authorization-window boundary/revocation, selected-only dialog/helper, recovery feedback, ChatBloc sends, transfer repository).
- Full `flutter analyze --no-pub --no-fatal-infos`: **exit 0; no errors or warnings; 301 informational lints**.
- Initial host receipt-verifier/Chat initialization baseline: **41 passed** at the old host pin. Final pin validation is recorded in the host repository, not inferred from this baseline.

Behavior added: monotonic two-minute authorization for summary and quick reply; pending quick-reply revocation on dismissal/reset; no parallel inline refresh; unchanged selected-message snapshot required for late replies; no old-account summary error. Both inline and sheet quick-reply entry points compile and use the window. Requests already sent cannot be recalled. Payment/export permissions are never acquired by these text-only routes.

The full suite compiles the production pages, but there is no device/provider end-to-end test of the new late-response branches. The fresh focused helper tests verify expiry and revocation, not physical network behavior. No coverage percentage is claimed from this run.

Remaining: physical two-phone/desktop recovery, real attachments and constrained network, configured AI/webhook service and group-bot removal, independent receiver/real-chain acceptance, non-EVM receipt support, durable idempotent payment/delivery settlement and optional commitment protocol. External configuration steps were skipped at the user's request. No real payment, chain write or application release occurred. English fallback consent copy follows the existing UI; complete locale translation remains open.

One intermediate focused run failed compilation because the sheet loader still used the previous signature. The entry point was repaired before the final full and focused runs above. Compressed logs are fresh final evidence; prior runs are not counted as final acceptance.
