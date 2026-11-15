# Chat golden tests

`chat_core_golden_test.dart` protects the light and dark rendering of core chat
surfaces at a fixed 390 x 760 logical-pixel viewport. The fixture covers
incoming, outgoing, and failed message bubbles, conversation rows, unread and
muted states, and a message rendered at 1.3x text scale.

Run the comparison locally with:

```sh
flutter test --no-pub test/goldens/chat_core_golden_test.dart
```

Only update the checked-in PNGs after reviewing the visual change:

```sh
flutter test --no-pub --update-goldens \
  test/goldens/chat_core_golden_test.dart
```

Flutter widget tests use the deterministic Ahem test font. These images are
therefore a stable check for spacing, radii, wrapping, font size, and theme
colors, rather than a substitute for reviewing platform glyph rendering on
Android and iOS devices.

The fixture must have a Material ancestor. A regression assertion rejects the
MaterialApp error fallback text style and its yellow underlines before image
comparison. Section headings use titleSmall, rather than the white primary
button label style. Both baselines were regenerated after repairing that
fixture; production widgets and pixel tolerances are unchanged.

The Chat golden regression workflow compares exact pixels on Linux with
Flutter 3.47.8 and preserves difference PNGs on failure. Local comparison is
necessary but does not replace that Linux check.

macOS and Linux keep separately reviewed baselines, selected by the actual host
OS (not Flutter's simulated target platform). The first Linux run of the repaired
Material fixture still differed by 11,130 glyph pixels in each theme, while
layout and message wrapping matched the reviewed images. Linux renders the Ahem
glyph edges differently from macOS. Both platform baselines retain strict pixel
comparison. The CI matrix runs both hosts; a new host needs reviewed baselines
rather than a skipped test or a relaxed threshold.

The macOS job uses the xcode-27 runner family, matching the macOS 27 family
on which the reviewed macOS baseline was generated (local host 27.2). A first
macos-latest run used macOS 26.6.2 and differed by four/six icon-edge pixels
with channel deltas of at most three. No comparator tolerance was changed;
the aligned runner still needs a successful comparison.
