import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  AppInfoService(this._packageInfo);

  final PackageInfo _packageInfo;

  static Future<AppInfoService> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppInfoService(packageInfo);
  }

  static AppInfoService get to => Get.find<AppInfoService>();

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
  String get displayVersion => 'Version $version';
}
