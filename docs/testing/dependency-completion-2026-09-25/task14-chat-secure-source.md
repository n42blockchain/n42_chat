# Task 14 Chat secure-storage source integration

Date: 2026-09-26. Chat base: `5deb59cf627a7ee686c9fb8dd0c4b8144f20cf0f`.

Chat's direct `flutter_secure_storage` dependency and both top-level source overrides select the reviewed app commit `9733aa21eb7e4fa98c2aa8a287ef9588960023c2`. The package subpaths are `packages/flutter_secure_storage` (11.2.0) and `packages/facebook_auth_desktop` (2.1.3). Chat is distributed through an immutable Git revision, so `publish_to: none` permits the required direct Git dependency without an analyzer publishability warning. No Chat runtime storage format, default options, or key names changed. The maintained Android adapter maps Chat's default options to its isolated v11 default namespace and imports eligible historical values before use.

Pub requires one source for a package in each resolution. The maintained desktop plugin declares a hosted secure-storage version, so Chat and its example each override both package names to the same reviewed Git revision. Dependency overrides of a Git dependency are **not inherited** by a consuming app: the host must repeat these exact two Git overrides until the upstream bounds and source contract are reconciled. A version-only or path override would not prove the reviewed migration adapter is present.

Both `pubspec.lock` files contain `source: git`, the package subpaths, and exact `resolved-ref: 9733aa21eb7e4fa98c2aa8a287ef9588960023c2` for both packages. Both `.dart_tool/package_config.json` files point to the same immutable pub-cache Git checkout. Source provenance and native upgrade evidence are in the host's `docs/testing/dependency-completion-2026-09-25/secure-storage.md`; those tests are not repeated here.

Verification with Flutter 3.47.5 / Dart 3.13.4:

- `flutter pub get`: passed for Chat and its example with real Git sources.
- `flutter analyze --no-fatal-infos`: exit 0, zero errors/warnings, 284 existing infos.
- `flutter analyze --no-fatal-infos` from `example/`: no issues.
- Focused secure-storage, auth, call, SQLCipher/archive and Matrix tests: 113 passed.
- `flutter test test/ --concurrency=4 --reporter expanded`: 6,782 passed, 3 existing skips, zero failures.

The focused tests use the resolved Git package's Dart API and fake platform storage; they do not substitute for the Task 13B real Android upgrade fixture or final host native builds. The host graph and native integration remain pending Task 14.
