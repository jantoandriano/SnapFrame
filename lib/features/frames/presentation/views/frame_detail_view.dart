import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_effect.dart';
import 'package:snapframe/features/frames/presentation/view_models/frame_detail_view_model.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class FrameDetailView extends ConsumerWidget {
  const FrameDetailView({required this.frame, super.key});

  final Frame frame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final provider = frameDetailViewModelProvider(frame);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    ref.listen(provider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case UseFrameEffect(frame: final usedFrame):
          notifier.clearEffect();
          unawaited(CaptureRoute($extra: usedFrame).push<void>(context));
        case ReportSentEffect():
          notifier.clearEffect();
          Navigator.of(context).maybePop();
          showSnapSnack(context, l10n.frameDetailReportSent);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(state.frame.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SnapSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: tokens.ink,
                    width: SnapTokens.borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(SnapRadius.lg),
                  boxShadow: [
                    BoxShadow(color: tokens.ink, offset: SnapShadow.offset),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: AspectRatio(
                  aspectRatio: state.frame.width / state.frame.height,
                  child: Image.asset(
                    state.frame.thumbnailPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: SnapSpacing.lg),
              Wrap(
                spacing: SnapSpacing.sm,
                children: [
                  if (state.frame.tier == Tier.pro)
                    StickerBadge(label: 'PRO ✦', color: tokens.sun),
                  if (state.frame.isOfficial)
                    StickerBadge(
                      label: 'NEW',
                      color: tokens.lime,
                      rotationDeg: 2,
                    ),
                ],
              ),
              const SizedBox(height: SnapSpacing.md),
              Text(
                l10n.frameDetailSlotCount(state.frame.slots.length),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: SnapSpacing.xs),
              Text(
                'by ${state.frame.ownerId}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: SnapSpacing.xl),
              ChunkyButton(
                label: l10n.frameDetailUseThisFrame,
                onPressed: notifier.onUseThisFramePressed,
              ),
              if (!state.frame.isOfficial) ...[
                const SizedBox(height: SnapSpacing.md),
                ChunkyButton(
                  label: l10n.frameDetailReport,
                  variant: SnapButtonVariant.ghost,
                  onPressed: () => _showReportSheet(context, notifier),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showReportSheet(BuildContext context, FrameDetailViewModel notifier) {
    final controller = TextEditingController();
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (sheetContext) {
          final l10n = AppLocalizations.of(sheetContext)!;
          return Padding(
            padding: EdgeInsets.only(
              left: SnapSpacing.lg,
              right: SnapSpacing.lg,
              top: SnapSpacing.lg,
              bottom:
                  MediaQuery.of(sheetContext).viewInsets.bottom +
                  SnapSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BrutalTextField(
                  label: l10n.frameDetailReport,
                  hintText: l10n.frameDetailReportHint,
                  controller: controller,
                ),
                const SizedBox(height: SnapSpacing.md),
                ChunkyButton(
                  label: l10n.frameDetailReportSubmit,
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    unawaited(
                      notifier.onReportSubmitted(controller.text.trim()),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
