import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';

/// Reachable without a session.
const _publicPaths = {'/', '/login'};

/// Routes whose data travels as GoRouter `extra`, which a web refresh
/// can't restore — landing on one without it would crash the page.
const _extraPaths = {'/frame', '/capture', '/review', '/result'};

/// GoRouter redirect: where [location] should go instead, or `null` to
/// stay. Pure so it can be tested without a router.
String? authRedirect({
  required AsyncValue<AppUser?> user,
  required String location,
  required bool hasExtra,
}) {
  // Session unknown yet: the splash gate waits for it and routes on.
  if (!user.hasValue) return location == '/' ? null : '/';

  if (user.value == null) {
    return _publicPaths.contains(location) ? null : '/login';
  }

  if (location == '/login') return '/home';
  if (_extraPaths.contains(location) && !hasExtra) return '/home';
  return null;
}
