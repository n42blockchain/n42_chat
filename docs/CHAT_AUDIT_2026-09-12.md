# Chat audit — 2026-09-12

## M0: shipped source reconciliation

The wallet at `6ffa34e2` declares Chat `fa08010e`, but builds its tracked cache
through a local override. The cache has 38 changed and 3 additional library
files relative to that pin. This branch starts at the declared pin and imports
the shipped library/test differences; it retains the canonical repository's
additional tests. Asset and pubspec contents already match. Archive source CRLF line endings are normalized; the manifest preserves the original shipped-byte hashes. File hashes are in
[the reconciliation manifest](HOST_BASELINE_SYNC_2026-09-12.json).

This preserves prior wallet fixes (friendly names, archive encryption, Story
preparation, Discover entries, protected-message AI filtering and RTC wiring),
without importing the sibling workspace's unrelated style branch or dirty files.
`flutter pub get` corrects the previously stale SQLite/SQLCipher lockfile.

The complete initial plugin suite produced 5,798 passes, one failure and one
credential-dependent live-test skip. The failure exposed timestamp collisions
in password-change event identity. Identity now uses a distinct object per
request; passwords stay out of equality/debug properties. The targeted auth
event suite passes all 73 tests, including 1,000 rapid distinct requests.

Baseline static analysis has no errors, with 195 existing info/warning findings.
This is not a clean lint gate. Full-suite verification after the fix is pending
the module pass. The host dependency pin is updated only after the audited
plugin commits are published.

## Module execution

The execution plan is maintained in the host repository at
`docs/CHAT_PLUGIN_AUDIT_PLAN_2026-09-12.md`. UI reference candidates are tracked
in `docs/FEATURE_ENTRY_INVENTORY.md`; references do not establish runtime reachability.
Further module results and remaining issues are recorded as work progresses.
