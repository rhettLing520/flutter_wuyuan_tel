enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static Environment current = Environment.dev;

  static String get baseUrl {
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
