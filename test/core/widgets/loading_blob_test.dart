import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/loading_blob.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('exposes a "loading" semantic label', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapForTest(const LoadingBlob()));
    await tester.pump(const Duration(milliseconds: 16));
    expect(find.bySemanticsLabel('loading'), findsOneWidget);

    handle.dispose();
  });

  testWidgets('still animates (as a pulse) when motion is reduced', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: LoadingBlob(),
        ),
      ),
    );

    List<double> opacities() => tester
        .widgetList<FadeTransition>(
          find.descendant(
            of: find.byType(LoadingBlob),
            matching: find.byType(FadeTransition),
          ),
        )
        .map((t) => t.opacity.value)
        .toList();

    // The first frame only starts the ticker; the clock runs from there.
    await tester.pump(const Duration(milliseconds: 16));
    final before = opacities();
    await tester.pump(const Duration(milliseconds: 300));
    expect(opacities(), isNot(before));
    // Nothing moves: the dots stay on their baseline.
    expect(
      find.descendant(
        of: find.byType(LoadingBlob),
        matching: find.byType(FractionalTranslation),
      ),
      findsNothing,
    );
  });

  testWidgets('golden - light', (tester) async {
    await tester.pumpWidget(wrapForTest(const LoadingBlob()));
    await tester.pump(const Duration(milliseconds: 16));
    await expectLater(
      find.byType(LoadingBlob),
      matchesGoldenFile('goldens/loading_blob_light.png'),
    );
  });

  testWidgets('golden - dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const LoadingBlob(), brightness: Brightness.dark),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await expectLater(
      find.byType(LoadingBlob),
      matchesGoldenFile('goldens/loading_blob_dark.png'),
    );
  });
}
