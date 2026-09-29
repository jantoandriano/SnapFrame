import 'package:flutter/material.dart';

const String displayFontFamily = 'Bricolage Grotesque';
const String bodyFontFamily = 'Space Grotesk';

/// Countdown numerals sit outside [TextTheme] since they need a stroke
/// paint, not just a font/size/weight triple.
const double countdownFontSizeMin = 160;
const double countdownFontSizeMax = 220;

/// Flutter has no text-transform, so widgets that want the shouty
/// brutalist look call `toUpperCase()` on their label themselves; these
/// styles are tuned (tight tracking on display, open tracking on labels)
/// for that uppercase text.
TextTheme buildSnapTextTheme(Color ink) {
  TextStyle display(double size) => TextStyle(
    fontFamily: displayFontFamily,
    fontWeight: FontWeight.w800,
    fontSize: size,
    letterSpacing: -1,
    color: ink,
    height: 0.95,
  );

  TextStyle title(double size) => TextStyle(
    fontFamily: displayFontFamily,
    fontWeight: FontWeight.w800,
    fontSize: size,
    color: ink,
  );

  TextStyle body(
    double size,
    FontWeight weight, {
    double? height,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: weight,
    fontSize: size,
    color: ink,
    height: height,
    letterSpacing: letterSpacing,
  );

  return TextTheme(
    displayLarge: display(56),
    displayMedium: display(44),
    displaySmall: display(36),
    headlineLarge: display(30),
    headlineMedium: display(26),
    headlineSmall: display(22),
    titleLarge: title(18),
    titleMedium: title(16),
    titleSmall: title(14),
    bodyLarge: body(16, FontWeight.w400, height: 1.4),
    bodyMedium: body(14, FontWeight.w400, height: 1.4),
    bodySmall: body(12, FontWeight.w400, height: 1.4),
    labelLarge: body(16, FontWeight.w700, letterSpacing: 0.8),
    labelMedium: body(14, FontWeight.w700, letterSpacing: 0.8),
    labelSmall: body(12, FontWeight.w700, letterSpacing: 0.8),
  );
}
