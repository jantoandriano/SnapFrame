import 'package:camera/camera.dart';
import 'package:snapframe/core/result/result.dart';

abstract interface class CaptureRepository {
  CameraController? get cameraController;

  Future<Result<void>> initializeCamera(CameraLensDirection lens);

  Future<Result<XFile>> takePicture();

  Future<void> disposeCamera();
}
