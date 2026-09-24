import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/auth/data/fake_auth_repository.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';

part 'auth_providers.g.dart';

/// `keepAlive: true` — this holds the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => FakeAuthRepository();

@Riverpod(keepAlive: true)
Stream<AppUser?> currentUserStream(Ref ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}
