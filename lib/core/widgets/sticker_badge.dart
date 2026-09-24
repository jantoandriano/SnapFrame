import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// A rotated sticker-sheet label, e.g. "PRO ✦", "NEW", "🔥 hot".
class StickerBadge extends StatelessWidget {
  const StickerBadge({
    required this.label,
    this.color,
    this.rotationDeg = -4,
    super.key,
  }) : assert(
         rotationDeg >= -4 && rotationDeg <= 4,
         'keep the sticker tilt within the -4..4 degree range',
       );

  final String label;
  final Color? color;
  final double rotationDeg;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Transform.rotate(
      angle: rotationDeg * math.pi / 180,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SnapSpacing.sm,
          vertical: SnapSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: color ?? tokens.sun,
          borderRadius: BorderRadius.circular(SnapRadius.pill),
          border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
          boxShadow: [BoxShadow(color: tokens.ink, offset: const Offset(2, 2))],
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: tokens.ink, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
