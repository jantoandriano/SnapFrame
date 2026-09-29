import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/title_block.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('rejects a rotation outside -4..4 degrees', (tester) async {
    expect(
      () => TitleBlock(text: 'ate.', rotationDeg: 6),
      throwsAssertionError,
    );
  });

  testWidgets('renders uppercase, keeps original casing in semantics', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapForTest(const TitleBlock(text: 'ate. 💅')));
    expect(find.text('ATE. 💅'), findsOneWidget);
    expect(find.bySemanticsLabel('ate. 💅'), findsOneWidget);

    handle.dispose();
  });

  testWidgets('golden - light', (tester) async {
    await tester.pumpWidget(wrapForTest(const TitleBlock(text: 'snapframe')));
    await expectLater(
      find.byType(TitleBlock),
      matchesGoldenFile('goldens/title_block_light.png'),
    );
  });

  testWidgets('golden - dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const TitleBlock(text: 'snapframe'),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(TitleBlock),
      matchesGoldenFile('goldens/title_block_dark.png'),
    );
  });
}
