/// Compile-time environment config, populated via
/// `--dart-define-from-file=env/dev.json` (or `env/prod.json`).
abstract final class Env {
  static const String name = String.fromEnvironment(
    'ENV_NAME',
    defaultValue: 'dev',
  );

  static const String revenueCatApiKeyIos = String.fromEnvironment(
    'REVENUECAT_API_KEY_IOS',
  );

  static const String revenueCatApiKeyAndroid = String.fromEnvironment(
    'REVENUECAT_API_KEY_ANDROID',
  );

  static bool get isProd => name == 'prod';
}
