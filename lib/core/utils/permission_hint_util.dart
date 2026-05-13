import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/common_export.dart';
import '../../services/storage_service.dart';

/// 首次权限温馨提示弹框
/// 相机/相册/保存到相册分别独立弹一次
class PermissionHintUtil {
  static Future<bool> _showIfFirstTime({
    required bool alreadyShown,
    required Future<bool> Function() markShown,
    required String message,
  }) async {
    if (alreadyShown) return true;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: AppText(
          'Reminder',
          fontSize: 18.sp,
          fontWeight: AppFontWeights.semiBold,
          color: AppColors.textPrimary,
          textAlign: TextAlign.center,
        ),
        content: AppText(
          message,
          fontSize: 15.sp,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.back(result: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: AppText(
                'Continue',
                fontSize: 16.sp,
                fontWeight: AppFontWeights.medium,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await markShown();
      return true;
    }
    return false;
  }

  /// 相机权限温馨提示
  static Future<bool> showCameraHint() {
    final storage = Get.find<StorageService>();
    return _showIfFirstTime(
      alreadyShown: storage.isCameraHintShown(),
      markShown: storage.setCameraHintShown,
      message: 'Camera access is required to take photos for your diary entries. Please enable camera access.',
    );
  }

  /// 相册权限温馨提示
  static Future<bool> showGalleryHint() {
    final storage = Get.find<StorageService>();
    return _showIfFirstTime(
      alreadyShown: storage.isGalleryHintShown(),
      markShown: storage.setGalleryHintShown,
      message: 'Photo library access is required to select photos for your diary entries. Please enable photo access.',
    );
  }

  /// 保存到相册权限温馨提示
  static Future<bool> showSaveToAlbumHint() {
    final storage = Get.find<StorageService>();
    return _showIfFirstTime(
      alreadyShown: storage.isSaveToAlbumHintShown(),
      markShown: storage.setSaveToAlbumHintShown,
      message: 'Photo library access is required to save the QR code to your album. Please enable photo access.',
    );
  }
}
