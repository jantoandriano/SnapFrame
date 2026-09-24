import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  /// Native side lives in `MainActivity.kt`. `share_plus` can't target an
  /// app or a recipient, so Android needs its own intent for that.
  static const _whatsApp = MethodChannel('snapframe/whatsapp');

  @override
  Future<Result<void>> shareToWhatsApp(
    Uint8List jpegBytes, {
    required String phone,
    String? text,
  }) async {
    try {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        await _whatsApp.invokeMethod<void>('shareImage', {
          'bytes': jpegBytes,
          'phone': phone,
          'text': text,
        });
      } else {
        await SharePlus.instance.share(
          ShareParams(
            text: text,
            files: [XFile.fromData(jpegBytes, mimeType: 'image/jpeg')],
            fileNameOverrides: ['snapframe.jpg'],
          ),
        );
      }
      return const Result.success(null);
    } on PlatformException catch (e) {
      return Result.failure(
        e.code == 'not_installed'
            ? const NotFoundException("WhatsApp isn't installed on this phone")
            : UnknownException(e.message ?? e.code),
      );
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
