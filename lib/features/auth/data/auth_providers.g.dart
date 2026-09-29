// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `keepAlive: true` — these hold the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.

@ProviderFor(fakeAuthRepository)
final fakeAuthRepositoryProvider = FakeAuthRepositoryProvider._();

/// `keepAlive: true` — these hold the fake in-memory "session", so it must
/// survive between screens regardless of who's currently watching it.
/// Autodispose would drop the signed-in user the moment nothing was
/// listening for a moment during navigation.

final class FakeAuthRepositoryProvider
    extends
        $FunctionalProvider<
          FakeAuthRepository,
          FakeAuthRepository,
          FakeAuthRepository
        >
    with $Provider<FakeAuthRepository> {
  /// `keepAlive: true` — these hold the fake in-memory "session", so it must
  /// survive between screens regardless of who's currently watching it.
  /// Autodispose would drop the signed-in user the moment nothing was
  /// listening for a moment during navigation.
  FakeAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fakeAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fakeAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<FakeAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FakeAuthRepository create(Ref ref) {
    return fakeAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FakeAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FakeAuthRepository>(value),
    );
  }
}

String _$fakeAuthRepositoryHash() =>
    r'36688a0ae22bec947915e773ef60709423e8d18d';

/// Backed by the same [fakeAuthRepository] instance the fake subscription
/// flow writes to, so a tier change reaches everyone watching the user.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Backed by the same [fakeAuthRepository] instance the fake subscription
/// flow writes to, so a tier change reaches everyone watching the user.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Backed by the same [fakeAuthRepository] instance the fake subscription
  /// flow writes to, so a tier change reaches everyone watching the user.
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

String _$authRepositoryHash() => r'6ceebed9c2c0d3b5e1b7cb9c8f7d7c4ff48ec4cb';

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
