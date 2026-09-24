import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/features/auth/presentation/state/splash_effect.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isChecking,
    SplashEffect? effect,
  }) = _SplashState;
}
