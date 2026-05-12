import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
    try {
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
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image?.path;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to take photo: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
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
