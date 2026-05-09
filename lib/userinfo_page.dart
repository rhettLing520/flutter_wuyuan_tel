// lib/pages/profile/user_info_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_image.dart';
import 'core/constants/app_images.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController _nicknameController = TextEditingController(
    text: '用户名',
  );
  final TextEditingController _bioController = TextEditingController(
    text: '这个人很懒，什么都没写~',
  );

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人资料'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Get.snackbar('成功', '保存成功', snackPosition: SnackPosition.TOP);
              Get.back();
            },
            child: const Text('保存'),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h),

          // 头像
          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: AppImage(
                    imagePath: AppImages.avatarDefault,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),
          Center(
            child: Text(
              '点击更换头像',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ),

          SizedBox(height: 30.h),

          // 表单
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _buildInputItem(
                  title: '昵称',
                  controller: _nicknameController,
                  hint: '请输入昵称',
                ),
                _buildDivider(),
                _buildInputItem(
                  title: '性别',
                  value: '男',
                  showArrow: true,
                  onTap: () {
                    // TODO: 显示性别选择
                  },
                ),
                _buildDivider(),
                _buildInputItem(
                  title: '生日',
                  value: '1990-01-01',
                  showArrow: true,
                  onTap: () {
                    // TODO: 显示日期选择器
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '个人简介',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _bioController,
                  maxLines: 3,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputItem({
    required String title,
    TextEditingController? controller,
    String? value,
    String? hint,
    bool showArrow = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: controller != null
                  ? TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hint,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                      ),
                    )
                  : Text(
                      value ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
            ),
            if (showArrow)
              Icon(Icons.chevron_right, size: 20.w, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 0.5,
      indent: 16.w,
      endIndent: 16.w,
      color: Colors.grey[200],
    );
  }
}
