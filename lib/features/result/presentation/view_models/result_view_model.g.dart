// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResultViewModel)
final resultViewModelProvider = ResultViewModelFamily._();

final class ResultViewModelProvider
    extends $NotifierProvider<ResultViewModel, ResultState> {
  ResultViewModelProvider._({
    required ResultViewModelFamily super.from,
    required (Frame, Uint8List) super.argument,
  }) : super(
         retry: null,
         name: r'resultViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resultViewModelHash();

  @override
  String toString() {
    return r'resultViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ResultViewModel create() => ResultViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ResultViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resultViewModelHash() => r'c0dd106e231c62d5639b2acafaa0e325f5f2bae9';

final class ResultViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ResultViewModel,
          ResultState,
          ResultState,
          ResultState,
          (Frame, Uint8List)
        > {
  ResultViewModelFamily._()
    : super(
        retry: null,
        name: r'resultViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResultViewModelProvider call(Frame frame, Uint8List jpegBytes) =>
      ResultViewModelProvider._(argument: (frame, jpegBytes), from: this);

  @override
  String toString() => r'resultViewModelProvider';
}

abstract class _$ResultViewModel extends $Notifier<ResultState> {
  late final _$args = ref.$arg as (Frame, Uint8List);
  Frame get frame => _$args.$1;
  Uint8List get jpegBytes => _$args.$2;

  ResultState build(Frame frame, Uint8List jpegBytes);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ResultState, ResultState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResultState, ResultState>,
              ResultState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
