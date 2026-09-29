import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/theme/app_theme.dart';
import 'package:snapframe/core/widgets/snap_app_bar.dart';

import '../../golden_helpers.dart';

/// Pushes a second route carrying a [SnapAppBar] so the back button has
/// somewhere to pop to.
Widget _pushedApp({Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.light
        ? SnapAppTheme.light
        : SnapAppTheme.dark,
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    const Scaffold(appBar: SnapAppBar(title: 'Browse frames')),
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('renders the title uppercase with no back button at root', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(height: 72, child: SnapAppBar(title: 'Browse frames')),
      ),
    );

    expect(find.text('BROWSE FRAMES'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_rounded), findsNothing);
  });

  testWidgets('renders a trailing action and fires it', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          height: 72,
          child: SnapAppBar(
            title: 'Browse',
            trailing: SnapSquareButton(
              semanticLabel: 'open profile',
              onPressed: () => taps++,
              child: const Text('MA'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('MA'));
    expect(taps, 1);
  });

  testWidgets('back button pops the route', (tester) async {
    await tester.pumpWidget(_pushedApp());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('BROWSE FRAMES'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(find.text('BROWSE FRAMES'), findsNothing);
  });

  testWidgets('golden - light', (tester) async {
    await tester.pumpWidget(_pushedApp());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(SnapAppBar),
      matchesGoldenFile('goldens/snap_app_bar_light.png'),
    );
  });

  testWidgets('golden - dark', (tester) async {
    await tester.pumpWidget(_pushedApp(brightness: Brightness.dark));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(SnapAppBar),
      matchesGoldenFile('goldens/snap_app_bar_dark.png'),
    );
  });
}
