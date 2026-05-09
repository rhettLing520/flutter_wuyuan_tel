// lib/core/network/api_endpoints.dart
class ApiEndpoints {
  // 认证相关
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // 用户相关
  static const String userInfo = '/user/info';
  static const String updateProfile = '/user/profile';
}
