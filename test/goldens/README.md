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
