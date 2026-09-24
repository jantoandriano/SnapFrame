import 'dart:typed_data';

/// Only the web build can trigger a browser download.
void downloadBytes(
  Uint8List bytes, {
  required String fileName,
  required String mimeType,
}) {
  throw UnsupportedError('browser downloads are web-only');
}
