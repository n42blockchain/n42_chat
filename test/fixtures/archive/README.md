# Historical SQLCipher archive fixture

`sqlcipher-4.10-archive.db` is synthetic test data written by **SQLCipher 4.10.0 community**, not the new 4.19 runtime. Its public raw hexadecimal key is 64 lowercase `a` characters. It contains one fictional message, schema version 1, and the historical FTS insert trigger. No user data or production key is present.

The writer used the existing, read-only SQLCipher 4.10.0 CocoaPods amalgamation at `ios/Pods/SQLCipher/sqlite3.c` in the host checkout. Host `Podfile.lock` identifies SQLCipher 4.10.0 (podspec checksum `eb79c64049cb002b4e9fcb30edb7979bf4706dfc`). The actual writer reports `PRAGMA cipher_version = 4.10.0 community` before writing.

SHA-256:

- Source amalgamation: `de78ef087cbc26e8fe584de05f1790f3e34897db8731e8154dc674d3f2df28cb`
- Local macOS writer dylib: `e70b9bbf738db6ce3cb067fb05e07b02003d5ae323a447d7ece88f24a986a7fe`
- Committed fixture: `cf488c02d1c00c519f5d20e57ae68b4122165b2e0d57b797bd5029242e9a5821`

Reproduce on macOS using an independently verified 4.10.0 amalgamation (the database salt is randomized, so a regenerated fixture has a different hash):

```sh
clang -dynamiclib -O2 -DSQLITE_HAS_CODEC -DSQLCIPHER_CRYPTO_CC \
  -DSQLITE_TEMP_STORE=2 -DSQLITE_ENABLE_FTS5 -DSQLITE_THREADSAFE=1 \
  -DSQLITE_EXTRA_INIT=sqlcipher_extra_init \
  -DSQLITE_EXTRA_SHUTDOWN=sqlcipher_extra_shutdown \
  /path/to/SQLCipher-4.10.0/sqlite3.c -framework Security \
  -framework CoreFoundation -o /tmp/libsqlcipher-4.10.0.dylib
python3 test/fixtures/archive/generate_legacy_fixture.py /tmp/libsqlcipher-4.10.0.dylib
```

`archive_sqlcipher_migration_test.dart` opens this fixture through the production `ArchiveDatabase.getInstance()` path under the new SQLCipher native asset; secure-storage access alone is mocked. Native ciphertext operations are real. Android keystore migration is outside this fixture's coverage.
