// One-off asset generator — run with:
//   flutter test tool/generate_sample_frame.dart
// Rewrites assets/frames/sample_overlay.png. Not part of the app or the
// test suite; it just needs a Flutter engine to rasterize a Canvas, which
// `flutter test` conveniently provides.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/features/frames/data/sample_frame_layout.dart';

Future<void> _loadWordmarkFont() async {
  final bytes = await rootBundle.load('assets/fonts/BricolageGrotesque.ttf');
  await (FontLoader(
    'Bricolage Grotesque',
  )..addFont(Future.value(bytes))).load();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generate sample overlay PNG', () async {
    await _loadWordmarkFont();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      const Rect.fromLTWH(0, 0, sampleOverlayWidth, sampleOverlayHeight),
    );

    canvas.drawRect(
      const Rect.fromLTWH(0, 0, sampleOverlayWidth, sampleOverlayHeight),
      Paint()..color = SnapTokens.light.lime,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        sampleOverlayBorderWidth / 2,
        sampleOverlayBorderWidth / 2,
        sampleOverlayWidth - sampleOverlayBorderWidth,
        sampleOverlayHeight - sampleOverlayBorderWidth,
      ),
      Paint()
        ..color = SnapTokens.light.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = sampleOverlayBorderWidth,
    );

    final cutout = Paint()..blendMode = BlendMode.clear;
    final slotBorder = Paint()
      ..color = SnapTokens.light.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = sampleOverlaySlotBorderWidth;
    for (final rect in sampleOverlaySlotRects) {
      final rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(sampleOverlaySlotCornerRadius),
      );
      canvas.drawRRect(rrect, cutout);
      canvas.drawRRect(rrect, slotBorder);
    }

    final wordmark = TextPainter(
      text: TextSpan(
        text: 'SnapFrame',
        style: TextStyle(
          fontFamily: 'Bricolage Grotesque',
          color: SnapTokens.light.ink,
          fontSize: 56,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    wordmark.paint(
      canvas,
      Offset(
        (sampleOverlayWidth - wordmark.width) / 2,
        sampleOverlayHeight - 130,
      ),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(
      sampleOverlayWidth.toInt(),
      sampleOverlayHeight.toInt(),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('assets/frames/sample_overlay.png');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData!.buffer.asUint8List());
  });
}
