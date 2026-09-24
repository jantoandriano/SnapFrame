// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(compositorRepository)
final compositorRepositoryProvider = CompositorRepositoryProvider._();

final class CompositorRepositoryProvider
    extends
        $FunctionalProvider<
          CompositorRepository,
          CompositorRepository,
          CompositorRepository
        >
    with $Provider<CompositorRepository> {
  CompositorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'compositorRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$compositorRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompositorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompositorRepository create(Ref ref) {
    return compositorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompositorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompositorRepository>(value),
    );
  }
}

String _$compositorRepositoryHash() =>
    r'77bbd75ebbdcafc0da4cc44468c664be511723e4';

@ProviderFor(saveShareRepository)
final saveShareRepositoryProvider = SaveShareRepositoryProvider._();

final class SaveShareRepositoryProvider
    extends
        $FunctionalProvider<
          SaveShareRepository,
          SaveShareRepository,
          SaveShareRepository
        >
    with $Provider<SaveShareRepository> {
  SaveShareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveShareRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveShareRepositoryHash();

  @$internal
  @override
  $ProviderElement<SaveShareRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveShareRepository create(Ref ref) {
    return saveShareRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveShareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveShareRepository>(value),
    );
  }
}

String _$saveShareRepositoryHash() =>
    r'8e572ee36bb6b8a349bd1241d085ca37e811f496';
