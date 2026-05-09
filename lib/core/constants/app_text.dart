import 'package:flutter/material.dart';
import 'app_text_styles.dart';

/// 预定义的文本样式类型
enum AppTextStyleType {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  bodyLarge,
  bodyMedium,
  bodySmall,
  button,
  buttonSmall,
  caption,
  overline,
  link,
}

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle = style ?? AppTextStyles.bodyRegular;

    return Text(
      text,
      style: baseStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// 字符串扩展 - 最简洁的使用方式,不过这种太简单了，维护代码可能不方便。
extension AppTextExtension on String {
  /// 使用 H1 样式
  Widget h1({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h1,
    color: color,
    textAlign: textAlign,
  );

  /// 使用 H2 样式
  Widget h2({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h2,
    color: color,
    textAlign: textAlign,
  );

  /// 使用 H3 样式
  Widget h3({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h3,
    color: color,
    textAlign: textAlign,
  );

  /// 使用 H4 样式
  Widget h4({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h4,
    color: color,
    textAlign: textAlign,
  );

  /// 使用 H5 样式
  Widget h5({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h5,
    color: color,
    textAlign: textAlign,
  );

  /// 使用 H6 样式
  Widget h6({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.h6,
    color: color,
    textAlign: textAlign,
  );

  /// 使用大正文样式
  Widget bodyLarge({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.bodyLarge,
    color: color,
    textAlign: textAlign,
  );

  /// 使用中等正文样式（最常用）
  Widget bodyMedium({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.bodyMedium,
    color: color,
    textAlign: textAlign,
  );

  /// 使用小正文样式
  Widget bodySmall({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.bodySmall,
    color: color,
    textAlign: textAlign,
  );

  /// 使用按钮文字样式
  Widget buttonText({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.button,
    color: color,
    textAlign: textAlign,
  );

  /// 使用说明文字样式
  Widget caption({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.caption,
    color: color,
    textAlign: textAlign,
  );

  /// 使用链接样式
  Widget linkText({Color? color, TextAlign? textAlign}) => AppText(
    this,
    style: AppTextStyles.link,
    color: color,
    textAlign: textAlign,
  );
}
