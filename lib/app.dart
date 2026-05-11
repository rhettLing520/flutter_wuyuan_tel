import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';
import 'config/environment.dart';
import 'core/network/api_client.dart';
import 'services/app_info_service.dart';
import 'services/auth_service.dart';
import 'services/diary_service.dart';
import 'services/image_picker_service.dart';
import 'services/permission_service.dart';
import 'services/storage_service.dart';

class App {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化本地存储
    final storage = await StorageService.init();
    Get.put<StorageService>(storage, permanent: true);

    // 初始化 Hive 日记本存储
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    final diaryService = await DiaryService.init();
    Get.put<DiaryService>(diaryService, permanent: true);

    // 初始化应用信息
    final appInfo = await AppInfoService.init();
    Get.put<AppInfoService>(appInfo, permanent: true);

    // 初始化网络客户端
    await ApiClient.init(
      baseUrl: EnvironmentConfig.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
    );

    // 恢复 token
    final token = storage.getToken();
    if (token != null) {
      ApiClient.setToken(token);
    }

    // 注册全局服务
    Get.put<AuthService>(AuthService(), permanent: true);

    // 初始化权限服务
    Get.put<PermissionService>(PermissionService(), permanent: true);

    // 初始化图片选择服务
    Get.put<ImagePickerService>(ImagePickerService(), permanent: true);
  }
}
