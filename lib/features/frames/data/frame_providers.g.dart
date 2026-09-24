// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(frameRepository)
final frameRepositoryProvider = FrameRepositoryProvider._();

final class FrameRepositoryProvider
    extends
        $FunctionalProvider<FrameRepository, FrameRepository, FrameRepository>
    with $Provider<FrameRepository> {
  FrameRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'frameRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$frameRepositoryHash();

  @$internal
  @override
  $ProviderElement<FrameRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FrameRepository create(Ref ref) {
    return frameRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FrameRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FrameRepository>(value),
    );
  }
}

String _$frameRepositoryHash() => r'854cea944c1ece777ff888ac25b3f809d3c68b61';
