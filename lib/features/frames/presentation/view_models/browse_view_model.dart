import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/core/utils/haptics.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/frames/data/frame_providers.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/frames/presentation/state/browse_effect.dart';
import 'package:snapframe/features/frames/presentation/state/browse_filter.dart';
import 'package:snapframe/features/frames/presentation/state/browse_state.dart';

part 'browse_view_model.g.dart';

@riverpod
class BrowseViewModel extends _$BrowseViewModel {
  List<Frame> _official = [];
  List<Frame> _community = [];

  @override
  BrowseState build() {
    final userAsync = ref.watch(currentUserStreamProvider);
    final tier = userAsync.value?.tier ?? Tier.free;

    unawaited(_fetchAndApply(official: true));

    return BrowseState(currentUserTier: tier);
  }

  Future<void> _fetchAndApply({required bool official}) async {
    final repo = ref.read(frameRepositoryProvider);
    final result = await repo.fetchFrames(official: official);
    result.when(
      success: (frames) {
        if (official) {
          _official = frames;
        } else {
          _community = frames;
        }
        state = state.copyWith(
          isLoading: false,
          isRefreshing: false,
          frames: _applyFilter(frames, state.selectedFilter),
        );
      },
      failure: (e) {
        state = state.copyWith(isLoading: false, isRefreshing: false, error: e);
      },
    );
  }

  // Takes `filter` explicitly rather than reading `state.selectedFilter`:
  // `onFilterSelected` calls this as an argument to `state.copyWith(...)`,
  // which evaluates before the reassignment lands — reading `state` in
  // here would still see the *previous* filter.
  List<Frame> _applyFilter(List<Frame> frames, BrowseFilter filter) {
    final filtered = switch (filter) {
      BrowseFilter.free => frames.where((f) => f.tier == Tier.free).toList(),
      BrowseFilter.pro => frames.where((f) => f.tier == Tier.pro).toList(),
      BrowseFilter.newest || BrowseFilter.popular => List<Frame>.of(frames),
    };
    return filtered..sort(
      filter == BrowseFilter.popular
          ? (a, b) => b.usageCount.compareTo(a.usageCount)
          : (a, b) => b.createdAt.compareTo(a.createdAt),
    );
  }

  void onTabChanged(int index) {
    if (index == state.tabIndex) return;
    Haptics.selection();
    state = state.copyWith(tabIndex: index, isLoading: true, error: null);
    unawaited(_fetchAndApply(official: index == 0));
  }

  void onFilterSelected(BrowseFilter filter) {
    state = state.copyWith(
      selectedFilter: filter,
      frames: _applyFilter(
        state.tabIndex == 0 ? _official : _community,
        filter,
      ),
    );
  }

  Future<void> onRefresh() async {
    state = state.copyWith(isRefreshing: true, error: null);
    await _fetchAndApply(official: state.tabIndex == 0);
  }

  void onFrameTapped(Frame frame) {
    state = state.copyWith(
      effect: state.isLocked(frame)
          ? const ShowLockedSnackEffect()
          : OpenFrameDetailEffect(frame),
    );
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
