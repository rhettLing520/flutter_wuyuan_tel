enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static const String _environmentName = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const String _definedBaseUrl = String.fromEnvironment('API_BASE_URL');

  static Environment get current {
    return Environment.values.firstWhere(
      (environment) => environment.name == _environmentName,
      orElse: () => Environment.dev,
    );
  }

  static String get baseUrl {
    if (_definedBaseUrl.isNotEmpty) {
      return _definedBaseUrl;
    }

    switch (current) {
      case Environment.dev:
        return 'http://localhost:8080/api';
      case Environment.staging:
        return 'https://staging-api.example.com/api';
      case Environment.prod:
        return 'https://api.example.com/api';
    }
  }

  static bool get isDev => current == Environment.dev;
  static bool get isProd => current == Environment.prod;
}
