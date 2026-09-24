import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/utils/haptics.dart';

/// A segmented tab bar (e.g. Official / Community) rendered as one pill.
class PillTabBar extends StatelessWidget {
  const PillTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.all(SnapSpacing.xs),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(SnapRadius.pill),
        border: Border.all(color: tokens.ink, width: SnapTokens.borderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, label) in tabs.indexed)
            _Segment(
              label: label,
              selected: index == selectedIndex,
              onTap: () {
                if (index != selectedIndex) {
                  Haptics.selection();
                  onChanged(index);
                }
              },
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.symmetric(horizontal: SnapSpacing.lg),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? tokens.lime : Colors.transparent,
            borderRadius: BorderRadius.circular(SnapRadius.pill),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: tokens.ink),
          ),
        ),
      ),
    );
  }
}

/// A single filter chip, e.g. Newest / Popular / Free / Pro.
class PillChip extends StatelessWidget {
  const PillChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: () {
          Haptics.selection();
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.symmetric(horizontal: SnapSpacing.lg),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? tokens.pink : tokens.surface,
            borderRadius: BorderRadius.circular(SnapRadius.pill),
            border: Border.all(
              color: tokens.ink,
              width: SnapTokens.borderWidth,
            ),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: tokens.ink),
          ),
        ),
      ),
    );
  }
}
