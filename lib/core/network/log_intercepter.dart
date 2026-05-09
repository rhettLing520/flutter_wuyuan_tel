import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 日志拦截器 - 打印请求和响应信息
class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════');
      debugPrint('📤 [REQUEST] ${options.method} ${options.uri}');
      debugPrint('📋 Headers: ${options.headers}');
      debugPrint('📦 Data: ${options.data}');
      debugPrint('═══════════════════════════════════════');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════');
      debugPrint(
        '📥 [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
      );
      debugPrint('📄 Data: ${response.data}');
      debugPrint('═══════════════════════════════════════');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════');
      debugPrint(
        '❌ [ERROR] ${err.requestOptions.method} ${err.requestOptions.uri}',
      );
      debugPrint('💬 Message: ${err.message}');
      debugPrint('🔢 Code: ${err.response?.statusCode}');
      debugPrint('═══════════════════════════════════════');
    }
    handler.next(err);
  }
}
