# SnapFrame — Profile Screen (identity, theme, fake Pro subscription)

## Context
App has no place to see who you are, change theme, or go Pro/free. `AppUser` already carries `displayName`, `email`, `tier`, `createdAt`, `proExpiresAt`; `ThemeModeController` exists with no UI; Pro is only reachable via the dummy `pro@snapframe.app` login. Real payments (RevenueCat) are a later milestone, so subscription is **faked behind an interface** like the rest of the current in-memory backend.

**Decisions (from user):**
- Content: **identity card**, **3-way theme toggle** (Light / Dark / System), **subscribe / unsubscribe Pro**.
- Payments: **fake** — `SubscriptionRepository` interface + fake impl; RevenueCat swaps in later.
- Entry: **avatar button in the Browse `SnapAppBar`** → push `/profile`. No bottom nav.

**Success:** from Browse tap avatar → profile shows name/email/member-since/tier; switching theme recolors app live; Subscribe → Pro sticker + expiry shown, Browse Pro frames unlock immediately; Unsubscribe (after confirm) → back to Free, Pro frames lock again. Analyze + tests green.

## Design

### Domain / data — new `lib/features/profile/`
- `domain/subscription_repository.dart`
  ```dart
  abstract interface class SubscriptionRepository {
    Future<Result<void>> subscribeToPro();
    Future<Result<void>> cancelPro();
  }
  ```
- `data/fake_subscription_repository.dart` — ctor takes `FakeAuthRepository`; ~600ms delay; `subscribeToPro` → `auth.setTier(Tier.pro, proExpiresAt: now + 30 days)`; `cancelPro` → `auth.setTier(Tier.free, proExpiresAt: null)`. No signed-in user → `PermissionDeniedException`. Cancel is immediate (demo clarity; real store semantics = Pro until period end, handled when RevenueCat lands).
- `data/profile_providers.dart` — `@Riverpod(keepAlive: true) SubscriptionRepository subscriptionRepository(Ref)` → `FakeSubscriptionRepository(ref.watch(fakeAuthRepositoryProvider))`.
- **Auth changes** (`lib/features/auth/data/`):
  - `FakeAuthRepository.setTier({required Tier tier, DateTime? proExpiresAt})` — copies `_current` with new tier and emits. Fake-only, not on `AuthRepository` interface.
  - `auth_providers.dart`: add `@Riverpod(keepAlive: true) FakeAuthRepository fakeAuthRepository(Ref)`; `authRepositoryProvider` returns `ref.watch(fakeAuthRepositoryProvider)` so both share one session.
- Browse needs **no change** — `BrowseViewModel` already watches `currentUserStreamProvider`, so tier flips re-lock/unlock frames.

### Presentation — MVVM like Browse (freezed state + sealed effect + `@riverpod` VM)
- `state/profile_state.dart`: `AppUser? user`, `bool isUpdatingPlan`, `ProfileEffect? effect`.
- `state/profile_effect.dart`: `ShowProfileSnackEffect(message, isError)`, `ConfirmCancelEffect`.
- `view_models/profile_view_model.dart`:
  - `build()` watches `currentUserStreamProvider` → `user`.
  - `onSubscribePressed()` → `isUpdatingPlan`, call repo, success snack ("you're pro now ✦") / error snack.
  - `onCancelPressed()` → emits `ConfirmCancelEffect`; `onCancelConfirmed()` → repo `cancelPro`, snack.
  - Theme handled directly in view via existing `themeModeControllerProvider.notifier.setMode` (no VM duplication).
- `views/profile_view.dart` (Scaffold + `SnapAppBar(title: l10n.profileTitle, accent: tokens.pink)`), scrollable column:
  1. **Identity card** — ink-bordered surface card, `SnapShadow.offset`: square initials avatar block (lilac, `onAccent` text, uppercase initials), name (headline uppercase), email (body), "member since {date}" (intl `yMMMd`), `StickerBadge` PRO ✦ (sun) or FREE (surface/lime).
  2. **Theme** — label + `PillTabBar(tabs: [light, dark, system])`, index ↔ `ThemeMode`.
  3. **Plan block** — Free: lime card "go pro, unlock everything ✦" (reuse `paywallTitle`) + perks line + primary `ChunkyButton` Subscribe (`isLoading: isUpdatingPlan`). Pro: sun card "pro until {date}" + ghost `ChunkyButton` Unsubscribe → confirm dialog (themed `dialogTheme` already brutal) → `onCancelConfirmed`.
- **Router** `lib/app/router.dart`: `@TypedGoRoute<ProfileRoute>(path: '/profile')`; regenerate `router.g.dart`.
- **Entry**: `SnapAppBar` gains optional `Widget? trailing`; extract its square button into reusable `SnapIconButton`-style private helper → avatar-initials button in `browse_view.dart` → `const ProfileRoute().push(context)`. (Browse file has user's uncommitted tab-bar removal — stage only my hunks again.)
- **l10n** `app_en.arb`: `profileTitle`, `profileMemberSince`, `profileThemeLabel`, `profileThemeLight/Dark/System`, `profileSubscribe`, `profileUnsubscribe`, `profileProUntil`, `profilePerks`, `profileSubscribedSnack`, `profileCancelledSnack`, `profileCancelConfirmTitle/Body/Yes/No`, `profileOpenSemantics`. Run `flutter gen-l10n` (or build) to regenerate.

## Implementation order
0. Branch `feat/profile` off `main`.
1. Save this as `docs/superpowers/specs/2026-09-29-profile-screen-design.md`, commit.
2. TDD data layer: `FakeAuthRepository.setTier` + `FakeSubscriptionRepository` tests → impl → providers. Commit.
3. TDD `ProfileViewModel` (mock `SubscriptionRepository`/`AuthRepository` via mocktail, pattern from `test/features/frames/browse_view_model_test.dart`). Commit.
4. `SnapAppBar.trailing` + test; profile view; route; l10n; browse avatar entry. `build_runner build --delete-conflicting-outputs`. Commit.

## Tests
- `test/features/auth/fake_auth_repository_test.dart` — `setTier` emits updated user; no-op when signed out.
- `test/features/profile/fake_subscription_repository_test.dart` — subscribe → Pro + expiry ~30d; cancel → Free + null expiry; signed-out → failure.
- `test/features/profile/profile_view_model_test.dart` — user mapped from stream; subscribe success/failure snacks + `isUpdatingPlan` toggling; cancel emits confirm effect; confirm calls repo.
- `test/core/widgets/snap_app_bar_test.dart` — trailing widget renders.
- Widget test `profile_view` — free user sees Subscribe; pro user sees Unsubscribe + expiry; theme tab tap updates `themeModeControllerProvider`.

## Verification
- `dart run build_runner build --delete-conflicting-outputs`, `flutter analyze` clean, `flutter test` all green.
- Manual (user runs app): login as normal email → Browse → avatar → profile shows Free; Subscribe → Pro sticker + "pro until"; back → Pro frames unlocked; Unsubscribe → confirm → Free, Pro frames locked; theme tabs recolor live in both directions. Also log in as `pro@snapframe.app` → profile shows Pro.
