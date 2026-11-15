# Mini App security policy and signed launch protocol v1

SDK security version: `1.1.1`. This is the native bridge version, not a page-supplied JavaScript version or the host app store version.

## Trust and behavior

`N42ChatConfig.miniAppSecurity` accepts a HTTPS policy URL, separate pinned Ed25519 public-key maps for policies and launches, an audience and a trusted HTTPS upgrade URL. No signing private keys belong in the app. Keys are base64url-encoded 32-byte Ed25519 public keys. `keyId` selects an already pinned key; a link cannot introduce a trusted key.

Without a policy URL, only bundled Mini App manifests and their base URLs can launch unsigned. Business deep links require signed claims even in this mode. A configured remote policy URL makes missing, invalid or expired policy fail closed. Ordinary chat remains usable. Arbitrary app manifests and additional manifest permissions are rejected.

The policy refresh interval is five minutes while the service is active. Validity is bounded by signed timestamps and fifteen-minute local age, with an additional monotonic clock. App resume and launch refresh; the page checks each minute and every native bridge call checks again. Background OS suspension is not a delivery guarantee. Measure the <=30-minute production goal on real devices, including offline/resume; do not count a client unit test as deployment acceptance.

Policies must use a monotonically increasing revision. The signed payload of an existing revision is immutable. The highest revision/payload pair and unexpired consumed launch nonces persist in local preferences. Managed mode starts closed after restart until a new verified fetch succeeds. Local storage reset or another device is not a server-side replay defense. Backend business endpoints must independently validate audience, signature, authorization and single-use nonce/transaction IDs.

## Envelope and payload

The policy endpoint returns HTTP 200, at most 64 KiB, without redirects:

```json
{"keyId":"policy-2026-10","payload":"BASE64URL_OF_EXACT_UTF8_JSON_BYTES","signature":"BASE64URL_ED25519_SIGNATURE_OVER_PAYLOAD_BYTES"}
```

The decoded policy payload:

```json
{"aud":"n42chat-miniapp","revision":1,"iat":1792764000,"exp":1792764900,"minVersion":"1.1.0","deniedVersions":[],"deniedAppIds":[]}
```

Use current Unix seconds when issuing. The example timestamps are illustrative and expire. `exp > iat`, no future `iat`, maximum lifetime 900 seconds. Versions require three numeric components without prerelease suffixes or leading zeroes. Invalid data never means “allow all”. Add an app ID to `deniedAppIds` for a kill switch; add a bridge version to `deniedVersions` or advance `minVersion` for an upgrade requirement. Restore access only through a newer signed revision.

A launch uses the same envelope with the separate launch key and claims:

```json
{"aud":"n42chat-miniapp","appId":"n42_shop","target":"https://shop.n42.world/offer?item=1","nonce":"AT_LEAST_22_BASE64URL_CHARACTERS","iat":1792764000,"exp":1792764300}
```

Encode the **whole launch envelope JSON** as base64url, append it as the unique `n42_launch` query parameter to the target. Maximum launch lifetime: 300 seconds. Sign the canonical URL produced by Dart `Uri` using unique query parameters in wire order; scheme, origin, path, query and fragment are covered. After verification, the envelope is removed before loading the page. The bridge does not expose the signature, private key or tokens to the page. Each page load receives a new native channel nonce; absent/stale nonces and revoked sessions cannot call native channels. Callback responses also recheck document identity after asynchronous operations.

Unsigned custom `n42chat://miniapp/<id>` links are base-entry shortcuts only. Their query/fragment suffixes are rejected rather than silently discarded. `redirect`, `redirect_uri`, `redirect_url`, `return_url`, `returnto`, `next`, `url`, `token`, `access_token`, `id_token` and `authorization` query parameters are prohibited on Mini App URLs. Account login uses the separate OAuth flow with exact callback endpoint matching, unique parameters and cryptographically random checked `state`.

## Deployment and acceptance

1. Operate an authenticated policy publishing service. Separate publish approval from the read-only HTTPS endpoint. Require strong authentication, audit changes and keep signing keys outside source/app builds.
2. Ship pinned public keys, endpoint, environment-specific audience and a valid upgrade destination through the host config. Keep staging/prod signing keys and audiences separate. Deploy a fresh allow policy before enabling managed mode.
3. Run the signed-policy tests and URL corpus; use the same attack cases on iOS/Android WebViews, system links and external-browser return paths. Confirm no token-bearing URL reaches logs or third-party origins. Verify current SDK and the policy revision in the operator's private test record.
4. Publish a new revision that disables one test app, then one SDK version. Keep a page open with a pending confirmation. Record publication time, device connectivity, rejection time and recovery/upgrade UI. Resume a suspended app and disconnect a device for >15 minutes. All native operations must fail closed without needing to reopen the page.
5. Restore with a newer revision. Replay an old signed policy, reuse a launch on the same device after restart, tamper with target/audience/expiry, replace a trusted key and test an unavailable upgrade URL. No white-screen or retry loop is acceptable.
6. Measure normal-link rejection on representative opted-in traffic. The 220 synthetic normal cases are regression checks, not evidence for the production <0.5% target. Do not collect raw query strings, identities or signatures in telemetry.

The repository supplies a client gate and protocol. It does not deploy a policy issuer, short-link resolver, merchant admin service, NFC tag hardware, universal-link association files or server-side business authorization.
