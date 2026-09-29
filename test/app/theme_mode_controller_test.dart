import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapframe/app/preferences.dart';
import 'package:snapframe/app/theme_mode_controller.dart';

Future<ProviderContainer> _container(Map<String, Object> stored) async {
  SharedPreferences.setMockInitialValues(stored);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('follows the system when nothing is saved', () async {
    final container = await _container({});

    expect(container.read(themeModeControllerProvider), ThemeMode.system);
  });

  test('restores the saved mode', () async {
    final container = await _container({themeModePrefsKey: 'dark'});

    expect(container.read(themeModeControllerProvider), ThemeMode.dark);
  });

  test('ignores an unrecognized saved value', () async {
    final container = await _container({themeModePrefsKey: 'sepia'});

    expect(container.read(themeModeControllerProvider), ThemeMode.system);
  });

  test('saves the mode when it changes', () async {
    final container = await _container({});

    container
        .read(themeModeControllerProvider.notifier)
        .setMode(ThemeMode.light);

    expect(container.read(themeModeControllerProvider), ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(themeModePrefsKey), 'light');
  });
}
