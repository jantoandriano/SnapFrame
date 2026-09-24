import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/app/app.dart';

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

    expect(find.text("let's get snappy ✦"), findsOneWidget);
  });
}
