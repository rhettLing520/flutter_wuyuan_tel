import 'package:get/get.dart';

import 'app_routes.dart';

class NavigationService {
  NavigationService._();

  static Future<T?>? toWebView<T>(String url, {String? title}) {
    final parameters = {'url': url};
    if (title != null) {
      parameters['title'] = title;
    }

    return Get.toNamed<T>(AppRoutes.webView, parameters: parameters);
  }
}
