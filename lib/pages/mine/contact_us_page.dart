// lib/pages/mine/contact_us_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/common_export.dart';
import '../../core/utils/toast_util.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/common_button.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _saveToGallery() async {
    try {
      // 通过 gal 直接检查和请求相册权限（自带系统弹框）
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        final granted = await Gal.requestAccess(toAlbum: true);
        if (!granted) {
          ToastUtil.show('Photo library permission required');
          return;
        }
      }

      // 从 asset 读取图片字节
      final byteData = await rootBundle.load(
        AppImages.getAssetsPath('contact_us_qq_code'),
      );
      final bytes = byteData.buffer.asUint8List();

      // 写入临时文件
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/contact_us_qq_code.webp');
      await file.writeAsBytes(bytes);

      // 保存到相册
      await Gal.putImage(file.path, album: 'SecretChat');
      ToastUtil.show('Saved to album');
    } catch (e) {
      ToastUtil.show('Save failed, please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(titleText: 'Contact Us'),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 24.h),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30.h),

                        // 客服群标题
                        AppText(
                          'Customer Service',
                          fontSize: 16.sp,
                          fontWeight: AppFontWeights.semiBold,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 16.h),

                        // 二维码
                        AppImage(
                          imagePath: AppImages.getAssetsPath('contact_us_qq_code'),
                          width: 180.w,
                          height: 180.w,
                          radius: 8.r,
                          errorWidget: Container(
                            width: 180.w,
                            height: 180.w,
                            decoration: BoxDecoration(
                              color: AppColors.divider,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.qr_code_2,
                              size: 80.w,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // 提示文字
                        AppText(
                          'Please save the QR code to your album and scan it with QQ',
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),

                        // 客服在线时间
                        AppText(
                          'Online Hours:',
                          fontSize: 14.sp,
                          fontWeight: AppFontWeights.medium,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 4.h),
                        AppText(
                          'Weekdays: 10:00-18:00',
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 4.h),
                        AppText(
                          'Please leave a message outside of business hours. We will respond as soon as possible.',
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // QQ 图标（在卡片顶部外部）
                  Positioned(
                    top: -45.h,
                    child: AppImage(
                      imagePath: AppImages.getAssetsPath('contact_us_qq'),
                      width: 90.w,
                      height: 90.w,
                      errorWidget: Icon(
                        Icons.group,
                        size: 90.w,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 底部保存按钮
          BottomConfirmButton(text: 'Save to Album', onTap: _saveToGallery),
        ],
      ),
    );
  }
}
