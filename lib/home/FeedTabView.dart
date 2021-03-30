import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftmic_news/article/ArticleDetailPageView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';
import 'package:swiftmic_news/feed/HomeFeedItemView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedTabView extends StatefulWidget {
  @override
  _FeedTabViewState createState() => _FeedTabViewState();
}

class _FeedTabViewState extends State<FeedTabView> {
  List<HomeFeedItemData> _dataList = [];
  int _currentFetchPageIndex = 0;

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<List<HomeFeedItemData>> fetchFeedList(
      int startPage, int pageSize) async {
    var url = Uri.parse(
        "https://easyqrcode-api.swiftmic.com/swiftmic/feed/list?startPage=${startPage}&pageSize=${pageSize}");
    var response = await http.get(url);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    int code = responseBody['code'];
    String message = responseBody['message'];

    print("code = ${code}");
    print("message = ${message}");

    List<dynamic> dataList = responseBody['data'];

    print("dataList = ${dataList}");

    List<HomeFeedItemData> itemDataList = [];

    for (Map element in dataList) {
      HomeFeedItemData itemData = HomeFeedItemData();

      String author = element['author'];
      String title = element['title'];
      int commentCount = element['commentCount'];

      itemData.authorName = author;
      itemData.title = title;
      itemData.commentCount = commentCount;
      itemData.itemType = ItemType.text;

      itemDataList.add(itemData);
    }

    return itemDataList;
  }

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));

    _currentFetchPageIndex = 0;

    List<HomeFeedItemData> dataList =
        await fetchFeedList(_currentFetchPageIndex, 10);
    print("dataList = ${dataList}");

    setState(() {
      _dataList = dataList;
      _currentFetchPageIndex++;
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    List<HomeFeedItemData> dataList =
        await fetchFeedList(_currentFetchPageIndex, 10);

    setState(() {
      _dataList.addAll(dataList);
      _currentFetchPageIndex++;
    });

    // for (var i = 0; i < 10; ++i) {
    //   items.add((items.length + 1).toString());
    // }

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(), //WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: buildListView(),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      // itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
      itemBuilder: (c, i) => buildRow(i),
      // itemExtent: 100.0,
      itemCount: _dataList.length,
    );
  }

  Widget buildRow(int index) {
    if (index >= _dataList.length) {
      return Text("Null");
    }

    HomeFeedItemData data = _dataList[index];

    // HomeFeedItemData data = HomeFeedItemData();

    // if (0 == index) {
    //   data.title =
    //       "64位Chrome运行至少需8GB内存：安卓网友直呼用不起。64位Chrome运行至少需8GB内存：安卓网友直呼用不起。";
    //   data.authorName = "量子位";
    //   data.commentCount = 819;
    //   data.itemType = ItemType.text;
    // } else if (1 == index) {
    //   data.title = "再次发现商晚期黄金面具！三星堆公布最新考古发掘成果";
    //   data.authorName = "四川观察";
    //   data.commentCount = 100;
    //   data.itemType = ItemType.text_images;
    // } else {
    //   data.title = "路中青石板凸起，怕游客摔跤工作人员赶到处理，揭开一看太意外！";
    //   data.authorName = "北青网";
    //   data.commentCount = 98;
    //   data.itemType = ItemType.text;
    // }

    return HomeFeedItemView(data, (data) {
      // 跳转到详情页面
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleDetailPageView()),
      );
    });
  }
}
