import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../logic/controllers/webview_controller.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewPage({Key? key, required this.url, this.title})
    : super(key: key);

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

  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
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
            onPressed: () async {
              if (await controller.canGoBack()) {
                await controller.goBack();
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Column(
          children: [
            Obx(
              () => LinearProgressIndicator(
                value: controller.isLoading.value ? controller.progress.value : 0,
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
                  print('WebView错误: ${error.description}');
                },
                onReceivedHttpError: (webViewController, request, errorResponse) {
                  print('HTTP错误: ${errorResponse.statusCode}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
