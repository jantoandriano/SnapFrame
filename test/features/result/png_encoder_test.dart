import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:snapframe/features/result/data/png_encoder.dart';

void main() {
  // Engine codecs complete on real async work, so they need runAsync.
  testWidgets('jpegToPng re-encodes a JPEG as a PNG of the same size', (
    tester,
  ) async {
    final jpeg = img.encodeJpg(img.Image(width: 12, height: 8));

    final png = (await tester.runAsync(() => jpegToPng(jpeg)))!;

    // PNG signature: 0x89 'P' 'N' 'G'.
    expect(png.sublist(0, 4), [0x89, 0x50, 0x4E, 0x47]);
    final decoded = img.decodePng(png)!;
    expect((decoded.width, decoded.height), (12, 8));
  });

  testWidgets('jpegToPng rejects bytes that are not an image', (tester) async {
    Object? error;
    await tester.runAsync(() async {
      try {
        await jpegToPng(Uint8List.fromList([1, 2, 3]));
      } on Object catch (e) {
        error = e;
      }
    });
    expect(error, isNotNull);
  });
}
