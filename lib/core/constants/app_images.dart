// lib/core/constants/app_images.dart
class AppImages {
  // 基础路径
  static const String _basePath = 'assets/images';
  static const String logo = 'assets/images/logo.webp';
  static const String avatarDefault = 'assets/images/logo.webp';

  static String getImage(
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
