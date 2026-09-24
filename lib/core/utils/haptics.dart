import 'package:flutter/services.dart';

/// Thin wrapper over [HapticFeedback] so widgets depend on one seam
/// instead of the platform channel directly — swappable in widget tests.
abstract final class Haptics {
  static void selection() => HapticFeedback.selectionClick();

  static void light() => HapticFeedback.lightImpact();

  static void medium() => HapticFeedback.mediumImpact();

  static void heavy() => HapticFeedback.heavyImpact();
}
