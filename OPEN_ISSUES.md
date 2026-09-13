# Open Issues Ledger

This file tracks unresolved issues intentionally left open during recent agent work in `n42_chat`.

## Update Rules

- Add or update an entry whenever work ends with an unresolved bug, unsupported path, partial implementation, or meaningful verification gap.
- Update an existing entry instead of creating a duplicate when the issue is already listed.
- Remove an entry only after the fix is implemented and verified, or mark it `Resolved` with a short note if keeping history is useful.
- Keep entries concrete: current behavior, why it is still open, and the next step needed to close it.

## Active Issues

### SOCIAL-001 Nearby discovery is limited to location-bearing Moments

- Severity: M
- Updated: 2026-09-12
- Evidence: `lib/src/presentation/pages/discover/nearby_page.dart`, `discover_page.dart`
- Current state: a real NearbyPage now exists and derives candidates from visible Moments with coordinates, after location permission. The previous claim that no discovery page exists was stale. This is not a dedicated proximity-presence protocol or complete people-discovery service.
- Next step: verify consent/visibility/expiry in a controlled multi-user scenario and define any broader discovery backend separately.

### SOCIAL-002 AR effects are still missing beyond reusable image filters/editor tools

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/presentation/pages/story/create_story_page.dart`, `lib/src/presentation/pages/moment/create_moment_page.dart`, `lib/src/presentation/pages/media/media_editor_page.dart`
- Current state: Stories and Moments now reuse the existing `MediaEditorPage` flow, so crop/draw/text/filter editing is available for social posting without duplicating editor code. However there is still no real AR stack for masks, face anchors, body tracking, or camera-time effects.
- Next step: choose the supported AR surface and SDK first, then decide whether it should run only at capture time, export rendered media into Stories/Moments, or also support live preview and interactive effects.

### SOCIAL-003 Virtual avatar support is still decorative, not a full persona system

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/presentation/widgets/common/n42_avatar.dart`, `lib/src/presentation/pages/profile/profile_edit_page.dart`, `lib/src/domain/entities/avatar_decoration_preset.dart`
- Current state: the latest entertainment/social pass added reusable avatar-decoration presets so profile and settings surfaces can share a consistent decorated avatar without duplicating border/badge code. However there is still no full virtual-avatar stack such as custom character builders, Bitmoji-style assets, 3D mesh avatars, or cross-user persona syncing beyond the owner account's profile data.
- Next step: decide whether the product wants lightweight 2D avatar kits, full 3D avatars, or both, then define the asset model, editor flow, and how avatar persona data should sync across devices and other users' clients.

### SOCIAL-004 24-hour status expiry is still client-owned, not an authoritative cross-user protocol

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/data/datasources/matrix/matrix_contact_datasource.dart`, `lib/src/core/utils/timed_status_utils.dart`, `lib/src/presentation/pages/profile/status_page.dart`
- Current state: status posts now store expiry metadata and the client clears expired statuses on session restore/profile reads instead of treating "visible for 24 hours" as a pure label. However the expiry is still enforced by the owner's client path. Other users still only see Matrix presence text, so there is no canonical shared expiry event that remote clients can independently honor.
- Next step: define a shared status-expiry model, for example room/state/account-data that contacts can read or a server-shaped ephemeral-status API, then migrate contact rendering off plain presence text for this feature.

### OFFICE-001 Collaborative tasks and calendar synchronization remain incomplete

- Severity: M
- Updated: 2026-09-12
- Evidence: `lib/src/core/services/reminder_service.dart`, `chat_page_message_actions.dart`, `favorite_list_page.dart`
- Current state: personal reminders exist, persist as FavoriteEntity values, and are reached from the message menu/favorites. The previous "no todo model" claim was stale. The periodic notifier only runs while the app process is alive; there is no assignee workflow or shared calendar sync.
- Next step: verify notifications after process termination and define collaborative assignment/calendar semantics before claiming full task collaboration.

### OFFICE-002 Whiteboard collaboration needs multi-client acceptance; spreadsheets are absent

- Severity: M
- Updated: 2026-09-12
- Evidence: `lib/src/presentation/pages/chat/whiteboard_page.dart`, `lib/src/presentation/widgets/chat/whiteboard/whiteboard_controller.dart`
- Current state: drawing/export and Matrix stroke/clear exchange exist with a chat entry. The previous "no renderer" claim was stale. Concurrent drawing, offline recovery and room permissions have not been accepted on multiple real clients; there is no spreadsheet editor.
- Next step: validate multi-client convergence and persistence, then scope spreadsheet collaboration independently.

### OFFICE-003 Audit logging is still missing

- Severity: M
- Added: 2026-03-21
- Evidence: no audit-log repository, append-only event sink, or admin-facing audit UI was found during the office-collaboration review.
- Current state: group settings and moderation actions exist, but they are not mirrored into a durable audit stream for enterprise review/export.
- Next step: define the audit event schema and storage boundary, then hook high-value actions such as membership changes, permission changes, export/backup actions, and moderation actions into it.

### COMPLIANCE-001 DLP remains a client-side display filter, not an enforced policy system

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/core/utils/content_filter_utils.dart`, `lib/src/presentation/blocs/chat/chat_bloc_message_handlers.part.dart`, `lib/src/presentation/pages/group/content_filter_settings_page.dart`
- Current state: groups can now configure keyword and sensitive-data redaction/hide rules, but enforcement currently happens only in the client when rendering loaded text messages. It does not block outbound sends, scan files, enforce server-side policy, or produce compliance/audit artifacts.
- Next step: decide which DLP paths must be authoritative, then add pre-send checks, media scanning hooks, and a server-side/admin-enforced policy surface instead of relying only on local rendering filters.

### AUTO-001 Group bot webhook/workflow automation is still client-session scoped

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/presentation/blocs/group/group_bloc.dart`, `lib/src/core/services/bot_webhook_service.dart`
- Current state: member-join welcome messages and webhook callbacks now share the same room bot config, but they still execute from the client-side `GroupBloc`. If no logged-in client is online and subscribed, those automations do not fire.
- Next step: move room automation triggers to a durable server-side worker/bot account, or introduce a background sync service with explicit delivery guarantees.

### MEDIA-002 Encrypted-room large file uploads still cap at 64MB

- Severity: H
- Added: 2026-03-20
- Evidence: `lib/src/presentation/pages/chat/chat_page_media_actions.dart`, `lib/src/data/datasources/matrix/message/matrix_media_sender.dart`
- Current state: the secure fallback for encrypted rooms intentionally fail-closes above 64MB to avoid sending unencrypted attachments. Large-file support therefore does not meet the `>2GB` requirement for encrypted rooms.
- Next step: implement a streaming encrypted upload path that preserves Matrix attachment encryption semantics instead of falling back to whole-file bytes or unencrypted upload.

### MEDIA-003 Built-in document preview is still incomplete for office formats

- Severity: M
- Added: 2026-03-20
- Evidence: `lib/src/presentation/pages/chat/chat_page_event_handlers.dart`, `lib/src/presentation/pages/chat/viewers/text_document_preview_page.dart`
- Current state: built-in preview currently covers text-like formats such as `txt`, `md`, `json`, `log`, `csv`, `yaml`, `xml`, and `html`. `docx`, `xlsx`, and `pptx` still do not have true in-app preview support.
- Next step: add a safe office-document rendering path or explicitly route these formats to a separate preview/open flow with clear UX.

### MEDIA-004 Collaborative document editing is not implemented

- Severity: M
- Added: 2026-03-20
- Evidence: no CRDT/OT/co-editing implementation was found in the recent review of `lib/` and `test/`.
- Current state: files can be sent and, for some formats, previewed, but they cannot be co-edited in-app.
- Next step: choose a collaboration model and editor stack, then define room/document synchronization, permissions, and conflict handling.

### MSG-001 Recent real-homeserver smoke does not cover several advanced message features

- Severity: M
- Added: 2026-03-20
- Evidence: `tool/live_message_smoke.dart`
- Current state: the live smoke script covers UTF-8 text, reply, edit, reaction redaction, and thread behavior, and now includes a poll send/vote/end path in code. However the latest confirmed real-homeserver run still does not cover search, favorites/bookmarks, pinning, built-in translation, scheduled send, and the new poll path still needs a live run with credentials to count as verified.
- Next step: run the updated smoke script against a real homeserver, then either extend it further for the remaining Matrix-facing flows or add a Flutter-hosted live test path for client-local features such as scheduled send that depend on local storage/BLoC wiring.

### CALL-001 Background blur / replacement still lacks a real video processor path

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/services/voip/livekit_service.dart`, `lib/src/services/voip/webrtc_service.dart`
- Current state: call config and toggles exist for background blur / virtual background, but the actual processor hookup is still not implemented. LiveKit currently only stores the config and logs intent, and the 1:1 WebRTC path still has no outbound background-processing pipeline.
- Next step: wire a real local video processor into LiveKit local tracks and decide whether 1:1 calls should share the same processor stack or explicitly remain unsupported.

### CALL-002 Call recording still depends on missing server-side Egress wiring

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/services/voip/livekit_service.dart`
- Current state: the client exposes recording config, but `startRecording()` still returns `false` and `stopRecording()` is a no-op because there is no backend Egress integration.
- Next step: add an authenticated backend endpoint that starts/stops LiveKit Egress jobs and surface its status back into the client.

### CALL-004 Exact per-app system ringtone playback is still constrained by CallKit/plugin limits

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/services/voip/incoming_call_ringtone_preference.dart`, `lib/src/services/voip/call_notification_service.dart`, `lib/src/core/notifications/firebase_push_service.dart`
- Current state: ringtone preference is now persisted locally and applied to foreground/background incoming-call params. However `flutter_callkit_incoming` still only accepts `system_ringtone_default` or bundled app resources, not arbitrary Android ringtone URIs. Exact system-ringtone picks are therefore normalized to the OS default sound for CallKit playback, and `silent` / `vibrate` still fall back to system default on iOS until the host app ships dedicated bundled assets.
- Next step: either limit the ringtone UI to truly supported options per platform, or replace the current CallKit sound path with a deeper native implementation that can honor exact system ringtone URIs and silent/vibrate semantics.

### CALL-005 Legacy profile ringtone labels are not fully migrated into the new local CallKit preference

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/services/voip/incoming_call_ringtone_preference.dart`, `lib/src/presentation/pages/profile/profile_ringtone_select_page.dart`, `lib/src/data/repositories/auth_repository_impl.dart`
- Current state: the new incoming-call ringtone bridge reads from local SharedPreferences, while older accounts may only have a `ringtone` label stored in Matrix account data. The ringtone picker now prefers the local preference when present, but there is still no app-start/session-time migration that converts legacy server-stored labels into the new local format before the next incoming call arrives.
- Next step: add a migration step during profile/session load, ideally by switching the persisted profile field to a stable ringtone key instead of a localized display label.

### SEC-001 Full 2FA is still missing

- Severity: M
- Added: 2026-03-20
- Evidence: `lib/src/presentation/pages/settings/security_settings_page.dart`
- Current state: the current security surface covers biometrics and passkey management, but not a full TOTP/SMS-style 2FA flow with enrollment, challenge, recovery, and device migration semantics.
- Next step: decide the supported 2FA modes and implement the required client and homeserver flows end to end.

### SEC-002 Screenshot blocking exists, but screenshot notification is still not surfaced

- Severity: M
- Added: 2026-03-20
- Evidence: `lib/src/core/services/screenshot_protection_service.dart`
- Current state: the service enables screenshot/screen-recording protection, but it does not expose a cross-platform callback or event stream that the app can use for "screenshot taken" notification behavior.
- Next step: add native hooks on supported platforms and surface a Dart-side event API for policy/UI handling.

### SEC-004 Account deactivation still lacks a full non-password UIA flow

- Severity: M
- Added: 2026-03-20
- Evidence: `lib/src/presentation/pages/settings/security_settings_page.dart`, `lib/src/core/utils/matrix_uia_utils.dart`, `lib/src/data/datasources/matrix/matrix_auth_datasource.dart`
- Current state: account deactivation no longer forces a password up front, but the retry path only handles `m.login.password`. Homeservers that require SSO/passkey or other UIA stages still fail closed.
- Next step: implement a generic UIA handler for deactivation instead of password-only fallback logic.

### SEC-005 iOS background APNs still bypasses client-side notification privacy mode

- Severity: H
- Added: 2026-03-21
- Evidence: `lib/src/core/notifications/firebase_push_service.dart`, `lib/src/n42_chat.dart`
- Current state: foreground notification privacy now applies in the local-notification path, and foreground iOS banners are suppressed when preview privacy would leak content. However iOS background/locked-screen APNs alerts still come from the homeserver push payload, so `senderOnly` / `hidden` privacy modes are not guaranteed once the app is backgrounded.
- Next step: decide whether iOS should switch to an `event_id_only` / local-rendered path for privacy-sensitive modes, or explicitly scope the setting as foreground/local-only until server-side push shaping exists.

### SYSTEM-001 Bandwidth control is still coarse auto-download policy, not real traffic throttling

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/presentation/pages/settings/auto_download_settings_page.dart`, `lib/src/core/services/auto_download_policy_service.dart`, `lib/src/core/services/download_service.dart`
- Current state: the recent system/account-management pass confirmed that storage management, offline cache, appearance, notifications, and multi-account switching now have real wiring. However "bandwidth / traffic control" is still limited to media auto-download allow/deny policy by network type. There is still no explicit upload/download rate limit, background sync quota, metered-network throttle, or room/file priority scheduler.
- Next step: define whether traffic control should be policy-only or include actual throughput limiting, then add a shared network budget service that media downloads, backups, and sync jobs must consult.

### SYSTEM-002 Accessibility coverage is still partial

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/n42_chat.dart`, `lib/src/presentation/pages/settings/account_switch_page.dart`, repository-wide search for `Semantics`, `ExcludeSemantics`, `MergeSemantics`, and `accessibleNavigation`
- Current state: font scaling is now wired through the chat presentation wrapper, which improves large-text behavior, but the broader accessibility surface is still incomplete. The recent audit did not find systematic screen-reader labels, semantics grouping, high-contrast accommodations, reduced-motion handling, or accessibility-focused regression tests across key chat/settings flows.
- Next step: define an accessibility checklist for navigation, message cells, media viewers, and settings controls, then add targeted semantics labels/tests and handle platform accessibility flags such as reduced motion and high contrast where applicable.

### SYSTEM-003 Notification customization still lacks keyword-based alerts

- Severity: M
- Added: 2026-03-21
- Evidence: `lib/src/presentation/pages/settings/notification_settings_page.dart`, `lib/src/presentation/pages/chat/chat_detail_page.dart`, `lib/src/core/notifications/firebase_push_service.dart`
- Current state: the latest pass closed room-level notification granularity by wiring `all messages / mentions only / mute` to Matrix push rules, and it added notification privacy levels for sender/body hiding. However there is still no Slack-style keyword alert list that can trigger notifications outside direct mentions.
- Next step: decide whether keyword rules should live in homeserver push rules or client-side preferences, then add a shared keyword matcher/editor and integrate it into foreground/background notification evaluation.

### IDHUB-001 Positive ID Hub chat login is blocked on Matrix provisioning

- Severity: H
- Added: 2026-07-14
- Evidence: `lib/src/presentation/blocs/auth/auth_bloc.dart`, `lib/src/data/datasources/remote/id_hub_api.dart`, unified-identity device QA against the deployed development Hub
- Current state: the deployed Hub reports Matrix provisioning disabled, so positive Hub-to-Matrix login cannot yet establish a chat session. The hardened client now permits legacy fallback only when Hub challenge creation fails before signing. Cancellation or any failure after a Hub challenge is signed stops with one clear error and never asks for a second signature. The Hub server code also rejects Chat challenge creation with `matrix-unavailable` before signing when provisioning is disabled.
- Next step: configure the production Hub with the Synapse shared-registration secret and Matrix password secret, deploy it, then run the positive Hub-to-Matrix login on a real device.

## Verification Gaps

### QA-003 AI smart replies and webhook automation were not live-tested end to end

- Severity: M
- Added: 2026-03-21
- Current state: the new AI smart reply suggestions, extensible bot command registry, and webhook automation paths were unit/analyze verified only. They were not exercised against the shared real homeserver or a real external webhook endpoint in this round.
- Next step: run a live smoke covering AI suggestions in chat, a custom registered slash command, and a member-join webhook delivery against a disposable endpoint.

### QA-004 Protected story-music playback was not tested end to end

- Severity: M
- Added: 2026-03-21
- Current state: story music playback for protected Matrix media now predownloads authenticated audio to a temporary local file before starting `audioplayers`, but this path was only compile/analyze reviewed in this round. There is no dedicated widget/integration test or real-homeserver smoke covering authenticated `mxc://` story music yet.
- Next step: add at least one automated test around the story music source-selection/cache path and run a real-homeserver smoke with a protected audio attachment in a story.

### QA-001 Anonymous registration and destructive account deactivation were not live-tested

- Severity: M
- Added: 2026-03-20
- Current state: these flows were intentionally not automated against the shared real homeserver during recent rounds because they create and destroy real accounts.
- Next step: add a disposable homeserver account fixture or a sandbox homeserver so these paths can be exercised safely.

### QA-002 Group-call token fetching and multi-party rendering were not live-tested

- Severity: M
- Added: 2026-03-21
- Current state: the new group-call entry flow now fetches LiveKit JWTs dynamically and the screen switched from a placeholder renderer to the real `VideoTrackRenderer`, but this path has only been compile/test verified so far, not exercised end to end against a real Matrix homeserver + LiveKit focus.
- Next step: run a real multi-device or multi-account smoke covering group voice join, group video join, screen share, and the JWT endpoint contract.

### QA-005 Multi-account switching and persisted notification settings were not live-tested end to end

- Severity: M
- Added: 2026-03-21
- Current state: the recent system/account-management pass wired saved-account switching, appearance persistence, and notification settings into the real runtime and covered them with analyze plus unit tests. However the new flows were not exercised against two real Matrix accounts/devices, so there is still no live confirmation that account switching, pusher re-registration, and restored appearance/notification preferences behave correctly across a real homeserver session change.
- Next step: run a smoke with at least two real accounts on the shared homeserver, switch between them on one device, and verify push registration, active room behavior, font/theme persistence, and DND/sound settings after restart.

### AUTO-002 AI group membership and responding bot are absent

- Severity: H
- Added: 2026-09-12
- Evidence: `lib/src/presentation/pages/group/bot_settings_page.dart`, `lib/src/core/services/bot_command_processor.dart`, `lib/src/n42_chat_config.dart`
- Current state: private AI routes exist and are repaired in M2. Group bot settings only configure welcome/webhook automation. There is no AI Matrix bot identity, invitation-specific configuration, response worker or group-context policy in this checkout. The local device build also lacks an AI provider key/model configuration.
- Next step: provide/deploy a responding bot service, specify bot identity and group disclosure/context rules, then wire invitation/member state and verify mention/response/removal in an isolated test room. Ordinary member invitation is not evidence of AI responses.

### MEDIA-005 Sticker pack sharing and importing are still stubs

- Severity: M
- Added: 2026-09-12
- Evidence: `lib/src/data/repositories/sticker_repository_impl.dart` importPack/getPackShareUrl
- Current state: installed/custom packs, upload, search and sending exist; these two cross-user sharing methods still return null. There is no verified share-manifest or import preview path. Do not claim a full sticker sharing ecosystem.
- Next step: define persistent pack distribution, resource validation and receiver preview/install, then wire and test both sender and receiver.

### INTEGRATION-002 Standalone Settings composition — Resolved

- Severity: M
- Added / resolved: 2026-09-12
- Evidence: `docs/SETTINGS_AUDIT_2026-09-12.md`, `settings_navigation_test.dart`, `settings_persistence_test.dart`
- Resolution: direct routes and Profile now share default notification/appearance/chat/language/password/email/logout composition. Existing host overrides retain precedence; account hub navigation preserves the active AuthBloc. Notification and appearance saves are awaited, persisted by default, and rolled back on rejection. The Chat category exposes background, quick replies, translation and auto-download.
- Verification: real widget routes cover direct settings, privacy/account hubs, multi-hop auth propagation, save/reopen, failures, slider commits, logout confirmation, and Arabic narrow-screen layout. Live account mutation is still outside this verification (QA-005).

### QA-006 Direct UI literals still need module-by-module translation review

- Severity: M
- Added: 2026-09-12
- Evidence: `docs/UI_LOCALIZATION_REVIEW_2026-09-12.md`, `tool/audit_ui_localization.py`
- Current state: all 26 ARB catalogs have matching English keys and no blank values. This does not cover direct UI literals: the conservative scanner initially found 539 candidates in 33 presentation directories, including on-device AI, points and system settings. Brands/examples are not necessarily defects. M1/M3/M4 localized the changed expression/actions labels. The settings follow-up localized six messages in all catalogs and reused the backup label; 533 direct literal candidates remain. Nested account/privacy hubs and notification-filter content still require translation; the complete backlog is not fixed.
- Next step: review and translate candidates by module, regenerate catalogs, then verify RTL and expanded text with real UI tests. Do not treat key parity as full translation coverage.

### QA-007 iPhone data continuity after test-runner cleanup is unverified

- Severity: H
- Added: 2026-09-12
- Evidence: host `docs/chat-audit-2026-09-12/DEVICE_RETRY_2026-09-12.md`; successful Flutter drive verbose log explicitly records app uninstall.
- Current state: iPhone fixture UI tests passed, but Flutter drive's default cleanup removed the host app. The normal app was reinstalled; the missing initialization preference was restored and read back to avoid additional first-install keychain cleanup. This does not recover removed app-container files or prove wallet/Chat data continuity. The agent did not read or export private keys or mnemonics. Host automation now uses `--keep-app-running`, with regression coverage for both drive paths. The user's subsequently established Android Chat session was preserved during the retry.
- User update: Chat login on iPhone is now confirmed, as on Android. Current login availability does not establish preservation of previous chat history or wallet data.
- Next step: verify wallet and historical Chat data in the normal iPhone app with the user; any recovery must use user-controlled backups. Do not mark this resolved based only on renewed login, install success or fixture test results.

### STORAGE-001 Favorite deletion spans two preference keys

- Severity: M
- Added: 2026-09-13
- Evidence: `MessageActionRepositoryImpl.unsaveMessage`, `message_action_persistence_test.dart`
- Current state: message and metadata writes now propagate rejection and publish caches only after successful persistence; mutations on one repository instance are serialized. Deletion still writes the message list before cleaning the separate metadata key. Failure of the second write can leave durable message deletion plus stale metadata and a surfaced error. There is no cross-key transaction or cross-isolate locking; the tests do not claim either.
- Next step: migrate favorites and metadata to one versioned transactional record with crash-recovery tests and update the caller's partial-failure behavior.

### UI-001 Legacy favorite tag and remark methods have no visible read/edit path

- Severity: M
- Added: 2026-09-13
- Evidence: `MessageActionRepositoryImpl.editFavoriteTags/editFavoriteRemark`, `FavoriteBloc`, `FavoriteListPage`
- Current state: tag/remark edits persist and their failure/retry behavior is covered, but `getSavedMessages` returns MessageEntity without this metadata and FavoriteListPage has no tag/remark editor. These backend methods are not evidence of a usable tagged-favorites feature. The newer FavoriteEntity/reminder storage is a separate path and must not be confused with this repository.
- Next step: consolidate the two favorites models, expose persisted metadata through the domain contract, and cover create/edit/search/reopen from the actual profile entry.

### AUTH-001 Email confirmation UI and Matrix verification contract differ

- Severity: H
- Added: 2026-09-13
- Evidence: `AuthRepositoryImpl.confirmChangeEmail`, `ChangeEmailPage`
- Current state: the confirmation method accepts `newEmail` and `code` but does not use them; it calls Matrix add3PID with the stored client secret/session ID. This still relies on server-side 3PID verification and is not evidence of an authentication bypass, but the entered code is not submitted by this method and the requested address is not matched. Local form/navigation tests do not validate email delivery or the server verification contract.
- Next step: align the page with the homeserver's supported verification link/token flow, validate the address/session association, and verify expiry, wrong code/session and success against an isolated account.

### QA-008 Xiaomi overwrite installation — Resolved

- Severity: M
- Added: 2026-09-13
- Resolution: after the user enabled USB installation, explicit overwrite installation succeeded on 2026-09-13. No uninstall or data clearing was used. This resolves installation permission only; acceptance exposed the SQLite loader issue below.

### STORAGE-002 Android media database background isolate lacks SQLCipher loader

- Severity: H
- Added: 2026-09-13
- Evidence: physical Xiaomi fixture failed resolving `libsqlite3.so`; the APK ships `libsqlcipher.so`. `MediaMetadataDatabase._openConnection` used `NativeDatabase.createInBackground` without configuring its isolate's library loader; the archive main-isolate override cannot propagate to it.
- Current state: added Android library preparation and a per-isolate SQLCipher override. A production-path regression writes, closes, reopens and cleans media metadata under an isolated temporary documents directory. All 15 local storage contracts pass; updated physical-device verification is pending.
- Next step: run the expanded device suite, restore the normal Android app and verify Chat entry, then record acceptance before release tagging.

## Resolved in the 2026-09-12 audit

### INTEGRATION-001 Wallet build source differed from its declared Chat pin — Resolved

Host master commit `aecb6f77` was published to n42appv2. It pins `cbc7bd1a128d841ff667708e513fc1ca0b708f9e`, removes the tracked Chat path override, and records Git source in pubspec.lock. The resolved Git package and host cache match across all 764 lib/assets files (SHA-256 manifest in host docs/chat-audit-2026-09-12/CHAT_SOURCE_MANIFEST_2026-09-12.json). Host full suite: 4,163 passed; after Git resolution, 18 additional targeted tests passed and analyze reports zero errors/warnings with 155 infos. The original divergence evidence remains in docs/HOST_BASELINE_SYNC_2026-09-12.json.

### INTEGRATION-003 Nested settings failure handling — Resolved

- Severity: M
- Added / resolved: 2026-09-12
- Evidence: `nested_settings_failure_test.dart`, `settings_write_failure_test.dart`
- Resolution: account-list and notification-filter reads show a retry state on failure. Filter saves serialize input, restore confirmed rules on failure, and update the running push filter only after storage succeeds. Appearance, notification and filter writes reject platform `false` results and reload SharedPreferences' optimistic cache from durable storage.
- Verification: fault injection covers both `false` and thrown platform failures, cached-value restoration, successful retry, filter read/write failures and late completion after disposal. If the platform also refuses cache reload, the original write failure is still surfaced; recovery from a persistently unavailable OS store is not claimed.
