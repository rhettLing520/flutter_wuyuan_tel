import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secretchat/pages/login/auth_service.dart';
import 'config/environment.dart';
import 'core/network/api_client.dart';
import 'services/diary_service.dart';
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
  }
}
