import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/auth/presentation/state/splash_effect.dart';
import 'package:snapframe/features/auth/presentation/view_models/splash_view_model.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashViewModelProvider);
    final notifier = ref.read(splashViewModelProvider.notifier);

    ref.listen(splashViewModelProvider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case NavigateToLogin():
          notifier.clearEffect();
          const LoginRoute().go(context);
        case NavigateToHome():
          notifier.clearEffect();
          const BrowseRoute().go(context);
      }
    });

    return Scaffold(
      backgroundColor: context.tokens.bg,
      body: const Center(child: LoadingBlob(size: 96)),
    );
  }
}
