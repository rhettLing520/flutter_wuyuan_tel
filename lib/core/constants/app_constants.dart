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


  // H5链接

  static const String baseH5Url = 'https://api.example.com';
  static const String privacyUrl = 'https://www.baidu.com';
  static const String userAgreementUrl = 'https://www.baidu.com';
  static const String commonH5Url = 'https://www.baidu.com';
}
