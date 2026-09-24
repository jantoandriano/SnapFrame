import 'package:camera/camera.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/capture/data/camera_service.dart';
import 'package:snapframe/features/capture/domain/capture_repository.dart';

class CaptureRepositoryImpl implements CaptureRepository {
  CaptureRepositoryImpl(this._service);

  final CameraService _service;

  @override
  CameraController? get cameraController => _service.controller;

  @override
  Future<Result<void>> initializeCamera(CameraLensDirection lens) async {
    try {
      await _service.initialize(lens);
      return const Result.success(null);
    } on CameraException catch (e) {
      return Result.failure(_mapCameraException(e));
    } on Object catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }

  @override
  Future<Result<XFile>> takePicture() async {
    try {
      final file = await _service.takePicture();
      return Result.success(file);
    } on CameraException catch (e) {
      return Result.failure(_mapCameraException(e));
    } on Object catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }

  @override
  Future<void> disposeCamera() => _service.dispose();

  AppException _mapCameraException(CameraException e) {
    return switch (e.code) {
      'CameraAccessDenied' ||
      'CameraAccessDeniedWithoutPrompt' ||
      'CameraAccessRestricted' => const PermissionDeniedException(
        "camera access denied — turn it on in settings and we're good",
      ),
      _ => UnknownException(e.description ?? e.code),
    };
  }
}
