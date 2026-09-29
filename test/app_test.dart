import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/app/app.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';

import 'golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('boots to splash, then routes to login when signed out', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: SnapApp()));
    // The splash/browse screens have looping animations (LoadingBlob), so
    // a bounded pump is used instead of `pumpAndSettle`, which would never
    // return.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("LET'S GET SNAPPY ✦"), findsOneWidget);
  });

  testWidgets('a signed-out deep link to a protected page lands on login', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const SnapApp()),
    );
    await tester.pump();

    container.read(goRouterProvider).go('/profile');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("LET'S GET SNAPPY ✦"), findsOneWidget);
  });

  testWidgets('a page opened without its passed-in data falls back home', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const SnapApp()),
    );
    await tester.pump();
    // The fake sign-in awaits a delay, which only elapses as the fake
    // clock is pumped — so start it, then pump past it.
    unawaited(
      container
          .read(authRepositoryProvider)
          .signInWithEmail('maya@example.com', 'whatever'),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    container.read(goRouterProvider).go('/capture');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('BROWSE'), findsOneWidget);
  });
}
