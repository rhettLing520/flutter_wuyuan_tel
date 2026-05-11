// lib/pages/mine/contact_us_page.dart
import 'package:flutter/material.dart';

import '../../core/constants/common_export.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/common_button.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(titleText: '联系我们'),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
                    // 客服群标题
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage(
                          imagePath: AppImages.getAssetsPath('contact_us_qq'),
                          width: 24.w,
                          height: 24.w,
                          errorWidget: Icon(
                            Icons.group,
                            size: 24.w,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        AppText(
                          '客服群',
                          fontSize: 16.sp,
                          fontWeight: AppFontWeights.semiBold,
                          color: AppColors.textPrimary,
                        ),
                      ],
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
                      '敬请保存二维码至相册，使用QQ扫一扫',
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),

                    // 客服在线时间
                    AppText(
                      '客服在线时间：',
                      fontSize: 14.sp,
                      fontWeight: AppFontWeights.medium,
                      color: AppColors.textPrimary,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      '工作日：10:00-18:00',
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      '其他时间请留言，客服将在上班的第一时间回复。',
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 底部保存按钮
          BottomConfirmButton(text: '保存至相册', onTap: () {}),
        ],
      ),
    );
  }
}
