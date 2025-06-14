class Env {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  static const String googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Taskify',
  );
  static const String appSuffix = String.fromEnvironment(
    'APP_SUFFIX',
    defaultValue: '',
  );

  static const bool isProduction = environment == 'prd';
  static const bool isDevelopment = environment == 'dev';
  static const bool isStaging = environment == 'stg';
}
