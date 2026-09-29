import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/app/preferences.dart';

part 'theme_mode_controller.g.dart';

const themeModePrefsKey = 'theme_mode';

/// The Light / Dark / System choice from the profile screen, saved so it
/// survives restarts. Stored as the [ThemeMode] name.
@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    final saved = ref
        .watch(sharedPreferencesProvider)
        .getString(themeModePrefsKey);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  void setMode(ThemeMode mode) {
    state = mode;
    // Fire-and-forget: the in-memory value is already applied, and the
    // write can't meaningfully fail on any supported platform.
    unawaited(
      ref
          .read(sharedPreferencesProvider)
          .setString(themeModePrefsKey, mode.name),
    );
  }
}
