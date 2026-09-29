// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Light / Dark / System choice from the profile screen, saved so it
/// survives restarts. Stored as the [ThemeMode] name.

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// The Light / Dark / System choice from the profile screen, saved so it
/// survives restarts. Stored as the [ThemeMode] name.
final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  /// The Light / Dark / System choice from the profile screen, saved so it
  /// survives restarts. Stored as the [ThemeMode] name.
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeControllerHash() =>
    r'5d5070e1139cb0fc0ee6df03612627bc4aafb07e';

/// The Light / Dark / System choice from the profile screen, saved so it
/// survives restarts. Stored as the [ThemeMode] name.

abstract class _$ThemeModeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
