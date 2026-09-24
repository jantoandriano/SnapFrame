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
