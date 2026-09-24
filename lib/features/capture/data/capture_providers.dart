import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/capture/data/camera_service.dart';
import 'package:snapframe/features/capture/data/capture_repository_impl.dart';
import 'package:snapframe/features/capture/domain/capture_repository.dart';

part 'capture_providers.g.dart';

@riverpod
CameraService cameraService(Ref ref) {
  final service = CameraService();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
CaptureRepository captureRepository(Ref ref) {
  return CaptureRepositoryImpl(ref.watch(cameraServiceProvider));
}
