import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../logic/controllers/webview_controller.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewPage({super.key, required this.url, this.title});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WebViewController>();
    if (widget.title != null) {
      controller.title.value = widget.title!;
    }
  }

  Future<void> _handleBack() async {
    if (await controller.canGoBackInWebView()) {
      await controller.goBack();
      return;
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.title.value.isEmpty ? '网页' : controller.title.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _handleBack,
          ),
        ),
        body: Column(
          children: [
            Obx(
              () => LinearProgressIndicator(
                value: controller.isLoading.value
                    ? controller.progress.value
                    : 0,
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                initialSettings: InAppWebViewSettings(
                  useShouldOverrideUrlLoading: false,
                  mediaPlaybackRequiresUserGesture: false,
                  javaScriptEnabled: true,
                  domStorageEnabled: true,
                  allowsInlineMediaPlayback: true,
                  useHybridComposition: true,
                  clearCache: false,
                  cacheEnabled: true,
                  supportZoom: false,
                  builtInZoomControls: false,
                  displayZoomControls: false,
                  safeBrowsingEnabled: true,
                  mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                ),
                onWebViewCreated: (webViewController) {
                  controller.webViewController = webViewController;
                },
                onLoadStart: (webViewController, url) {
                  controller.setLoading(true);
                  controller.clearError();
                  controller.title.value = '加载中...';
                },
                onLoadStop: (webViewController, url) async {
                  controller.setLoading(false);
                  await controller.updateNavigationState(webViewController);
                  final pageTitle = await webViewController.getTitle();
                  if (pageTitle != null && pageTitle.isNotEmpty) {
                    controller.title.value = pageTitle;
                  }
                },
                onProgressChanged: (webViewController, progress) {
                  controller.onProgressChanged(progress);
                },
                onTitleChanged: (webViewController, newTitle) {
                  controller.onTitleChanged(newTitle);
                },
                onReceivedError: (webViewController, request, error) {
                  debugPrint('WebView错误: ${error.description}');
                },
                onReceivedHttpError:
                    (webViewController, request, errorResponse) {
                      debugPrint('HTTP错误: ${errorResponse.statusCode}');
                    },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
