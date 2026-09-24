import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/chunky_button.dart';
import 'package:snapframe/core/widgets/snap_snack.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('showSnapSnack surfaces the message via ScaffoldMessenger', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        Builder(
          builder: (context) => ChunkyButton(
            label: 'trigger',
            onPressed: () => showSnapSnack(context, 'ate. 💅'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('trigger'));
    await tester.pump();

    expect(find.text('ate. 💅'), findsOneWidget);
  });

  testWidgets('golden - neutral, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const SnapSnackContent(message: 'ate. 💅')),
    );
    await expectLater(
      find.byType(SnapSnackContent),
      matchesGoldenFile('goldens/snap_snack_neutral_light.png'),
    );
  });

  testWidgets('golden - error, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SnapSnackContent(
          message: 'oops, something flopped',
          variant: SnapSnackVariant.error,
        ),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(SnapSnackContent),
      matchesGoldenFile('goldens/snap_snack_error_dark.png'),
    );
  });
}
