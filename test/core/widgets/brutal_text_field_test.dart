import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/widgets/brutal_text_field.dart';

import '../../golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('reports changes via onChanged', (tester) async {
    String? value;
    await tester.pumpWidget(
      wrapForTest(BrutalTextField(onChanged: (v) => value = v)),
    );

    await tester.enterText(find.byType(TextField), 'snapframe');
    expect(value, 'snapframe');
  });

  testWidgets('shows the error text when set', (tester) async {
    await tester.pumpWidget(
      wrapForTest(const BrutalTextField(errorText: 'oops')),
    );
    expect(find.text('oops'), findsOneWidget);
  });

  testWidgets('golden - empty, light', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 280,
          child: BrutalTextField(label: 'email', hintText: 'you@snapframe.app'),
        ),
      ),
    );
    await expectLater(
      find.byType(BrutalTextField),
      matchesGoldenFile('goldens/brutal_text_field_light.png'),
    );
  });

  testWidgets('golden - error, dark', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 280,
          child: BrutalTextField(label: 'email', errorText: 'invalid email'),
        ),
        brightness: Brightness.dark,
      ),
    );
    await expectLater(
      find.byType(BrutalTextField),
      matchesGoldenFile('goldens/brutal_text_field_error_dark.png'),
    );
  });
}
