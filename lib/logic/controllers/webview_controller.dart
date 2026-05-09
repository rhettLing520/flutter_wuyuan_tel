import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewController extends GetxController {
  InAppWebViewController? webViewController;
  RxDouble progress = 0.0.obs;
  RxString title = ''.obs;
  RxBool canGoBack = false.obs;
  RxBool canGoForward = false.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxBool hasError = false.obs;

  void onProgressChanged(int progress) {
    this.progress.value = progress / 100;
  }

  void onTitleChanged(String? title) {
    if (title != null && title.isNotEmpty) {
      this.title.value = title;
    }
  }

  Future<void> updateNavigationState(InAppWebViewController controller) async {
    try {
      canGoBack.value = await controller.canGoBack();
      canGoForward.value = await controller.canGoForward();
    } catch (e) {
      print('更新导航状态失败: $e');
    }
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String message) {
    hasError.value = true;
    errorMessage.value = message;
    isLoading.value = false;
  }

  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }

  Future<void> goBack() async {
    if (webViewController != null && await webViewController!.canGoBack()) {
      await webViewController!.goBack();
    }
  }

  Future<void> goForward() async {
    if (webViewController != null && await webViewController!.canGoForward()) {
      await webViewController!.goForward();
    }
  }

  Future<void> reload() async {
    if (webViewController != null) {
      clearError();
      setLoading(true);
      await webViewController!.reload();
    }
  }

  @override
  void onClose() {
    webViewController?.dispose();
    super.onClose();
  }
}
