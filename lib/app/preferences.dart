import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.g.dart';

/// Loaded once in `bootstrap()` (it's async) and injected with an
/// override, so providers can read preferences synchronously.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError(
  'sharedPreferencesProvider must be overridden with a loaded instance',
);
