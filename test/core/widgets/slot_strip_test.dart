import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/slot_strip.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  // The current slot pulses forever (flutter_animate `repeat(reverse: true)`)
  // so these tests use a fixed `pump()` instead of `pumpAndSettle()`, which
  // would never return for an animation that never finishes.

  testWidgets('renders one box per slot', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const SlotStrip(slotCount: 4, currentIndex: 1)),
    );
    await tester.pump(const Duration(milliseconds: 16));

    final boxes = find.descendant(
      of: find.byType(SlotStrip),
      matching: find.byType(Container),
    );
    expect(boxes, findsNWidgets(4));
  });

  testWidgets('golden - light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const SlotStrip(slotCount: 4, currentIndex: 1)),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await expectLater(
      find.byType(SlotStrip),
      matchesGoldenFile('goldens/slot_strip_light.png'),
    );
  });

  testWidgets('golden - dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SlotStrip(slotCount: 4, currentIndex: 2),
        brightness: Brightness.dark,
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await expectLater(
      find.byType(SlotStrip),
      matchesGoldenFile('goldens/slot_strip_dark.png'),
    );
  });
}
