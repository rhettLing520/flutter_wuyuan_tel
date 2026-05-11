// lib/widgets/divider_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';

/// 普通分割线,
///
//基础用法
// const AppDivider()
// const AppDashedDivider()
// // 自定义样式
// AppDivider(color: Colors.grey, height: 2, indent: 20)
// AppDashedDivider(dashWidth: 6, dashSpacing: 3, color: AppColors.primary)引用 const AppDivider(),
class AppDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? padding;

  const AppDivider({
    super.key,
    this.height,
    this.color,
    this.indent,
    this.endIndent,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        height: height ?? 1.h,
        color: color ?? AppColors.divider,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

/// 虚线分割线
class AppDashedDivider extends StatelessWidget {
  final double dashWidth;
  final double dashSpacing;
  final Color? color;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppDashedDivider({
    super.key,
    this.dashWidth = 4,
    this.dashSpacing = 2,
    this.color,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        children: List.generate(
          30,
          (_) => Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (dashSpacing / 2).w),
              child: Container(
                height: height ?? 1.h,
                color: color ?? AppColors.divider,
                width: dashWidth.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
