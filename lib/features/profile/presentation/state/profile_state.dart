import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/profile/presentation/state/profile_effect.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    AppUser? user,

    /// True only until the user stream first answers. Once it has, a null
    /// [user] means signed out — not "still loading".
    @Default(true) bool isLoadingUser,
    @Default(false) bool isUpdatingPlan,
    ProfileEffect? effect,
  }) = _ProfileState;
}
