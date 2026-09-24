import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/misc.dart' show Override;
import 'package:snapframe/core/theme/app_theme.dart';

/// `flutter test` renders text with a tofu fallback font unless the real
/// font bytes are loaded into the test binding first — there's no
/// `golden_toolkit` in this stack, so this does it by hand.
Future<void> loadAppFonts() async {
  final bricolage = await rootBundle.load(
    'assets/fonts/BricolageGrotesque.ttf',
  );
  final space = await rootBundle.load('assets/fonts/SpaceGrotesk.ttf');
  await (FontLoader(
    'Bricolage Grotesque',
  )..addFont(Future.value(bricolage))).load();
  await (FontLoader('Space Grotesk')..addFont(Future.value(space))).load();
}

Widget wrapForTest(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.light
        ? SnapAppTheme.light
        : SnapAppTheme.dark,
    home: Scaffold(body: Center(child: child)),
  );
}

Widget wrapWithProviders(
  Widget child, {
  List<Override> overrides = const [],
  Brightness brightness = Brightness.light,
}) {
  return ProviderScope(
    overrides: overrides,
    child: wrapForTest(child, brightness: brightness),
  );
}
