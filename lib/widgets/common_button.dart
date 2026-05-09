import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_text.dart';

import '../core/constants/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  final String text; // 按钮文字
  final Color bgColor; // 背景色
  final Color textColor; // 文字颜色
  final double? height; // 高度（可选）
  final double? width; // 高度（可选）
  final double? fontSize; // 字体大小（可选）
  final VoidCallback onTap; // 点击事件

  const CommonButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.onTap,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 48,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height!.h,
        width: width!.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r), // 圆角可改
        ),
        alignment: Alignment.center,
        // 文字绝对居中
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize!.sp,
            color: textColor,
            fontWeight: AppFontWeights.medium, // 用你刚才写的字体粗细
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final Color startColor; // 左边渐变颜色
  final Color endColor; // 右边渐变颜色
  final Color textColor;
  final double? height;
  final double? width; // 高度（可选）
  final double fontSize;
  final VoidCallback onTap;

  const GradientButton({
    super.key,
    required this.text,
    required this.startColor,
    required this.endColor,
    required this.onTap,
    this.textColor = Colors.white,
    this.height = 48,
    this.width = double.infinity,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height!.h,
        width: width?.h,
        // 核心：左右渐变
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.centerLeft, // 左
            end: Alignment.centerRight, // 右
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        // 文字绝对居中
        child: AppText(
          text,
          fontSize: fontSize.sp,
          color: textColor,
          fontWeight: AppFontWeights.medium,
        ),
      ),
    );
  }
}
