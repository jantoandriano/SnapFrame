import 'package:camera/camera.dart';

/// Thin wrapper over the `camera` plugin: owns the one `CameraController`
/// instance the capture flow needs at a time.
class CameraService {
  CameraController? _controller;

  CameraController? get controller => _controller;

  Future<void> initialize(CameraLensDirection lens) async {
    final cameras = await availableCameras();
    final description = cameras.firstWhere(
      (c) => c.lensDirection == lens,
      orElse: () => cameras.first,
    );
    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller.initialize();
    await dispose();
    _controller = controller;
  }

  Future<XFile> takePicture() {
    final controller = _controller;
    if (controller == null) {
      throw StateError('CameraService.takePicture called before initialize');
    }
    return controller.takePicture();
  }

  Future<void> dispose() async {
    final controller = _controller;
    _controller = null;
    await controller?.dispose();
  }
}
