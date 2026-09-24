import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/presentation/state/login_effect.dart';
import 'package:snapframe/features/auth/presentation/state/login_state.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  void onEmailChanged(String value) =>
      state = state.copyWith(email: value, error: null);

  void onPasswordChanged(String value) =>
      state = state.copyWith(password: value, error: null);

  void onDisplayNameChanged(String value) =>
      state = state.copyWith(displayName: value, error: null);

  void onModeToggled() =>
      state = state.copyWith(isSignUpMode: !state.isSignUpMode, error: null);

  Future<void> onSubmitPressed() async {
    state = state.copyWith(isSubmitting: true, error: null);
    final repo = ref.read(authRepositoryProvider);

    final Result<void> result;
    if (state.isSignUpMode) {
      result = await repo.signUpWithEmail(
        state.email,
        state.password,
        state.displayName,
      );
    } else {
      result = await repo.signInWithEmail(state.email, state.password);
    }

    result.when(
      success: (_) {
        state = state.copyWith(
          isSubmitting: false,
          effect: const LoginSucceededEffect(),
        );
      },
      failure: (e) {
        state = state.copyWith(isSubmitting: false, error: e);
      },
    );
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
