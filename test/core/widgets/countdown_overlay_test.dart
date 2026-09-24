import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/countdown_overlay.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('shows the numeral for a positive tick', (tester) async {
    await tester.pumpWidget(wrapForTest(const CountdownOverlay(tick: 3)));
    await tester.pumpAndSettle();
    // Rendered twice: once for the ink stroke layer, once for the fill.
    expect(find.text('3'), findsNWidgets(2));
  });

  testWidgets('shows the capture emoji at tick 0', (tester) async {
    await tester.pumpWidget(wrapForTest(const CountdownOverlay(tick: 0)));
    await tester.pumpAndSettle();
    expect(find.text('📸'), findsNWidgets(2));
  });

  testWidgets('golden - counting down, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 300,
          height: 300,
          child: CountdownOverlay(tick: 2),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CountdownOverlay),
      matchesGoldenFile('goldens/countdown_overlay_light.png'),
    );
  });

  testWidgets('golden - capture moment, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 300,
          height: 300,
          child: CountdownOverlay(tick: 0),
        ),
        brightness: Brightness.dark,
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CountdownOverlay),
      matchesGoldenFile('goldens/countdown_overlay_capture_dark.png'),
    );
  });
}
