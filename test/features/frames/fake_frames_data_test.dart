import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:snapframe/features/frames/data/fake_frames_data.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('browse offers exactly one free and one pro frame', () {
    expect(fakeFrames.map((f) => f.tier), [Tier.free, Tier.pro]);
    expect(fakeFrames.map((f) => f.overlayPath).toSet(), hasLength(2));
  });

  for (final frame in fakeFrames) {
    test(
      '${frame.title}: overlay size matches and every slot is a cutout',
      () async {
        final bytes = (await rootBundle.load(frame.overlayPath)).buffer
            .asUint8List();
        final overlay = img.decodePng(bytes)!;

        expect(overlay.width, frame.width);
        expect(overlay.height, frame.height);
        for (final slot in frame.slots) {
          final cx = ((slot.x + slot.w / 2) * frame.width).round();
          final cy = ((slot.y + slot.h / 2) * frame.height).round();
          expect(overlay.getPixel(cx, cy).a, 0, reason: 'slot at ($cx, $cy)');
        }
      },
    );
  }
}
