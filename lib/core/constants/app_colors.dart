import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 主色调
  static const Color primary = Color(0xFf377BFF);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  // 次要颜色
  static const Color secondary = Color(0xFF6C63FF);
  static const Color secondaryLight = Color(0xFF9E99FF);
  static const Color secondaryDark = Color(0xFF4A42E8);

  // 背景色
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // 文字颜色
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);

  // 功能色
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // 边框和分割线
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color f377BFF = Color(0xFF377BFF);
  static const Color f3AEFFF = Color(0xFF3AEFFF);

  // 阴影
  static const Color shadow = Color(0x1F000000);

  //倒数日颜色
  static const Color countDownRed = Color(0xFFFF5045);
  static const Color countDownBlue = Color(0xFf377BFF);

  // 渐变色
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
