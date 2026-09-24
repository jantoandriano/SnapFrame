import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as img;
import 'package:snapframe/core/compositing/composite_request.dart';
import 'package:snapframe/core/compositing/cover_crop.dart';

/// Composites captured photos into a frame's slots and flattens the
/// overlay PNG on top, at the overlay's native resolution, encoded as a
/// JPEG.
///
/// Two constraints shape this, both discovered empirically rather than
/// assumed:
/// - `dart:ui`'s `PictureRecorder`/`Canvas` throw "UI actions are only
///   available on root isolate" inside `compute()` — so the actual
///   drawing has to happen on the main isolate; it cannot be the part
///   that's backgrounded.
/// - `dart:ui` has no JPEG encoder at all (`ImageByteFormat` only offers
///   raw pixel formats and PNG) — the `image` package's encoder fills
///   that gap.
/// Those two together decide the split: Canvas compositing runs on the
/// main isolate (required), then only the CPU-heavy JPEG encode — pure
/// Dart, no engine dependency — is handed to `compute()`, which is where
/// "runs in a background isolate" actually still holds.
Future<Uint8List> compositeFrame(CompositeRequest request) async {
  final rgba = await _compose(request);
  return await compute(_encodeJpeg, (
    rgba: rgba,
    width: request.width,
    height: request.height,
    quality: request.jpegQuality,
  ));
}

Future<ByteData> _compose(CompositeRequest request) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(
    recorder,
    ui.Rect.fromLTWH(0, 0, request.width.toDouble(), request.height.toDouble()),
  );

  for (var i = 0; i < request.slots.length; i++) {
    final slot = request.slots[i];
    final photo = await _decode(request.photoBytes[i]);
    final destRect = ui.Rect.fromLTWH(
      slot.x * request.width,
      slot.y * request.height,
      slot.w * request.width,
      slot.h * request.height,
    );
    final srcRect = coverCropSourceRect(
      ui.Size(photo.width.toDouble(), photo.height.toDouble()),
      ui.Size(destRect.width, destRect.height),
    );
    canvas.drawImageRect(photo, srcRect, destRect, ui.Paint());
    photo.dispose();
  }

  final overlay = await _decode(request.overlayBytes);
  canvas.drawImage(overlay, ui.Offset.zero, ui.Paint());
  overlay.dispose();

  final picture = recorder.endRecording();
  final composed = await picture.toImage(request.width, request.height);
  final rgba = await composed.toByteData();
  composed.dispose();
  return rgba!;
}

Future<ui.Image> _decode(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}

typedef _EncodeJob = ({ByteData rgba, int width, int height, int quality});

Uint8List _encodeJpeg(_EncodeJob job) {
  final image = img.Image.fromBytes(
    width: job.width,
    height: job.height,
    bytes: job.rgba.buffer,
    numChannels: 4,
    order: img.ChannelOrder.rgba,
  );
  return img.encodeJpg(image, quality: job.quality);
}
