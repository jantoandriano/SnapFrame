import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/capture/presentation/state/review_effect.dart';
import 'package:snapframe/features/capture/presentation/view_models/review_view_model.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class ReviewView extends ConsumerWidget {
  const ReviewView({required this.frame, required this.captures, super.key});

  final Frame frame;
  final List<XFile> captures;

  ReviewViewModelProvider get _provider =>
      reviewViewModelProvider(frame, captures);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);
    final previewJpeg = state.previewJpeg;

    ref.listen(_provider, (previous, next) async {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case RequestRetakeEffect(:final slotIndex):
          notifier.clearEffect();
          final photo = await CaptureRoute(
            $extra: next.frame,
            retakeSlotIndex: slotIndex,
          ).push<XFile>(context);
          if (photo != null && context.mounted) {
            await notifier.onRetakeCompleted(slotIndex, photo);
          }
        case ProceedToResultEffect(:final jpegBytes):
          notifier.clearEffect();
          ResultRoute($extra: (frame: next.frame, jpegBytes: jpegBytes))
              .go(context);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SnapSpacing.lg),
          child: Column(
            children: [
              Text(
                l10n.retakeHint,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: SnapSpacing.md),
              Expanded(
                child: Center(
                  child: previewJpeg == null
                      ? const LoadingBlob()
                      : Image.memory(previewJpeg, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: SnapSpacing.md),
              SlotStrip(
                slotCount: state.captures.length,
                currentIndex: -1,
                thumbnails: [
                  for (var i = 0; i < state.captures.length; i++)
                    GestureDetector(
                      onTap: () => notifier.onSlotTapped(i),
                      child: XFileImage(state.captures[i]),
                    ),
                ],
              ),
              const SizedBox(height: SnapSpacing.lg),
              ChunkyButton(
                label: l10n.reviewContinue,
                onPressed: previewJpeg == null
                    ? null
                    : notifier.onContinuePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
