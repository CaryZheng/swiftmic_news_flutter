import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftmic_news/api/ApiManager.dart';
import 'package:swiftmic_news/article/ArticleDetailPageView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swiftmic_news/feed/BodyPageView.dart';
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

  List<GlobalKey> keys = <GlobalKey>[];
  ScrollController _menuScrollController = ScrollController();
  PageController _pageController = PageController();
  int _currentMenuIndex = 0;
  List<String> _menuTitles = [
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
    "汽车",
    "段子",
    "手机",
    "知否",
    "和文化",
    "公开课",
    "圈子",
    "健康",
    "图片",
    "网易号",
    "热点",
    "直播",
    "跟贴",
    "娱乐",
    "小视频",
    "体育",
    "房产",
    "家居",
    "轻松一刻",
    "游戏",
    "时尚",
    "独家",
    "军事",
    "播单",
    "历史",
    "艺术",
    "股票",
    "航空",
  ];

  _FeedTabViewState() {
    for (int i = 0; i < _menuTitles.length; i++) {
      keys.add(GlobalKey(debugLabel: i.toString()));
    }
  }

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
    ListView listView = ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _menuScrollController,
      itemCount: _menuTitles.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            key: keys[index],
            width: 70,
            alignment: Alignment.center,
            child: Text(
              _menuTitles.elementAt(index),
              style: TextStyle(
                fontSize: 16,
                color:
                    (_currentMenuIndex == index) ? Colors.black : Colors.grey,
              ),
            ),
          ),
          onTap: () {
            onMenuItemClicked(index);
          },
        );
      },
    );

    return Container(
      height: 40,
      child: listView,
    );
  }

  /// 横向Menu item被点击事件
  void onMenuItemClicked(int index) {
    print("横向滚动标题 item 被点击, index = $index");
    setState(() {
      _currentMenuIndex = index;
    });

    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

    scrollMenuItemToCenter(index);
  }

  // Page左右滑动切换事件
  void onPageChanged(int index) {
    print("onPageChanged index = $index");

    setState(() {
      _currentMenuIndex = index;
    });

    scrollMenuItemToCenter(index);
  }

  void scrollMenuItemToCenter(int index) {
    print("scrollMenuItemToCenter index = $index");
    double screenWidth = MediaQuery.of(context).size.width;

    print("scrollMenuItemToCenter screenWidth = $screenWidth");

    RenderBox box = keys[index].currentContext.findRenderObject();
    if (null == box) {
      return;
    }
    Offset os = box.localToGlobal(Offset.zero);

    print("scrollMenuItemToCenter os = $os");

    double w = box.size.width;
    double x = os.dx;

    print("scrollMenuItemToCenter w = $w");
    print("scrollMenuItemToCenter x = $x");

    double rlOffset = screenWidth / 2 - (x + w / 2);
    print("scrollMenuItemToCenter rlOffset = $rlOffset");
    double offset = _menuScrollController.offset - rlOffset;

    double offsetMin = 0;
    double offsetMax = w * _menuTitles.length - screenWidth;
    if (offset < offsetMin) {
      offset = offsetMin;
    } else if (offset > offsetMax) {
      offset = offsetMax;
    }

    print(
        "scrollMenuItemToCenter _menuScrollController.offset = ${_menuScrollController.offset}");
    print("scrollMenuItemToCenter offset = $offset");

    _menuScrollController.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
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
            child: BodyPageView(
              datas: _menuTitles,
              pageController: _pageController,
              pageChangeCall: onPageChanged,
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Scaffold(
          //     body: SmartRefresher(
          //       enablePullDown: true,
          //       enablePullUp: true,
          //       header: ClassicHeader(), //WaterDropHeader(),
          //       footer: CustomFooter(
          //         builder: (BuildContext context, LoadStatus mode) {
          //           Widget body;
          //           if (mode == LoadStatus.idle) {
          //             body = Text("pull up load");
          //           } else if (mode == LoadStatus.loading) {
          //             body = CupertinoActivityIndicator();
          //           } else if (mode == LoadStatus.failed) {
          //             body = Text("Load Failed!Click retry!");
          //           } else if (mode == LoadStatus.canLoading) {
          //             body = Text("release to load more");
          //           } else {
          //             body = Text("No more Data");
          //           }
          //           return Container(
          //             height: 55.0,
          //             child: Center(child: body),
          //           );
          //         },
          //       ),
          //       controller: _refreshController,
          //       onRefresh: _onRefresh,
          //       onLoading: _onLoading,
          //       child: buildListView(),
          //     ),
          //   ),
          // ),
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
