import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/pill_tab_bar.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('PillTabBar reports the tapped tab index', (tester) async {
    int? selected;
    await tester.pumpWidget(
      wrapForTest(
        PillTabBar(
          tabs: const ['Official', 'Community'],
          selectedIndex: 0,
          onChanged: (i) => selected = i,
        ),
      ),
    );

    await tester.tap(find.text('Community'));
    expect(selected, 1);
  });

  testWidgets('PillChip reports taps', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapForTest(
        PillChip(label: 'Newest', selected: false, onTap: () => tapped = true),
      ),
    );

    await tester.tap(find.text('Newest'));
    expect(tapped, isTrue);
  });

  testWidgets('golden - PillTabBar, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        PillTabBar(
          tabs: const ['Official', 'Community'],
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ),
    );
    await expectLater(
      find.byType(PillTabBar),
      matchesGoldenFile('goldens/pill_tab_bar_light.png'),
    );
  });

  testWidgets('golden - PillChip, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        PillChip(label: 'Pro', selected: true, onTap: () {}),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(PillChip),
      matchesGoldenFile('goldens/pill_chip_dark.png'),
    );
  });
}
