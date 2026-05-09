// lib/routes/app_routes.dart
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';

  // 示例：后续可以添加更多路由
  static const String profile = '/profile';
  static const String settings = '/settings';

  static const WEB_VIEW = '/web-view'; // 添加这一行

  // 便捷方法,// 简单使用
  // AppRoutes.toWebView('https://example.com');
  static void toWebView(String url, {String? title}) {
    Get.toNamed(
      WEB_VIEW,
      parameters: {'url': url, if (title != null) 'title': title},
    );
  }
}
