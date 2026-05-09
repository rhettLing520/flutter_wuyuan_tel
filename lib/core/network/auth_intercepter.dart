import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// 认证拦截器 - 自动添加 Token
class AuthInterceptor extends Interceptor {
  String? _token;

  /// 设置 Token
  void setToken(String? token) {
    _token = token;
  }

  /// 清除 Token
  void clearToken() {
    _token = null;
  }

  /// 获取当前 Token
  String? get token => _token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 如果已有 token，添加到请求头
    if (_token != null && _token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }

    // 添加通用请求头
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 401 未授权，可以在这里处理 token 过期逻辑
    if (err.response?.statusCode == 401) {
      // TODO: 处理 token 过期，例如跳转到登录页
      debugPrint('⚠️ Token 已过期，需要重新登录');
    }
    handler.next(err);
  }
}
