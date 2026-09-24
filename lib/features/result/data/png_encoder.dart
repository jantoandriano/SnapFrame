import 'dart:typed_data';
import 'dart:ui' as ui;

/// Re-encodes the composited JPEG as a lossless PNG — the format saves use
/// by default.
///
/// Uses the engine's codecs rather than the pure-Dart `image` package: on
/// web there are no isolates, so a Dart-side encode would block the UI
/// thread and freeze the "saving…" indicator for the whole encode.
Future<Uint8List> jpegToPng(Uint8List jpegBytes) async {
  final codec = await ui.instantiateImageCodec(jpegBytes);
  try {
    final frame = await codec.getNextFrame();
    final image = frame.image;
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) throw const FormatException('PNG encode failed');
      return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    } finally {
      image.dispose();
    }
  } finally {
    codec.dispose();
  }
}
