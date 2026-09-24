import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/compositing/cover_crop.dart';

void main() {
  group('coverCropSourceRect', () {
    test('crops the sides off a source wider than the destination', () {
      // 2:1 source into a 1:1 destination -> crop left/right, keep full height.
      final rect = coverCropSourceRect(
        const Size(2000, 1000),
        const Size(500, 500),
      );

      expect(rect.height, 1000);
      expect(rect.width, 1000);
      expect(rect.left, 500); // centered: (2000 - 1000) / 2
      expect(rect.top, 0);
    });

    test('crops the top/bottom off a source taller than the destination', () {
      // 1:2 source into a 1:1 destination -> crop top/bottom, keep full width.
      final rect = coverCropSourceRect(
        const Size(1000, 2000),
        const Size(500, 500),
      );

      expect(rect.width, 1000);
      expect(rect.height, 1000);
      expect(rect.left, 0);
      expect(rect.top, 500); // centered: (2000 - 1000) / 2
    });

    test('returns the full source when the aspect ratios already match', () {
      final rect = coverCropSourceRect(
        const Size(1200, 800),
        const Size(300, 200),
      );

      expect(rect, const Rect.fromLTWH(0, 0, 1200, 800));
    });

    test('destination aspect ratio, not size, drives the crop', () {
      // Same 2:1 source, much larger 1:1 destination -> same crop rect as
      // the small-destination case: cover-crop only depends on aspect.
      final rect = coverCropSourceRect(
        const Size(2000, 1000),
        const Size(4000, 4000),
      );

      expect(rect, const Rect.fromLTWH(500, 0, 1000, 1000));
    });
  });
}
