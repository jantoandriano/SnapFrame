import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// Captured-photo thumbnails for the active session; the slot currently
/// being captured pulses so it's obvious which shot is "live".
class SlotStrip extends StatelessWidget {
  const SlotStrip({
    required this.slotCount,
    required this.currentIndex,
    this.thumbnails = const [],
    this.highlightIndex,
    super.key,
  });

  final int slotCount;
  final int currentIndex;
  final List<Widget?> thumbnails;

  /// A slot that just changed (e.g. a retake): lime border plus a one-off
  /// pop, rather than the endless pulse of [currentIndex].
  final int? highlightIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < slotCount; i++) ...[
          if (i > 0) const SizedBox(width: SnapSpacing.sm),
          _Slot(
            isCurrent: i == currentIndex,
            isHighlighted: i == highlightIndex,
            thumbnail: i < thumbnails.length ? thumbnails[i] : null,
          ),
        ],
      ],
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.isCurrent,
    required this.isHighlighted,
    required this.thumbnail,
  });

  final bool isCurrent;
  final bool isHighlighted;
  final Widget? thumbnail;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final borderColor = isCurrent || isHighlighted ? tokens.lime : tokens.ink;

    Widget box = Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(SnapRadius.sm),
        border: Border.all(color: borderColor, width: SnapTokens.borderWidth),
      ),
      child: thumbnail,
    );

    if (isCurrent && !reduceMotion) {
      box = box
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            end: const Offset(1.08, 1.08),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
    } else if (isHighlighted && !reduceMotion) {
      box = box
          .animate()
          .scaleXY(
            end: 1.25,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
          )
          .then()
          .scaleXY(
            end: 0.8,
            duration: const Duration(milliseconds: 320),
            curve: Curves.elasticOut,
          );
    }

    return Semantics(
      label: isCurrent
          ? 'current shot'
          : isHighlighted
          ? 'updated shot'
          : 'captured shot',
      child: box,
    );
  }
}
