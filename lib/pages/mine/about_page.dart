// lib/pages/profile/about_page.dart
import 'package:flutter/material.dart';

import '../../core/constants/common_export.dart';
import '../../services/app_info_service.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('关于我们'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h),

            // Logo
            AppImage(
              imagePath: AppImages.getImage("logo"),
              width: 100.w,
              height: 100.h,
              radius: 20,
            ),

            SizedBox(height: 16.h),

            // 应用名称
            AppText(
              AppInfoService.to.appName,
              fontSize: 24.sp,
              fontWeight: AppFontWeights.bold,
              color: AppColors.textPrimary,
            ),

            SizedBox(height: 8.h),

            AppText(
              AppInfoService.to.displayVersion,
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),

            SizedBox(height: 40.h),

            // 介绍卡片
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '应用介绍',
                    fontSize: 18.sp,
                    fontWeight: AppFontWeights.semiBold,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: 12.h),
                  AppText(
                    '这是一款优秀的移动应用，致力于为用户提供便捷、高效的服务体验。我们持续优化产品功能，不断提升用户满意度。',
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    height: 1.8,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // 公司信息
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '联系我们',
                    fontSize: 18.sp,
                    fontWeight: AppFontWeights.semiBold,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: 12.h),
                  _buildContactItem(Icons.email, '邮箱', 'contact@example.com'),
                  SizedBox(height: 8.h),
                  _buildContactItem(Icons.phone, '电话', '400-xxx-xxxx'),
                  SizedBox(height: 8.h),
                  _buildContactItem(Icons.location_on, '地址', '北京市朝阳区xxx路xxx号'),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // 版权信息
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppText(
                '© 2024 Your Company. All rights reserved.',
                textAlign: TextAlign.center,
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18.w, color: AppColors.textSecondary),
        SizedBox(width: 8.w),
        AppText(
          '$label：',
          fontSize: 14.sp,
          color: AppColors.textSecondary,
        ),
        Expanded(
          child: AppText(
            value,
            fontSize: 14.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
