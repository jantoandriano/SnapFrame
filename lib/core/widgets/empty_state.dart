import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/chunky_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.message, this.emoji = '✨', super.key});

  final String message;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return _StateScaffold(emoji: emoji, message: message);
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.message,
    this.emoji = '😵',
    this.onRetry,
    super.key,
  });

  final String message;
  final String emoji;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateScaffold(
      emoji: emoji,
      message: message,
      action: onRetry == null
          ? null
          : ChunkyButton(label: 'try again?', onPressed: onRetry),
    );
  }
}

class _StateScaffold extends StatelessWidget {
  const _StateScaffold({
    required this.emoji,
    required this.message,
    this.action,
  });

  final String emoji;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SnapSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: SnapSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (action != null) ...[
              const SizedBox(height: SnapSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
