# Friend privacy, encrypted sends and call lifecycle — September 16, 2026

## Report and changes

Reviewed recordings 4, 5, 6 and 8 supplied by the user. Contacts now open the
friend profile; its call action resolves an accepted direct room and opens the
voice/video chooser. Hidden calls have a persistent return button and tapping
the same conversation's call action reopens its current call.

Friend permission preferences previously lived in unscoped local storage and
were not applied by the feed. They now use account-scoped Matrix account data.
Own social rooms are identified by creator, not the first tagged room. Outbound
restrictions update invite-only room membership, joined-only history and room
policy, and are rechecked before publication. Incoming restrictions refresh
Moments, profile feeds, video feeds and open detail/story views. Status/Stories
use a separate room, keeping their access independent from Moments. Applying
status restrictions migrates recent legacy stories before redacting originals
and clears globally visible presence text. Failed enforcement remains visible
and prevents publication into a room whose restriction failed.

Legacy local permission records cannot safely be attributed to an account:
users must save the intended friend permissions again after upgrading. Already
downloaded content cannot be revoked. Cooperating clients filter retained
content, while server membership prevents subsequent restricted room access.

## New encrypted messages

Source inspection found forced cross-verified-only key sharing even for accounts
without cross-signing, and SDK best-effort incremental/background key sharing.
The default now follows `crossVerifiedIfEnabled`: unsigned devices belonging to
accounts that have cross-signing still require verification. Blocked devices are
never trusted. No plaintext fallback or automatic cross-signing reset was added.

Before new messages, the send gate refreshes device keys, verifies recipient
eligibility and Olm sessions, rotates on recipient changes, and awaits complete
key distribution. A failure stops publication and gives actionable localized
feedback; text remains available for retry. Calls establish this encrypted
session before sending an invitation/answer. Call records also use the gate.

This prevents the identified silent failure paths, not every possible future
loss of keys: a receiving device can erase its state after successful delivery.
Delivery to the homeserver is not a recipient decryption acknowledgement. Old
messages with permanently lost keys are not reconstructed, as allowed by the
user. Native Megolm tests verify a fresh receiver decrypts the next message.

## Call defects found

- iOS shows a system CallKit interface alongside the application's custom UI.
  These represent the same call. Android uses the plugin's native notification/UI.
- System end events previously cleared only the notification ID. They now end
  the WebRTC call. Programmatic dismissals and stale call IDs are ignored to
  prevent ending a subsequent/accepted call.
- Native nested map decoding could throw before dispatching an action; decoding
  now accepts platform map types. Listeners reconnect after account teardown.
- Hangup now releases local media/state before network delivery; cancellation
  during TURN lookup cannot restart a cancelled call.
- ICE candidates could precede the invitation, and incoming candidates were
  discarded while TURN lookup ran before the session was assigned. Outbound
  candidates wait for the description event; incoming sessions are reserved
  before async setup, retaining early candidates.
- Call payload bodies are no longer logged by the call-event listener.

## Verification boundaries

Automated coverage exercises privacy/account isolation/failure handling, profile
navigation and call launch, stale feed removal, key eligibility and failed key
delivery, real native Megolm decryption, native event channel end/reinitialization,
early incoming ICE and cancellation during TURN lookup. These tests use mocked
homeserver responses and do not establish a successful Android-to-iOS live call.

Both physical device platforms are attached for native smoke testing. Server SSH
still rejects the configured root login; effective TURN availability/credentials
and registration policy have not been checked on the deployment. No production
configuration was changed. User-account cross-platform calls, background ringing,
network handover and new-message delivery must be accepted on both updated apps.
TestFlight build 2026072667 predates these fixes.

## Contact and tag follow-up

Video 9 exposed a stricter friendship check running before lazy-loaded member
state was present after login. Resolve the actual room member (without global
profile fallback) before contact enumeration and sends. Unknown membership
fails explicitly rather than publishing a false empty contact snapshot. Reuse
accepted/pending direct rooms; create a fresh invitation for an abandoned room.
Outgoing requests appear as awaiting acceptance; they do not offer Accept/Reject.
Profile Add and request acceptance now wait for their actual asynchronous result.
No existing rooms or historical messages are removed.

The populated friend-tag picker now includes a create button alongside Confirm.
Creating selects the new tag; confirming saves the friend's selection. Matching
trimmed, case-insensitive names reuse the existing tag. Dialog-owned controllers
survive exit animations and storage failures roll back mutations.

Both attached phones passed the native smoke scenarios after Android USB install
was allowed. These are not the reported phones, and fixture signaling does not
verify dxx/dxx01 contacts or successful live calls. The original affected accounts
must still perform QR acceptance and exchange fresh encrypted messages.
