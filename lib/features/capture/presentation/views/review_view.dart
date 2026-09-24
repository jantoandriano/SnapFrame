import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show Uint8List;
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
        case SlotUpdatedEffect(:final slotIndex):
          notifier.clearEffect();
          showSnapSnack(
            context,
            l10n.reviewSlotUpdated(slotIndex + 1),
            variant: SnapSnackVariant.success,
          );
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
                      : _ComposedPreview(
                          jpeg: previewJpeg,
                          isComposing: state.isComposing,
                        ),
                ),
              ),
              const SizedBox(height: SnapSpacing.md),
              SlotStrip(
                slotCount: state.captures.length,
                currentIndex: -1,
                highlightIndex: state.updatedSlotIndex,
                thumbnails: [
                  for (var i = 0; i < state.captures.length; i++)
                    GestureDetector(
                      onTap: () => notifier.onSlotTapped(i),
                      child: XFileImage(state.captures[i], cacheWidth: 144),
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

/// The composited frame. While a retake is being recomposed the old image
/// dims under a loader; the new one then pops in, so a swap is never silent.
class _ComposedPreview extends StatelessWidget {
  const _ComposedPreview({required this.jpeg, required this.isComposing});

  final Uint8List jpeg;
  final bool isComposing;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isComposing ? 0.35 : 1,
          duration: const Duration(milliseconds: 200),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: reduceMotion ? 0 : 350),
            // Overshoot on scale only — opacity must stay within 0..1.
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                ),
                child: child,
              ),
            ),
            child: Image.memory(
              jpeg,
              key: ObjectKey(jpeg),
              fit: BoxFit.contain,
              gaplessPlayback: true,
            ),
          ),
        ),
        if (isComposing) const LoadingBlob(),
      ],
    );
  }
}
