import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/app/theme_mode_controller.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/core/theme/app_theme.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/profile/data/profile_providers.dart';
import 'package:snapframe/features/profile/domain/subscription_repository.dart';
import 'package:snapframe/features/profile/presentation/views/profile_view.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

AppUser _user({Tier tier = Tier.free, DateTime? proExpiresAt}) => AppUser(
  uid: 'maya@example.com',
  displayName: 'Maya Putri',
  email: 'maya@example.com',
  tier: tier,
  proExpiresAt: proExpiresAt,
  createdAt: DateTime.utc(2026, 9),
);

void main() {
  late _MockAuthRepository authRepo;
  late _MockSubscriptionRepository subRepo;
  late ProviderContainer container;

  Future<void> pumpProfile(WidgetTester tester, AppUser user) async {
    authRepo = _MockAuthRepository();
    subRepo = _MockSubscriptionRepository();
    when(() => authRepo.currentUser).thenAnswer((_) => Stream.value(user));
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepo),
        subscriptionRepositoryProvider.overrideWithValue(subRepo),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: SnapAppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProfileView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('profileInitials', () {
    test('takes the first letter of the first two words', () {
      expect(profileInitials('maya putri ayu'), 'MP');
    });

    test('takes two letters of a single name', () {
      expect(profileInitials('maya'), 'MA');
      expect(profileInitials('m'), 'M');
    });

    test('falls back to ? for a blank name', () {
      expect(profileInitials('  '), '?');
    });
  });

  testWidgets('a free user sees their identity and a subscribe button', (
    tester,
  ) async {
    await pumpProfile(tester, _user());

    expect(find.text('MP'), findsOneWidget);
    expect(find.text('MAYA PUTRI'), findsOneWidget);
    expect(find.text('maya@example.com'), findsOneWidget);
    expect(find.text('FREE'), findsOneWidget);
    expect(find.text('GO PRO'), findsOneWidget);
    expect(find.text('CANCEL PRO'), findsNothing);
  });

  testWidgets('tapping subscribe calls the repository', (tester) async {
    await pumpProfile(tester, _user());
    when(() => subRepo.subscribeToPro())
        .thenAnswer((_) async => const Result.success(null));

    await tester.tap(find.text('GO PRO'));
    await tester.pumpAndSettle();

    verify(() => subRepo.subscribeToPro()).called(1);
    expect(find.text("you're pro now ✦"), findsOneWidget);
  });

  testWidgets('a pro user sees their renewal date and can cancel', (
    tester,
  ) async {
    await pumpProfile(
      tester,
      _user(tier: Tier.pro, proExpiresAt: DateTime(2026, 10, 29)),
    );
    when(() => subRepo.cancelPro())
        .thenAnswer((_) async => const Result.success(null));

    expect(find.text('PRO UNTIL OCT 29, 2026'), findsOneWidget);
    expect(find.text('GO PRO'), findsNothing);

    await tester.tap(find.text('CANCEL PRO'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('YES, CANCEL'));
    await tester.pumpAndSettle();

    verify(() => subRepo.cancelPro()).called(1);
  });

  testWidgets('backing out of the cancel dialog keeps pro', (tester) async {
    await pumpProfile(tester, _user(tier: Tier.pro));

    await tester.tap(find.text('CANCEL PRO'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('KEEP PRO'));
    await tester.pumpAndSettle();

    verifyNever(() => subRepo.cancelPro());
  });

  testWidgets('the theme toggle switches the app theme mode', (tester) async {
    await pumpProfile(tester, _user());
    expect(container.read(themeModeControllerProvider), ThemeMode.system);

    await tester.tap(find.text('DARK'));
    await tester.pump();

    expect(container.read(themeModeControllerProvider), ThemeMode.dark);
  });
}
