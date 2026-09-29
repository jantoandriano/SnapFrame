import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/app/auth_redirect.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

final _user = AppUser(
  uid: 'maya@example.com',
  displayName: 'Maya',
  email: 'maya@example.com',
  tier: Tier.free,
  createdAt: DateTime.utc(2026, 9),
);

String? _redirect(
  AsyncValue<AppUser?> user,
  String location, {
  bool hasExtra = false,
}) => authRedirect(user: user, location: location, hasExtra: hasExtra);

void main() {
  group('while the session is unknown', () {
    const loading = AsyncLoading<AppUser?>();

    test('stays on the splash gate', () {
      expect(_redirect(loading, '/'), isNull);
    });

    test('sends everything else to the splash gate', () {
      expect(_redirect(loading, '/profile'), '/');
      expect(_redirect(loading, '/login'), '/');
    });
  });

  group('when signed out', () {
    const signedOut = AsyncData<AppUser?>(null);

    test('allows the splash gate and login', () {
      expect(_redirect(signedOut, '/'), isNull);
      expect(_redirect(signedOut, '/login'), isNull);
    });

    test('sends protected pages to login', () {
      expect(_redirect(signedOut, '/home'), '/login');
      expect(_redirect(signedOut, '/profile'), '/login');
      expect(_redirect(signedOut, '/capture', hasExtra: true), '/login');
    });
  });

  group('when signed in', () {
    final signedIn = AsyncData<AppUser?>(_user);

    test('bounces login to home', () {
      expect(_redirect(signedIn, '/login'), '/home');
    });

    test('lets ordinary pages through', () {
      expect(_redirect(signedIn, '/'), isNull);
      expect(_redirect(signedIn, '/home'), isNull);
      expect(_redirect(signedIn, '/profile'), isNull);
    });

    test('sends pages that lost their passed-in data home', () {
      for (final path in ['/frame', '/capture', '/review', '/result']) {
        expect(_redirect(signedIn, path), '/home', reason: path);
        expect(_redirect(signedIn, path, hasExtra: true), isNull, reason: path);
      }
    });
  });
}
