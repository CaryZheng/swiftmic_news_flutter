import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftmic_news/api/ApiManager.dart';
import 'package:swiftmic_news/article/ArticleDetailPageView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';
import 'package:swiftmic_news/feed/HomeFeedItemView.dart';
import 'dart:convert';

typedef OnNetworkCallback = void Function(String response, {String tag});

class FeedTabView extends StatefulWidget {
  @override
  _FeedTabViewState createState() => _FeedTabViewState();
}

class _FeedTabViewState extends State<FeedTabView> {
  List<HomeFeedItemData> _dataList = [];
  int _currentFetchPageIndex = 0;
  final int _pageSize = 10;

  ApiManager _apiManager = new ApiManager();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));

    _currentFetchPageIndex = 0;

    _apiManager.fetchFeedList(_currentFetchPageIndex, _pageSize,
        tag: _currentFetchPageIndex.toString(),
        onNetworkCallback: (String response, {String tag}) {
      print("onNetworkCallback response = $response");

      Map<String, dynamic> responseBody = jsonDecode(response);
      int code = responseBody['code'];
      String message = responseBody['message'];

      print("code = $code");
      print("message = $message");

      List<dynamic> dataList = responseBody['data'];

      print("dataList = $dataList");

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

      setState(() {
        _dataList = itemDataList;
      });

      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    int startPageIndex = _currentFetchPageIndex + 1;
    _apiManager.fetchFeedList(startPageIndex, _pageSize,
        tag: startPageIndex.toString(),
        onNetworkCallback: (String response, {String tag}) {
      print("onNetworkCallback response = $response");

      Map<String, dynamic> responseBody = jsonDecode(response);
      int code = responseBody['code'];
      String message = responseBody['message'];

      print("code = $code");
      print("message = $message");

      List<dynamic> dataList = responseBody['data'];

      print("dataList = $dataList");

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

      setState(() {
        _dataList.addAll(itemDataList);
      });

      _currentFetchPageIndex++;

      if (mounted) setState(() {});
      _refreshController.loadComplete();
    });
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

    return HomeFeedItemView(data, (data) {
      // 跳转到详情页面
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleDetailPageView()),
      );
    });
  }
}
