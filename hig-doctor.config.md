# HIG audit: what is configured, and what is left

```bash
npx hig-doctor . --exclude "build/**,coverage/**,example/**,**/*.g.dart,**/*.freezed.dart,**/generated/**"
```

audits this package against Apple's Human Interface Guidelines. It found
nothing critical and nothing serious — no missing labels, no unreachable
controls. What it did find is 2414 hardcoded colours and font sizes, held at a
baseline rather than rewritten.

## Turned off

Theme and colour files — `lib/src/core/theme/app_colors.dart`,
`n42_chat_theme.dart` and friends — are *where* literals belong; flagging a
token definition for containing one is backwards. Tests and the example app are
off for the same practical reason: nothing a user sees. That accounts for 145 of
the original 2559.

## Held at a baseline: 2414 findings

`.hig-baseline.json` snapshots what exists today, so the audit reports **new**
occurrences only.

| Rule | Count | What it is |
|---|---|---|
| `flutter/hardcoded-font-size` | 1341 | `fontSize: 14` and friends, bypassing the type scale |
| `flutter/colors-red-blue` | 839 | `Colors.white`, `Colors.black.withValues(...)`, `Colors.grey[600]` |
| `flutter/hardcoded-color` | 379 | `Color(0xFF...)` written at the point of use |

None of it is mechanically rewritable. `Colors.white` on a dark bubble is
correct; the same literal on a surface that flips in dark mode is a bug, and the
two look identical to a regex. Each one has to be read against the surface it
paints and checked in both themes.

## How to work it down

The head is short — five files hold a seventh of the total:

1. `lib/src/presentation/pages/chat/message_item.dart` (86)
2. `.../red_packet/red_packet_detail_page.dart` (52)
3. `.../contact/contact_list_page.dart` (47)
4. `.../call/group_call_screen.dart` (42)
5. `.../red_packet/send_red_packet_page.dart` (39)

One file at a time: run that screen in light and dark, move its literals onto
`AppColors` and the type scale, then re-run with `--write-baseline` so the
snapshot shrinks with the debt.

## In CI

```bash
npx hig-doctor . --exclude "<the list above>" --fail-on moderate
```

Passes today; fails the moment new hardcoded colour or type appears.

## Note

This package is also vendored into `n42appv2` under `packages/n42_chat`, which
carries its own baseline covering that copy. Fixes made here should be carried
across, or the two snapshots will drift.
