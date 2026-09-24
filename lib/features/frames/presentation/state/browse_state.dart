import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/frames/presentation/state/browse_effect.dart';
import 'package:snapframe/features/frames/presentation/state/browse_filter.dart';

part 'browse_state.freezed.dart';

@freezed
abstract class BrowseState with _$BrowseState {
  const factory BrowseState({
    required Tier currentUserTier,
    @Default(0) int tabIndex,
    @Default(BrowseFilter.newest) BrowseFilter selectedFilter,
    @Default(<Frame>[]) List<Frame> frames,
    @Default(true) bool isLoading,
    @Default(false) bool isRefreshing,
    AppException? error,
    BrowseEffect? effect,
  }) = _BrowseState;
}

extension BrowseStateX on BrowseState {
  /// Pro frames are locked for anyone not on the pro tier.
  bool isLocked(Frame frame) =>
      frame.tier == Tier.pro && currentUserTier != Tier.pro;
}
