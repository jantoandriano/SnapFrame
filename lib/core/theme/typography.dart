import 'package:flutter/material.dart';

const String displayFontFamily = 'Bricolage Grotesque';
const String bodyFontFamily = 'Space Grotesk';

/// Countdown numerals sit outside [TextTheme] since they need a stroke
/// paint, not just a font/size/weight triple.
const double countdownFontSizeMin = 160;
const double countdownFontSizeMax = 220;

TextTheme buildSnapTextTheme(Color ink) {
  TextStyle display(double size, {double letterSpacing = -0.5}) => TextStyle(
    fontFamily: displayFontFamily,
    fontWeight: FontWeight.w800,
    fontSize: size,
    letterSpacing: letterSpacing,
    color: ink,
    height: 1.05,
  );

  TextStyle body(double size, FontWeight weight, {double? height}) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: weight,
    fontSize: size,
    color: ink,
    height: height,
  );

  return TextTheme(
    displayLarge: display(48),
    displayMedium: display(40),
    displaySmall: display(32),
    headlineLarge: display(28),
    headlineMedium: display(24),
    headlineSmall: display(20),
    titleLarge: body(18, FontWeight.w700),
    titleMedium: body(16, FontWeight.w700),
    titleSmall: body(14, FontWeight.w700),
    bodyLarge: body(16, FontWeight.w400, height: 1.4),
    bodyMedium: body(14, FontWeight.w400, height: 1.4),
    bodySmall: body(12, FontWeight.w400, height: 1.4),
    labelLarge: body(16, FontWeight.w500),
    labelMedium: body(14, FontWeight.w500),
    labelSmall: body(12, FontWeight.w500),
  );
}
