import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../data/models/auth_models.dart';
import '../data/models/user_model.dart';
import 'storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  static AuthService get to => Get.find<AuthService>();

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await ApiClient.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    if (response.success && response.data != null) {
      final loginData = LoginResponse.fromJson(response.data!);

      await _storage.saveToken(loginData.token);
      if (loginData.refreshToken != null) {
        await _storage.saveRefreshToken(loginData.refreshToken!);
      }
      await _storage.setLoggedIn(true);

      ApiClient.setToken(loginData.token);

      return loginData;
    } else {
      throw Exception(response.message ?? '登录失败');
    }
  }

  Future<void> register(RegisterRequest request) async {
    final response = await ApiClient.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );

    if (!response.success) {
      throw Exception(response.message ?? '注册失败');
    }
  }

  Future<void> logout() async {
    try {
      await ApiClient.post(ApiEndpoints.logout);
    } catch (e) {
      debugPrint('登出请求失败: $e');
    } finally {
      await _storage.removeToken();
      await _storage.removeRefreshToken();
      await _storage.setLoggedIn(false);
      ApiClient.clearToken();
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final response = await ApiClient.get<Map<String, dynamic>>(
      ApiEndpoints.userInfo,
    );

    if (response.success && response.data != null) {
      return UserModel.fromJson(response.data!);
    }
    return null;
  }

  bool isAuthenticated() {
    final token = _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  String? getToken() {
    return _storage.getToken();
  }
}
