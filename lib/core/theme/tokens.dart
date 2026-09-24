import 'package:flutter/material.dart';

/// Neo-brutalist design tokens: colors, shape, shadow, spacing.
///
/// Every widget in `core/widgets` reads its visual constants from this
/// `ThemeExtension` instead of hardcoding them, so light/dark and any
/// future re-skin flow through `SnapAppTheme` alone.
@immutable
class SnapTokens extends ThemeExtension<SnapTokens> {
  const SnapTokens({
    required this.bg,
    required this.surface,
    required this.ink,
    required this.lime,
    required this.pink,
    required this.blue,
    required this.sun,
    required this.orange,
    required this.lilac,
    required this.success,
    required this.error,
  });

  final Color bg;
  final Color surface;
  final Color ink;
  final Color lime;
  final Color pink;
  final Color blue;
  final Color sun;
  final Color orange;
  final Color lilac;
  final Color success;
  final Color error;

  static const SnapTokens light = SnapTokens(
    bg: Color(0xFFFFF8EE),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111111),
    lime: Color(0xFFC6FF3D),
    pink: Color(0xFFFF4FD8),
    blue: Color(0xFF3D5AFE),
    sun: Color(0xFFFFD23F),
    orange: Color(0xFFFF7A3D),
    lilac: Color(0xFFB69CFF),
    success: Color(0xFF2BD67B),
    error: Color(0xFFFF3B3B),
  );

  static const SnapTokens dark = SnapTokens(
    bg: Color(0xFF0E0E10),
    surface: Color(0xFF1A1A1F),
    ink: Color(0xFFF5F5F5),
    lime: Color(0xFFC6FF3D),
    pink: Color(0xFFFF4FD8),
    blue: Color(0xFF3D5AFE),
    sun: Color(0xFFFFD23F),
    orange: Color(0xFFFF7A3D),
    lilac: Color(0xFFB69CFF),
    success: Color(0xFF2BD67B),
    error: Color(0xFFFF3B3B),
  );

  static const double borderWidth = 2.5;

  @override
  SnapTokens copyWith({
    Color? bg,
    Color? surface,
    Color? ink,
    Color? lime,
    Color? pink,
    Color? blue,
    Color? sun,
    Color? orange,
    Color? lilac,
    Color? success,
    Color? error,
  }) {
    return SnapTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      lime: lime ?? this.lime,
      pink: pink ?? this.pink,
      blue: blue ?? this.blue,
      sun: sun ?? this.sun,
      orange: orange ?? this.orange,
      lilac: lilac ?? this.lilac,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  SnapTokens lerp(ThemeExtension<SnapTokens>? other, double t) {
    if (other is! SnapTokens) return this;
    return SnapTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      lime: Color.lerp(lime, other.lime, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      sun: Color.lerp(sun, other.sun, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      lilac: Color.lerp(lilac, other.lilac, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

abstract final class SnapRadius {
  static const double sm = 12;
  static const double md = 20;
  static const double lg = 28;
  static const double pill = 999;
}

/// Hard offset shadow, no blur. Pressed state collapses the offset to zero
/// while the widget itself translates by [offset], so a button looks like
/// it physically sinks onto the canvas.
abstract final class SnapShadow {
  static const Offset offset = Offset(4, 4);
  static const Offset pressedOffset = Offset.zero;
}

abstract final class SnapSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}
