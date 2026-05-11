import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as perm_handler;

/// 通用权限服务
/// 基于 GetX 封装的权限管理工具类
class PermissionService extends GetxService {
  static PermissionService get to => Get.find();

  /// 请求单个权限
  /// 
  /// [permission] 要请求的权限
  /// [showRationale] 是否显示权限说明对话框
  /// [rationaleMessage] 权限说明消息
  /// 返回权限是否授予
  Future<bool> requestPermission(
    perm_handler.Permission permission, {
    bool showRationale = true,
    String? rationaleMessage,
  }) async {
    final status = await permission.status;

    // 如果已授权，直接返回
    if (status.isGranted) {
      return true;
    }

    // 如果是永久拒绝，提示用户去设置
    if (status.isPermanentlyDenied) {
      return _handlePermanentlyDenied(
        permission,
        rationaleMessage ?? '请在设置中开启相关权限',
      );
    }

    // 显示权限说明
    if (showRationale && status.isDenied) {
      final shouldRequest = await _showRationaleDialog(
        rationaleMessage ?? '需要${_getPermissionName(permission)}权限才能继续使用此功能',
      );
      if (!shouldRequest) return false;
    }

    // 请求权限
    final result = await permission.request();
    return result.isGranted;
  }

  /// 请求多个权限
  /// 
  /// [permissions] 要请求的权限列表
  /// [showRationale] 是否显示权限说明对话框
  /// [rationaleMessage] 权限说明消息
  /// 返回权限授予结果 Map
  Future<Map<perm_handler.Permission, bool>> requestMultiplePermissions(
    List<perm_handler.Permission> permissions, {
    bool showRationale = true,
    String? rationaleMessage,
  }) async {
    final results = <perm_handler.Permission, bool>{};

    for (final permission in permissions) {
      results[permission] = await requestPermission(
        permission,
        showRationale: showRationale,
        rationaleMessage: rationaleMessage,
      );
    }

    return results;
  }

  /// 检查权限状态
  Future<bool> checkPermission(perm_handler.Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// 检查多个权限状态
  Future<Map<perm_handler.Permission, bool>> checkMultiplePermissions(
    List<perm_handler.Permission> permissions,
  ) async {
    final results = <perm_handler.Permission, bool>{};
    for (final permission in permissions) {
      results[permission] = await checkPermission(permission);
    }
    return results;
  }

  /// 打开应用设置页面
  Future<bool> openAppSettings() async {
    return await perm_handler.openAppSettings();
  }

  /// 处理永久拒绝的权限
  Future<bool> _handlePermanentlyDenied(
    perm_handler.Permission permission,
    String message,
  ) async {
    final shouldOpenSettings = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('权限被永久拒绝'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('去设置'),
          ),
        ],
      ),
    );

    if (shouldOpenSettings == true) {
      return await openAppSettings();
    }
    return false;
  }

  /// 显示权限说明对话框
  Future<bool> _showRationaleDialog(String message) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text('需要权限'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('授权'),
          ),
        ],
      ),
    ) ?? false;
  }

  /// 获取权限名称
  String _getPermissionName(perm_handler.Permission permission) {
    switch (permission) {
      case perm_handler.Permission.camera:
        return '相机';
      case perm_handler.Permission.photos:
        return '相册';
      case perm_handler.Permission.storage:
        return '存储';
      case perm_handler.Permission.location:
        return '位置';
      case perm_handler.Permission.microphone:
        return '麦克风';
      case perm_handler.Permission.notification:
        return '通知';
      default:
        return '相关';
    }
  }

  /// 便捷方法：请求相机权限
  Future<bool> requestCameraPermission() async {
    return requestPermission(perm_handler.Permission.camera);
  }

  /// 便捷方法：请求相册权限
  Future<bool> requestPhotosPermission() async {
    return requestPermission(perm_handler.Permission.photos);
  }

  /// 便捷方法：请求存储权限
  Future<bool> requestStoragePermission() async {
    return requestPermission(perm_handler.Permission.storage);
  }

  /// 便捷方法：请求位置权限
  Future<bool> requestLocationPermission() async {
    return requestPermission(perm_handler.Permission.location);
  }

  /// 便捷方法：请求麦克风权限
  Future<bool> requestMicrophonePermission() async {
    return requestPermission(perm_handler.Permission.microphone);
  }

  /// 便捷方法：请求通知权限
  Future<bool> requestNotificationPermission() async {
    return requestPermission(perm_handler.Permission.notification);
  }
}
