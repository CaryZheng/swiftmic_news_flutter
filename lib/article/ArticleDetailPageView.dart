import 'package:flutter/material.dart';

class ArticleDetailPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帖子详情"),
      ),
      body: Center(
        child: Text("正文内容")
      ),
    );
  }
}