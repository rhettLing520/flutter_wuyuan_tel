import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static late SharedPreferences _prefs;

  static Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return StorageService();
  }

  // Token 相关
  Future<bool> saveToken(String token) async {
    return await _prefs.setString('token', token);
  }

  String? getToken() {
    return _prefs.getString('token');
  }

  Future<bool> removeToken() async {
    return await _prefs.remove('token');
  }

  // Refresh Token 相关
  Future<bool> saveRefreshToken(String refreshToken) async {
    return await _prefs.setString('refresh_token', refreshToken);
  }

  String? getRefreshToken() {
    return _prefs.getString('refresh_token');
  }

  Future<bool> removeRefreshToken() async {
    return await _prefs.remove('refresh_token');
  }

  // 用户登录状态
  Future<bool> setLoggedIn(bool value) async {
    return await _prefs.setBool('is_logged_in', value);
  }

  bool isLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  // 是否首次启动
  Future<bool> setFirstLaunch(bool value) async {
    return await _prefs.setBool('first_launch', value);
  }

  bool isFirstLaunch() {
    return _prefs.getBool('first_launch') ?? true;
  }

  // 清除所有数据
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
