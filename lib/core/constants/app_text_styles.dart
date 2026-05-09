import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

/// 自定义字重常量
class AppFontWeights {
  AppFontWeights._();

  /// 细体 (300)
  static const FontWeight light = FontWeight.w300;

  /// 常规 (400)
  static const FontWeight normal = FontWeight.normal;

  /// 中等 (500)
  static const FontWeight medium = FontWeight.w500;

  /// 半粗体 (600)
  static const FontWeight semiBold = FontWeight.w600;

  /// 粗体 (700)
  static const FontWeight bold = FontWeight.bold;

  /// 特粗 (800)
  static const FontWeight extraBold = FontWeight.w800;
}

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Roboto';

  // 标题样式
  static TextStyle h1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: AppFontWeights.medium,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 3 / 2,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.3,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.4,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.4,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  // 正文样式
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  static TextStyle bodyRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  // 按钮样式
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    fontFamily: _fontFamily,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    fontFamily: _fontFamily,
    letterSpacing: 0.3,
  );

  // 标签样式
  static  TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _fontFamily,
    height: 1.4,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: _fontFamily,
    letterSpacing: 1.5,
  );

  // 链接样式
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
    fontFamily: _fontFamily,
    decoration: TextDecoration.underline,
  );

  // 辅助方法 - 带颜色的样式
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}
