import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// Saves [bytes] to the user's machine through the browser's download flow
/// (a hidden `<a download>` pointing at a blob URL).
void downloadBytes(
  Uint8List bytes, {
  required String fileName,
  required String mimeType,
}) {
  final blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: mimeType));
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..style.display = 'none';
  web.document.body!.append(anchor);
  anchor
    ..click()
    ..remove();
  // Revoking right away can cancel the download in some browsers.
  Timer(const Duration(seconds: 1), () => web.URL.revokeObjectURL(url));
}
