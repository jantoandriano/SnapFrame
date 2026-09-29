import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/theme_mode_controller.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/profile/presentation/state/profile_effect.dart';
import 'package:snapframe/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:snapframe/l10n/app_localizations.dart';

/// Two-letter initials for the avatar block, e.g. "Maya Putri" → "MP".
String profileInitials(String displayName) {
  final words = displayName.trim().split(RegExp(r'\s+'))
    ..removeWhere((w) => w.isEmpty);
  if (words.isEmpty) return '?';
  final letters = words.length == 1
      ? words.first.substring(0, words.first.length.clamp(1, 2))
      : '${words[0][0]}${words[1][0]}';
  return letters.toUpperCase();
}

/// Theme segments, in the order the toggle shows them.
const List<ThemeMode> _themeModes = [
  ThemeMode.light,
  ThemeMode.dark,
  ThemeMode.system,
];

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final state = ref.watch(profileViewModelProvider);
    final notifier = ref.read(profileViewModelProvider.notifier);
    final themeMode = ref.watch(themeModeControllerProvider);

    ref.listen(profileViewModelProvider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      notifier.clearEffect();
      switch (effect) {
        case SubscribedEffect():
          showSnapSnack(
            context,
            l10n.profileSubscribedSnack,
            variant: SnapSnackVariant.success,
          );
        case CancelledEffect():
          showSnapSnack(context, l10n.profileCancelledSnack);
        case PlanFailedEffect(:final message):
          showSnapSnack(context, message, variant: SnapSnackVariant.error);
        case ConfirmCancelEffect():
          unawaited(_confirmCancel(context, notifier));
      }
    });

    final user = state.user;
    return Scaffold(
      appBar: SnapAppBar(title: l10n.profileTitle, accent: tokens.pink),
      body: user == null
          ? const Center(child: LoadingBlob())
          : ListView(
              padding: const EdgeInsets.all(SnapSpacing.lg),
              children: [
                _IdentityCard(user: user),
                const SizedBox(height: SnapSpacing.xxl),
                _SectionLabel(l10n.profileThemeLabel),
                const SizedBox(height: SnapSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: PillTabBar(
                    tabs: [
                      l10n.profileThemeLight,
                      l10n.profileThemeDark,
                      l10n.profileThemeSystem,
                    ],
                    selectedIndex: _themeModes.indexOf(themeMode),
                    onChanged: (i) => ref
                        .read(themeModeControllerProvider.notifier)
                        .setMode(_themeModes[i]),
                  ),
                ),
                const SizedBox(height: SnapSpacing.xxl),
                _SectionLabel(l10n.profilePlanLabel),
                const SizedBox(height: SnapSpacing.sm),
                _PlanCard(
                  user: user,
                  isUpdating: state.isUpdatingPlan,
                  onSubscribe: notifier.onSubscribePressed,
                  onCancel: notifier.onCancelPressed,
                ),
              ],
            ),
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    ProfileViewModel notifier,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(SnapSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.profileCancelConfirmTitle.toUpperCase(),
                style: Theme.of(dialogContext).textTheme.headlineMedium,
              ),
              const SizedBox(height: SnapSpacing.sm),
              Text(
                l10n.profileCancelConfirmBody,
                style: Theme.of(dialogContext).textTheme.bodyLarge,
              ),
              const SizedBox(height: SnapSpacing.xl),
              ChunkyButton(
                label: l10n.profileCancelConfirmNo,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
              const SizedBox(height: SnapSpacing.md),
              ChunkyButton(
                label: l10n.profileCancelConfirmYes,
                variant: SnapButtonVariant.ghost,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed ?? false) await notifier.onCancelConfirmed();
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

/// Avatar block, name, email, join date, and the current tier sticker.
class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final textTheme = Theme.of(context).textTheme;
    final isPro = user.tier == Tier.pro;

    return Container(
      padding: const EdgeInsets.all(SnapSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(SnapRadius.md),
        border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
        boxShadow: [BoxShadow(color: tokens.ink, offset: SnapShadow.offset)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tokens.lilac,
              borderRadius: BorderRadius.circular(SnapRadius.sm),
              border: Border.all(
                color: tokens.ink,
                width: SnapTokens.borderWidth,
              ),
            ),
            child: Text(
              profileInitials(user.displayName),
              style: textTheme.headlineLarge?.copyWith(
                color: SnapTokens.onAccent,
              ),
            ),
          ),
          const SizedBox(width: SnapSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: SnapSpacing.xs),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium,
                ),
                Text(
                  l10n.profileMemberSince(user.createdAt),
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: SnapSpacing.sm),
                StickerBadge(
                  label: isPro ? l10n.profileTierPro : l10n.profileTierFree,
                  color: isPro ? tokens.sun : tokens.lime,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Free: the pitch plus a subscribe button. Pro: the renewal date plus a
/// (ghost, de-emphasized) cancel button.
class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.user,
    required this.isUpdating,
    required this.onSubscribe,
    required this.onCancel,
  });

  final AppUser user;
  final bool isUpdating;
  final VoidCallback onSubscribe;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final textTheme = Theme.of(context).textTheme;
    final isPro = user.tier == Tier.pro;
    final expiresAt = user.proExpiresAt;

    return Container(
      padding: const EdgeInsets.all(SnapSpacing.lg),
      decoration: BoxDecoration(
        color: isPro ? tokens.sun : tokens.lime,
        borderRadius: BorderRadius.circular(SnapRadius.md),
        border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
        boxShadow: [BoxShadow(color: tokens.ink, offset: SnapShadow.offset)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            (isPro
                    ? (expiresAt == null
                          ? l10n.profileTierPro
                          : l10n.profileProUntil(expiresAt))
                    : l10n.paywallTitle)
                .toUpperCase(),
            style: textTheme.headlineSmall?.copyWith(
              color: SnapTokens.onAccent,
            ),
          ),
          if (!isPro) ...[
            const SizedBox(height: SnapSpacing.xs),
            Text(
              l10n.profilePerks,
              style: textTheme.bodyMedium?.copyWith(color: SnapTokens.onAccent),
            ),
          ],
          const SizedBox(height: SnapSpacing.lg),
          if (isPro)
            ChunkyButton(
              label: l10n.profileUnsubscribe,
              variant: SnapButtonVariant.ghost,
              isLoading: isUpdating,
              onPressed: onCancel,
            )
          else
            ChunkyButton(
              label: l10n.profileSubscribe,
              variant: SnapButtonVariant.secondary,
              isLoading: isUpdating,
              onPressed: onSubscribe,
            ),
        ],
      ),
    );
  }
}
