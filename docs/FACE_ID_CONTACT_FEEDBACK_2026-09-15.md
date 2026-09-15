# Face ID and contact-details feedback — 2026-09-15

## Confirmed defects and changes

- Contacts created a direct conversation without its peer user ID. Chat details
  fell back to its Matrix room ID (`!…`) when opening a contact profile, so the
  existing friendship could not be found. Carry `directUserId`, resolve older
  conversations from Matrix room metadata when available, and report a failed
  load rather than ever opening a room ID as a user profile.
- Contact details now read the retained contact list during transient actions
  such as starting a chat or updating remarks; they refresh after deletion too.
  The existing requirement for mutual joined membership remains unchanged.
- Chat Face ID restores an existing session token; remembered credentials contain
  only a server and username, not a password. Explicit logout revokes the token
  and clears the session. The login page previously still offered and automatically
  prompted Face ID based on remembered account fields. It now requires a saved
  session and otherwise explains that login is needed. The Bloc checks session
  presence/completeness before invoking biometrics. A concurrent login suppresses
  the delayed page prompt.
- Settings → Privacy & Security now explicitly lists Biometric Login. The Security
  page keeps that section visible even if device discovery fails, displays an
  enrollment/permission explanation in all 26 locales, and refreshes after
  returning from system settings. Existing consent can still be disabled while
  hardware is unavailable. Enrollment uses the current saved session to remember
  the account; saves are serialized and failures are surfaced.

## Acceptance and limits

Targeted coverage exercises no-session rejection without a biometric prompt or
server restore, normal restore/failure/cancellation, unavailable-device settings,
known friendships during transient statuses, deletion, correct profile identity,
and refusal to use a room ID. Existing remark and key-recovery tests remain part
of the regression run. The full Chat suite passes 6,470 tests with one skipped
and no failures; the final targeted rerun passes 77 cases. Static analysis has
zero errors/warnings and 173 existing informational diagnostics. The final
null-localization fallback adjustment was validated by the targeted rerun after
the full run. Eight new tests cover the reported paths. Wallet integration
retains archived logs and the exact resolved dependency revision.

The user has not yet clarified whether Face ID failed after explicit logout,
after reopening the app, or before displaying a system prompt. These verified
code paths are not proof of the exact hardware failure on that device.

On dedicated iOS and Android devices, verify the explicit settings entry,
permission denial/re-enrollment and returning from system settings, successful
biometric restore of a valid session, server-expired session fallback, explicit
logout requiring normal authentication, and enable/disable persistence. Also
verify Contacts → chat → chat details → friend profile shows the real user ID
and Message action for an accepted friend, including after updating a remark.
No real user password, Face ID data or recovery key was used for these changes.

A new server login after logout requires a supported authentication method;
biometric success alone cannot authenticate a revoked Matrix token. This patch
does not keep logged-out tokens alive or start storing account passwords.
Unresolved acceptance remains in `OPEN_ISSUES.md`, `QA-009`.
