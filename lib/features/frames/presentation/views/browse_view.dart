import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/frames/presentation/state/browse_effect.dart';
import 'package:snapframe/features/frames/presentation/state/browse_filter.dart';
import 'package:snapframe/features/frames/presentation/state/browse_state.dart';
import 'package:snapframe/features/frames/presentation/view_models/browse_view_model.dart';
import 'package:snapframe/l10n/app_localizations.dart';

String _filterLabel(AppLocalizations l10n, BrowseFilter filter) {
  return switch (filter) {
    BrowseFilter.newest => l10n.browseFilterNewest,
    BrowseFilter.popular => l10n.browseFilterPopular,
    BrowseFilter.free => l10n.browseFilterFree,
    BrowseFilter.pro => l10n.browseFilterPro,
  };
}

class BrowseView extends ConsumerWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(browseViewModelProvider);
    final notifier = ref.read(browseViewModelProvider.notifier);

    ref.listen(browseViewModelProvider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case OpenFrameDetailEffect(:final frame):
          notifier.clearEffect();
          unawaited(FrameDetailRoute($extra: frame).push<void>(context));
        case ShowLockedSnackEffect():
          notifier.clearEffect();
          showSnapSnack(
            context,
            l10n.browseLockedSnack,
            variant: SnapSnackVariant.error,
          );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.browseTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SnapSpacing.lg,
              vertical: SnapSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PillTabBar(
                  tabs: [l10n.browseTabOfficial, l10n.browseTabCommunity],
                  selectedIndex: state.tabIndex,
                  onChanged: notifier.onTabChanged,
                ),
                const SizedBox(height: SnapSpacing.sm),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: BrowseFilter.values.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: SnapSpacing.sm),
                    itemBuilder: (context, index) {
                      final filter = BrowseFilter.values[index];
                      return PillChip(
                        label: _filterLabel(l10n, filter),
                        selected: state.selectedFilter == filter,
                        onTap: () => notifier.onFilterSelected(filter),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _Body(
              state: state,
              onRefresh: notifier.onRefresh,
              onTap: notifier.onFrameTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.onRefresh,
    required this.onTap,
  });

  final BrowseState state;
  final Future<void> Function() onRefresh;
  final void Function(Frame frame) onTap;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: LoadingBlob());
    }
    if (state.error != null) {
      return ErrorState(
        message: AppLocalizations.of(context)!.errorGeneric,
        onRetry: onRefresh,
      );
    }
    if (state.frames.isEmpty) {
      return EmptyState(message: AppLocalizations.of(context)!.emptyCommunity);
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(SnapSpacing.lg),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: SnapSpacing.lg,
          crossAxisSpacing: SnapSpacing.lg,
          childAspectRatio: 0.62,
        ),
        itemCount: state.frames.length,
        itemBuilder: (context, index) {
          final frame = state.frames[index];
          return FrameCard(
            title: frame.title,
            isPro: frame.tier == Tier.pro,
            isLocked: state.isLocked(frame),
            thumbnail: Image.asset(frame.thumbnailPath, fit: BoxFit.cover),
            onTap: () => onTap(frame),
          );
        },
      ),
    );
  }
}
