import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/utils/haptics.dart';

/// The brutalist replacement for Material's `AppBar`: a solid [accent]
/// color block with an ink bottom rule, an UPPERCASE title, and — when the
/// route can pop — a square, hard-shadowed back button. [trailing] sits
/// at the right edge (typically a [SnapSquareButton]).
class SnapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SnapAppBar({
    required this.title,
    this.accent,
    this.trailing,
    super.key,
  });

  final String title;
  final Widget? trailing;

  /// Fill for the whole bar; defaults to [SnapTokens.sun].
  final Color? accent;

  static const double _height = 72;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final canPop = Navigator.of(context).canPop();

    return Container(
      decoration: BoxDecoration(
        color: accent ?? tokens.sun,
        border: Border(
          bottom: BorderSide(color: tokens.ink, width: SnapTokens.borderWidth),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SnapSpacing.lg),
            child: Row(
              children: [
                if (canPop) ...[
                  SnapSquareButton(
                    semanticLabel: MaterialLocalizations.of(context)
                        .backButtonTooltip,
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: Icon(Icons.arrow_back_rounded, color: tokens.ink),
                  ),
                  const SizedBox(width: SnapSpacing.md),
                ],
                Expanded(
                  child: Semantics(
                    header: true,
                    label: title,
                    excludeSemantics: true,
                    child: Text(
                      title.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: SnapTokens.onAccent),
                    ),
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: SnapSpacing.md),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Square, ink-bordered, hard-shadowed tap target — the app bar's back
/// button, and any bar action (e.g. the profile avatar on Browse).
class SnapSquareButton extends StatelessWidget {
  const SnapSquareButton({
    required this.semanticLabel,
    required this.onPressed,
    required this.child,
    this.color,
    super.key,
  });

  final String semanticLabel;
  final VoidCallback onPressed;
  final Widget child;

  /// Fill; defaults to [SnapTokens.surface].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Haptics.light();
          onPressed();
        },
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? tokens.surface,
            borderRadius: BorderRadius.circular(SnapRadius.sm),
            border: Border.all(
              color: tokens.ink,
              width: SnapTokens.borderWidth,
            ),
            boxShadow: [BoxShadow(color: tokens.ink, offset: SnapShadow.small)],
          ),
          child: child,
        ),
      ),
    );
  }
}
