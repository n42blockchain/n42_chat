# Chat improvement plan from weekly product research

Date: 2026-10-05
Scope: `n42_chat` package and its N42 Wallet host bridge. Keep Matrix E2EE fail-closed. Do not run real wallet transactions or publish chat/social data on-chain.

## Baseline findings

- Room-key restore fetches the homeserver backup, imports and validates each returned Megolm session, and returns a count. The recovery-key dialog shows only a success count or one error. It does not show a durable summary of restored, skipped, or failed items. This count means encryption keys, not messages or attachments.
- Media sends set the shared `ChatState.isSending` flag. The composer refuses a text send while that flag is set. A slow upload can therefore block a short text message. Encrypted file uploads are limited to 50 MiB because the current SDK encryption path buffers the file in memory; do not bypass this limit or upload plaintext.
- Inline AI smart replies build context from recent room messages and send that context to the configured AI service without a message-level confirmation. Draft rewrite and the separate AI assistant use text the user enters or selects; keep those flows distinct.
- Wallet transfer results currently carry success/error and a transaction hash. Chat transfer messages store amount, token, and hash. The local red-packet service uses `SharedPreferences` and is explicitly a demo; it does not reserve funds or settle an on-chain payment.
- Production acceptance is separate from code tests. Prior real-homeserver encryption tests exist, but feedback-device recovery acceptance is still open. The host bridge and package source also need to be checked at the exact pinned Git revision before release claims are made.

## Implementation plan

### P0 — Recovery feedback and weak-network message delivery

1. Give room-key restoration a typed result that distinguishes the number of returned keys, validated/restored keys, and keys that could not be imported. Keep the old count-only entry point only if compatibility requires it. Do not infer readable-message count from the key count.
2. Show the active account and homeserver context in the recovery result. Show the key counts and a useful retry path. Never show room names or message text in diagnostic output. Wrong keys and network failures must retain the recovery form and must not report success.
3. Add a regression test that holds an attachment upload open, sends a short text message in the same room, and proves that the text send reaches the Matrix sender before the upload completes. Keep encrypted media size limits and encryption requirements unchanged.
4. Split text-send gating from attachment-upload state. Track concurrent work without allowing a completion from one upload to clear the busy state for another operation. Preserve slow-mode checks, pending text deduplication, message order as returned by Matrix, and failed-message retry behavior.
5. Add deterministic tests for overlapping uploads, text during upload, upload failure, retry, and late completion after page/account disposal. Record device acceptance as pending until tested on two phones and one desktop client over a constrained network.

### P1 — Explicit, narrow AI context authorization

1. Make inline contextual AI default to no conversation context until the user grants a one-shot permission.
2. Show the exact candidate messages and let the user select which ones to share. Bind the one-shot grant to the logged-in Matrix user, device/session generation, room, message IDs, purpose (`smart_reply`), and a short expiry.
3. Send only the selected text and required role labels to the AI provider. Do not send member lists, room metadata, unrelated history, or message attachments.
4. Consume the grant once. Invalidate it on expiry, account/client change, room change, cancellation, or removal of the AI target. If identity changes while a request is in flight, discard the response and do not place it in the new account's room.
5. Keep user-entered standalone assistant prompts, selected draft rewrite, and explicit image-analysis actions separate. They must not silently acquire room-history permissions.
6. Test default denial, exact-message selection, purpose/room/account mismatch, expiry, cancellation, duplicate requests, and late responses after account change. Do not claim server-side webhook restrictions: current group webhooks run from a foreground client and require a separate durable service design.

### P2 — Verifiable payment and delivery receipt contract

1. Define a versioned receipt payload with request/idempotency ID, exact chain and network, asset type and contract/native identity, decimal amount string, sender and recipient addresses, transaction hash, creation time, and a lifecycle state: `awaiting_signature`, `broadcast`, `confirmed`, or `failed`.
2. Add an optional wallet capability for exact transfer submission and receipt verification so older `IWalletBridge` hosts continue to compile. A legacy hash-only result remains `broadcast/unverified`; it must never render as confirmed.
3. Verify a receipt against the selected network and exact asset fields through the host's chain adapter. Reject mismatched chain, token/contract, sender, recipient, amount, empty/malformed hash, unsupported verifier, or insufficient confirmations. Expose reorg/failed outcomes rather than converting them to success.
4. Send the receipt as a structured Matrix message inside the encrypted room. Keep memos and social graph data off-chain. Only consider a salted commitment after a contract, chain, consent text, and disclosure review exist; this phase does not submit an on-chain commitment.
5. Keep local demo red packets visibly marked as demo and separate from verified wallet transfers. Do not retrofit local claim balances as payment proof.
6. Test schema compatibility, tampering, replay/idempotency, exact-asset mismatch, verification unavailable, pending/broadcast/confirmed/failed transitions, and legacy hash-only behavior. Live chain, device-signing, and receiver-side independent verification remain external acceptance gates.

## Execution order and validation

1. Add this plan before implementation and confirm the baseline against the current Chat SHA and host pin.
2. Implement P0 and focused regression tests; run the complete recovery, message-send, and relevant page suites plus Chat analysis.
3. Implement P1 with no persistent/broad room grants; run service/helper and widget tests plus analysis.
4. Implement P2 contract/host capability in small compatibility-safe changes; run Chat and host bridge tests. Do not broadcast a transaction.
5. Run the full Chat suite with fresh LCOV on the final Chat commit, then enforce the host lockfile and run focused host adapter tests. Update `OPEN_ISSUES.md`, the plan, and both repositories' pinned source metadata with exact validation boundaries.
6. Treat two-phone/one-desktop recovery, constrained-network sends, configured AI provider/webhook tests, and signed live-chain verification as pending until performed in the target environments.

## Research references

- WhatsApp teen controls (2026-09-30): https://blog.whatsapp.com/new-controls-to-help-parents-guide-their-teens-on-whatsapp
- Telegram message buttons and new-member welcome messages (2026-08-25): https://telegram.org/blog/welcome-messages-buttons-TG-13
- Telegram guest AI bot scope (2026-05-07, earlier reference): https://telegram.org/blog/ai-bot-revolution-11-new-features
- LINE LIFF security release notes (2026-09-30): https://developers.line.biz/en/docs/liff/release-notes/
- Apple platform updates (2026-09-14): https://www.apple.com/newsroom/2026/09/major-updates-for-apples-software-platforms-are-now-available/
- Signal encrypted backup improvements: https://signal.org/blog/backup-improvements/

These products provide design references only. Their features do not establish N42 Chat behavior or acceptance.

## Execution record

- P0 source changes: added a typed room-key restore report with total, restored, and failed session counts; the recovery-key dialog shows the active account and homeserver and keeps partial failures visible without exposing room identifiers. It describes keys, not restored messages. Text sends now have a separate busy flag from concurrent image, voice, file, and video uploads. Encrypted media size and E2EE checks are unchanged.
- P1 source changes: removed message-triggered automatic AI requests. Opening Quick Reply presents up to six eligible messages with none selected; only the selected text is sent. The one-shot decision is held only during the request, checked against the same user/client/room and unchanged selected message snapshot, and the result is discarded if the account/client/room changes or the latest incoming message advances. No grant is persisted. Other AI entry points remain separate and require a follow-up privacy audit before broad AI authorization claims.
- P1 follow-up: group summaries show a per-message consent dialog with no items selected by default. Only selected, unchanged messages are sent. The grant is checked against the same Matrix user/client/room before the request and again before displaying its result. The selected count appears on the summary bubble. Widget tests cover selected-only consent and cancellation.
- P2 source changes: wallet success now means `processing`/submitted, not `completed`; repository status updates reject completion without a verified chain receipt, and incoming Matrix transfer events cannot claim a completed card. A payment request does not emit a paid event before confirmation. Chat preserves exact sender, receiver, chain, network, asset, and amount metadata and exposes a receipt-check action. N42WalletBridge verifies native EVM and standard ERC-20 transactions against the configured RPC, checks RPC chain ID plus transaction/calldata/log fields, and requires 12 mainnet or 1 testnet confirmation. Rechecking clears a previous local confirmed marker when the result is no longer confirmed. This is session-local verification, not receiver-device acceptance or durable settlement; non-EVM assets, reorg monitoring, idempotency/replay protection, and salted commitments remain open under `PAYMENT-RECEIPT-001`.
- Final validation: the complete Chat suite passed 7,316 tests, skipped 3, and failed 0 (excluding 606 hidden setup/teardown events). Fresh raw LCOV is 97,065 / 138,553 = 70.0562%. The new consent-dialog, transfer-status, and Matrix message-mapping tests passed. Chat and the nine changed Dart files analyze without errors or warnings; the full analyze run reports 301 informational lints across the repository. The host wallet bridge behavior suite passed 7 tests in the prior validation, including exact-capability opt-in. Use Flutter 3.47.5 / Dart 3.13.4; system Flutter 3.44.8 / Dart 3.12.2 cannot compile this package's Dart 3.13 language level.
- Remaining acceptance: test account switching and recovery on two phones plus a desktop over constrained network; verify receipts from a separate receiver device on supported test networks; exercise reorg/replay behavior and durable settlement policy. No wallet transaction was sent and no production Matrix/AI provider was contacted.
- Receipt follow-up validation (2026-10-06): the Matrix metadata and transfer-repository suites passed 33 tests; targeted Chat analysis reports no errors or warnings. The host verifier suite passed 7 deterministic native/ERC-20 cases against a fake RPC, and host analysis reports no errors or warnings. The host test temporarily pointed its ignored package configuration at the local Chat checkout so it compiled the pending Chat API; the committed host dependency pin still needs the new immutable Chat SHA. No real RPC transaction or receiver device was used.
