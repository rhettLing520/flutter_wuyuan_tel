// lib/logic/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/home/home_page.dart';
import '../../pages/login/auth_service.dart';
import '../../pages/login/login_request.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();

  final AuthService _authService = Get.find<AuthService>();

  // 表单状态
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // 加载状态
  final isLoading = false.obs;

  // 密码可见性
  final isPasswordVisible = false.obs;

  // 错误信息
  final errorMessage = ''.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// 切换密码可见性
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// 登录
  Future<void> login() async {
    // 验证表单
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = LoginRequest(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );

      final response = await _authService.login(request);

      // 登录成功，跳转到首页
      Get.offAll(() => const HomePage());

      Get.snackbar(
        '登录成功',
        '欢迎回来，${response.user.nickname ?? response.user.username}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        '登录失败',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 清除错误信息
  void clearError() {
    errorMessage.value = '';
  }
}
