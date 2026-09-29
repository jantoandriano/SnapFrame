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
      // Anything still using stock Material chrome gets squared off and
      // ink-ruled so it doesn't break the brutalist look.
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.bg,
        foregroundColor: tokens.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: IconThemeData(color: tokens.ink),
        shape: Border(
          bottom: BorderSide(color: tokens.ink, width: SnapTokens.borderWidth),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: tokens.ink,
        linearTrackColor: tokens.lime,
        circularTrackColor: tokens.lime,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: tokens.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SnapRadius.md),
          side: BorderSide(color: tokens.ink, width: SnapTokens.borderWidth),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: tokens.surface,
        elevation: 0,
        shape: Border(
          top: BorderSide(color: tokens.ink, width: SnapTokens.borderWidth),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: <ThemeExtension<dynamic>>[tokens],
    );
  }
}
