import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/captured_overlay.dart';

import '../../golden_helpers.dart';

void main() {
  testWidgets('pops the photo in with its label', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const CapturedOverlay(
          photo: ColoredBox(key: Key('photo'), color: Colors.red),
          label: 'got it!',
        ),
      ),
    );
    // Mid-hold: fully popped in, not yet exiting.
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('photo')), findsOneWidget);
    expect(find.text('got it!'), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('with reduced motion, shows statically', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: wrapForTest(
          const CapturedOverlay(photo: SizedBox(), label: 'got it!'),
        ),
      ),
    );

    expect(find.text('got it!'), findsOneWidget);
    // Nothing scheduled — no animation to settle.
    expect(tester.hasRunningAnimations, isFalse);
  });
}
