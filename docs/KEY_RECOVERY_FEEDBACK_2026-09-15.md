# Recovery feedback — 2026-09-15

The user reports that a recovery operation says it succeeded, but returning to
the room still shows encrypted messages. The Security screen also shows that no
backup is configured. No user recovery key, password or message content was used
for testing.

Confirmed client repairs:

- Security displays the verified session count returned by the restore operation.
  Zero sessions produces an explicit empty-backup message. A positive count says
  that messages without backed-up keys may remain encrypted, in 26 locales.
- The page unlocks/imports once instead of calling two separate restore methods.
  The E2EE manager retains the recovery key in its existing in-memory cache.
- Server backup discovery no longer depends on locally cached SSSS secrets, and
  reads current metadata rather than a five-minute cache. Backup metadata is
  retained if the independent device-list request fails.
- Each verified session notifies existing Matrix timelines to retry decryption.
  This also handles the SDK's early return when an equally good local session
  already exists. Session notifications do not bypass encryption or fabricate
  plaintext for messages whose keys are missing.
- Recovery dialog input is disposed after the route finishes its exit animation.
  Security section surfaces use Material so ListTile feedback is visible.

Seventeen targeted tests pass. New cases include both restore modes with an empty
result, server backup discovery before local secret caching, actual SDK Timeline
refresh, empty/nonempty/failed page outcomes, and backup metadata retention. The
Timeline test mocks the cryptographic decryption boundary and verifies that the
matching event is refreshed while an event for an unbacked session stays encrypted.
It is not a real-device cryptographic recovery test.

The complete Chat suite passes 6,462 tests with one credential-dependent test
skipped and no failures. Static analysis reports zero errors/warnings and 173
existing informational diagnostics.

The separate permissions question concerns a different settings scope. The current
entry is Contacts → select a friend → top-right “…” → Set Permissions. Global Chat
settings contain background, quick replies, translation and downloads. No friend
permission entry was added to global settings in this patch.

Unresolved real-account acceptance is tracked only in `OPEN_ISSUES.md`, `QA-009`.
Historical messages whose keys exist neither in a valid backup nor on another
device cannot be recovered by refreshing the UI. Production registration also
remains disabled pending authorized server access; unified login is unchanged.
