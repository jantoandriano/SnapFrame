import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/sticker_badge.dart';

/// "Got it" confirmation shown right after a shot: the screen dims, the
/// photo pops in as a tilted polaroid with a sticker, then shrinks away.
/// Runs once in ~900ms, inside the ViewModel's hold before the next
/// countdown starts.
class CapturedOverlay extends StatelessWidget {
  const CapturedOverlay({required this.photo, required this.label, super.key});

  final Widget photo;
  final String label;

  static const _popIn = Duration(milliseconds: 350);
  static const _hold = Duration(milliseconds: 300);
  static const _exit = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    final card = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: -3 * math.pi / 180,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              SnapSpacing.sm,
              SnapSpacing.sm,
              SnapSpacing.sm,
              SnapSpacing.xl,
            ),
            decoration: BoxDecoration(
              color: tokens.surface,
              border: Border.all(
                color: tokens.ink,
                width: SnapTokens.borderWidth,
              ),
              boxShadow: [
                BoxShadow(color: tokens.ink, offset: SnapShadow.offset),
              ],
            ),
            child: SizedBox(width: 180, height: 220, child: photo),
          ),
        ),
        const SizedBox(height: SnapSpacing.md),
        StickerBadge(label: label, color: tokens.lime, rotationDeg: 3),
      ],
    );

    const scrim = ColoredBox(color: Colors.black45);

    if (reduceMotion) {
      return Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(child: scrim),
          card,
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: scrim
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 150))
              .then(delay: _popIn + _hold - const Duration(milliseconds: 150))
              .fadeOut(duration: _exit),
        ),
        card
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 120))
            .scaleXY(begin: 0.6, duration: _popIn, curve: Curves.elasticOut)
            .then(delay: _hold)
            .scaleXY(end: 0.5, duration: _exit, curve: Curves.easeIn)
            .slideY(end: 0.8, duration: _exit, curve: Curves.easeIn)
            .fadeOut(duration: _exit),
      ],
    );
  }
}
