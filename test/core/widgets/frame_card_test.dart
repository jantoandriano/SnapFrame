import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/frame_card.dart';
import 'package:snapframe/core/widgets/sticker_badge.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('invokes onTap even when locked', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          width: 160,
          child: FrameCard(
            title: 'vip',
            isLocked: true,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FrameCard));
    expect(tapped, isTrue);
  });

  testWidgets('locked frame shows the PRO sticker and the lock', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(const SizedBox(width: 160, child: FrameCard(title: 'vip'))),
    );
    expect(find.byType(StickerBadge), findsNothing);

    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 160,
          child: FrameCard(title: 'vip', isLocked: true),
        ),
      ),
    );
    expect(find.byType(StickerBadge), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
  });

  testWidgets('unlocked pro frame keeps the PRO sticker but drops the lock', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(width: 160, child: FrameCard(title: 'vip', isPro: true)),
      ),
    );
    expect(find.byType(StickerBadge), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNothing);
  });

  testWidgets('golden - unlocked, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(width: 160, child: FrameCard(title: 'birthday bash')),
      ),
    );
    await expectLater(
      find.byType(FrameCard),
      matchesGoldenFile('goldens/frame_card_light.png'),
    );
  });

  testWidgets('golden - locked, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 160,
          child: FrameCard(title: 'vip only', isLocked: true),
        ),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(FrameCard),
      matchesGoldenFile('goldens/frame_card_locked_dark.png'),
    );
  });
}
