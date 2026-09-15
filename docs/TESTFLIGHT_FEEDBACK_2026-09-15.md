# TestFlight Chat feedback repairs — 2026-09-15

The reported build is 2.4.8 (user-provided build number 2006072639); the wallet's release record identifies 2.4.8+2026072639. The screenshots confirm the actual surfaces but do not independently establish the build number. This work targets feedback 1.1–1.5 in the canonical Chat repository; the wallet must resolve the new Git commit before a subsequent build contains these repairs.

| Feedback | Source repair | Verification boundary |
|---|---|---|
| 1.1 Registration says invalid username/password | Remove prefilled bundled token and false built-in/filled labels; discover UIA before supplying auth; follow supported complete token/dummy flows with session and completed stages; retain rejected-token errors and bound retries. Registration rejection no longer uses login credential wording. | Read-only server token-validity response rejects token registration. Mock SDK flows and real form dispatch tested; no account created. |
| 1.2 Unequal contacts and premature messaging | Both direct-room members must explicitly be joined. Missing member content cannot inherit the SDK's default joined fallback. Guard text/media/custom/reply/forward send paths; do not invite a pending contact to Moments. | Pending/left/banned/knocking/missing states and acceptance covered. Server membership propagation needs two-account device acceptance. |
| 1.2 / 1.3 History encrypted after logout/login | Separate timeline/message caches across client/user/device/homeserver identities; discard disposed/in-flight old timelines. Complete actual online-key-backup bootstrap while preserving existing secrets, verify downloaded sessions rather than trusting silent SDK no-ops, and expose Restore Keys from encrypted bubbles. Logout explains the need for key backup and provides an entry. | Regression tests cover same-account/new-device cache changes, late creation, supported backup states, failed/skipped restoration, and narrow English/Chinese/Arabic bubbles. Real cryptographic logout/recovery remains unverified. |
| 1.4 File action survives onto wallet home | Route-scoped ScaffoldMessenger above Chat's state context. Download actions and completion/error notices belong to that route. | Real ChatPage file tap/pop test verifies disappearance and continued parent notifications. Screenshot identifies the stale download action on wallet home. |
| 1.5 Profile / Chat Settings do not open | Add default authenticated profile navigation and preserve host overrides. Current Chat Settings already has default navigation, retained and tested. | Real settings-route and AuthBloc propagation tests. |

The prior encrypted-placeholder cache and missing-key request repairs are retained, with their existing repository tests. No encryption was disabled and no recovery keys were hardcoded or retained outside existing SDK secret storage.

## Reproduction evidence

At pre-fix canonical commit `0894354`, the new registration/friendship/file/profile regression selection has 22 passes and 13 failures. Separately, all three new timeline-lifetime regressions fail against that commit. They pass after the fixes. Initial fixture/compilation corrections are excluded from these baseline claims.

The screenshot homeserver's read-only `/versions` response identified Tuwunel 1.8.2. Uppercase/lowercase synthetic username availability queries both returned HTTP 200 with `available: true`. The bundled-token validity query returned HTTP 403 with `M_FORBIDDEN: Server does not allow token registration`. These observations support a token-policy mismatch; they do not prove a successful account-creation transaction.

Five screenshots were inspected from the user's local Downloads transfer directory. They contain personal account information, including visible registration credentials. Screenshots and credentials are not copied into this repository or used for authentication.

## Validation

- Full plugin suite: 6,445 passed, 1 skipped, no failures (`flutter test --no-pub --concurrency=4 --machine`). Raw logs will be retained in wallet integration evidence.
- Static analysis: zero errors, zero warnings, 173 existing infos.
- Focused UI: logout/registration/settings/file routes pass; encrypted-message recovery labels fit 320px English, Chinese and Arabic layouts.
- All 26 ARB catalogs preserve key parity and contain the translated logout key-loss explanation. Generated localization code was regenerated with `flutter gen-l10n`.

## Release acceptance

See `OPEN_ISSUES.md` QA-009 for the outstanding device and live-server matrix. TestFlight was not rebuilt or uploaded by this repair. Lost unbacked-up session keys cannot be recovered by changing a placeholder. The registration email field still has an unimplemented binding contract, recorded in AUTH-001.
