import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Displays a captured [XFile] on every platform — on web, `XFile.path` is
/// a blob URL rather than a file path, so `Image.file` can't be used there.
class XFileImage extends StatelessWidget {
  const XFileImage(
    this.file, {
    this.fit = BoxFit.cover,
    this.cacheWidth,
    super.key,
  });

  final XFile file;
  final BoxFit fit;

  /// Decode width in physical pixels — set it for thumbnails so a
  /// full-resolution camera photo isn't decoded just to be shown small.
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.network(file.path, fit: fit, cacheWidth: cacheWidth)
        : Image.file(File(file.path), fit: fit, cacheWidth: cacheWidth);
  }
}
