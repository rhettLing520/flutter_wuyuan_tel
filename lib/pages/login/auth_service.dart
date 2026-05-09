// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../data/models/user_model.dart';
import '../../services/storage_service.dart';
import 'login_request.dart';

class AuthService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  static AuthService get to => Get.find<AuthService>();

  /// 登录
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await ApiClient.post<LoginResponse>(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    if (response.success && response.data != null) {
      final loginData = response.data!;

      // 保存 token
      await _storage.saveToken(loginData.token);
      if (loginData.refreshToken != null) {
        await _storage.saveRefreshToken(loginData.refreshToken!);
      }
      await _storage.setLoggedIn(true);

      // 设置 ApiClient 的 token
      ApiClient.setToken(loginData.token);

      return loginData;
    } else {
      throw Exception(response.message ?? '登录失败');
    }
  }

  /// 注册
  Future<void> register(RegisterRequest request) async {
    final response = await ApiClient.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );

    if (!response.success) {
      throw Exception(response.message ?? '注册失败');
    }
  }

  /// 登出
  Future<void> logout() async {
    try {
      await ApiClient.post(ApiEndpoints.logout);
    } catch (e) {
      debugPrint('登出请求失败: $e');
    } finally {
      // 清除本地数据
      await _storage.removeToken();
      await _storage.removeRefreshToken();
      await _storage.setLoggedIn(false);
      ApiClient.clearToken();
    }
  }

  /// 获取当前用户信息
  Future<UserModel?> getCurrentUser() async {
    final response = await ApiClient.get<Map<String, dynamic>>(
      ApiEndpoints.userInfo,
    );

    if (response.success && response.data != null) {
      return UserModel.fromJson(response.data!);
    }
    return null;
  }

  /// 检查是否已登录
  bool isAuthenticated() {
    final token = _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  /// 获取当前 token
  String? getToken() {
    return _storage.getToken();
  }
}
