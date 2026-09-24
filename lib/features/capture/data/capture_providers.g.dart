// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cameraService)
final cameraServiceProvider = CameraServiceProvider._();

final class CameraServiceProvider
    extends $FunctionalProvider<CameraService, CameraService, CameraService>
    with $Provider<CameraService> {
  CameraServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cameraServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cameraServiceHash();

  @$internal
  @override
  $ProviderElement<CameraService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CameraService create(Ref ref) {
    return cameraService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CameraService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CameraService>(value),
    );
  }
}

String _$cameraServiceHash() => r'7fd509e164c877fe32e6ae2bff1e9cfd15858a52';

@ProviderFor(captureRepository)
final captureRepositoryProvider = CaptureRepositoryProvider._();

final class CaptureRepositoryProvider
    extends
        $FunctionalProvider<
          CaptureRepository,
          CaptureRepository,
          CaptureRepository
        >
    with $Provider<CaptureRepository> {
  CaptureRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'captureRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$captureRepositoryHash();

  @$internal
  @override
  $ProviderElement<CaptureRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CaptureRepository create(Ref ref) {
    return captureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CaptureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaptureRepository>(value),
    );
  }
}

String _$captureRepositoryHash() => r'e36ab2fdeb541f456017cdd2db539db87b7a2b07';
