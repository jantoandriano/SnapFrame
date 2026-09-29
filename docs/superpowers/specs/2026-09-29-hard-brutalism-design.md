# SnapFrame → Hard Neo-Brutalism Re-skin

## Context
SnapFrame already runs a *soft* neo-brutal look: cream bg, neon palette (lime/pink/sun/blue/lilac), 2.5px ink borders, 4px hard shadows, but **rounded 12–28px corners, pill chips, polite type, stock Material AppBar**. User likes the vibe, wants it more eye-catching by leaning into brutalism.

**Decisions (from user):**
- Direction: **Hard neo-brutal** — keep neon palette + fun Gen Z energy; go square, thicker, louder shadows, big uppercase display type, tilted stickers.
- Scope: **System + screens** — retune tokens/type, restyle all `core/widgets`, add brutal app bar + Material component themes, then polish all 7 screens. Flows/layout structure unchanged. No new packages/fonts.

**Success:** every screen reads unmistakably brutal (no soft corners/pills left, no stock Material chrome), light + dark both work, `flutter analyze` + `flutter test` green with regenerated goldens.

## Design

### 1. Tokens — `lib/core/theme/tokens.dart`
- `borderWidth` 2.5 → **3.5**; add `borderWidthThin = 2.5` (small stickers/dots).
- `SnapRadius`: `sm 12→2`, `md 20→4`, `lg 28→6`; **remove `pill`** (migrate its usages to `sm`).
- `SnapShadow`: `offset (4,4)→(6,6)`; add `small = (3,3)` (stickers, chips, selected tab) and `large = (10,10)` (hero images: result photo, frame detail preview). `pressedOffset` unchanged.
- Palette: keep all hues. Light `bg` stays cream. No new colors.

### 2. Typography — `lib/core/theme/typography.dart`
- Display styles (Bricolage w800): sizes up (displayLarge 56, displayMedium 44, displaySmall 36, headline 30/26/22), `letterSpacing -1.0`, `height 0.95`.
- `titleSmall/Medium/Large` → w800 Bricolage for card/button titles; `labelLarge/Medium/Small` → Space Grotesk w700, `letterSpacing 0.8` (sticker/chip labels).
- Uppercasing happens in widgets (`label.toUpperCase()`), not TextTheme (Flutter has no text-transform). Wrap with `Semantics(label: original, excludeSemantics…)` where needed so screen readers don't spell letters.

### 3. Theme — `lib/core/theme/app_theme.dart`
Add component themes so leftover Material bits match:
- `appBarTheme`: bg `tokens.bg`, `elevation 0`, `scrolledUnderElevation 0`, `shape: Border(bottom: BorderSide(ink, 3.5))`, uppercase-ready `titleTextStyle` = headlineMedium, `iconTheme` ink, `centerTitle false`.
- `progressIndicatorTheme` (ink/lime), `dialogTheme` + `bottomSheetTheme` (square, ink border), `iconButtonTheme` (square ink-bordered).
- RefreshIndicator picks up `colorScheme.primary` already — verify.

### 4. New widget — `lib/core/widgets/snap_app_bar.dart` (export in `widgets.dart`)
`SnapAppBar implements PreferredSizeWidget`: `title`, optional `accent` color block (default `tokens.sun`), square ink-bordered back button with small shadow, UPPERCASE title, 3.5px bottom rule. Replaces `AppBar(...)` in `browse_view.dart:52` and `frame_detail_view.dart:43`.

### 5. Core widget restyle (pattern: swap radii/shadow/border to new tokens, uppercase labels)
- `chunky_button.dart` — radius `md`, shadow 6, border 3.5, UPPERCASE label, icon 22. Press-sink behavior unchanged.
- `frame_card.dart` — square card, shadow 6, title UPPERCASE w800, placeholder lilac block; PRO sticker tilt kept.
- `sticker_badge.dart` — radius `sm`, `small` shadow, bolder label; widen assert to −8..8° and default −6°.
- `pill_tab_bar.dart` (`PillTabBar`, `PillChip`) — square segments/chips; selected chip: pink fill + `small` shadow; unselected: flat surface. Keep class names (avoid churn).
- `brutal_text_field.dart` — radius `sm`, focused = lime-tinted fill + `small` shadow appears.
- `snap_snack.dart`, `slot_strip.dart`, `captured_overlay.dart`, `loading_blob.dart` (square dots), `empty_state.dart` — token swap only.
- `countdown_overlay.dart` — unchanged (already stroked numerals).

### 6. Screen polish (no flow changes)
- **Splash** — wordmark in tilted sun color block, big shadow.
- **Login** — title as UPPERCASE block on `sun`, rotated −2°, large shadow; fields/buttons inherit.
- **Browse** — `SnapAppBar` (sun); grid spacing +4 so 6px shadows don't collide; keep current uncommitted edits in this file intact.
- **Frame detail** — `SnapAppBar`, preview uses `SnapShadow.large` + `SnapRadius.lg`.
- **Capture** — top labels/flip button as bordered square chips on camera; shutter stays functional, restyled square.
- **Review** — slot strip inherits; header UPPERCASE.
- **Result** — title as tilted lime block, photo with `large` shadow, button row inherits.

## Implementation order
0. Branch `feat/hard-brutalism` off `main`. Leave existing uncommitted changes (`android/app/build.gradle.kts`, `browse_view.dart`) untouched/unstaged in my commits.
1. Save this design as `docs/superpowers/specs/2026-09-29-hard-brutalism-design.md`, commit.
2. Tokens + typography + app_theme (commit).
3. `SnapAppBar` + core widgets, updating widget tests (commit).
4. Screens (commit per 2–3 screens).
5. Regenerate goldens, full verification, README screenshot note if needed.

## Tests to touch
- `test/core/widgets/*_test.dart` — `find.text('Label')` → uppercase where widget now uppercases (chunky_button, pill_tab_bar, frame_card, sticker). 13 `find.text` hits across 7 files; audit each.
- Add `test/core/widgets/snap_app_bar_test.dart` (renders uppercase title, back button pops, light/dark golden).
- Goldens in `test/core/widgets/goldens/` regenerate via `--update-goldens`; eyeball the diffs.

## Verification
- `flutter analyze` — clean.
- `flutter test --update-goldens` then `flutter test` — all green; open new golden PNGs to visually confirm square/thick/shadow look.
- `grep -rn "SnapRadius.pill\|AppBar(" lib` — no hits outside `SnapAppBar`.
- Run app (`flutter run -d chrome` or device): walk splash → login → browse → detail → capture → review → result in **light and dark**; check no clipped shadows, text overflow at large text scale, tilted blocks not overlapping SafeArea.
