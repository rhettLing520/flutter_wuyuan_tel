// lib/pages/profile/about_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_image.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';

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
            Text(
              'Your App Name',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: AppFontWeights.bold,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
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
                  Text(
                    '应用介绍',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: AppFontWeights.semiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '这是一款优秀的移动应用，致力于为用户提供便捷、高效的服务体验。我们持续优化产品功能，不断提升用户满意度。',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                      height: 1.8,
                    ),
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
                  Text(
                    '联系我们',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: AppFontWeights.semiBold,
                      color: AppColors.textPrimary,
                    ),
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
              child: Text(
                '© 2024 Your Company. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
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
        Icon(icon, size: 18.w, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Text(
          '$label：',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
