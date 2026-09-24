import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/theme/typography.dart';

abstract final class SnapAppTheme {
  static ThemeData light = _build(SnapTokens.light, Brightness.light);
  static ThemeData dark = _build(SnapTokens.dark, Brightness.dark);

  static ThemeData _build(SnapTokens tokens, Brightness brightness) {
    final textTheme = buildSnapTextTheme(tokens.ink);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: tokens.bg,
      canvasColor: tokens.bg,
      fontFamily: bodyFontFamily,
      textTheme: textTheme,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: tokens.lime,
        onPrimary: tokens.ink,
        secondary: tokens.pink,
        onSecondary: tokens.ink,
        error: tokens.error,
        onError: Colors.white,
        surface: tokens.surface,
        onSurface: tokens.ink,
      ),
      dividerColor: tokens.ink,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: <ThemeExtension<dynamic>>[tokens],
    );
  }
}
