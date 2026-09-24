// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BrowseViewModel)
final browseViewModelProvider = BrowseViewModelProvider._();

final class BrowseViewModelProvider
    extends $NotifierProvider<BrowseViewModel, BrowseState> {
  BrowseViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'browseViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$browseViewModelHash();

  @$internal
  @override
  BrowseViewModel create() => BrowseViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BrowseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BrowseState>(value),
    );
  }
}

String _$browseViewModelHash() => r'62fa56fbdc752cfca51fc63a038b6e64782a4c48';

abstract class _$BrowseViewModel extends $Notifier<BrowseState> {
  BrowseState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BrowseState, BrowseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BrowseState, BrowseState>,
              BrowseState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
