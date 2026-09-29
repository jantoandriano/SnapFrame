import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/auth/data/fake_auth_repository.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';

part 'auth_providers.g.dart';

/// `keepAlive: true` — these hold the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.
@Riverpod(keepAlive: true)
FakeAuthRepository fakeAuthRepository(Ref ref) => FakeAuthRepository();

/// Backed by the same [fakeAuthRepository] instance the fake subscription
/// flow writes to, so a tier change reaches everyone watching the user.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => ref.watch(fakeAuthRepositoryProvider);

@Riverpod(keepAlive: true)
Stream<AppUser?> currentUserStream(Ref ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}
