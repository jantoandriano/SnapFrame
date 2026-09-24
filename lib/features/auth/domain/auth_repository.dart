import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';

abstract interface class AuthRepository {
  /// Emits the signed-in user (with their current tier), or `null` when
  /// signed out. `SplashGate` watches this to decide where to route.
  Stream<AppUser?> get currentUser;

  Future<Result<void>> signInWithEmail(String email, String password);

  Future<Result<void>> signUpWithEmail(
    String email,
    String password,
    String displayName,
  );

  Future<Result<void>> signOut();
}
