import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/fake_auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/profile/domain/subscription_repository.dart';

/// Stands in for RevenueCat until real store products exist: no payment,
/// just flips the tier on the fake session. Cancelling drops to Free
/// immediately — a real store keeps Pro until the paid period ends, which
/// becomes the backend's job once purchases are real.
class FakeSubscriptionRepository implements SubscriptionRepository {
  FakeSubscriptionRepository(
    this._auth, {
    this.delay = const Duration(milliseconds: 600),
  });

  final FakeAuthRepository _auth;

  /// Simulated store round-trip, so the loading state is visible.
  final Duration delay;

  static const _period = Duration(days: 30);

  @override
  Future<Result<void>> subscribeToPro() => _apply(
    () => _auth.setTier(Tier.pro, proExpiresAt: DateTime.now().add(_period)),
  );

  @override
  Future<Result<void>> cancelPro() => _apply(() => _auth.setTier(Tier.free));

  Future<Result<void>> _apply(bool Function() change) async {
    await Future<void>.delayed(delay);
    if (!change()) {
      return const Result.failure(
        PermissionDeniedException('sign in to manage your plan'),
      );
    }
    return const Result.success(null);
  }
}
