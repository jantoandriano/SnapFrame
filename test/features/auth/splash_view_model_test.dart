import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/auth/presentation/state/splash_effect.dart';
import 'package:snapframe/features/auth/presentation/view_models/splash_view_model.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

final _user = AppUser(
  uid: 'u1',
  displayName: 'Ren',
  email: 'ren@snapframe.app',
  tier: Tier.free,
  createdAt: DateTime.utc(2026),
);

void main() {
  late _MockAuthRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = _MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test('routes to login when signed out', () async {
    when(() => repo.currentUser).thenAnswer((_) => Stream.value(null));

    container.listen(splashViewModelProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(splashViewModelProvider);
    expect(state.isChecking, isFalse);
    expect(state.effect, isA<NavigateToLogin>());
  });

  test('routes to home when signed in', () async {
    when(() => repo.currentUser).thenAnswer((_) => Stream.value(_user));

    container.listen(splashViewModelProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(splashViewModelProvider);
    expect(state.isChecking, isFalse);
    expect(state.effect, isA<NavigateToHome>());
  });
}
