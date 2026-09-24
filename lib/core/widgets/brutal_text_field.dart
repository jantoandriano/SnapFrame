import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';

/// A bordered text field whose border turns pink on focus.
class BrutalTextField extends StatefulWidget {
  const BrutalTextField({
    this.controller,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.errorText,
    this.keyboardType,
    this.onChanged,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final String? errorText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<BrutalTextField> createState() => _BrutalTextFieldState();
}

class _BrutalTextFieldState extends State<BrutalTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final textTheme = Theme.of(context).textTheme;
    final errorText = widget.errorText;
    final hasError = errorText != null && errorText.isNotEmpty;

    final Color borderColor;
    if (hasError) {
      borderColor = tokens.error;
    } else if (_focusNode.hasFocus) {
      borderColor = tokens.pink;
    } else {
      borderColor = tokens.ink;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: textTheme.labelLarge),
          const SizedBox(height: SnapSpacing.xs),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: SnapSpacing.md),
          decoration: BoxDecoration(
            color: tokens.surface,
            borderRadius: BorderRadius.circular(SnapRadius.sm),
            border: Border.all(
              color: borderColor,
              width: SnapTokens.borderWidth,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: textTheme.bodyLarge,
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
              hintText: widget.hintText,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: tokens.ink.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: SnapSpacing.xs),
          Text(
            errorText,
            style: textTheme.bodySmall?.copyWith(color: tokens.error),
          ),
        ],
      ],
    );
  }
}
