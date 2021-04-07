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

class _FeedTabViewState extends State<FeedTabView>
    with AutomaticKeepAliveClientMixin {
  @protected
  bool get wantKeepAlive => true;

  List<HomeFeedItemData> _dataList = [];
  int _currentFetchPageIndex = 0;
  final int _pageSize = 10;

  ApiManager _apiManager = new ApiManager();

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

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

      if (this.mounted) {
        setState(() {
          _dataList = itemDataList;
        });
      }

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

  /// 自定义顶部标题栏
  Widget buildCustomTitleView() {
    return Container(
      color: Colors.red,
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          child: Row(
            children: [
              // Logo
              Image.asset(
                'images/logo.png',
                width: 72,
                height: 72,
              ),
              // Search
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
                flex: 1,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'images/skin1_news_main_message_box_icon.png',
                      width: 36,
                      height: 36,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'images/skin1_news_main_message_box_icon.png',
                      width: 36,
                      height: 36,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuView() {
    List<String> titles = [
      "关注",
      "头条",
      "抗疫",
      "视频",
      "数码",
      "新时代",
      "旅游",
      "上海",
      "财经",
      "科技",
      "汽车"
    ];
    ListView listView = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: titles.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 60,
          alignment: Alignment.center,
          child: Text(
            titles.elementAt(index),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        );
      },
    );

    return Container(
      height: 40,
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildCustomTitleView(),
          buildMenuView(),
          Expanded(
            flex: 1,
            child: Scaffold(
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
            ),
          ),
        ],
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
