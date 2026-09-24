import 'dart:typed_data';

import 'package:snapframe/core/result/result.dart';

abstract interface class SaveShareRepository {
  Future<Result<void>> saveToGallery(Uint8List jpegBytes);

  /// Sends the image to [phone] (digits-only international format) on
  /// WhatsApp. Android opens the chat directly; other platforms can't
  /// target a number, so they fall back to the system share sheet.
  Future<Result<void>> shareToWhatsApp(
    Uint8List jpegBytes, {
    required String phone,
    String? text,
  });
}
