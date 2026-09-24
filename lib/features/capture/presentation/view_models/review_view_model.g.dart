// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReviewViewModel)
final reviewViewModelProvider = ReviewViewModelFamily._();

final class ReviewViewModelProvider
    extends $NotifierProvider<ReviewViewModel, ReviewState> {
  ReviewViewModelProvider._({
    required ReviewViewModelFamily super.from,
    required (Frame, List<XFile>) super.argument,
  }) : super(
         retry: null,
         name: r'reviewViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reviewViewModelHash();

  @override
  String toString() {
    return r'reviewViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ReviewViewModel create() => ReviewViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reviewViewModelHash() => r'ce59edaddf1a2990e52d06d9313a67f2f64a6619';

final class ReviewViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ReviewViewModel,
          ReviewState,
          ReviewState,
          ReviewState,
          (Frame, List<XFile>)
        > {
  ReviewViewModelFamily._()
    : super(
        retry: null,
        name: r'reviewViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReviewViewModelProvider call(Frame frame, List<XFile> captures) =>
      ReviewViewModelProvider._(argument: (frame, captures), from: this);

  @override
  String toString() => r'reviewViewModelProvider';
}

abstract class _$ReviewViewModel extends $Notifier<ReviewState> {
  late final _$args = ref.$arg as (Frame, List<XFile>);
  Frame get frame => _$args.$1;
  List<XFile> get captures => _$args.$2;

  ReviewState build(Frame frame, List<XFile> captures);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReviewState, ReviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReviewState, ReviewState>,
              ReviewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
