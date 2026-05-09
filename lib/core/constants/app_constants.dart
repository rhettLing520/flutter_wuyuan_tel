/// 应用常量
class AppConstants {
  AppConstants._();

  // API 配置
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/api/v1';

  // 超时配置（毫秒）
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // 存储 Key
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_info';
}
