import 'package:snapframe/core/result/result.dart';

/// Starts or stops the signed-in user's Pro plan. The resulting tier
/// change shows up on `AuthRepository.currentUser`, not here, so every
/// screen watching the user (Browse's frame locks included) reacts.
abstract interface class SubscriptionRepository {
  Future<Result<void>> subscribeToPro();

  Future<Result<void>> cancelPro();
}
