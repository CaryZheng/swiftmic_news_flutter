import 'package:flutter/material.dart';
import 'package:swiftmic_news/helper/AliveKeeper.dart';
import 'package:swiftmic_news/topic/TopicRecommendView.dart';

class TopicTabView extends StatefulWidget {
  @override
  _TopicTabViewState createState() => _TopicTabViewState();
}

class _TopicTabViewState extends State<TopicTabView> {
  int _selectedTitleIndex = 0;

  /// 自定义顶部标题栏
  Widget buildCustomTitleView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Text(
              "推荐",
              style: (0 == _selectedTitleIndex)
                  ? TextStyle(fontSize: 22, color: Colors.black)
                  : TextStyle(fontSize: 22, color: Colors.grey),
            ),
            onTap: () {
              setState(() {
                _selectedTitleIndex = 0;
              });
            },
          ),
          SizedBox(
            width: 40,
          ),
          InkWell(
            child: Text(
              "广场",
              style: (1 == _selectedTitleIndex)
                  ? TextStyle(fontSize: 22, color: Colors.black)
                  : TextStyle(fontSize: 22, color: Colors.grey),
            ),
            onTap: () {
              setState(() {
                _selectedTitleIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildRecommendContentView() {
    return Expanded(
      flex: 1,
      child: TopicRecommendView(),
    );
  }

  Widget buildSquareContentView() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AliveKeeper(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(children: [
            buildCustomTitleView(),
            (0 == _selectedTitleIndex)
                ? buildRecommendContentView()
                : buildSquareContentView()
          ]),
        ),
      ),
    );
  }
}
