import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

import '../core/utils/permission_hint_util.dart';

/// 图片选择服务
/// 封装图片选择、压缩和管理功能
class ImagePickerService extends GetxService {
  static ImagePickerService get to => Get.find();

  final ImagePicker _picker = ImagePicker();

  /// 从相册选择图片
  ///
  /// [maxImages] 最大选择图片数量，默认为9
  /// [allowMultiple] 是否允许多选，默认为false
  /// 返回选择的图片路径列表
  Future<List<String>> pickImagesFromGallery({
    int maxImages = 9,
    bool allowMultiple = false,
  }) async {
    // 首次相册权限温馨提示
    final canContinue = await PermissionHintUtil.showGalleryHint();
    if (!canContinue) return [];

    try {
      final hasPermission = await _ensureGalleryPermission();
      if (!hasPermission) {
        return [];
      }

      if (allowMultiple) {
        // 多选图片
        final images = await _picker.pickMultiImage(
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );

        // 限制最大数量
        final selectedImages = images.take(maxImages).toList();
        return selectedImages.map((e) => e.path).toList();
      } else {
        // 单选图片
        final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        return image != null ? [image.path] : [];
      }
    } on PlatformException catch (e) {
      if (_isPermissionException(e)) {
        await _showPermissionSettingsDialog(_galleryPermissionMessage);
        return [];
      }

      Get.snackbar(
        'Error',
        'Failed to select image: ${e.message ?? e.code}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to select image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  /// 从相机拍照
  ///
  /// 返回拍照后的图片路径
  Future<String?> takePhoto() async {
    // 首次相机权限温馨提示
    final canContinue = await PermissionHintUtil.showCameraHint();
    if (!canContinue) return null;

    try {
      final hasPermission = await _ensureCameraPermission();
      if (!hasPermission) {
        return null;
      }

      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image?.path;
    } on PlatformException catch (e) {
      if (_isPermissionException(e)) {
        await _showPermissionSettingsDialog(_cameraPermissionMessage);
        return null;
      }

      Get.snackbar(
        'Error',
        'Failed to take photo: ${e.message ?? e.code}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to take photo: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  static const String _cameraPermissionMessage =
      'Camera access is required so you can take photos and attach them to diary entries. Please enable camera access in Settings.';

  static const String _galleryPermissionMessage =
      'Photo library access is required so you can choose photos and attach them to diary entries. Please enable photo access in Settings.';

  Future<bool> _ensureCameraPermission() async {
    return _ensurePermission(
      permission_handler.Permission.camera,
      _cameraPermissionMessage,
    );
  }

  Future<bool> _ensureGalleryPermission() async {
    final photosGranted = await _ensurePermission(
      permission_handler.Permission.photos,
      _galleryPermissionMessage,
      showSettingsDialog: false,
    );
    if (photosGranted) {
      return true;
    }

    if (Platform.isAndroid) {
      final storageGranted = await _ensurePermission(
        permission_handler.Permission.storage,
        _galleryPermissionMessage,
        showSettingsDialog: false,
      );
      if (storageGranted) {
        return true;
      }
    }

    await _showPermissionSettingsDialog(_galleryPermissionMessage);
    return false;
  }

  Future<bool> _ensurePermission(
    permission_handler.Permission permission,
    String message, {
    bool showSettingsDialog = true,
  }) async {
    final status = await permission.status;

    if (status.isGranted || status.isLimited) {
      return true;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      if (showSettingsDialog) {
        await _showPermissionSettingsDialog(message);
      }
      return false;
    }

    final requestedStatus = await permission.request();
    if (requestedStatus.isGranted || requestedStatus.isLimited) {
      return true;
    }

    if (showSettingsDialog) {
      await _showPermissionSettingsDialog(message);
    }
    return false;
  }

  Future<void> _showPermissionSettingsDialog(String message) async {
    final shouldOpenSettings = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Settings'),
          ),
        ],
      ),
    );

    if (shouldOpenSettings == true) {
      await permission_handler.openAppSettings();
    }
  }

  bool _isPermissionException(PlatformException exception) {
    final code = exception.code.toLowerCase();
    final message = exception.message?.toLowerCase() ?? '';
    return code.contains('permission') ||
        code.contains('denied') ||
        message.contains('permission') ||
        message.contains('denied');
  }

  /// 显示图片选择对话框
  ///
  /// [allowMultiple] 是否允许多选
  /// [maxImages] 最大选择图片数量
  /// 返回选择的图片路径列表
  Future<List<String>> showImagePicker({
    bool allowMultiple = false,
    int maxImages = 9,
  }) async {
    final result = await Get.dialog<String>(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Get.back(result: 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Get.back(result: 'gallery'),
            ),
          ],
        ),
      ),
    );

    if (result == null) return [];

    if (result == 'camera') {
      final imagePath = await takePhoto();
      return imagePath != null ? [imagePath] : [];
    } else {
      return await pickImagesFromGallery(
        allowMultiple: allowMultiple,
        maxImages: maxImages,
      );
    }
  }

  /// 删除图片
  ///
  /// [imagePath] 图片路径
  /// 返回是否删除成功
  Future<bool> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  /// 批量删除图片
  ///
  /// [imagePaths] 图片路径列表
  /// 返回删除成功的数量
  Future<int> deleteImages(List<String> imagePaths) async {
    int count = 0;
    for (final path in imagePaths) {
      if (await deleteImage(path)) {
        count++;
      }
    }
    return count;
  }

  /// 检查图片是否存在
  ///
  /// [imagePath] 图片路径
  Future<bool> imageExists(String imagePath) async {
    try {
      return await File(imagePath).exists();
    } catch (e) {
      return false;
    }
  }
}
