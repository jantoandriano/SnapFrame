import 'dart:typed_data';

import 'package:snapframe/features/frames/domain/slot.dart';

/// Everything `compositeFrame` needs, crossing the isolate boundary as
/// plain data — no `dart:ui` handles, no `BuildContext`.
class CompositeRequest {
  const CompositeRequest({
    required this.overlayBytes,
    required this.photoBytes,
    required this.slots,
    required this.width,
    required this.height,
    this.jpegQuality = 90,
  });

  final Uint8List overlayBytes;
  final List<Uint8List> photoBytes;
  final List<Slot> slots;
  final int width;
  final int height;
  final int jpegQuality;
}
