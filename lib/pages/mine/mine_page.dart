// lib/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_image.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';
import '../../userinfo_page.dart';
import 'about_page.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // 顶部用户信息卡片
          SliverToBoxAdapter(child: _buildHeader(context)),

          // 功能列表
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSection(
                  title: '个人信息',
                  children: [
                    _buildMenuItem(
                      context: context,
                      icon: Icons.person_outline,
                      title: '个人资料',
                      subtitle: '编辑头像、昵称等信息',
                      onTap: () => Get.to(() => const UserInfoPage()),
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.phone_outlined,
                      title: '手机号码',
                      subtitle: '138****8888',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.security_outlined,
                      title: '账号与安全',
                      onTap: () {},
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                _buildSection(
                  title: '通用设置',
                  children: [
                    _buildMenuItem(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: '消息通知',
                      trailing: Switch(value: true, onChanged: (value) {}),
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.privacy_tip_outlined,
                      title: '隐私政策',
                      onTap: () => Get.to(() => const PrivacyPolicyPage()),
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.info_outline,
                      title: '关于我们',
                      onTap: () => Get.to(() => const AboutPage()),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                SizedBox(height: 20.h),

                // 版本号
                Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
                  ),
                ),

                SizedBox(height: 20.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Row(
        children: [
          // 头像
          ClipOval(
            child: AppImage(
              imagePath: AppImages.avatarDefault,
              width: 70.w,
              height: 70.h,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
          ),
          SizedBox(width: 16.w),

          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '用户名',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: AppFontWeights.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'ID: 123456789',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: AppFontWeights.medium,
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
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
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // 图标
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 20.w,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: 12.w),

            // 标题和副标题
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: AppFontWeights.medium,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 右侧内容
            if (trailing != null)
              trailing
            else
              Icon(Icons.chevron_right, size: 20.w, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('隐私政策'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '隐私政策',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: AppFontWeights.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '更新日期：2024年1月1日',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 20.h),
            Text(
              '我们非常重视您的隐私保护...',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
