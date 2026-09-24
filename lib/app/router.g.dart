// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashGateRoute,
  $loginRoute,
  $browseRoute,
  $frameDetailRoute,
  $captureRoute,
  $reviewRoute,
  $resultRoute,
];

RouteBase get $splashGateRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $SplashGateRoute._fromState,
);

mixin $SplashGateRoute on GoRouteData {
  static SplashGateRoute _fromState(GoRouterState state) =>
      const SplashGateRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  hasOverriddenOnExit: false,
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $browseRoute => GoRouteData.$route(
  path: '/home',
  hasOverriddenOnExit: false,
  factory: $BrowseRoute._fromState,
);

mixin $BrowseRoute on GoRouteData {
  static BrowseRoute _fromState(GoRouterState state) => const BrowseRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $frameDetailRoute => GoRouteData.$route(
  path: '/frame',
  hasOverriddenOnExit: false,
  factory: $FrameDetailRoute._fromState,
);

mixin $FrameDetailRoute on GoRouteData {
  static FrameDetailRoute _fromState(GoRouterState state) =>
      FrameDetailRoute($extra: state.extra as Frame);

  FrameDetailRoute get _self => this as FrameDetailRoute;

  @override
  String get location => GoRouteData.$location('/frame');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $captureRoute => GoRouteData.$route(
  path: '/capture',
  hasOverriddenOnExit: false,
  factory: $CaptureRoute._fromState,
);

mixin $CaptureRoute on GoRouteData {
  static CaptureRoute _fromState(GoRouterState state) => CaptureRoute(
    retakeSlotIndex: _$convertMapValue(
      'retake-slot-index',
      state.uri.queryParameters,
      int.tryParse,
    ),
    $extra: state.extra as Frame,
  );

  CaptureRoute get _self => this as CaptureRoute;

  @override
  String get location => GoRouteData.$location(
    '/capture',
    queryParams: {
      if (_self.retakeSlotIndex != null)
        'retake-slot-index': _self.retakeSlotIndex!.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $reviewRoute => GoRouteData.$route(
  path: '/review',
  hasOverriddenOnExit: false,
  factory: $ReviewRoute._fromState,
);

mixin $ReviewRoute on GoRouteData {
  static ReviewRoute _fromState(GoRouterState state) =>
      ReviewRoute($extra: state.extra as ({List<XFile> captures, Frame frame}));

  ReviewRoute get _self => this as ReviewRoute;

  @override
  String get location => GoRouteData.$location('/review');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $resultRoute => GoRouteData.$route(
  path: '/result',
  hasOverriddenOnExit: false,
  factory: $ResultRoute._fromState,
);

mixin $ResultRoute on GoRouteData {
  static ResultRoute _fromState(GoRouterState state) =>
      ResultRoute($extra: state.extra as ({Frame frame, Uint8List jpegBytes}));

  ResultRoute get _self => this as ResultRoute;

  @override
  String get location => GoRouteData.$location('/result');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goRouter)
final goRouterProvider = GoRouterProvider._();

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'0b9970934c700929d1c2af043093e5136c0691b1';
