import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/result/presentation/state/result_effect.dart';

part 'result_state.freezed.dart';

@freezed
abstract class ResultState with _$ResultState {
  const factory ResultState({
    required Frame frame,
    required Uint8List jpegBytes,
    @Default(false) bool isSaving,
    @Default(false) bool isSharing,
    @Default('') String whatsAppNumber,

    /// Set when a send was attempted with a number that isn't a full
    /// international one; cleared as soon as the user edits it.
    @Default(false) bool whatsAppNumberInvalid,
    ResultEffect? effect,
  }) = _ResultState;
}
