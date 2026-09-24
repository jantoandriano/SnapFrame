import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/frames/data/frame_providers.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_effect.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_state.dart';

part 'frame_detail_view_model.g.dart';

@riverpod
class FrameDetailViewModel extends _$FrameDetailViewModel {
  @override
  FrameDetailState build(Frame frame) => FrameDetailState(frame: frame);

  void onUseThisFramePressed() {
    state = state.copyWith(effect: UseFrameEffect(state.frame));
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
