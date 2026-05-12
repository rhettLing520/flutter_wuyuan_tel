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
  static const String privacyUrl = 'https://ww7emq8pji1.feishu.cn/wiki/LvMJwNY90iCJuTkQjnQcP2OVnUf?from=from_copylink';
  static const String userAgreementUrl = 'https://ww7emq8pji1.feishu.cn/wiki/QJYTws52lir0IrkGORgcV5jmnKf?from=from_copylink';
  static const String commonH5Url = 'https://www.baidu.com';
}
