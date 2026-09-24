import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/auth/presentation/state/login_effect.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String displayName,
    @Default(false) bool isSignUpMode,
    @Default(false) bool isSubmitting,
    AppException? error,
    LoginEffect? effect,
  }) = _LoginState;
}
