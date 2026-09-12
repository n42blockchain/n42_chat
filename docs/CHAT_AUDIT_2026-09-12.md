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

## M1: expression entries and GIF retrieval

Emoji, installed sticker packs and GIF callbacks were present, but icon-only
bottom tabs made the combined panel hard to discover. Tabs now show localized
labels, respect the bottom safe area and enlarged text, and initialize a source
only on its first visit. The recent-panel empty actions are localized as well.

Two failing widget regressions demonstrated that typing during a pending
trending/search request discarded the newer query. Request generations now
invalidate obsolete responses before debounce. First-page errors and later-page
errors expose retry, and a failed page preserves its existing results/cursor.
Tenor now forwards the opaque `next` cursor as `pos` per its
[official contract](https://developers.google.com/tenor/guides/endpoints).
Composite fallback chooses a source on page one and pins later pages/retries to
that source. Attribution follows the actual provider instead of always GIPHY.

Validation: 30 passing tests across Giphy, Tenor/composite pagination, picker
lifecycle and expression-panel entry suites. Widget checks cover installed
sticker selection/usage callbacks, lazy GIF loading, en/zh/ar at 1.5 text scale,
and the bottom safe area. These are automated widget checks, not physical-device
or authenticated provider acceptance. No credentials were added to the plugin;
a build without GIF provider configuration still reports unavailable.

## M2: AI assistant entries and routing

The conversation add panel now always offers AI Assistant, and Profile has a
persistent assistant entry. Missing provider configuration opens a localized
status page instead of hiding the capability or throwing a GetIt exception.
The direct AI settings route creates its own initialized bloc; navigation from
an active assistant continues to share that assistant's bloc. The page reuses
the registered bloc factory so its wallet bridge is preserved. The repository
uses the existing local/cloud router, respecting the local-model preference.
Raw user prompts were removed from assistant diagnostic logging.

Validation: 34 passing AI page/bloc tests, including missing DI, unavailable
composer, and direct settings navigation. The current local device build-defines
file has no GIPHY_API_KEY, TENOR_API_KEY, AI_API_KEY or LOCAL_LLM_MODEL_URL;
only presence was inspected. The host intentionally disables GIF/AI proxy mode.
These code fixes cannot supply missing external service credentials.

Group AI remains an explicit gap: BotSettingsPage configures welcome messages
and client-session webhooks; BotCommandProcessor implements utility commands.
Neither implements a responding AI Matrix member. No bot account, inference
worker or group-AI configuration exists in the audited source. Restoring a label
would not restore that service. AUTO-002 records the required backend/member
work and a real-room acceptance test; no test messages were sent to real chats.
