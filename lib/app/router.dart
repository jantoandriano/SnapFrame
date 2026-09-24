import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/auth/presentation/views/login_view.dart';
import 'package:snapframe/features/auth/presentation/views/splash_view.dart';
import 'package:snapframe/features/capture/presentation/views/capture_view.dart';
import 'package:snapframe/features/capture/presentation/views/review_view.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/presentation/views/browse_view.dart';
import 'package:snapframe/features/frames/presentation/views/frame_detail_view.dart';
import 'package:snapframe/features/result/presentation/views/result_view.dart';

part 'router.g.dart';

@TypedGoRoute<SplashGateRoute>(path: '/')
class SplashGateRoute extends GoRouteData with $SplashGateRoute {
  const SplashGateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashView();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

@TypedGoRoute<BrowseRoute>(path: '/home')
class BrowseRoute extends GoRouteData with $BrowseRoute {
  const BrowseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BrowseView();
}

@TypedGoRoute<FrameDetailRoute>(path: '/frame')
class FrameDetailRoute extends GoRouteData with $FrameDetailRoute {
  const FrameDetailRoute({required this.$extra});

  final Frame $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FrameDetailView(frame: $extra);
  }
}

@TypedGoRoute<CaptureRoute>(path: '/capture')
class CaptureRoute extends GoRouteData with $CaptureRoute {
  const CaptureRoute({required this.$extra, this.retakeSlotIndex});

  final Frame $extra;
  final int? retakeSlotIndex;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CaptureView(frame: $extra, retakeSlotIndex: retakeSlotIndex);
  }
}

typedef ReviewRouteExtra = ({Frame frame, List<XFile> captures});

@TypedGoRoute<ReviewRoute>(path: '/review')
class ReviewRoute extends GoRouteData with $ReviewRoute {
  const ReviewRoute({required this.$extra});

  final ReviewRouteExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReviewView(frame: $extra.frame, captures: $extra.captures);
  }
}

typedef ResultRouteExtra = ({Frame frame, Uint8List jpegBytes});

@TypedGoRoute<ResultRoute>(path: '/result')
class ResultRoute extends GoRouteData with $ResultRoute {
  const ResultRoute({required this.$extra});

  final ResultRouteExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResultView(frame: $extra.frame, jpegBytes: $extra.jpegBytes);
  }
}

@riverpod
GoRouter goRouter(Ref ref) => GoRouter(routes: $appRoutes);
