import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// Three chunky dots bouncing in sequence, used wherever the app is
/// waiting on something.
///
/// A single subtly-rotating shape (the M1 first pass) read as a static
/// decoration rather than a loading state at a glance — bouncing dots are
/// an unambiguous, universally-recognized "this is loading" signal
/// regardless of what phase of the loop you catch it at. Kept as a
/// `flutter_animate` loop rather than Lottie for the same reason as
/// before: no Lottie asset exists in the design system yet.
class LoadingBlob extends StatelessWidget {
  const LoadingBlob({this.size = 64, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final dotSize = size / 3.4;
    final colors = [tokens.lime, tokens.pink, tokens.blue];

    Widget dot(int index) {
      final box = Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: colors[index],
          border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
          borderRadius: BorderRadius.circular(dotSize * 0.3),
        ),
      );

      final delay = Duration(milliseconds: index * 150);

      // Reduced motion (on web this follows the OS/browser setting, e.g.
      // Windows' "Animation effects" off) swaps the bounce for an in-place
      // pulse: no movement, but still visibly "working" — a frozen
      // indicator reads as a hung app.
      if (reduceMotion) {
        return box
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .fade(
              delay: delay,
              begin: 1,
              end: 0.25,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOut,
            );
      }

      // The stagger uses the effect's own `delay` (part of this one
      // AnimationController's timeline) rather than `.animate(delay:)`
      // (a separate Timer) — the latter leaks a pending Timer past
      // disposal when combined with `repeat()`.
      return box
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .slideY(
            delay: delay,
            end: -0.7,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
    }

    return Semantics(
      label: 'loading',
      child: SizedBox(
        width: size,
        height: size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [for (var i = 0; i < colors.length; i++) dot(i)],
        ),
      ),
    );
  }
}
