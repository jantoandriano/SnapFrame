# SnapFrame

A Gen Z / neo-brutalist mobile photobooth app for iOS and Android, built with Flutter and strict MVVM.

This is through **Milestone 2** plus a UI-only slice of **Milestone 3**: Splash → Login → Browse (home) →
Frame Detail → the Milestone 2 capture/review/result loop, all running end-to-end — but against a fake,
in-memory backend, not Firebase. See "Milestone 3 is UI-only, on purpose" below for why and what that
means concretely.

## The capture flow

1. **Frame Detail** — pick a **3s or 5s countdown** (defaults to the frame's own `countdownSec` if it's one
   of those). The choice travels into capture as a copy of the frame with `countdownSec` overridden, so
   retakes from Review reuse it too.
2. **Capture** — each slot is shot in order on an automatic countdown. A full-screen white flash marks
   every shot; the "📸" icon only appears on the **final** one. After each shot a **"got it!"** confirmation
   (the photo popping in as a tilted polaroid, then shrinking away) holds for `capturedHoldDuration` (1s)
   before the next countdown starts.
3. **Review** — the composited frame plus a thumbnail per slot. Tap a thumbnail to **retake** just that
   slot. While the frame recomposes the old preview dims under a loader, the new one pops in, the retaken
   thumbnail gets a lime highlight, and a "pic N updated" snack confirms it.
4. **Result** — save to gallery, or **send to WhatsApp**: enter a number with its country code (formatting
   is stripped; a leading `0` is rejected as a missing country code). See "WhatsApp sharing" below for
   what that does per platform.

## Tech stack

Flutter **3.47.0** (stable) / Dart **3.13.0**.

| Layer / concern | Package | Version |
|---|---|---|
| ViewModel / state / DI | flutter_riverpod | 3.4.3 |
| | riverpod_annotation | 4.0.7 |
| | riverpod_generator (dev) | 4.0.9 |
| Routing | go_router | 17.5.0 (pinned `^17.3.0`, see note below) |
| | go_router_builder (dev) | 4.5.0 |
| Models / immutability | freezed_annotation | 3.1.0 |
| | freezed (dev) | 4.0.2 |
| | json_annotation | 4.12.0 |
| | json_serializable (dev) | 6.14.1 |
| Animation / vibe | flutter_animate | 4.5.2 |
| Logging | logger | 2.8.0 |
| l10n | intl | 0.20.3 |
| Lints | very_good_analysis (dev) | 11.0.0 |
| Codegen | build_runner (dev) | 2.16.1 |
| Testing | flutter_test, mocktail (dev) | 1.0.5 |
| Camera | camera | 0.12.1 |
| Compositing (JPEG encode only, see below) | image | 4.10.1 |
| Save / share | gal | 2.3.3 |
| | share_plus | 13.3.0 |
| WhatsApp share (Android `FileProvider`) | androidx.core:core (Gradle) | 1.13.1 |
| Confetti (Result screen) | confetti | 0.8.0 |

Packages further down the stack table in the spec (Firebase, purchases_flutter, permission_handler,
cached_network_image, lottie, audioplayers, google_sign_in, sign_in_with_apple, fake_cloud_firestore,
firebase_auth_mocks) still aren't dependencies — added, version-checked, and documented here in the
milestone that first needs them, same as before.

### Deviations from the spec, and why

- **go_router pinned to `^17.3.0`, not the latest 18.0.1.** go_router_builder 4.5.0 (latest) declares
  `go_router: ^17.3.0` as its own dev dependency. go_router 18.0.0 migrated its route widgets to
  `material_ui`/`cupertino_ui` — a real API surface change — and go_router_builder hasn't been
  re-verified against it. Pub won't block mixing them (that constraint is scoped to go_router_builder's
  own dev_dependencies, not enforced transitively), but generated-code compatibility is unverified.
  17.3.0 is the pairing go_router_builder is actually tested against.
- **Fonts are bundled as plain Flutter assets, not via the `google_fonts` package.** Bricolage Grotesque
  and Space Grotesk are only published by Google as variable fonts (single `[wght]` axis files, no static
  per-weight files). `google_fonts`'s offline self-hosting feature matches font files by a static
  `Family-Weight.ttf` naming convention and loads them dynamically via `FontLoader`, which doesn't select
  a variable font's weight axis correctly — every weight would render at the font's default instance.
  Instead, the same variable `.ttf` is declared multiple times in `pubspec.yaml` under different `weight:`
  values (a standard Flutter technique for variable fonts), which does respect the weight axis. This is
  fully offline either way; `google_fonts` isn't a dependency.
- **`LoadingBlob` uses a `flutter_animate` shape loop, not Lottie**, since there's no Lottie asset in the
  design system yet (the spec lists this as an explicit either/or). `lottie` isn't a dependency until a
  real animation file shows up, likely in the polish milestone.
- **Two lint rules disabled** in `analysis_options.yaml` beyond the standard `very_good_analysis` set:
  - `public_member_api_docs` — this codebase's convention is no comments unless a non-obvious WHY needs
    explaining; doc comments on every public member would be pure noise here.
  - `unnecessary_type_name_in_constructor` — new in Dart 3.13, wants `new()`/`new name()` instead of
    `ClassName()`/`ClassName.name()` constructor declarations. Not adopting a rewrite this fresh
    repo-wide; it reads unfamiliar to most Flutter tooling/devs right now for no functional benefit.
- **`flutter gen-l10n`'s synthetic package is gone.** Current Flutter generates straight to
  `lib/l10n/app_localizations.dart` (imported as `package:snapframe/l10n/app_localizations.dart`), not
  the old `package:flutter_gen/gen_l10n/...` path. Only matters if you've used flutter_gen before.
- **Compositing splits across isolates differently than the spec describes, for a hard engine reason,
  confirmed empirically:** `dart:ui`'s `PictureRecorder`/`Canvas` throw *"UI actions are only available on
  root isolate"* when called inside `compute()` — the actual Canvas drawing cannot be the backgrounded
  part. And separately, `dart:ui` has no JPEG encoder at all (`ImageByteFormat` is raw formats + PNG only)
  — the data contract wants `results/{uid}/{sessionId}.jpg`, so *some* encoder was never optional. Given
  both constraints, `core/compositing/compositor.dart` draws (decode + Canvas + crop + overlay) on the
  main isolate, then hands only the raw RGBA bytes to `compute()` for the `image` package's JPEG encoder —
  the one CPU-heavy step that both doesn't touch `dart:ui` and is the reason "background isolate" was
  worth doing in the first place. `image` is a new dependency purely for `encodeJpg`; everything else is
  still Canvas/PictureRecorder as specified.
- **The two bundled frames are placeholder art generated in-code**, not real design work — no such
  assets existed. `tool/generate_sample_frame.dart` draws both straight to PNG via Canvas:
  - `sample_overlay.png` — **classic strip** (free): 3 horizontal slots, lime chrome, ink border.
  - `photo_dump_overlay.png` — **photo dump** (Pro): a pink 2×2 grid of polaroid cards with hard shadows,
    tape strips and sparkles.

  Swapping in real artwork later is a file replacement, not a code change — each frame's `Frame.slots`
  and its PNG's cutouts share one layout source (`sample_frame_layout.dart`, `photo_dump_layout.dart`) so
  they can't drift apart, and `fake_frames_data_test.dart` checks every slot center is a transparent
  cutout of the right-sized PNG.
- **WhatsApp sharing targets a number via an undocumented intent extra on Android.** `share_plus` can't
  pick a target app or recipient, so `MainActivity.kt` exposes a `snapframe/whatsapp` MethodChannel that
  writes the JPEG to the cache dir, serves it through its own `FileProvider` (`WhatsAppShareProvider`), and
  launches WhatsApp (falling back to WhatsApp Business) with the chat preselected via the `jid` extra.
  WhatsApp reads `jid` but doesn't document it — if a future version drops it, the image still attaches
  and the user just picks the contact. iOS and web can't target a recipient at all, so they fall back to
  the system share sheet with the image. The public `wa.me` link wasn't an option: it can prefill text
  but can't attach an image.
- **`WRITE_EXTERNAL_STORAGE` uses `tools:replace` in the manifest.** `camera_android_camerax` declares it
  with `maxSdkVersion` 28 while the app needs 29 (for `gal`), and the manifest merger fails the Android
  build on the mismatch. The app's value wins.
- **`recordFrameUse` isn't called.** It's a Cloud Functions callable and there's no Firebase yet (that's
  Milestone 3) — wiring it against a backend that doesn't exist isn't meaningful yet.
- **Permission UX is functional, not polished.** `camera`'s `CameraController.initialize()` and `gal`'s
  `Gal.requestAccess()` trigger the native OS prompts themselves, and a denial surfaces as an `ErrorState`
  with a retry button. The rationale-sheet / "open Settings when permanently denied" treatment the spec
  asks for (§6) is deferred to the Milestone 6 polish pass, along with adding `permission_handler` — not
  needed for the bare functional path.
- **`AsyncValue.value` replaces `.valueOrNull`.** Riverpod 3.x made `AsyncValue.value` itself nullable and
  dropped the separate getter — `userAsync.value` is the whole answer now, no `valueOrNull` to reach for.
- **Filter chips are a `BrowseFilter` enum, not raw strings.** The first pass used the English chip label
  ("Free", "Pro", …) as both the display text and the ViewModel's filter key — harmless until the label
  gets localized, at which point a translated chip would stop matching the filter switch and silently show
  the wrong grid. Caught before it shipped; `BrowseFilter` is now the stable key, and the view maps it to
  a localized label separately.

## Milestone 3 is UI-only, on purpose

Splash, Login, Browse/Home, and Frame Detail are built and wired end-to-end, but against
`FakeAuthRepository` and `FakeFrameRepository` — in-memory stand-ins, not `firebase_auth`/Firestore. This
was a deliberate scope call, not a shortcut: there's no Firebase project to connect to yet, and wiring
real Firebase SDKs against nonexistent credentials would mean shipping a screen that can't actually run.
Concretely:

- **Auth**: email/password only (no Google/Apple yet). `FakeAuthRepository` accepts any well-formed
  email + 6-character password, no real account check — it's a flow stub — and signs them in as **free**.
  The one exception is the dummy Pro account below. Session state is a broadcast stream in memory,
  `keepAlive: true` so it survives navigation; it does **not** survive an app restart.
- **Frames**: `fake_frames_data.dart` is exactly two official frames — `sampleFrame` (classic strip, free)
  and `photoDumpFrame` (photo dump, Pro), each with its own overlay art. The Community tab is empty until
  real user frames exist. `reportFrame` is a stub that always succeeds.
- **Tier gating is real** — `FrameCard.isLocked` and the pro-frame tap check both compare against the
  signed-in fake user's `Tier`, exactly as they will against a real one. For a free user, tapping a locked
  frame shows a snack with the paywall copy instead of opening a paywall screen that doesn't exist yet
  (that's Milestone 4).
- **Dummy Pro account**: sign in as `pro@snapframe.app` / `snapframe` to get a Pro user and try Pro frames
  without a paywall. That email checks its password (anything else is "wrong password"); the credentials
  are hardcoded in `FakeAuthRepository` and go away with it when real Firebase auth lands.
- **Swapping in real Firebase later is a DI change, not a rewrite.** `AuthRepository` and `FrameRepository`
  are the same interfaces a `FirebaseAuthRepository`/`FirestoreFrameRepository` would implement; every
  ViewModel and View here only depends on the interface. When there's a real project, the fix is new
  `data/` implementations plus one line each in `auth_providers.dart` / `frame_providers.dart` — nothing
  in `presentation/` should need to change.
- **`recordFrameUse`** still isn't called (see the Milestone 2 note above) — still no Cloud Functions to
  call it against.

## Platform targets

- Android `minSdk` 23, `targetSdk`/`compileSdk` = Flutter's current defaults.
- iOS deployment target 15.0 (Flutter's own current default for this SDK; not lowered, since Firebase/
  RevenueCat/sign_in_with_apple all expect 13+ anyway and going lower risks other plugins' compatibility).
- **This was built on Windows, with no Xcode available.** iOS code/config is written to be correct, but
  hasn't been built or run — that needs verification on a Mac or CI.
- **Windows + project and pub cache on different drives:** `flutter build apk` can fail inside a plugin
  with *"Could not close incremental caches"* — a known Kotlin incremental-compilation bug when the
  project (e.g. `D:`) and the pub cache (`C:`) live on different drive roots. Build with
  `-Pkotlin.incremental=false` (e.g. `cd android && ./gradlew assembleDebug "-Pkotlin.incremental=false"`)
  or add `kotlin.incremental=false` to `android/gradle.properties`.
- **Web is a dev convenience, not a target.** Capture → Review works in a browser (captured `XFile`s are
  blob URLs there, which `XFileImage` handles), but **Save** won't: `gal` is Android/iOS only.
- **The capture screen itself hasn't been visually verified on a real device either** — no Android
  emulator or physical device was available in this environment, and `camera` doesn't work on the
  Windows-desktop/web targets used to check design-system widgets in isolation (no `camera_windows`, and
  web camera support is limited). Everything below the camera preview — countdown sequencing, capture ordering,
  retake, compositing math, save/share — is covered by ViewModel unit tests with a mocked camera
  repository (see Testing), and the compositor's actual Canvas/crop/overlay/JPEG pipeline is tested
  end-to-end against the real bundled asset, pixel values included. But nobody has watched the camera
  preview render or tapped through the real countdown on an actual screen yet. Worth doing before trusting
  this milestone fully — say the word and an Android emulator can be set up.

## Architecture

Strict MVVM, feature-first:

```
lib/
  main.dart, bootstrap.dart      — entrypoint, ProviderScope, error logging
  app/                           — app.dart (MaterialApp.router), router.dart (typed go_router routes),
                                    env.dart (--dart-define-from-file reader), theme_mode_controller.dart
  core/
    theme/                       — tokens.dart (SnapTokens ThemeExtension), app_theme.dart, typography.dart
    widgets/                     — design-system components (see below)
    result/                      — Result<T> (Success/Failure) + AppException
    utils/                       — Haptics, appLogger
    compositing/                 — cover_crop.dart (pure math), compositor.dart (Canvas + isolate JPEG)
  features/
    auth/                        — AppUser, AuthRepository (+ Fake impl), Splash/Login screens
    frames/                      — Frame/Slot/Tier/.../FrameRepository (+ Fake impl), Browse/FrameDetail
    capture/                     — Capture screen + Review/Retake screen (camera, countdown, compositing)
    result/                      — Result screen (save/share), compositor + save/share repositories
  l10n/                          — ARB source + generated AppLocalizations
tool/
  generate_sample_frame.dart     — one-off: rewrites both frame overlay PNGs in assets/frames/
                                    (`flutter test tool/generate_sample_frame.dart`; add
                                    `--plain-name "photo dump"` to regenerate just that one)
```

Each feature follows `data/` (services, DTOs, repo impls) / `domain/` (entities, repo interfaces) /
`presentation/` (`views/`, `view_models/`, `state/`). The Review/Retake screen lives under `capture/` per
the spec's folder note, but its compositor/save-share repositories live under `result/` — also per the
spec — so `capture` has one intentional cross-feature import into `result`'s domain layer.

Screen flow: `SplashGateRoute` (`/`) watches auth state and routes to `LoginRoute` (`/login`) or
`BrowseRoute` (`/home`); Browse → `FrameDetailRoute` (`/frame`) → `CaptureRoute` (`/capture`) →
`ReviewRoute` (`/review`) → `ResultRoute` (`/result`), with `CaptureRoute` also reachable *from* Review
(pushed with `retakeSlotIndex` set) for single-slot retakes — same screen, same countdown logic,
parameterized. Non-primitive route payloads (`Frame`, capture lists, JPEG bytes) go through go_router's
`$extra` field as Dart records, not URL-encoded.

ViewModels are Riverpod `@riverpod` `Notifier`s exposing an immutable freezed state; views only
`ref.watch` state and call ViewModel methods, never touching business logic or `BuildContext` from a
ViewModel. `core/result/result.dart` is the `Result<T>` sealed class repositories will return once there
are repositories to return it.

## Design system

`SnapTokens` (a `ThemeExtension`) holds every color; `SnapRadius`, `SnapShadow`, and `SnapSpacing` hold
the shape/shadow/spacing constants that don't change between light and dark. No widget hardcodes a color,
radius, shadow offset, or spacing value — everything reads from these.

Core widgets, each with a widget test and light/dark goldens in `test/core/widgets/`: `ChunkyButton`,
`StickerBadge`, `FrameCard`, `PillTabBar` + `PillChip`, `BrutalTextField`, `CountdownOverlay`, `SlotStrip`,
`EmptyState` + `ErrorState`, `showSnapSnack`/`SnapSnackContent`, `LoadingBlob`. Also in `core/widgets/`,
with widget tests but no goldens (they're animation-driven): `CapturedOverlay` (the per-shot "got it!"
confirmation) — plus `XFileImage`, which shows a captured `XFile` on every platform (`Image.network` for
web blob URLs, `Image.file` elsewhere, with an optional `cacheWidth` for thumbnails). `SlotStrip` takes an
optional `highlightIndex` for a one-off "just updated" pop, alongside the pulsing `currentIndex`.

The app boots to Splash → Login; sign in with any well-formed email + 6-character password
(`FakeAuthRepository` accepts it, as a free user) to reach Browse and the rest of the flow — or use the
dummy Pro account (`pro@snapframe.app` / `snapframe`) to open the Pro frame too. There's no standalone
component-review screen — each core widget's look in light/dark is covered by its golden test instead
(`test/core/widgets/`), which is also the fastest way to check one in isolation while working on it.

Note: emoji glyphs (✦, 🔥, 📸) render as tofu boxes in golden-test screenshots because `flutter test`'s
headless renderer has no system emoji font loaded — on a real device/emulator they render normally via
the platform's emoji font (Segoe UI Emoji / Noto Color Emoji / Apple Color Emoji).

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=env/dev.json
```

`env/dev.json` and `env/prod.json` hold `ENV_NAME` and the (currently empty) RevenueCat API keys — no
secrets are committed; fill in real keys locally or via CI secrets before Milestone 4.

### Testing

```bash
flutter analyze
flutter test
```

To regenerate golden images after an intentional visual change:

```bash
flutter test --update-goldens
```

ViewModel tests use `mocktail` to mock repositories and `ProviderContainer` directly, no widgets needed.
Two things worth knowing if you add more:

- **`@riverpod` providers are autoDispose by default.** A bare `container.read()` with no listener builds
  the provider and can tear it down again before an async continuation lands, so a later `read()` sees a
  *fresh* rebuild instead of the one you triggered. Hold a `container.listen(provider, (_, _) {})` open
  for the life of the test (see `keepAlive` in `capture_view_model_test.dart`) — same role a widget's
  `ref.watch` plays in the real app.
- **Never read `state` before a Notifier's `build()` has returned.** Kicking off async init from `build()`
  via `unawaited(_doThing())` is the normal pattern, but if `_doThing` touches `state` before its first
  `await`, it runs that read synchronously *during* `build()` — before Riverpod has recorded a value —
  and throws "tried to read the state of an uninitialized provider". Read `build()`'s own parameters
  instead of `state` for anything touched before the first `await`. Hit this exact bug in both
  `CaptureViewModel` and `ReviewViewModel` while writing their tests; both are fixed.
- `ui.instantiateImageCodec` (real image decoding) hangs indefinitely if awaited inside `testWidgets()` in
  this Flutter build — confirmed with a minimal repro, not just in this codebase. Plain `test()` with
  `TestWidgetsFlutterBinding.ensureInitialized()` doesn't have the problem; `compositor_test.dart` uses
  that pattern for exactly this reason.

## Milestones

1. ✅ Project setup, lints, env, theme tokens, core widgets (each with a widget test + golden).
2. ✅ Offline core loop: bundled frames → capture with a 3s/5s countdown and per-shot confirmation →
   retake with visible feedback → composite → save / send to WhatsApp (camera preview and the WhatsApp
   hand-off still need a real-device check, see Platform targets above).
3. 🟡 Splash + Login + Browse/Home + Frame Detail, with tier locking — **UI/flow only**, against a fake
   in-memory backend (see "Milestone 3 is UI-only, on purpose" above). Firebase, real auth, and Firestore
   are still open.
4. RevenueCat paywall + tier stream.
5. MyFrames + FrameEditor + upload + report.
6. Polish: motion, sounds, accessibility pass, tests, README updates.
