import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/utils/haptics.dart';

enum SnapButtonVariant { primary, secondary, ghost }

/// A button that visually sinks onto the canvas when pressed: the hard
/// offset shadow collapses to zero while the button translates by the
/// same offset, so it reads as a physical object rather than a flat tap
/// target.
class ChunkyButton extends StatefulWidget {
  const ChunkyButton({
    required this.label,
    required this.onPressed,
    this.variant = SnapButtonVariant.primary,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final SnapButtonVariant variant;
  final IconData? icon;

  @override
  State<ChunkyButton> createState() => _ChunkyButtonState();
}

class _ChunkyButtonState extends State<ChunkyButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  // Ghost stays fully opaque when disabled; the filled variants fade.
  Color _fillColor(SnapTokens tokens, {required bool enabled}) {
    final Color accent;
    switch (widget.variant) {
      case SnapButtonVariant.primary:
        accent = tokens.lime;
      case SnapButtonVariant.secondary:
        accent = tokens.pink;
      case SnapButtonVariant.ghost:
        return tokens.surface;
    }
    return enabled ? accent : accent.withValues(alpha: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final enabled = widget.onPressed != null;
    final fill = _fillColor(tokens, enabled: enabled);

    return Semantics(
      button: true,
      enabled: enabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? (_) => _setPressed(true) : null,
        onTapUp: enabled ? (_) => _setPressed(false) : null,
        onTapCancel: enabled ? () => _setPressed(false) : null,
        onTap: enabled
            ? () {
                Haptics.light();
                widget.onPressed!();
              }
            : null,
        child: Transform.translate(
          offset: _pressed ? SnapShadow.offset : Offset.zero,
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.symmetric(
              horizontal: SnapSpacing.xl,
              vertical: SnapSpacing.md,
            ),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(SnapRadius.md),
              border: Border.all(
                color: tokens.ink,
                width: SnapTokens.borderWidth,
              ),
              boxShadow: _pressed
                  ? const []
                  : [BoxShadow(color: tokens.ink, offset: SnapShadow.offset)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 20, color: tokens.ink),
                  const SizedBox(width: SnapSpacing.sm),
                ],
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: tokens.ink),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
