import 'dart:async';

import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/capture/presentation/state/review_effect.dart';
import 'package:snapframe/features/capture/presentation/state/review_state.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/result/data/result_providers.dart';

part 'review_view_model.g.dart';

@riverpod
class ReviewViewModel extends _$ReviewViewModel {
  @override
  ReviewState build(Frame frame, List<XFile> captures) {
    unawaited(_recompose(captures));
    return ReviewState(frame: frame, captures: captures, isComposing: true);
  }

  // Uses the `frame` build argument rather than `state.frame` — this runs
  // synchronously from `build()` on the first call, before `state` is
  // readable yet.
  Future<bool> _recompose(List<XFile> captures) async {
    final repo = ref.read(compositorRepositoryProvider);
    final result = await repo.compose(frame: frame, photos: captures);
    return result.when<bool>(
      success: (jpeg) {
        state = state.copyWith(
          previewJpeg: jpeg,
          isComposing: false,
          error: null,
        );
        return true;
      },
      failure: (e) {
        state = state.copyWith(error: e, isComposing: false);
        return false;
      },
    );
  }

  void onSlotTapped(int index) {
    state = state.copyWith(effect: RequestRetakeEffect(index));
  }

  Future<void> onRetakeCompleted(int index, XFile photo) async {
    final updated = [...state.captures];
    updated[index] = photo;
    state = state.copyWith(
      captures: updated,
      isComposing: true,
      updatedSlotIndex: null,
    );
    if (await _recompose(updated)) {
      state = state.copyWith(
        updatedSlotIndex: index,
        effect: SlotUpdatedEffect(index),
      );
    }
  }

  void onContinuePressed() {
    final jpeg = state.previewJpeg;
    if (jpeg == null) return;
    state = state.copyWith(effect: ProceedToResultEffect(jpeg));
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
