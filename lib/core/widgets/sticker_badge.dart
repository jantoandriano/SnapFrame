import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// A rotated sticker-sheet label, e.g. "PRO ✦", "NEW", "🔥 hot".
class StickerBadge extends StatelessWidget {
  const StickerBadge({
    required this.label,
    this.color,
    this.rotationDeg = -6,
    super.key,
  }) : assert(
         rotationDeg >= -8 && rotationDeg <= 8,
         'keep the sticker tilt within the -8..8 degree range',
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
          borderRadius: BorderRadius.circular(SnapRadius.sm),
          border: Border.all(
            color: tokens.ink,
            width: SnapTokens.borderWidthThin,
          ),
          boxShadow: [BoxShadow(color: tokens.ink, offset: SnapShadow.small)],
        ),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: tokens.ink, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
