import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/chunky_button.dart';
import 'package:snapframe/core/widgets/loading_blob.dart';

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

  testWidgets('isLoading shows dots and ignores taps', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapForTest(
        ChunkyButton(
          label: 'saving',
          isLoading: true,
          onPressed: () => tapped = true,
        ),
      ),
    );

    // Lets flutter_animate's start timer fire.
    await tester.pump(const Duration(milliseconds: 16));
    expect(find.byType(LoadingBlob), findsOneWidget);
    await tester.tap(find.text('saving'));
    await tester.pump();
    expect(tapped, isFalse);
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
