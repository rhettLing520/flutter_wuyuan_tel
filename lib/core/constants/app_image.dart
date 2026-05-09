// lib/widgets/app_image.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImage extends StatelessWidget {
  /// 图片路径
  final String imagePath;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 填充方式
  final BoxFit fit;

  /// 圆角
  final double radius;

  /// 是否为圆形
  final bool isCircle;

  /// 占位图
  final String? placeholder;

  /// 错误时显示的图标
  final Widget? errorWidget;

  /// 颜色滤镜
  final ColorFilter? colorFilter;

  /// 透明度
  final double opacity;

  /// 边框
  final BoxBorder? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 点击回调
  final VoidCallback? onTap;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 0,
    this.isCircle = false,
    this.placeholder,
    this.errorWidget,
    this.colorFilter,
    this.opacity = 1.0,
    this.border,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Opacity(
      opacity: opacity,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );

    // 如果需要圆角或圆形
    if (isCircle || radius > 0) {
      imageWidget = ClipRRect(
        borderRadius: isCircle
            ? BorderRadius.circular(9999)
            : BorderRadius.circular(radius.r),
        child: imageWidget,
      );
    }

    // 如果有边框或阴影，使用 Container 包裹
    if (border != null || boxShadow != null) {
      imageWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          boxShadow: boxShadow,
          borderRadius: isCircle
              ? BorderRadius.circular(9999)
              : (radius > 0 ? BorderRadius.circular(radius.r) : null),
        ),
        child: imageWidget,
      );
    }

    // 如果有点击事件，使用 GestureDetector 包裹
    if (onTap != null) {
      imageWidget = GestureDetector(onTap: onTap, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildErrorWidget() {
    if (errorWidget != null) {
      return errorWidget!;
    }

    // 如果有占位图，显示占位图
    if (placeholder != null) {
      return Image.asset(placeholder!, width: width, height: height, fit: fit);
    }

    // 默认显示灰色背景和图标
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported,
        color: Colors.grey[400],
        size: width != null ? width! * 0.5 : 24.w,
      ),
    );
  }
}
