import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/presentation/state/splash_effect.dart';
import 'package:snapframe/features/auth/presentation/state/splash_state.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  StreamSubscription<AppUser?>? _subscription;

  @override
  SplashState build() {
    final repo = ref.watch(authRepositoryProvider);
    _subscription = repo.currentUser.listen(_onUser);
    ref.onDispose(() => _subscription?.cancel());
    return const SplashState();
  }

  void _onUser(AppUser? user) {
    state = state.copyWith(
      isChecking: false,
      effect: user == null ? const NavigateToLogin() : const NavigateToHome(),
    );
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
