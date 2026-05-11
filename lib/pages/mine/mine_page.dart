// lib/pages/mine/mine_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/common_export.dart';
import '../../routes/navigation_service.dart';
import '../../widgets/divider_widget.dart';
import 'contact_us_page.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      title: '用户协议',
                      onTap: () => NavigationService.toWebView(
                        AppConstants.userAgreementUrl,
                      ),
                    ),

                    _buildMenuItem(
                      title: '隐私政策',
                      onTap: () =>
                          NavigationService.toWebView(AppConstants.privacyUrl),
                    ),
                    _buildMenuItem(
                      title: '应用评价',
                      onTap: () => NavigationService.toWebView(
                        AppConstants.userAgreementUrl,
                      ),
                    ),
                    _buildMenuItem(title: '分享好友', onTap: () {}),
                    _buildMenuItem(
                      title: '联系我们',
                      onTap: () => Get.to(() => const ContactUsPage()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 24.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.getAssetsPath('mine_bg')),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          // 头像
          ClipOval(
            child: AppImage(
              imagePath: AppImages.avatarDefault,
              width: 70.w,
              height: 70.w,
              border: Border.all(color: AppColors.textWhite, width: 2.w),
            ),
          ),
          SizedBox(width: 16.w),
          // 用户名
          Expanded(
            child: AppText(
              '游客登录',
              fontSize: 20.sp,
              fontWeight: AppFontWeights.medium,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                title,
                fontSize: 16.sp,
                color: AppColors.textPrimary,
              ),
            ),
            AppImage(
              imagePath: AppImages.getAssetsPath('mine_right_bt'),
              width: 16.w,
              height: 16.w,
              errorWidget: Icon(
                Icons.chevron_right,
                size: 20.w,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
