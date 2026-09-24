import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:snapframe/core/compositing/composite_request.dart';
import 'package:snapframe/core/compositing/compositor.dart';
import 'package:snapframe/features/frames/data/sample_frame.dart';

Uint8List _solidColorPng(
  int r,
  int g,
  int b, {
  int width = 400,
  int height = 300,
}) {
  final image = img.Image(width: width, height: height);
  img.fill(image, color: img.ColorRgb8(r, g, b));
  return img.encodePng(image);
}

void main() {
  // `ui.instantiateImageCodec` (used inside `compositeFrame`) hangs
  // indefinitely when awaited inside `testWidgets()` in this Flutter
  // build — confirmed empirically, not just here but with a minimal
  // repro too. Plain `test()` with the binding initialized manually
  // doesn't have this problem, so that's used instead.
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'compositeFrame layers photos into slots and the overlay on top, as a JPEG',
    () async {
      final overlayBytes = (await rootBundle.load(sampleFrame.overlayPath))
          .buffer
          .asUint8List();

      final photoColors = [
        (255, 0, 0), // slot 0 -> red
        (0, 255, 0), // slot 1 -> green
        (0, 0, 255), // slot 2 -> blue
      ];

      final result = await compositeFrame(
        CompositeRequest(
          overlayBytes: overlayBytes,
          photoBytes: [
            for (final (r, g, b) in photoColors) _solidColorPng(r, g, b),
          ],
          slots: sampleFrame.slots,
          width: sampleFrame.width,
          height: sampleFrame.height,
        ),
      );

      expect(result, isNotEmpty);

      final decoded = img.decodeJpg(result);
      expect(decoded, isNotNull);
      expect(decoded!.width, sampleFrame.width);
      expect(decoded.height, sampleFrame.height);

      // Sample the center of each slot: it should be close to that slot's
      // photo color (JPEG is lossy, so allow some tolerance) and NOT the
      // overlay's lime chrome color.
      for (var i = 0; i < sampleFrame.slots.length; i++) {
        final slot = sampleFrame.slots[i];
        final (r, g, b) = photoColors[i];
        final centerX = ((slot.x + slot.w / 2) * sampleFrame.width).round();
        final centerY = ((slot.y + slot.h / 2) * sampleFrame.height).round();
        final pixel = decoded.getPixel(centerX, centerY);

        expect(pixel.r.round(), closeTo(r, 20));
        expect(pixel.g.round(), closeTo(g, 20));
        expect(pixel.b.round(), closeTo(b, 20));
      }

      // A point in the chrome (outside every slot) should be the overlay's
      // lime, not any photo color.
      final chromePixel = decoded.getPixel(20, 20);
      expect(chromePixel.r.round(), closeTo(198, 15)); // #C6FF3D
      expect(chromePixel.g.round(), closeTo(255, 15));
      expect(chromePixel.b.round(), closeTo(61, 15));
    },
  );
}
