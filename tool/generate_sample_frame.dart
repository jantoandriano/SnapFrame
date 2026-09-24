// One-off asset generator — run with:
//   flutter test tool/generate_sample_frame.dart
// Rewrites assets/frames/sample_overlay.png and photo_dump_overlay.png
// (add `--plain-name "photo dump"` to regenerate just that one). Not part
// of the app or the test suite; it just needs a Flutter engine to rasterize
// a Canvas, which `flutter test` conveniently provides.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/features/frames/data/photo_dump_layout.dart';
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

    await _writePng(
      recorder,
      sampleOverlayWidth,
      sampleOverlayHeight,
      'assets/frames/sample_overlay.png',
    );
  });

  test('generate photo dump overlay PNG', () async {
    await _loadWordmarkFont();
    final t = SnapTokens.light;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      const Rect.fromLTWH(0, 0, photoDumpWidth, photoDumpHeight),
    );

    canvas.drawRect(
      const Rect.fromLTWH(0, 0, photoDumpWidth, photoDumpHeight),
      Paint()..color = t.pink,
    );
    canvas.drawRect(
      const Rect.fromLTWH(
        photoDumpBorderWidth * 1.5,
        photoDumpBorderWidth * 1.5,
        photoDumpWidth - photoDumpBorderWidth * 3,
        photoDumpHeight - photoDumpBorderWidth * 3,
      ),
      Paint()
        ..color = t.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = photoDumpBorderWidth * 3,
    );

    _paintText(canvas, 'photo dump', t.ink, 72, centerX: 540, top: 40);
    _paintSparkle(canvas, const Offset(250, 88), 34, t.sun, t.ink);
    _paintSparkle(canvas, const Offset(835, 88), 26, t.lime, t.ink);

    final ink = Paint()..color = t.ink;
    final inkStroke = Paint()
      ..color = t.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = photoDumpBorderWidth;
    final cutout = Paint()..blendMode = BlendMode.clear;
    for (final slot in photoDumpSlotRects) {
      final card = photoDumpCardFor(slot);
      canvas
        ..drawRect(
          card.shift(
            const Offset(photoDumpShadowOffset, photoDumpShadowOffset),
          ),
          ink,
        )
        ..drawRect(card, Paint()..color = t.surface)
        ..drawRect(card, inkStroke)
        ..drawRect(slot, cutout)
        ..drawRect(slot, inkStroke..strokeWidth = 4);
      inkStroke.strokeWidth = photoDumpBorderWidth;

      // A strip of tape across the card's top edge, slightly askew.
      canvas
        ..save()
        ..translate(card.center.dx, card.top)
        ..rotate(slot.left < photoDumpWidth / 2 ? -0.07 : 0.07)
        ..drawRect(
          const Rect.fromLTWH(-80, -22, 160, 44),
          Paint()..color = t.sun.withValues(alpha: 0.9),
        )
        ..restore();
    }

    _paintSparkle(canvas, const Offset(540, 700), 30, t.lime, t.ink);
    _paintText(canvas, 'SnapFrame', t.ink, 56, centerX: 540, top: 1262);

    await _writePng(
      recorder,
      photoDumpWidth,
      photoDumpHeight,
      'assets/frames/photo_dump_overlay.png',
    );
  });
}

void _paintText(
  Canvas canvas,
  String text,
  Color color,
  double fontSize, {
  required double centerX,
  required double top,
}) {
  final painter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Bricolage Grotesque',
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  painter.paint(canvas, Offset(centerX - painter.width / 2, top));
}

/// A four-point sparkle, filled with [fill] and outlined in [stroke].
void _paintSparkle(
  Canvas canvas,
  Offset center,
  double radius,
  Color fill,
  Color stroke,
) {
  final inner = radius * 0.28;
  final path = Path()
    ..moveTo(center.dx, center.dy - radius)
    ..lineTo(center.dx + inner, center.dy - inner)
    ..lineTo(center.dx + radius, center.dy)
    ..lineTo(center.dx + inner, center.dy + inner)
    ..lineTo(center.dx, center.dy + radius)
    ..lineTo(center.dx - inner, center.dy + inner)
    ..lineTo(center.dx - radius, center.dy)
    ..lineTo(center.dx - inner, center.dy - inner)
    ..close();
  canvas
    ..drawPath(path, Paint()..color = fill)
    ..drawPath(
      path,
      Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeJoin = StrokeJoin.round,
    );
}

Future<void> _writePng(
  ui.PictureRecorder recorder,
  double width,
  double height,
  String path,
) async {
  final picture = recorder.endRecording();
  final image = await picture.toImage(width.toInt(), height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final file = File(path);
  await file.create(recursive: true);
  await file.writeAsBytes(byteData!.buffer.asUint8List());
}
