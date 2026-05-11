import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_text.dart';

import '../core/constants/app_text_styles.dart';
import '../core/constants/common_export.dart';

class CommonButton extends StatelessWidget {
  final String text; // 按钮文字
  final Color bgColor; // 背景色
  final Color textColor; // 文字颜色
  final double? height; // 高度（可选）
  final double? width; // 宽度（可选）
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
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: height!.h,
          width: width!.w,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize!.sp,
              color: textColor,
              fontWeight: AppFontWeights.medium,
            ),
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
  final double? width; // 宽度（可选）
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
    return Container(
      height: height!.h,
      width: width?.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            alignment: Alignment.center,
            child: AppText(
              text,
              fontSize: fontSize.sp,
              color: textColor,
              fontWeight: AppFontWeights.medium,
            ),
          ),
        ),
      ),
    );
  }
}


/// 底部确定按钮（带安全区域适配）
class BottomConfirmButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? startColor;
  final Color? endColor;
  final double? height;
  final double fontSize;

  const BottomConfirmButton({
    super.key,
    required this.text,
    required this.onTap,
    this.startColor,
    this.endColor,
    this.height = 48,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        12.h + MediaQuery.of(context).padding.bottom,
      ),
      color: AppColors.background,
      child: GradientButton(
        text: text,
        startColor: startColor ?? AppColors.primary,
        endColor: endColor ?? AppColors.f3AEFFF,
        onTap: onTap,
        height: height,
        fontSize: fontSize,
      ),
    );
  }
}
