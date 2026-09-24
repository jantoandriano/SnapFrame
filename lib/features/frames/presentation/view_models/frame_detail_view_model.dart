import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/frames/data/frame_providers.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_effect.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_state.dart';

part 'frame_detail_view_model.g.dart';

@riverpod
class FrameDetailViewModel extends _$FrameDetailViewModel {
  static const countdownOptions = [3, 5];

  @override
  FrameDetailState build(Frame frame) => FrameDetailState(
    frame: frame,
    countdownSec: countdownOptions.contains(frame.countdownSec)
        ? frame.countdownSec
        : countdownOptions.first,
  );

  void onCountdownSelected(int seconds) {
    state = state.copyWith(countdownSec: seconds);
  }

  void onUseThisFramePressed() {
    state = state.copyWith(
      effect: UseFrameEffect(
        state.frame.copyWith(countdownSec: state.countdownSec),
      ),
    );
  }

  Future<void> onReportSubmitted(String reason) async {
    state = state.copyWith(isSubmittingReport: true, error: null);
    final repo = ref.read(frameRepositoryProvider);
    final result = await repo.reportFrame(state.frame.id, reason);
    result.when(
      success: (_) {
        state = state.copyWith(
          isSubmittingReport: false,
          effect: const ReportSentEffect(),
        );
      },
      failure: (e) {
        state = state.copyWith(isSubmittingReport: false, error: e);
      },
    );
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
