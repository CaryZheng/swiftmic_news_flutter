import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebViewPageViewState();
  }
}

class _WebViewPageViewState extends State<WebViewPageView> {
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  JavascriptChannel _jsCallFlutterChannel(BuildContext context) {
    return JavascriptChannel(
        name: "SwiftMic",
        onMessageReceived: (JavascriptMessage message) {
          print("js调用flutter, message = ${message.message}");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: WebView(
        initialUrl: "",
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: [_jsCallFlutterChannel(context)].toSet(),
        onWebViewCreated: (controller) {
          _webViewController = controller;

          _loadHtmlFromAssets();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Flutter调用js
          _webViewController.evaluateJavascript('callJS("visible")');
        },
      ),
    );
  }

  void _loadHtmlFromAssets() async {
    String filePath = "html/test.html";
    String htmlContent = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(
      Uri.dataFromString(htmlContent,
              mimeType: "text/html", encoding: Encoding.getByName("utf-8"))
          .toString(),
    );
  }
}
