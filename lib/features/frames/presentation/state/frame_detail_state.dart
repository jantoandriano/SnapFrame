import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_effect.dart';

part 'frame_detail_state.freezed.dart';

@freezed
abstract class FrameDetailState with _$FrameDetailState {
  const factory FrameDetailState({
    required Frame frame,
    @Default(false) bool isSubmittingReport,
    AppException? error,
    FrameDetailEffect? effect,
  }) = _FrameDetailState;
}
