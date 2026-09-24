import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/app/theme_mode_controller.dart';
import 'package:snapframe/core/theme/app_theme.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class SnapApp extends ConsumerWidget {
  const SnapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);

    return MaterialApp.router(
      title: 'SnapFrame',
      debugShowCheckedModeBanner: false,
      theme: SnapAppTheme.light,
      darkTheme: SnapAppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
