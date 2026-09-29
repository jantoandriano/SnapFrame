import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// A screen heading stamped onto a tilted, hard-shadowed color block —
/// the loudest element on a screen (login title, result title, wordmark).
class TitleBlock extends StatelessWidget {
  const TitleBlock({
    required this.text,
    this.color,
    this.rotationDeg = -2,
    super.key,
  }) : assert(
         rotationDeg >= -4 && rotationDeg <= 4,
         'keep the title tilt within the -4..4 degree range',
       );

  final String text;

  /// Block fill; defaults to [SnapTokens.sun].
  final Color? color;
  final double rotationDeg;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      header: true,
      label: text,
      excludeSemantics: true,
      child: Transform.rotate(
        angle: rotationDeg * math.pi / 180,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SnapSpacing.lg,
            vertical: SnapSpacing.md,
          ),
          decoration: BoxDecoration(
            color: color ?? tokens.sun,
            borderRadius: BorderRadius.circular(SnapRadius.md),
            border: Border.all(
              color: tokens.ink,
              width: SnapTokens.borderWidth,
            ),
            boxShadow: [
              BoxShadow(color: tokens.ink, offset: SnapShadow.offset),
            ],
          ),
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            // The block fills are always bright, so the text stays dark
            // in both themes.
            style: Theme.of(context).textTheme.displaySmall
                ?.copyWith(color: SnapTokens.onAccent),
          ),
        ),
      ),
    );
  }
}
