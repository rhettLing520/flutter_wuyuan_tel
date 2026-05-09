// lib/routes/app_pages.dart
import 'package:get/get.dart';
import '../logic/bindings/web_view_binding.dart';
import '../pages/splash_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/login/login_page.dart';
import '../pages/home/home_page.dart';
import '../pages/webview/web_view_page.dart';
import 'app_routes.dart';
import '../logic/bindings/auth_binding.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),

    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingPage()),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.WEB_VIEW,
      page: () => WebViewPage(
        url: Get.parameters['url'] ?? '',
        title: Get.parameters['title'],
      ),
      binding:
      WebViewBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // 示例：后续添加的路由
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => const ProfilePage(),
    //   binding: ProfileBinding(),
    //   middlewares: [AuthMiddleware()], // 需要登录才能访问
    // ),
  ];
}
