// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `keepAlive: true` — this holds the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// `keepAlive: true` — this holds the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// `keepAlive: true` — this holds the fake in-memory "session", so it must
  /// survive between screens regardless of who's currently watching it.
  /// Autodispose would drop the signed-in user the moment nothing was
  /// listening for a moment during navigation.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'a94a1cbc137adecf85b92722132bef35783d5df2';

@ProviderFor(currentUserStream)
final currentUserStreamProvider = CurrentUserStreamProvider._();

final class CurrentUserStreamProvider
    extends
        $FunctionalProvider<AsyncValue<AppUser?>, AppUser?, Stream<AppUser?>>
    with $FutureModifier<AppUser?>, $StreamProvider<AppUser?> {
  CurrentUserStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserStreamHash();

  @$internal
  @override
  $StreamProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AppUser?> create(Ref ref) {
    return currentUserStream(ref);
  }
}

String _$currentUserStreamHash() => r'2178db2b0b902066f699822d5208648b92838610';
