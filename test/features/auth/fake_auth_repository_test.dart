import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/auth/data/fake_auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

void main() {
  test('the dummy pro account signs in as a Pro user', () async {
    final repo = FakeAuthRepository();

    await repo.signInWithEmail(fakeProEmail, fakeProPassword);

    final user = await repo.currentUser.first;
    expect(user!.tier, Tier.pro);
  });

  test('the dummy pro account rejects a wrong password', () async {
    final repo = FakeAuthRepository();

    final result = await repo.signInWithEmail(fakeProEmail, 'nope123');

    result.when(
      success: (_) => fail('expected a failure'),
      failure: (e) => expect(e, isA<ValidationException>()),
    );
    expect(await repo.currentUser.first, isNull);
  });

  test('any other account signs in as free', () async {
    final repo = FakeAuthRepository();

    await repo.signInWithEmail('maya@example.com', 'whatever');

    final user = await repo.currentUser.first;
    expect(user!.tier, Tier.free);
  });

  test('setTier updates the signed-in user', () async {
    final repo = FakeAuthRepository();
    await repo.signInWithEmail('maya@example.com', 'whatever');
    final expiry = DateTime(2026, 10, 29);

    final applied = repo.setTier(Tier.pro, proExpiresAt: expiry);

    expect(applied, isTrue);
    final user = await repo.currentUser.first;
    expect(user!.tier, Tier.pro);
    expect(user.proExpiresAt, expiry);
    expect(user.email, 'maya@example.com');
  });

  test('setTier is a no-op when signed out', () async {
    final repo = FakeAuthRepository();

    expect(repo.setTier(Tier.pro), isFalse);
    expect(await repo.currentUser.first, isNull);
  });
}
