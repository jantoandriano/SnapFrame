import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/chunky_button.dart';
import 'package:snapframe/core/widgets/empty_state.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('EmptyState has no retry button', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const EmptyState(message: 'nothing here')),
    );
    expect(find.byType(ChunkyButton), findsNothing);
  });

  testWidgets('ErrorState invokes onRetry when tapped', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      wrapForTest(
        ErrorState(message: 'flopped', onRetry: () => retried = true),
      ),
    );

    await tester.tap(find.byType(ChunkyButton));
    expect(retried, isTrue);
  });

  testWidgets('golden - EmptyState, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 300,
          height: 300,
          child: EmptyState(message: 'no frames yet… make one'),
        ),
      ),
    );
    await expectLater(
      find.byType(EmptyState),
      matchesGoldenFile('goldens/empty_state_light.png'),
    );
  });

  testWidgets('golden - ErrorState, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          width: 300,
          height: 300,
          child: ErrorState(message: 'oops, something flopped', onRetry: () {}),
        ),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(ErrorState),
      matchesGoldenFile('goldens/error_state_dark.png'),
    );
  });
}
