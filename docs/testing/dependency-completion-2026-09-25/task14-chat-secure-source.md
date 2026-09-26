# Task 14 Chat secure-storage source integration

Date: 2026-09-26. Chat base: `5deb59cf627a7ee686c9fb8dd0c4b8144f20cf0f`.

Chat's direct `flutter_secure_storage` dependency and both top-level source overrides select the reviewed app commit `9733aa21eb7e4fa98c2aa8a287ef9588960023c2`. The package subpaths are `packages/flutter_secure_storage` (11.2.0) and `packages/facebook_auth_desktop` (2.1.3). Chat is distributed through an immutable Git revision, so `publish_to: none` permits the required direct Git dependency without an analyzer publishability warning. No Chat runtime storage format, default options, or key names changed. The maintained Android adapter maps Chat's default options to its isolated v11 default namespace and imports eligible historical values before use.

Pub requires one source for a package in each resolution. The maintained desktop plugin declares a hosted secure-storage version, so Chat and its example each override both package names to the same reviewed Git revision. Dependency overrides of a Git dependency are **not inherited** by a consuming app: the host must repeat these exact two Git overrides until the upstream bounds and source contract are reconciled. A version-only or path override would not prove the reviewed migration adapter is present.

Both `pubspec.lock` files contain `source: git`, the package subpaths, and exact `resolved-ref: 9733aa21eb7e4fa98c2aa8a287ef9588960023c2` for both packages. Both `.dart_tool/package_config.json` files point to the same immutable pub-cache Git checkout. Source provenance and native upgrade evidence are in the host's `docs/testing/dependency-completion-2026-09-25/secure-storage.md`; those tests are not repeated here.

Verification with Flutter 3.47.5 / Dart 3.13.4:

- `flutter pub get --offline`: passed for Chat and its example with real Git sources; the initial online resolve also passed. [Resolution log](task14-chat-pubget.log.gz).
- `flutter analyze --no-fatal-infos`: exit 0, zero errors/warnings, 284 existing infos. [Analysis log](task14-chat-analyze.log.gz).
- `flutter analyze --no-fatal-infos` from `example/`: no issues. [Example analysis log](task14-chat-example-analyze.log.gz).
- Focused secure-storage, auth, call, SQLCipher/archive and Matrix tests: 113 passed. [Focused test log](task14-chat-focused.log.gz).
- `flutter test test/ --concurrency=4 --reporter expanded`: 6,782 passed, 3 existing skips, zero failures. [Full test log](task14-chat-full.log.gz). The full log includes expected fixture error prints from unavailable map tiles and simulated backup/network failures; the final test summary is green.

The compressed log SHA-256 values, in the order above, are `4e8a59d7136f8ebe503e491a1da28bd9ba1d3c9fd21e87cad0d110e45c585e28`, `ac02a39a998efca1bd7cf025d08e43df8cfcbef1a7acfb066d6cdd931ee1fe54`, `7b91374cab8fa130eb8549d65a89610429896e043f77ab3a88d623e0707d78d1`, `f0aac02fe72e7c22e0d58a0436cec8c19630e3d80b7d50516e43ccf14f110d70`, and `44e03a3ad16fdbce4e7985d11f8dffffa7e8aec98ecac001ba15407082e6ef20`.

The focused tests use the resolved Git package's Dart API and fake platform storage; they do not substitute for the Task 13B real Android upgrade fixture or final host native builds. The host graph and native integration remain pending Task 14.
