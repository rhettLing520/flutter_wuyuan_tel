import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'app_network_exceptions.dart';
import 'auth_intercepter.dart';

/// API 响应包装类
class ApiResponse<T> {
  final bool success;
  final int? code;
  final String? message;
  final T? data;

  const ApiResponse({
    required this.success,
    this.code,
    this.message,
    this.data,
  });

  factory ApiResponse.success(T? data, {String? message}) {
    return ApiResponse(success: true, data: data, message: message);
  }

  factory ApiResponse.error(int? code, String message) {
    return ApiResponse(success: false, code: code, message: message);
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, code: $code, message: $message, data: $data)';
  }
}

/// Dio 网络请求客户端
class ApiClient extends GetxService {
  static late Dio _dio;
  static late AuthInterceptor _authInterceptor;

  /// 存储 CancelToken，用于取消请求
  static final Map<String, CancelToken> _cancelTokens = {};

  /// 初始化 ApiClient
  static Future<ApiClient> init({
    required String baseUrl,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    int sendTimeout = 30000,
  }) async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        sendTimeout: Duration(milliseconds: sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _authInterceptor = AuthInterceptor();

    // 添加拦截器
    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(LogInterceptor());

    return ApiClient();
  }

  /// 获取 Dio 实例
  static Dio get dio => _dio;

  /// 获取认证拦截器
  static AuthInterceptor get authInterceptor => _authInterceptor;

  /// 设置 Token
  static void setToken(String? token) {
    _authInterceptor.setToken(token);
  }

  /// 清除 Token
  static void clearToken() {
    _authInterceptor.clearToken();
  }

  /// 获取 Token
  static String? getToken() {
    return _authInterceptor.token;
  }

  // ==================== GET 请求 ====================

  /// GET 请求
  static Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== POST 请求 ====================

  /// POST 请求
  static Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== PUT 请求 ====================

  /// PUT 请求
  static Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== DELETE 请求 ====================

  /// DELETE 请求
  static Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== PATCH 请求 ====================

  /// PATCH 请求
  static Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== 文件上传 ====================

  /// 上传文件
  static Future<ApiResponse<T>> uploadFile<T>(
    String path,
    String filePath, {
    String fileKey = 'file',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(filePath),
        if (data != null) ...data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  /// 上传多文件
  static Future<ApiResponse<T>> uploadFiles<T>(
    String path,
    List<String> filePaths, {
    String fileKey = 'files',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      final multipartFiles = await Future.wait(
        filePaths.map((path) => MultipartFile.fromFile(path)),
      );

      final formData = FormData.fromMap({
        fileKey: multipartFiles,
        if (data != null) ...data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return _handleResponse<T>(response);
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== 文件下载 ====================

  /// 下载文件
  static Future<ApiResponse<String>> downloadFile(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    String? cancelTag,
  }) async {
    try {
      CancelToken? cancelToken;
      if (cancelTag != null) {
        cancelToken = CancelToken();
        _cancelTokens[cancelTag] = cancelToken;
      }

      await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }

      return ApiResponse.success(savePath, message: '下载成功');
    } on DioException catch (e) {
      if (cancelTag != null) {
        _cancelTokens.remove(cancelTag);
      }
      throw createException(e);
    }
  }

  // ==================== 响应处理 ====================

  /// 统一处理响应
  static ApiResponse<T> _handleResponse<T>(Response response) {
    final data = response.data;

    // 这里根据你的后端返回格式调整
    // 假设后端返回格式为: { code: 200, message: "success", data: {} }
    if (data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      final message = data['message'] as String?;
      final responseData = data['data'] as T?;

      // 根据业务状态码判断成功或失败
      if (code == 200 || code == 0) {
        return ApiResponse.success(responseData, message: message);
      } else {
        throw BusinessException(
          message: message ?? '请求失败',
          code: code,
          data: data,
        );
      }
    }

    // 如果直接返回数据，没有包装
    return ApiResponse.success(data as T?);
  }

  // ==================== 取消请求 ====================

  /// 取消指定标签的请求
  static void cancelRequest(String tag) {
    final cancelToken = _cancelTokens[tag];
    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel('请求已取消');
      _cancelTokens.remove(tag);
    }
  }

  /// 取消所有请求
  static void cancelAllRequests() {
    for (final entry in _cancelTokens.entries) {
      if (!entry.value.isCancelled) {
        entry.value.cancel('所有请求已取消');
      }
    }
    _cancelTokens.clear();
  }
}
