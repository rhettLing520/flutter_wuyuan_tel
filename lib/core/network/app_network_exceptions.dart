import 'package:dio/dio.dart';

/// 网络请求异常基类
class AppNetworkException implements Exception {
  final String message;
  final int? code;
  final dynamic data;

  const AppNetworkException({required this.message, this.code, this.data});

  @override
  String toString() => 'AppNetworkException: $message (code: $code)';
}

/// HTTP 错误
class HttpException extends AppNetworkException {
  const HttpException({required super.message, super.code, super.data});
}

/// 连接超时
class ConnectTimeoutException extends AppNetworkException {
  const ConnectTimeoutException({required super.message, super.code});
}

/// 响应超时
class ReceiveTimeoutException extends AppNetworkException {
  const ReceiveTimeoutException({required super.message, super.code});
}

/// 发送超时
class SendTimeoutException extends AppNetworkException {
  const SendTimeoutException({required super.message, super.code});
}

/// 网络未连接
class NoInternetException extends AppNetworkException {
  const NoInternetException({super.message = '网络连接不可用'});
}

/// 取消请求
class CancelRequestException extends AppNetworkException {
  const CancelRequestException({super.message = '请求已取消'});
}

/// 业务逻辑错误
class BusinessException extends AppNetworkException {
  const BusinessException({required super.message, super.code, super.data});
}

/// 解析错误
class ParseException extends AppNetworkException {
  const ParseException({super.message = '数据解析失败', super.data});
}

/// 未知错误
class UnknownException extends AppNetworkException {
  const UnknownException({super.message = '发生未知错误', super.code, super.data});
}

/// 异常工厂 - 将 DioError 转换为 AppNetworkException
AppNetworkException createException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ConnectTimeoutException(
        message: '连接超时，请检查网络',
        code: error.response?.statusCode,
      );
    case DioExceptionType.sendTimeout:
      return SendTimeoutException(
        message: '请求超时，请稍后重试',
        code: error.response?.statusCode,
      );
    case DioExceptionType.receiveTimeout:
      return ReceiveTimeoutException(
        message: '响应超时，请稍后重试',
        code: error.response?.statusCode,
      );
    case DioExceptionType.badResponse:
      return HttpException(
        message: _getHttpErrorMessage(error.response?.statusCode),
        code: error.response?.statusCode,
        data: error.response?.data,
      );
    case DioExceptionType.cancel:
      return const CancelRequestException();
    case DioExceptionType.unknown:
      if (error.error != null &&
          error.error.toString().contains('SocketException')) {
        return const NoInternetException();
      }
      return UnknownException(
        message: error.message ?? '网络请求失败',
        data: error.response?.data,
      );
    default:
      return UnknownException(
        message: error.message ?? '网络请求失败',
        data: error.response?.data,
      );
  }
}

/// 获取 HTTP 状态码对应的错误信息
String _getHttpErrorMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return '请求参数错误';
    case 401:
      return '未授权，请重新登录';
    case 403:
      return '拒绝访问';
    case 404:
      return '请求资源不存在';
    case 405:
      return '请求方法不允许';
    case 408:
      return '请求超时';
    case 500:
      return '服务器内部错误';
    case 502:
      return '网关错误';
    case 503:
      return '服务不可用';
    case 504:
      return '网关超时';
    default:
      return '请求失败 ($statusCode)';
  }
}
