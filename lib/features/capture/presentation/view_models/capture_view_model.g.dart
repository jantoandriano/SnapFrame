// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CaptureViewModel)
final captureViewModelProvider = CaptureViewModelFamily._();

final class CaptureViewModelProvider
    extends $NotifierProvider<CaptureViewModel, CaptureState> {
  CaptureViewModelProvider._({
    required CaptureViewModelFamily super.from,
    required (Frame, {int? retakeSlotIndex}) super.argument,
  }) : super(
         retry: null,
         name: r'captureViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$captureViewModelHash();

  @override
  String toString() {
    return r'captureViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CaptureViewModel create() => CaptureViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CaptureState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaptureState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CaptureViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$captureViewModelHash() => r'd9f6ca63d5b4316e94cd3213a1eac3e682939479';

final class CaptureViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CaptureViewModel,
          CaptureState,
          CaptureState,
          CaptureState,
          (Frame, {int? retakeSlotIndex})
        > {
  CaptureViewModelFamily._()
    : super(
        retry: null,
        name: r'captureViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CaptureViewModelProvider call(Frame frame, {int? retakeSlotIndex}) =>
      CaptureViewModelProvider._(
        argument: (frame, retakeSlotIndex: retakeSlotIndex),
        from: this,
      );

  @override
  String toString() => r'captureViewModelProvider';
}

abstract class _$CaptureViewModel extends $Notifier<CaptureState> {
  late final _$args = ref.$arg as (Frame, {int? retakeSlotIndex});
  Frame get frame => _$args.$1;
  int? get retakeSlotIndex => _$args.retakeSlotIndex;

  CaptureState build(Frame frame, {int? retakeSlotIndex});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CaptureState, CaptureState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CaptureState, CaptureState>,
              CaptureState,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(_$args.$1, retakeSlotIndex: _$args.retakeSlotIndex),
    );
  }
}
