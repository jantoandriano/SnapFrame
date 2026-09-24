import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/domain/frame.dart';

abstract interface class CompositorRepository {
  /// Composites [photos] into [frame]'s slots and flattens its overlay on
  /// top, returning the result as JPEG bytes.
  Future<Result<Uint8List>> compose({
    required Frame frame,
    required List<XFile> photos,
  });
}
