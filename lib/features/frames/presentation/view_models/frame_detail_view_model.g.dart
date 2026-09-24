// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FrameDetailViewModel)
final frameDetailViewModelProvider = FrameDetailViewModelFamily._();

final class FrameDetailViewModelProvider
    extends $NotifierProvider<FrameDetailViewModel, FrameDetailState> {
  FrameDetailViewModelProvider._({
    required FrameDetailViewModelFamily super.from,
    required Frame super.argument,
  }) : super(
         retry: null,
         name: r'frameDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$frameDetailViewModelHash();

  @override
  String toString() {
    return r'frameDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FrameDetailViewModel create() => FrameDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FrameDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FrameDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FrameDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$frameDetailViewModelHash() =>
    r'dbd1fa0958a9502dad7201c21db617f08cf79e1f';

final class FrameDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          FrameDetailViewModel,
          FrameDetailState,
          FrameDetailState,
          FrameDetailState,
          Frame
        > {
  FrameDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'frameDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FrameDetailViewModelProvider call(Frame frame) =>
      FrameDetailViewModelProvider._(argument: frame, from: this);

  @override
  String toString() => r'frameDetailViewModelProvider';
}

abstract class _$FrameDetailViewModel extends $Notifier<FrameDetailState> {
  late final _$args = ref.$arg as Frame;
  Frame get frame => _$args;

  FrameDetailState build(Frame frame);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FrameDetailState, FrameDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FrameDetailState, FrameDetailState>,
              FrameDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
