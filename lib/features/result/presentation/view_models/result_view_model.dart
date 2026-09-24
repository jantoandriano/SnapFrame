import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/result/data/result_providers.dart';
import 'package:snapframe/features/result/presentation/state/result_effect.dart';
import 'package:snapframe/features/result/presentation/state/result_state.dart';

part 'result_view_model.g.dart';

@riverpod
class ResultViewModel extends _$ResultViewModel {
  @override
  ResultState build(Frame frame, Uint8List jpegBytes) {
    return ResultState(frame: frame, jpegBytes: jpegBytes);
  }

  Future<void> onSavePressed() async {
    state = state.copyWith(isSaving: true);
    final repo = ref.read(saveShareRepositoryProvider);
    final result = await repo.saveToGallery(state.jpegBytes);
    state = state.copyWith(isSaving: false);
    result.when(
      success: (_) {
        state = state.copyWith(effect: const ShowResultSnackEffect('saved ✦'));
      },
      failure: (e) {
        state = state.copyWith(
          effect: ShowResultSnackEffect(e.message, isError: true),
        );
      },
    );
  }

  Future<void> onSharePressed() async {
    state = state.copyWith(isSharing: true);
    final repo = ref.read(saveShareRepositoryProvider);
    final result = await repo.share(
      state.jpegBytes,
      text: 'made with SnapFrame ✦',
    );
    state = state.copyWith(isSharing: false);
    result.when(
      success: (_) {},
      failure: (e) {
        state = state.copyWith(
          effect: ShowResultSnackEffect(e.message, isError: true),
        );
      },
    );
  }

  void onAgainPressed() {
    state = state.copyWith(effect: const AgainRequestedEffect());
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
