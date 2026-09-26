# Historical Vodozemac pickles

`vodozemac-0.5-pickles.json` contains newly generated, synthetic **legacy-format** account identity, inbound Megolm and outbound Megolm encrypted pickles. All private material and the pickle key here are public test data, never a user's account.

The writer really ran **vodozemac 0.5.0**, **flutter_rust_bridge 2.11.1**, and the native macOS universal framework published in **flutter_vodozemac 0.6.0**, matching the previously shipped dependency family. It did not generate these using the new 0.8 code. The isolated harness under ignored `.dart_tool/task13-legacy-vodo/` used exact package versions, no dependency overrides, and a symlink to the matching read-only published native artifact. Its FRB initialization/handshake succeeded. `legacy-harness.lock` records the full resolved writer graph.

Published package archive SHA-256 (pub cache hosted hash records):

- flutter_vodozemac 0.6.0: `4503bc4a33a5126539fe68eecbf736eafe412474874a2ebbfc94aef0b0d2e304`
- vodozemac 0.5.0: `bbe7dd31d7f623e2aeedb92e4b71a8b519e6109ce1e2911b5a220f6752b65cda`
- flutter_rust_bridge 2.11.1: `37ef40bc6f863652e865f0b2563ea07f0d3c58d8efad803cc01933a4b2ee067e`
- Old native framework executable: `3ea422528a42564c6b0a8ceb0cd94e4889ce3c844efe40f4bbad9146451757aa`
- Fixture JSON: `fb333c76054d891503537433db553aa25c1210581a6c96540b617e0c536d74da`

Inspected production persistence formats in Matrix 6.0.0:

- `lib/encryption/olm_manager.dart:45,86`: encrypted Account pickle and restore.
- `lib/encryption/key_manager.dart:168,490`: encrypted inbound/outbound Megolm pickles.
- `lib/encryption/utils/pickle_key.dart:4`: user-ID code units, zero-padded or truncated to 32 bytes. The generator uses this exact derivation for the fictional `@fixture:example.org` identity.

Reproduction on macOS:

1. Create an isolated Dart project with exact `vodozemac: 0.5.0` and `flutter_rust_bridge: 2.11.1`; use the committed writer lockfile and resolve dependencies.
2. Copy `generate_legacy_fixture.dart` into that project.
3. Symlink `lib/libvodozemac_bindings_dart.dylib` to the old package's `macos/flutter_vodozemac/flutter_vodozemac.xcframework/macos-arm64_x86_64/flutter_vodozemac.framework/flutter_vodozemac` executable.
4. Run `dart run generate_legacy_fixture.dart /absolute/harness/lib/ /absolute/output.json` using Flutter 3.47.5's Dart 3.13.4. Random generation makes new keys/ciphertexts and a different hash.

The new package's real native ABI test imports all three old pickles, compares both account public keys, verifies the old signature and reproduces it with the restored private key, decrypts the old ciphertext, and continues outbound encryption at the preserved session state. Wrong account/session pickle keys are rejected. This verifies native pickle continuity; Android keystore and secure-storage namespace migration remain separate Task 13B work.
