import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swiftmic_news/api/ApiManager.dart';
import 'package:swiftmic_news/article/ArticleDetailPageView.dart';
import 'package:swiftmic_news/article/WebViewPageView.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';
import 'package:swiftmic_news/feed/HomeFeedItemView.dart';
import 'package:swiftmic_news/helper/EnumHelper.dart';

class TopicRecommendView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopicRecommendViewState();
  }
}

class _TopicRecommendViewState extends State<TopicRecommendView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<HomeFeedItemData> _dataList = [];
  int _currentFetchPageIndex = 0;
  final int _pageSize = 10;

  ApiManager _apiManager = new ApiManager();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE9ECF0),
      child: buildContentView(),
    );
  }

  Widget buildContentView() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载更多");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("释放加载更多");
          } else {
            body = Text("没有更多数据了");
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
      if (ItemType.video == data.itemType) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebViewPageView()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleDetailPageView()),
        );
      }
    });
  }

  void handleResult(int fetchPageIndex) {
    _apiManager.fetchFeedHeadList(_currentFetchPageIndex, _pageSize,
        tag: _currentFetchPageIndex.toString(),
        onNetworkCallback: (String response, {String tag}) {
      print("onNetworkCallback response = $response");

      Map<String, dynamic> responseBody = jsonDecode(response);
      int code = responseBody['code'];
      String message = responseBody['message'];

      print("code = $code");
      print("message = $message");

      List<dynamic> dataList = responseBody['data']["items"];

      print("dataList = $dataList");

      List<HomeFeedItemData> itemDataList = [];

      for (Map element in dataList) {
        HomeFeedItemData itemData = HomeFeedItemData();

        String author = element['source'];
        String title = element['title'];
        int commentCount = element['replyCount'];
        String videoCover = element["videoCover"];
        int videoTime = element['videoTime'];
        ItemType itemType = EnumHelper.getItemType(element['type']);

        itemData.itemType = itemType;
        itemData.authorName = author;
        itemData.title = title;
        itemData.commentCount = commentCount;
        itemData.videoCover = videoCover;
        itemData.videoTime = videoTime;

        var images = element['images'];
        if (null != images) {
          itemData.images = images.cast<String>();
        }

        itemDataList.add(itemData);
      }

      if (0 == fetchPageIndex) {
        if (this.mounted) {
          setState(() {
            _dataList = itemDataList;
          });
        }

        // if failed,use refreshFailed()
        _refreshController.refreshCompleted();
      } else {
        _currentFetchPageIndex++;

        if (this.mounted) {
          setState(() {
            _dataList.addAll(itemDataList);
          });
        }

        _refreshController.loadComplete();
      }
    });
  }

  void _onRefresh() async {
    _currentFetchPageIndex = 0;

    handleResult(0);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    int startPageIndex = _currentFetchPageIndex + 1;
    handleResult(startPageIndex);
  }
}
