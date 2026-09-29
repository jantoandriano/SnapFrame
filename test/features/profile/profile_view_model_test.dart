import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/profile/data/profile_providers.dart';
import 'package:snapframe/features/profile/domain/subscription_repository.dart';
import 'package:snapframe/features/profile/presentation/state/profile_effect.dart';
import 'package:snapframe/features/profile/presentation/view_models/profile_view_model.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

final _user = AppUser(
  uid: 'maya@example.com',
  displayName: 'Maya',
  email: 'maya@example.com',
  tier: Tier.free,
  createdAt: DateTime.utc(2026, 9),
);

void main() {
  late _MockAuthRepository authRepo;
  late _MockSubscriptionRepository subRepo;
  late ProviderContainer container;

  setUp(() {
    authRepo = _MockAuthRepository();
    subRepo = _MockSubscriptionRepository();
    when(() => authRepo.currentUser).thenAnswer((_) => Stream.value(_user));
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepo),
        subscriptionRepositoryProvider.overrideWithValue(subRepo),
      ],
    );
    addTearDown(container.dispose);
    container.listen(profileViewModelProvider, (_, _) {});
  });

  ProfileViewModel notifier() =>
      container.read(profileViewModelProvider.notifier);

  test('exposes the signed-in user', () async {
    await Future<void>.delayed(Duration.zero);

    expect(container.read(profileViewModelProvider).user, _user);
  });

  test('is loading while the user stream has not answered', () async {
    final silentAuth = _MockAuthRepository();
    when(() => silentAuth.currentUser)
        .thenAnswer((_) => StreamController<AppUser?>().stream);
    final fresh = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(silentAuth)],
    );
    addTearDown(fresh.dispose);
    fresh.listen(profileViewModelProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);

    final state = fresh.read(profileViewModelProvider);
    expect(state.user, isNull);
    expect(state.isLoadingUser, isTrue);
  });

  test('a signed-out stream is not treated as loading', () async {
    when(() => authRepo.currentUser).thenAnswer((_) => Stream.value(null));
    container.invalidate(currentUserStreamProvider);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(profileViewModelProvider);
    expect(state.user, isNull);
    expect(state.isLoadingUser, isFalse);
  });

  test('subscribing shows progress, then a success effect', () async {
    final pending = Completer<Result<void>>();
    when(() => subRepo.subscribeToPro()).thenAnswer((_) => pending.future);

    final call = notifier().onSubscribePressed();
    expect(container.read(profileViewModelProvider).isUpdatingPlan, isTrue);

    pending.complete(const Result.success(null));
    await call;

    final state = container.read(profileViewModelProvider);
    expect(state.isUpdatingPlan, isFalse);
    expect(state.effect, isA<SubscribedEffect>());
  });

  test('a failed subscribe surfaces the error message', () async {
    when(() => subRepo.subscribeToPro()).thenAnswer(
      (_) async => const Result.failure(NetworkException('store is down')),
    );

    await notifier().onSubscribePressed();

    final state = container.read(profileViewModelProvider);
    expect(state.isUpdatingPlan, isFalse);
    expect(
      state.effect,
      isA<PlanFailedEffect>().having(
        (e) => e.message,
        'message',
        'store is down',
      ),
    );
  });

  test('cancel asks for confirmation before touching the plan', () {
    notifier().onCancelPressed();

    expect(
      container.read(profileViewModelProvider).effect,
      isA<ConfirmCancelEffect>(),
    );
    verifyNever(() => subRepo.cancelPro());
  });

  test('confirming the cancel drops the plan', () async {
    when(() => subRepo.cancelPro())
        .thenAnswer((_) async => const Result.success(null));

    await notifier().onCancelConfirmed();

    verify(() => subRepo.cancelPro()).called(1);
    expect(
      container.read(profileViewModelProvider).effect,
      isA<CancelledEffect>(),
    );
  });

  test('signing out ends the session', () async {
    when(() => authRepo.signOut())
        .thenAnswer((_) async => const Result.success(null));

    await notifier().onSignOutPressed();

    verify(() => authRepo.signOut()).called(1);
  });

  test('ignores a second tap while a plan change is in flight', () async {
    final pending = Completer<Result<void>>();
    when(() => subRepo.subscribeToPro()).thenAnswer((_) => pending.future);

    final first = notifier().onSubscribePressed();
    await notifier().onSubscribePressed();
    pending.complete(const Result.success(null));
    await first;

    verify(() => subRepo.subscribeToPro()).called(1);
  });
}
