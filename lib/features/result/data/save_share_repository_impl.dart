import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/result/domain/save_share_repository.dart';

class SaveShareRepositoryImpl implements SaveShareRepository {
  @override
  Future<Result<void>> saveToGallery(Uint8List jpegBytes) async {
    try {
      await Gal.putImageBytes(jpegBytes, name: 'snapframe');
      return const Result.success(null);
    } on GalException catch (e) {
      return Result.failure(_mapGalException(e));
    } on Object catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }

  @override
  Future<Result<void>> share(Uint8List jpegBytes, {String? text}) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: text,
          files: [XFile.fromData(jpegBytes, mimeType: 'image/jpeg')],
          fileNameOverrides: ['snapframe.jpg'],
        ),
      );
      return const Result.success(null);
    } on Object catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }

  AppException _mapGalException(GalException e) {
    return switch (e.type) {
      GalExceptionType.accessDenied => const PermissionDeniedException(
        "photo access denied — turn it on in settings and we're good",
      ),
      _ => UnknownException(e.type.name),
    };
  }
}
