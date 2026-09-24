import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/capture/presentation/state/review_effect.dart';
import 'package:snapframe/features/frames/domain/frame.dart';

part 'review_state.freezed.dart';

@freezed
abstract class ReviewState with _$ReviewState {
  const factory ReviewState({
    required Frame frame,
    required List<XFile> captures,
    Uint8List? previewJpeg,
    @Default(false) bool isComposing,

    /// The slot most recently replaced by a retake, highlighted in the
    /// strip so it's clear which shot changed.
    int? updatedSlotIndex,
    AppException? error,
    ReviewEffect? effect,
  }) = _ReviewState;
}
