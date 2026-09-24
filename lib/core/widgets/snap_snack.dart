import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

enum SnapSnackVariant { neutral, success, error }

void showSnapSnack(
  BuildContext context,
  String message, {
  SnapSnackVariant variant = SnapSnackVariant.neutral,
}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        content: SnapSnackContent(message: message, variant: variant),
      ),
    );
}

/// The brutal-style toast body — split out from [showSnapSnack] so it can
/// be golden-tested on its own without a `Scaffold`/`SnackBar` host.
class SnapSnackContent extends StatelessWidget {
  const SnapSnackContent({
    required this.message,
    this.variant = SnapSnackVariant.neutral,
    super.key,
  });

  final String message;
  final SnapSnackVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final (fill, textColor) = switch (variant) {
      SnapSnackVariant.neutral => (tokens.surface, tokens.ink),
      SnapSnackVariant.success => (tokens.success, tokens.ink),
      SnapSnackVariant.error => (tokens.error, Colors.white),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SnapSpacing.lg,
        vertical: SnapSpacing.md,
      ),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(SnapRadius.md),
        border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
        boxShadow: [BoxShadow(color: tokens.ink, offset: SnapShadow.offset)],
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleSmall
            ?.copyWith(color: textColor),
      ),
    );
  }
}
