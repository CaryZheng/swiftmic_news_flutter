import 'package:flutter/material.dart';

class ArticleDetailPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("帖子详情"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "64位Chrome运行至少需8GB内存：安卓网友直呼用不起。64位Chrome运行至少需8GB内存：安卓网友直呼用不起。",
                style: TextStyle(fontSize: 20, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/item_images_test.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "快科技",
                          style: TextStyle(
                            fontSize: 14,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "57分钟前",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(" . "),
                          Text(
                            "快科技官方号",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
