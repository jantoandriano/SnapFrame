import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/typography.dart';

/// Presentational countdown numeral. Driven by [tick]: positive values
/// count down, `0` shows the capture flash. The caller (a ViewModel) owns
/// the timer; this widget only reacts to value changes.
class CountdownOverlay extends StatelessWidget {
  const CountdownOverlay({required this.tick, super.key});

  /// Seconds remaining; `0` renders the capture ("📸" + flash) moment.
  final int tick;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final isCapture = tick <= 0;
    final cycleColors = [tokens.blue, tokens.pink, tokens.lime];
    final color = cycleColors[tick.abs() % cycleColors.length];

    final text = isCapture ? '📸' : '$tick';
    final fontSize = isCapture ? countdownFontSizeMin : countdownFontSizeMax;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: reduceMotion ? 0 : 220),
          switchInCurve: reduceMotion ? Curves.linear : Curves.elasticOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => reduceMotion
              ? FadeTransition(opacity: animation, child: child)
              : ScaleTransition(scale: animation, child: child),
          child: _StrokedNumber(
            key: ValueKey(tick),
            text: text,
            fontSize: fontSize,
            fill: color,
            stroke: tokens.ink,
          ),
        ),
        if (isCapture) _CaptureFlash(reduceMotion: reduceMotion),
      ],
    );
  }
}

class _StrokedNumber extends StatelessWidget {
  const _StrokedNumber({
    required this.text,
    required this.fontSize,
    required this.fill,
    required this.stroke,
    super.key,
  });

  final String text;
  final double fontSize;
  final Color fill;
  final Color stroke;

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontFamily: displayFontFamily,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          style: base.copyWith(
            foreground: Paint()
              ..style = ui.PaintingStyle.stroke
              ..strokeWidth = fontSize * 0.05
              ..color = stroke,
          ),
        ),
        Text(text, style: base.copyWith(color: fill)),
      ],
    );
  }
}

class _CaptureFlash extends StatefulWidget {
  const _CaptureFlash({required this.reduceMotion});

  final bool reduceMotion;

  @override
  State<_CaptureFlash> createState() => _CaptureFlashState();
}

class _CaptureFlashState extends State<_CaptureFlash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _flash;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.reduceMotion ? 1 : 260),
    )..forward();
    _flash = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 0), weight: 70),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _flash,
          builder: (context, _) => Opacity(
            opacity: _flash.value,
            child: const ColoredBox(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
