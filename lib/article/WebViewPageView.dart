import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebViewPageViewState();
  }
}

class _WebViewPageViewState extends State<WebViewPageView> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: WebView(
        initialUrl: "https://flutter.dev",
      ),
    );
  }
}
