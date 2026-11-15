# Synthetic media decode verification — 2026-11-07

Chat source: `ca0d02eb` (documentation-only change after tested source `ad7ce8c4`). Flutter 3.47.8 host test on macOS.

Generated the existing reproducible corpus with `dart run tool/weekly_benchmark/generate_image_corpus.dart /tmp/n42-media-corpus-20261107`. Ran `N42_MEDIA_CORPUS=/tmp/n42-media-corpus-20261107 flutter test --no-pub test/benchmarks/media_decode_baseline_test.dart`, exit 0, one passed test and no skips. All 200 PNG RGB/RGBA, JPEG, GIF and BMP samples passed byte SHA-256 and decoded dimensions checks. Host first-frame decode p95: 1014 microseconds. This is a single synthetic host run, not a mobile performance threshold or production failure-rate result.

`python3 -m unittest discover -s tool/weekly_benchmark -p 'test_*.py'`: four passed tests, exit 0.

Remaining: real camera/media corpus, animated/video codecs, malformed files, HDR/P3 accuracy, peak memory, live encrypted upload/download, weak network and native iOS/Android acceptance. RSS snapshots do not measure peak RSS. No source behavior or packaged binaries changed.

## Local evidence hashes

- `/tmp/n42-media-corpus-20261107/manifest.json`: `3528bcd51d59bb9cfa29659893c23c94c2d12ca08599852133e9d10f300f2b69`
- `/tmp/n42-media-corpus-20261107/decode-results.json`: `2ad40f9ed652ef758a3d421bfc87691ef04e9891afcdb224293e0df4b7049e74`
- `/tmp/n42-media-decode-20261107.log`: `1e598a356e746571dad8c9eb292e794909f27390ee6a93b9ef477bcc8234112f`
