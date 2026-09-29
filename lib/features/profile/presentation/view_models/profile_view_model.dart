import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/profile/data/profile_providers.dart';
import 'package:snapframe/features/profile/presentation/state/profile_effect.dart';
import 'package:snapframe/features/profile/presentation/state/profile_state.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileState build() {
    // `listen`, not `watch`: a plan change re-emits the user, and a
    // rebuild would reset the state and drop the success effect that the
    // same change is about to set.
    ref.listen(currentUserStreamProvider, (_, next) {
      state = state.copyWith(user: next.value, isLoadingUser: !next.hasValue);
    });
    final user = ref.read(currentUserStreamProvider);
    return ProfileState(user: user.value, isLoadingUser: !user.hasValue);
  }

  Future<void> onSubscribePressed() => _changePlan(
    () => ref.read(subscriptionRepositoryProvider).subscribeToPro(),
    const SubscribedEffect(),
  );

  void onCancelPressed() {
    if (state.isUpdatingPlan) return;
    state = state.copyWith(effect: const ConfirmCancelEffect());
  }

  Future<void> onCancelConfirmed() => _changePlan(
    () => ref.read(subscriptionRepositoryProvider).cancelPro(),
    const CancelledEffect(),
  );

  /// No navigation here: the router's session guard sends the user to
  /// login as soon as the session goes null.
  Future<void> onSignOutPressed() async {
    final result = await ref.read(authRepositoryProvider).signOut();
    result.when(
      success: (_) {},
      failure: (e) =>
          state = state.copyWith(effect: PlanFailedEffect(e.message)),
    );
  }

  Future<void> _changePlan(
    Future<Result<void>> Function() change,
    ProfileEffect onSuccess,
  ) async {
    if (state.isUpdatingPlan) return;
    state = state.copyWith(isUpdatingPlan: true);
    final result = await change();
    state = state.copyWith(
      isUpdatingPlan: false,
      effect: result.when(
        success: (_) => onSuccess,
        failure: (e) => PlanFailedEffect(e.message),
      ),
    );
  }

  void clearEffect() => state = state.copyWith(effect: null);
}
