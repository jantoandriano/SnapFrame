import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/auth/data/fake_auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/profile/data/fake_subscription_repository.dart';

void main() {
  late FakeAuthRepository auth;
  late FakeSubscriptionRepository repo;

  setUp(() {
    auth = FakeAuthRepository();
    repo = FakeSubscriptionRepository(auth, delay: Duration.zero);
  });

  test('subscribing makes the user Pro for ~30 days', () async {
    await auth.signInWithEmail('maya@example.com', 'whatever');

    final result = await repo.subscribeToPro();

    result.when(success: (_) {}, failure: (e) => fail('unexpected $e'));
    final user = await auth.currentUser.first;
    expect(user!.tier, Tier.pro);
    final daysLeft = user.proExpiresAt!.difference(DateTime.now()).inDays;
    expect(daysLeft, inInclusiveRange(29, 30));
  });

  test('cancelling drops the user back to Free', () async {
    await auth.signInWithEmail(fakeProEmail, fakeProPassword);

    final result = await repo.cancelPro();

    result.when(success: (_) {}, failure: (e) => fail('unexpected $e'));
    final user = await auth.currentUser.first;
    expect(user!.tier, Tier.free);
    expect(user.proExpiresAt, isNull);
  });

  test('fails when nobody is signed in', () async {
    final result = await repo.subscribeToPro();

    result.when(
      success: (_) => fail('expected a failure'),
      failure: (e) => expect(e, isA<PermissionDeniedException>()),
    );
  });
}
