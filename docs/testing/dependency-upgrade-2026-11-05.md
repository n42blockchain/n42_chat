# Dependency upgrade acceptance — 2026-11-05

- Flutter 3.47.8 / Dart 3.13.7.
- Matrix 13 → 15, flutter_vodozemac 0.8.1 → 0.9.0, vodozemac 0.8 → 0.9, Firebase Core 5 / Messaging 17, Slidable 5.
- Keep Equatable 2.1: the wallet host fl_chart 1.3 requires Equatable 2. A forced override would bypass a real incompatible major constraint.
- Reviewed secure-storage and desktop Facebook immutable source stays at 9733aa21eb7e4fa98c2aa8a287ef9588960023c2.
- Full Flutter suite passed (JSON runner success=true, 4 intentionally skipped cases). This includes the packaged Vodozemac ABI, legacy encrypted pickles and continuing Megolm messages.
- Whole analyzer: exit 0; 308 existing info diagnostics, no errors/warnings.
- Added real SQLite schema-11 → schema-12 migration checks for both outdated flags, retained direct trust, key lists, last sent Olm message, account/session/history bytes, and reopen idempotence.
- Local automated acceptance does not prove physical-device push, existing installed account migration, or live multi-device homeserver acceptance. See OPEN_ISSUES.md.
