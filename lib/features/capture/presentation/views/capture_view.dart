import 'dart:async';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/capture/presentation/state/capture_effect.dart';
import 'package:snapframe/features/capture/presentation/state/capture_phase.dart';
import 'package:snapframe/features/capture/presentation/view_models/capture_view_model.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class CaptureView extends ConsumerStatefulWidget {
  const CaptureView({required this.frame, this.retakeSlotIndex, super.key});

  final Frame frame;
  final int? retakeSlotIndex;

  @override
  ConsumerState<CaptureView> createState() => _CaptureViewState();
}

class _CaptureViewState extends ConsumerState<CaptureView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    final notifier = ref.read(_provider.notifier);
    switch (lifecycleState) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        unawaited(notifier.onAppPaused());
      case AppLifecycleState.resumed:
        unawaited(notifier.onAppResumed());
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  CaptureViewModelProvider get _provider => captureViewModelProvider(
    widget.frame,
    retakeSlotIndex: widget.retakeSlotIndex,
  );

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);

    ref.listen(_provider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case CaptureFinishedEffect(:final photos):
          notifier.clearEffect();
          ReviewRoute($extra: (frame: next.frame, captures: photos))
              .go(context);
        case RetakeFinishedEffect(:final photo):
          notifier.clearEffect();
          Navigator.of(context).pop(photo);
      }
    });

    final controller = notifier.cameraController;
    final error = state.error;

    return Scaffold(
      backgroundColor: tokens.ink,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (controller != null && controller.value.isInitialized)
              _MirrorablePreview(
                controller: controller,
                mirrored: state.cameraLens == CameraLensDirection.front,
              )
            else
              const Center(child: LoadingBlob()),

            if (error != null)
              ErrorState(
                message: error.message,
                onRetry: notifier.onRetryPressed,
              )
            else ...[
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    l10n.captureSlotLabel(
                      state.currentSlotIndex + 1,
                      state.frame.slots.length,
                    ),
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              // Full-screen (not centered) so the capture flash and the
              // "got it" scrim cover the whole preview.
              Positioned.fill(
                child: _PhaseOverlay(
                  phase: state.phase,
                  // A retake is a single shot, so it's always the last one.
                  isFinalShot:
                      widget.retakeSlotIndex != null ||
                      state.currentSlotIndex == state.frame.slots.length - 1,
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: Semantics(
                  button: true,
                  label: 'switch camera',
                  child: IconButton(
                    icon: const Icon(Icons.cameraswitch, color: Colors.white),
                    iconSize: 32,
                    onPressed: notifier.onLensTogglePressed,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PhaseOverlay extends StatelessWidget {
  const _PhaseOverlay({required this.phase, required this.isFinalShot});

  final CapturePhase phase;
  final bool isFinalShot;

  @override
  Widget build(BuildContext context) {
    return switch (phase) {
      CaptureCountingDown(:final n) => CountdownOverlay(tick: n),
      CaptureCapturing() => CountdownOverlay(
        tick: 0,
        showCaptureIcon: isFinalShot,
      ),
      CaptureCaptured(:final photo) => CapturedOverlay(
        // Keyed per photo so back-to-back shots each replay the animation.
        key: ValueKey(photo.path),
        photo: XFileImage(photo, cacheWidth: 480),
        label: AppLocalizations.of(context)!.captureGotIt,
      ),
      CaptureIdle() || CaptureDone() => const SizedBox.shrink(),
    };
  }
}

class _MirrorablePreview extends StatelessWidget {
  const _MirrorablePreview({required this.controller, required this.mirrored});

  final CameraController controller;
  final bool mirrored;

  @override
  Widget build(BuildContext context) {
    final preview = CameraPreview(controller);
    if (!mirrored) return preview;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: preview,
    );
  }
}
