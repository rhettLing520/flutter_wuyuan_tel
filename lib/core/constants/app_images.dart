// lib/core/constants/app_images.dart
class AppImages {
  // 基础路径
  static const String _basePath = 'assets/images';
  static const String logo = '$_basePath/logo.webp';
  static const String avatarDefault = '$_basePath/logo.webp';

  static String getAssetsPath(
    String name, {
    String? category,
    String extension = 'webp',
  }) {
    String path = _basePath;

    if (category != null && category.isNotEmpty) {
      path = '$path/$category';
    }

    return '$path/$name.$extension';
  }
}
