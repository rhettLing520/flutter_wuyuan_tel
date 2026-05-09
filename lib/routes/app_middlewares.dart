// lib/routes/app_middlewares.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/login/auth_service.dart';
import 'app_routes.dart';

/// 认证中间件 - 检查用户是否登录
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();

    if (!authService.isAuthenticated()) {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null;
  }
}

/// 访客中间件 - 已登录用户不能访问
class GuestMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();

    if (authService.isAuthenticated()) {
      return const RouteSettings(name: AppRoutes.home);
    }

    return null;
  }
}
