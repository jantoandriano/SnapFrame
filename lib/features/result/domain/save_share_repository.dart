import 'dart:typed_data';

import 'package:snapframe/core/result/result.dart';

abstract interface class SaveShareRepository {
  Future<Result<void>> saveToGallery(Uint8List jpegBytes);

  Future<Result<void>> share(Uint8List jpegBytes, {String? text});
}
