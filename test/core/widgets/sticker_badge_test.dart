import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/sticker_badge.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('rejects a rotation outside -4..4 degrees', (tester) async {
    expect(
      () => StickerBadge(label: 'PRO ✦', rotationDeg: 10),
      throwsAssertionError,
    );
  });

  testWidgets('exposes its label as a semantic label', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapForTest(const StickerBadge(label: 'NEW')));
    expect(find.bySemanticsLabel('NEW'), findsOneWidget);

    // `addTearDown` runs after this binding's own end-of-test invariant
    // check (which asserts no SemanticsHandle is left open), so it has to
    // be disposed inline here rather than via `addTearDown`.
    handle.dispose();
  });

  testWidgets('golden - light', (tester) async {
    await tester.pumpWidget(wrapForTest(const StickerBadge(label: 'PRO ✦')));
    await expectLater(
      find.byType(StickerBadge),
      matchesGoldenFile('goldens/sticker_badge_light.png'),
    );
  });

  testWidgets('golden - dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const StickerBadge(label: 'PRO ✦'),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(StickerBadge),
      matchesGoldenFile('goldens/sticker_badge_dark.png'),
    );
  });
}
