# Daily Chat audit — September 16, 2026

## Scope and recent work

Reviewed the September 16 friend-profile, permissions, friendship, encryption/call and video-entry changes and their adjacent read/write paths. This is a targeted source and regression review, not a claim that every app path or production server has been audited.

The preceding releases include friend annotation editing and previews, multi-photo management, tag creation, authoritative direct-room membership recovery, contact-to-profile navigation, profile call actions, native-call lifecycle repair, encrypted-send key-delivery gating, server-backed friend social permissions, and video publishing/broadcast entry points. Wallet TestFlight/APK 2.4.8 build 2026072670 predates this audit's fixes.

## Confirmed defects and repairs

1. **High — selected audiences were discarded.** The composer did not pass selected user IDs to text, image or video publication. All three events now carry a copied audience list.
2. **High — per-post privacy relied on client filtering.** Private/selected/excluded posts previously used the common social room. New restricted posts use a separate invitation-only room with an immutable-by-reader audience, invited history visibility and owner-only invitations/state/publication. Recipients come from accepted direct friendships, not untrusted social-room membership. Invite failure or account changes abort publication. Restoring a friend's global access cannot add them to an old post whose original audience excluded them. Own-profile reads aggregate rooms and deletion resolves the actual post room, propagating deletion failures.
3. **High — automatic social invitations lacked friendship verification.** An invitation reason or room name could trigger automatic joining and reciprocal sharing. The room creator must now have an authoritative, mutually joined direct friendship before automatic joining. Pending requests and strangers remain unaccepted.
4. **Medium — asynchronous video refresh could restore stale content.** Generation checks reject superseded loads and stream errors invalidate pending results. Permission updates clear the current feed while it reloads. Stable item keys prevent a previous video's player from being reused for a different post. Creator route failures surface feedback.
5. **Medium — media and profile lifecycle gaps.** Media picking is serialized, checks mounted state across async boundaries and reports picker errors. Canceling image editing preserves an existing video. Friend annotations re-check the current account after loading; text dialogs own and dispose their controllers with their actual widget lifetime. Failed partial image copies remove the incomplete file. The audience picker now supplies the Material ancestor required by its tiles.

## Validation

- Focused Matrix privacy, profile/photo, composer/feed, Moment repository and Bloc tests: 75 passed.
- Coverage includes private/selected/excluded room audiences, rejected/pending/accepted automatic invitations, failed invitations, switched accounts, personal profile/deletion routing, global permission restoration, stale feed completion, picker completion after page disposal and partial file cleanup.
- Chat `flutter analyze --no-fatal-infos`: no errors or warnings; existing info-level style findings remain.
- Host integration additionally verifies closing/reopening the broadcast route starts at the requested entry with a newly owned/disposed router.

## Limits and acceptance still required

- Existing restricted posts already published into common rooms are not migrated by this change. Already received events/files cannot be recalled. Room membership is access control for new events; it is not a promise of encrypted social media or protection against an authorized viewer redistributing a file.
- Each new restricted post creates a room. Failed setup can leave an empty private room; it never falls back to publishing into the common room.
- Real homeserver enforcement, invitation delivery/history retrieval and private/selected/excluded image/video viewing need dedicated-account iOS/Android acceptance. Tests use Matrix SDK mocks and do not prove production server behavior.
- The user's affected phones differ from the attached test phones. Live dxx/dxx01 QR/contact restoration, new encrypted message delivery and two-way calls remain outstanding, as do production registration/TURN checks. No new production post or broadcast was created during this audit.
- These source fixes require a new build after 2026072670. See QA-009 in OPEN_ISSUES.md for the continuing acceptance record.
