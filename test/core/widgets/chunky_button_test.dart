import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/chunky_button.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('invokes onPressed when tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapForTest(ChunkyButton(label: 'go', onPressed: () => tapped = true)),
    );

    await tester.tap(find.text('go'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('is disabled when onPressed is null', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const ChunkyButton(label: 'go', onPressed: null)),
    );

    final semantics = tester.getSemantics(find.byType(ChunkyButton));
    expect(semantics.flagsCollection.isEnabled.toBoolOrNull(), isFalse);
  });

  testWidgets('golden - primary variant, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(ChunkyButton(label: 'snap it', onPressed: () {})),
    );
    await expectLater(
      find.byType(ChunkyButton),
      matchesGoldenFile('goldens/chunky_button_light.png'),
    );
  });

  testWidgets('golden - primary variant, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        ChunkyButton(label: 'snap it', onPressed: () {}),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(ChunkyButton),
      matchesGoldenFile('goldens/chunky_button_dark.png'),
    );
  });
}
