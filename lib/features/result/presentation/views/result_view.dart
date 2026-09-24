import 'dart:typed_data';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/result/presentation/state/result_effect.dart';
import 'package:snapframe/features/result/presentation/view_models/result_view_model.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class ResultView extends ConsumerStatefulWidget {
  const ResultView({required this.frame, required this.jpegBytes, super.key});

  final Frame frame;
  final Uint8List jpegBytes;

  @override
  ConsumerState<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends ConsumerState<ResultView> {
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    _confetti.play();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  ResultViewModelProvider get _provider =>
      resultViewModelProvider(widget.frame, widget.jpegBytes);

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
        case ShowResultSnackEffect(:final message, :final isError):
          notifier.clearEffect();
          showSnapSnack(
            context,
            message,
            variant: isError
                ? SnapSnackVariant.error
                : SnapSnackVariant.success,
          );
        case AgainRequestedEffect():
          notifier.clearEffect();
          CaptureRoute($extra: next.frame).go(context);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(SnapSpacing.lg),
              child: Column(
                children: [
                  Text(
                    l10n.resultTitle,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: SnapSpacing.lg),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: tokens.ink,
                          width: SnapTokens.borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(SnapRadius.lg),
                        boxShadow: [
                          BoxShadow(
                            color: tokens.ink,
                            offset: SnapShadow.offset,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.memory(state.jpegBytes, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: SnapSpacing.lg),
                  BrutalTextField(
                    label: l10n.resultWhatsAppNumber,
                    hintText: l10n.resultWhatsAppNumberHint,
                    keyboardType: TextInputType.phone,
                    errorText: state.whatsAppNumberInvalid
                        ? l10n.resultWhatsAppNumberInvalid
                        : null,
                    onChanged: notifier.onWhatsAppNumberChanged,
                  ),
                  const SizedBox(height: SnapSpacing.md),
                  Wrap(
                    spacing: SnapSpacing.md,
                    runSpacing: SnapSpacing.md,
                    alignment: WrapAlignment.center,
                    children: [
                      ChunkyButton(
                        label: l10n.resultSave,
                        variant: SnapButtonVariant.secondary,
                        onPressed: state.isSaving
                            ? null
                            : notifier.onSavePressed,
                      ),
                      ChunkyButton(
                        label: l10n.resultShare,
                        onPressed:
                            state.isSharing || state.whatsAppNumber.isEmpty
                            ? null
                            : notifier.onSendToWhatsAppPressed,
                      ),
                      ChunkyButton(
                        label: l10n.resultAgain,
                        variant: SnapButtonVariant.ghost,
                        onPressed: notifier.onAgainPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: _confetti,
              blastDirection: 1.5708,
              numberOfParticles: 24,
              colors: [tokens.lime, tokens.pink, tokens.blue, tokens.sun],
            ),
          ],
        ),
      ),
    );
  }
}
